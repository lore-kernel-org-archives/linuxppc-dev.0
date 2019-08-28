Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D447C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 15:26:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D79822CED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 15:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D79822CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JV2n3BQtzDrGp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 01:26:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=zohar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JTvP56d8zDqG6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 01:20:17 +1000 (AEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7SFIFlq164848
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 11:20:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2umpb3bt4w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 11:20:11 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.ibm.com>;
 Wed, 28 Aug 2019 16:20:05 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 28 Aug 2019 16:20:01 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7SFK0Zv24510654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 15:20:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D25411C054;
 Wed, 28 Aug 2019 15:20:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26EF411C04A;
 Wed, 28 Aug 2019 15:19:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.129.156])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 28 Aug 2019 15:19:59 +0000 (GMT)
Subject: Re: [PATCH] sefltest/ima: support appended signatures (modsig)
From: Mimi Zohar <zohar@linux.ibm.com>
To: shuah <shuah@kernel.org>, linux-integrity@vger.kernel.org
Date: Wed, 28 Aug 2019 11:19:58 -0400
In-Reply-To: <2f89d09f-1b69-3d77-6846-01bef7d20f39@kernel.org>
References: <1566995946-6582-1-git-send-email-zohar@linux.ibm.com>
 <2f89d09f-1b69-3d77-6846-01bef7d20f39@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082815-0016-0000-0000-000002A3EF99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082815-0017-0000-0000-0000330440F8
Message-Id: <1567005598.6115.40.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-28_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280157
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
Cc: Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
 Petr Vorel <pvorel@suse.cz>, linux-kselftest@vger.kernel.org,
 Jessica Yu <jeyu@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-08-28 at 08:45 -0600, shuah wrote:
> Hi Mimi,
> 
> On 8/28/19 6:39 AM, Mimi Zohar wrote:
> > Detect and allow appended signatures.
> > 
> 
> Can you please add a couple of more sentences on the feature
> and what happens without it? I know this is a test for the
> feature, however, it will be useful for users and testers to
> know more about this test and the feature it is testing.

I've updated the patch description as requested.  

> Also, are there test skip conditions to be concerned about?

The kexec selftests tests the coordination of the different methods of
verifying the kexec kernel image.  As the appended signature support
is part of IMA, there is no new skip conditions.

> Is there a dependency on another tree or would like me to take
> this through kselftest tree?

I would prefer upstreaming this test with the rest of IMA support for
appended signatures.

thanks,

Mimi

