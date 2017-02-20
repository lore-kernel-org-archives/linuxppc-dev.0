Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRyj45ZZpzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 09:19:20 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vRyj42DmBz9s9Y
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:19:19 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1KMJEU3044692
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 17:19:18 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r2vrqjxp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 17:19:18 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 21 Feb 2017 08:19:15 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 322F42CE8046
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:19:12 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1KMJ4Gu50003968
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:19:12 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1KMIdjt003051
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:18:39 +1100
Subject: Re: [next-20170217] WARN @/arch/powerpc/include/asm/xics.h:124
 .icp_hv_eoi+0x40/0x140
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-next@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Date: Tue, 21 Feb 2017 09:18:14 +1100
In-Reply-To: <alpine.DEB.2.20.1702201402270.4208@nanos>
References: <E96217CD-2ADD-430D-86BD-27FF87752D7F@linux.vnet.ibm.com>
 <87zihhh9mp.fsf@concordia.ellerman.id.au>
 <15420F42-D2C6-4E29-8874-C47F4D61B098@linux.vnet.ibm.com>
 <87mvdhgmhj.fsf@concordia.ellerman.id.au>
 <1487624024.23576.181.camel@au1.ibm.com>
 <alpine.DEB.2.20.1702201402270.4208@nanos>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1487629094.23576.183.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-20 at 14:04 -0800, Thomas Gleixner wrote:
> > HOWEVER. Looking at current upstream code I don't understand the error,
> > the DEBUG_SHIRQ code is calling the driver's handler not the flow
> > handler so it shouldn't be called handle_fasteoi_irq or am I missing
> > something ?
> 
> I tried to invoke the normal handler path which also invokes the flow
> handler, but that breaks on x86 as well for different reasons. I zapped
> that commit and still need to find a way to do that debug thing proper. So
> it's appearence in -next was only temporary.

Ok I see. Yes I wouldn't be surprised if we aren't the only ones to
expect that one get_irq() matches *one* invocation of the flow handler.

We had to hack around this for irq_replay already but at least we have
a hook to do that.

You could possibly use replay, but what's wrong with what the code
currently does which is to just call the driver handler directly ?

Cheers,
Ben.
