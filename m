Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s77bY3w5yzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 17:00:41 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s77bX6VZYz9sR9
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 17:00:40 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u786xCMg007176
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 03:00:39 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24n8shchhq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Aug 2016 03:00:38 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 17:00:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 598042BB005D
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 17:00:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7870Yau27131932
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 17:00:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7870X0R001871
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 17:00:34 +1000
Date: Mon, 8 Aug 2016 12:30:28 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv: Load correct TOC pointer while waking up from
 winkle.
Reply-To: svaidy@linux.vnet.ibm.com
References: <147040459202.19770.16560483806363144997.stgit@jupiter.in.ibm.com>
 <1470436733.12584.164.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1470436733.12584.164.camel@kernel.crashing.org>
Message-Id: <20160808070028.GF19419@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2016-08-06 08:38:53]:

> On Fri, 2016-08-05 at 19:13 +0530, Mahesh J Salgaonkar wrote:
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > The function pnv_restore_hyp_resource() loads the TOC into r2 from
> > the invalid PACA pointer before fixing r13 value. This do not affect
> > POWER ISA 3.0 but it does have an impact on POWER ISA 2.07 or less
> > leading CPU to get stuck forever.
> 
> When was this broken ? Should this get backported to stable ?

Broken for 4.8-rc1 only after moving the SPRN_HSPRG0 checking to
idle_book3s.S. Hence no back ports needed.

--Vaidy
