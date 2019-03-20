Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD735C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:53:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6202F2075C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6202F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PVGX01vkzDqQ6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 23:53:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PVCz54gSzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 23:51:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44PVCz1DgCz8tRd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 23:51:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44PVCy6mHvz9sPF; Wed, 20 Mar 2019 23:51:26 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=michaele@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44PVCy29Qgz9sPC
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Mar 2019 23:51:25 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2KCnLje054165
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Mar 2019 08:51:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rbnr1grg6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Mar 2019 08:51:23 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <michaele@au1.ibm.com>;
 Wed, 20 Mar 2019 12:51:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 12:51:13 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2KCpHla54067448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2019 12:51:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89B0811C050;
 Wed, 20 Mar 2019 12:51:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3884411C05E;
 Wed, 20 Mar 2019 12:51:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2019 12:51:17 +0000 (GMT)
Received: from localhost (unknown [9.102.58.243])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BAA5AA0129;
 Wed, 20 Mar 2019 23:51:13 +1100 (AEDT)
From: Michael Ellerman <michaele@au1.ibm.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Disable kcov for slb routines.
In-Reply-To: <3e0bd37b-5e34-f056-250c-c36bd495ea94@linux.vnet.ibm.com>
References: <44Kn0q0xN3z9s71@ozlabs.org>
 <3e0bd37b-5e34-f056-250c-c36bd495ea94@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2019 23:51:12 +1100
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19032012-4275-0000-0000-0000031D3F4D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032012-4276-0000-0000-0000382BC375
Message-Id: <87woktyain.fsf@concordia.ellerman.id.au>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-20_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=562 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200099
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: syzkaller@googlegroups.com, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, Andrew Donnellan <andonnel@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> On 3/14/19 5:13 PM, Michael Ellerman wrote:
>> On Mon, 2019-03-04 at 08:25:51 UTC, Mahesh J Salgaonkar wrote:
>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>
>>> The kcov instrumentation inside SLB routines causes duplicate SLB entries
>>> to be added resulting into SLB multihit machine checks.
>>> Disable kcov instrumentation on slb.o
>>>
>>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>>> Tested-by: Satheesh Rajendran <sathnaga@linux.vent.ibm.com>
>> 
>> Applied to powerpc next, thanks.
>> 
>> https://git.kernel.org/powerpc/c/19d6907521b04206676741b26e05a152
>> 
>> cheers
>> 
>
> There was a v2 at http://patchwork.ozlabs.org/patch/1051718/, looks like
> v1 got picked up. But I see the applied commit does address Andrew's
> comments.

Sorry not sure how I missed v2.

cheers

