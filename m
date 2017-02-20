Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRwqd1QZ3zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 07:54:53 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vRwqc3l18z9sDB
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:54:52 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1KKrZV2139114
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 15:54:50 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r2vmmcyg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 15:54:50 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 21 Feb 2017 06:54:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 36FC63578053
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:54:43 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1KKsZD942795014
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:54:43 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1KKsAVo006291
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:54:11 +1100
Subject: Re: [next-20170217] WARN @/arch/powerpc/include/asm/xics.h:124
 .icp_hv_eoi+0x40/0x140
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, Sachin Sant
 <sachinp@linux.vnet.ibm.com>, tglx@linutronix.de
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Date: Tue, 21 Feb 2017 07:53:44 +1100
In-Reply-To: <87mvdhgmhj.fsf@concordia.ellerman.id.au>
References: <E96217CD-2ADD-430D-86BD-27FF87752D7F@linux.vnet.ibm.com>
 <87zihhh9mp.fsf@concordia.ellerman.id.au>
 <15420F42-D2C6-4E29-8874-C47F4D61B098@linux.vnet.ibm.com>
 <87mvdhgmhj.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1487624024.23576.181.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-20 at 21:55 +1100, Michael Ellerman wrote:
> But when we're called for CONFIG_DEBUG_SHIRQ get_irq() is not called,
> precisely because we're faking an interrupt.
> 
> I'm not sure if there's a good way to fix it :/

In the irq_replay path we have code to adjust the CPPR stack. We could
do something similar.

HOWEVER. Looking at current upstream code I don't understand the error,
the DEBUG_SHIRQ code is calling the driver's handler not the flow
handler so it shouldn't be called handle_fasteoi_irq or am I missing
something ?

Cheers,
Ben.
