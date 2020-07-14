Return-Path: <SRS0=DUdi=AZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF38C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11D9214DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11D9214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B5kXS4wNbzDqf6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 01:12:40 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B5kQz1mcLzDq9D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 01:07:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4B5kQw5d8vz8tZk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 01:07:52 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4B5kQw4HH9z9sRN; Wed, 15 Jul 2020 01:07:52 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B5kQw19pRz9sQt;
 Wed, 15 Jul 2020 01:07:50 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06EF3ACR030872; Tue, 14 Jul 2020 11:07:46 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 328s1hqkw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2020 11:07:46 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06EF6Jql030994;
 Tue, 14 Jul 2020 15:07:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04fra.de.ibm.com with ESMTP id 327527hrbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2020 15:07:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06EF7dma53805290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2020 15:07:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B95FBAE057;
 Tue, 14 Jul 2020 15:07:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C3A7AE05A;
 Tue, 14 Jul 2020 15:07:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2020 15:07:38 +0000 (GMT)
Message-ID: <1594739258.12900.164.camel@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/pseries: detect secure and trusted boot
 state of the system.
From: Mimi Zohar <zohar@linux.ibm.com>
To: Daniel Axtens <dja@axtens.net>, Nayna Jain <nayna@linux.ibm.com>,
 linuxppc-dev@ozlabs.org
Date: Tue, 14 Jul 2020 11:07:38 -0400
In-Reply-To: <87y2nmtxce.fsf@dja-thinkpad.axtens.net>
References: <1594434329-31219-1-git-send-email-nayna@linux.ibm.com>
 <87y2nmtxce.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-14_05:2020-07-14,
 2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140113
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-07-14 at 16:38 +1000, Daniel Axtens wrote:
> Hi Nayna,
> 
> Thanks! Would you be able to fold in some of the information from my
> reply to v1 into the changelog? Until we have public PAPR release with
> it, that information is the extent of the public documentation. It would
> be good to get it into the git log rather than just floating around in
> the mail archives!
> 
> A couple of small nits:
> 
> > +	if (enabled)
> > +		goto out;
> > +
> > +	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot)) {
> > +		if (secureboot)
> > +			enabled = (secureboot > 1) ? true : false;
> 
> Your tests double up here - you don't need both the 'if' statement and
> the 'secureboot > 1' ternary operator.
> 
> Just
> 
> +	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot)) {
> +		enabled = (secureboot > 1) ? true : false;
> 
> or even
> 
> +	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot)) {
> +		enabled = (secureboot > 1);
> 
> would work.

I haven't been following this thread, which might be the reason I'm
missing something here.  The patch description should explain why the
test is for "(secureboot > 1)", rather than a fixed number.

thanks,

Mimi
