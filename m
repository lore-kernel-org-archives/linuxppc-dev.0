Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945FCC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:55:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0F12084B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0F12084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZJHr2NrNzDqHY
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 07:55:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=stewart@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZJG630TWzDqFY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 07:53:49 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x33KnUhD166069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Apr 2019 16:53:46 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rn3het11f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2019 16:53:46 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.ibm.com>;
 Wed, 3 Apr 2019 21:53:45 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Apr 2019 21:53:42 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x33KrfWT24248334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Apr 2019 20:53:41 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B60A124054;
 Wed,  3 Apr 2019 20:53:41 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 291F1124053;
 Wed,  3 Apr 2019 20:53:40 +0000 (GMT)
Received: from birb.localdomain (unknown [9.81.197.170])
 by b01ledav002.gho.pok.ibm.com (Postfix) with SMTP;
 Wed,  3 Apr 2019 20:53:39 +0000 (GMT)
Received: by birb.localdomain (Postfix, from userid 1000)
 id 475904E87DC; Thu,  4 Apr 2019 07:53:37 +1100 (AEDT)
From: Stewart Smith <stewart@linux.ibm.com>
To: Mathieu Malaterre <malat@debian.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] powerpc: config: skiroot: Add (back) MLX5 ethernet support
In-Reply-To: <CA+7wUsymTA6XO21KRdwD9Pouv1e8w6VUKSA2wbaPHN7Bz215rw@mail.gmail.com>
References: <20190403004926.6702-1-joel@jms.id.au>
 <CA+7wUsymTA6XO21KRdwD9Pouv1e8w6VUKSA2wbaPHN7Bz215rw@mail.gmail.com>
Date: Thu, 04 Apr 2019 07:53:37 +1100
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19040320-0064-0000-0000-000003C60E00
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010868; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183889; UDB=6.00619842; IPR=6.00964641; 
 MB=3.00026283; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-03 20:53:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040320-0065-0000-0000-00003CF04864
Message-Id: <87k1gayfn2.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-03_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030139
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
Cc: Carol L Soto <clsoto@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mathieu Malaterre <malat@debian.org> writes:
> On Wed, Apr 3, 2019 at 2:51 AM Joel Stanley <joel@jms.id.au> wrote:
>>
>> It turns out that some defconfig changes and kernel config option
>> changes meant we accidentally dropped Ethernet support for Mellanox CLX5
>> cards.
>>
>> Reported-by: Carol L Soto <clsoto@us.ibm.com>
>> Suggested-by: Carol L Soto <clsoto@us.ibm.com>
>> Signed-off-by: Stewart Smith <stewart@linux.ibm.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> Fixes: cbc39809a398 ("powerpc/configs: Update skiroot defconfig")
>
> ?

Yes.

-- 
Stewart Smith
OPAL Architect, IBM.

