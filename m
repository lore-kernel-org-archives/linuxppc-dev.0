Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc0pH5J1ZzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 11:21:43 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v260JJ1v039339
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 19:21:29 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 290byktqsm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 19:21:29 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 6 Mar 2017 10:21:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3513D2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 11:21:24 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v260LGoT45220020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 11:21:24 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v260KpwD012155
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 11:20:51 +1100
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero
 in init_cache_info()
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Gabriel Paubert <paubert@iram.es>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 06 Mar 2017 11:20:26 +1100
In-Reply-To: <20170306001047.GO31469@gate.crashing.org>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
 <87pohw3tp4.fsf@concordia.ellerman.id.au>
 <20170305123737.GM31469@gate.crashing.org>
 <20170305165837.GA2019@visitor2.iram.es>
 <20170305172456.GN31469@gate.crashing.org>
 <1488755341.2870.117.camel@au1.ibm.com>
 <20170306001047.GO31469@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1488759626.2870.120.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-03-05 at 18:10 -0600, Segher Boessenkool wrote:
> You cannot really have something at address 0, the way NULL pointers
> are represented in GCC.  0 in firmware, so *fun*, especially before
> the
> CFAR was invented.  "Something jumped to 0, CTR is 0 so it's probably
> a BCTR, but which one of the 6000?"
> 
> What do you have at 0?  Not anything you need often I hope?

I think it was some kind of boot flag. I've had cases also of
copying the 0..0x100 region over with the kexec gunk etc...

Ben.
