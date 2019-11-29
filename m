Return-Path: <SRS0=844/=ZV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF24C432C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 07:59:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF7F21721
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 07:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF7F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47PRjn4sq9zDr9S
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 18:59:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47PRgd0RMCzDqxV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 18:57:32 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAT7vLtD055623
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 02:57:27 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2whcxsgfb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 02:57:26 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAT7p0dR004747
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 07:57:26 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma01dal.us.ibm.com with ESMTP id 2wevd7h19p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 07:57:26 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAT7vP0H33358088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 07:57:25 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F48EAC05E;
 Fri, 29 Nov 2019 07:57:25 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD977AC060;
 Fri, 29 Nov 2019 07:57:23 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.41.201])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 07:57:23 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: Re: [-merge] BUG followed by oops running ndctl tests
In-Reply-To: <6D6FA8CC-7FD3-409E-9CB9-1D3DB5353F7A@linux.vnet.ibm.com>
References: <B0EBF64C-3B57-4716-BAAF-CBC4CBDF5FBC@linux.vnet.ibm.com>
 <86aee55a-3968-cf0d-6030-cbc6e63fddc9@linux.ibm.com>
 <6D6FA8CC-7FD3-409E-9CB9-1D3DB5353F7A@linux.vnet.ibm.com>
Date: Fri, 29 Nov 2019 13:27:20 +0530
Message-ID: <87eexrm7xb.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_01:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=644
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290069
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
Cc: harish@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sachin Sant <sachinp@linux.vnet.ibm.com> writes:

>> On 16-Nov-2019, at 12:25 AM, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.co=
m> wrote:
>>=20
>> On 11/15/19 11:36 AM, Sachin Sant wrote:
>>> Following Oops is seen on latest (commit 3b4852888d) powerpc merge bran=
ch
>>> code while running ndctl (test_namespace) tests
>>> 85c5b0984e was good.
>>=20
>>=20
>>=20
>> Are the namespace size created with size that is multiple of 16M size?
>>=20
>> Wondering whether this is related to https://patchwork.kernel.org/patch/=
11215049/
>
> This patch series doesn=E2=80=99t seem to help. I can still recreate the =
problem with the patches applied.
>

Are the namespace 16MB size aligned? If not you need to recreate all of
them size aligned.

-aneesh
