Return-Path: <SRS0=zi2C=LT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68DDC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 05:51:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F245C61417
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 05:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F245C61417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GB5hh2JH2z3bvm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 15:51:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Bw/p3P0n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=bharata@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=Bw/p3P0n; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GB5h56QsKz2yWJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 15:50:29 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15P5j6eH118498; Fri, 25 Jun 2021 01:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=HxbJJArdxQqEJfa3XAkD4jiouEa0fm+K5xZwxjTLTTo=;
 b=Bw/p3P0n5m5WCpOnT0mtTDEiD2HS5iIldUE81bp6zIJySph70ciyJT7MvexR/IuFZpds
 7e/TW30J8jM+i5EkgxXfv8Id9x2jqZ6wWOydiF5wO73LUU9GHPHm2R1PHskwcErtTNLl
 Dqquu7NscS7IFwjkTMAKWi/kvELaBsz5nhlltoLIdJKT236nx1Jlr70Io3cSyhHW8wYf
 q5yPsVtTVhhyGawja0vgvSClFKSt6RngJ19XjsrKpjQI2HMrEXLMz6CF9VeTfqz1adW9
 UsSgogEPopaIW0Sqy3SyuHr24UN33KkIY3RiCfpcqgElHiyM2F+qcPafke+0mSXtB5iW eg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 39d98s84my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Jun 2021 01:50:18 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15P5oFD1015646;
 Fri, 25 Jun 2021 05:50:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06fra.de.ibm.com with ESMTP id 3997uhhkaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Jun 2021 05:50:15 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 15P5oD4M32375074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Jun 2021 05:50:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FBBA11C050;
 Fri, 25 Jun 2021 05:50:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96E7D11C064;
 Fri, 25 Jun 2021 05:50:11 +0000 (GMT)
Received: from in.ibm.com (unknown [9.85.119.88])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Jun 2021 05:50:11 +0000 (GMT)
Date: Fri, 25 Jun 2021 11:20:09 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: PowerPC guest getting "BUG: scheduling while atomic" on
 linux-next-20210623 during secondary CPUs bringup
Message-ID: <YNVukVCgPjCksagq@in.ibm.com>
References: <YNSq3UQTjm6HWELA@in.ibm.com>
 <20210625054608.fmwt7lxuhp7inkjx@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625054608.fmwt7lxuhp7inkjx@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fego09511Jl2BHF_EjJlLB_hSs1T0pDr
X-Proofpoint-GUID: fego09511Jl2BHF_EjJlLB_hSs1T0pDr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-25_01:2021-06-24,
 2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250030
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
Reply-To: bharata@linux.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Valentin Schneider <valentin.schneider@arm.com>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 25, 2021 at 11:16:08AM +0530, Srikar Dronamraju wrote:
> * Bharata B Rao <bharata@linux.ibm.com> [2021-06-24 21:25:09]:
> 
> > A PowerPC KVM guest gets the following BUG message when booting
> > linux-next-20210623:
> > 
> > smp: Bringing up secondary CPUs ...
> > BUG: scheduling while atomic: swapper/1/0/0x00000000
> > no locks held by swapper/1/0.
> > Modules linked in:
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.13.0-rc7-next-20210623
> > Call Trace:
> > [c00000000ae5bc20] [c000000000badc64] dump_stack_lvl+0x98/0xe0 (unreliable)
> > [c00000000ae5bc60] [c000000000210200] __schedule_bug+0xb0/0xe0
> > [c00000000ae5bcd0] [c000000001609e28] __schedule+0x1788/0x1c70
> > [c00000000ae5be20] [c00000000160a8cc] schedule_idle+0x3c/0x70
> > [c00000000ae5be50] [c00000000022984c] do_idle+0x2bc/0x420
> > [c00000000ae5bf00] [c000000000229d88] cpu_startup_entry+0x38/0x40
> > [c00000000ae5bf30] [c0000000000666c0] start_secondary+0x290/0x2a0
> > [c00000000ae5bf90] [c00000000000be54] start_secondary_prolog+0x10/0x14
> > 
> > <The above repeats for all the secondary CPUs>
> > 
> > smp: Brought up 2 nodes, 16 CPUs
> > numa: Node 0 CPUs: 0-7
> > numa: Node 1 CPUs: 8-15
> > 
> > This seems to have started from next-20210521 and isn't seen on
> > next-20210511.
> > 
> 
> Bharata,
> 
> I think the regression is due to Commit f1a0a376ca0c ("sched/core:
> Initialize the idle task with preemption disabled")
> 
> Can you please try with the above commit reverted?

Yes, reverting that commit helps.

Regards,
Bharata.
