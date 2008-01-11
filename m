Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 243FDDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 03:13:50 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [PATCH 0/2] [PPC 4xx] L2-cache synchronization for ppc44x
Date: Fri, 11 Jan 2008 18:24:46 +0300
References: <7310408706.20071107014010@emcraft.com>
	<20071128195037.GB22325@gate.ebshome.net>
In-Reply-To: <20071128195037.GB22325@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801111824.46920.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hello, Eugene,

 The h/w snooping mechanism you are talking about is limited to the Low 
Latency (LL) segment of the PLB bus in ppc440sp and ppc440spe chips (see 
section "7.2.7 L2 Cache Coherency" of the ppc440spe spec), whereas DMA and 
XOR engines use the High Bandwidth (HB) segment of PLB bus (see 
section "1.1.2 Internal Buses" of the ppc440spe spec).

 Thus, the h/w snooping mechanism is not able to trace the results of 
operations performed by DMA and XOR engines and keep L2-cache coherent with 
SDRAM, because the data flow through the HB PLB segment. This leads to, for 
example, incorrect results of RAID-parity calculations if one uses the h/w 
accelerated ppc440spe ADMA driver with L2-cache enabled.

 The s/w synchronization algorithms proposed in my patches has no LL PLB 
limitations as opposed to h/w snooping, but, probably, this is not the best 
way of how it might be implemented. Even though with these patches the h/w 
accelerated RAID starts to operate correctly (with L2-cache enabled) there is 
a performance degradation (induced by loops in the L2-cache synchronization 
routines) observed in the most cases. So, as a result, there is no benefit 
from using L2-cache for these, RAID, cases at all.

 Regards, Yuri

On Wednesday 28 November 2007 22:50, Eugene Surovegin wrote:
> On Wed, Nov 07, 2007 at 01:40:10AM +0300, Yuri Tikhonov wrote:
> > 
> >  Hello all,
> > 
> >  Here is a patch-set for support L2-cache synchronization routines for
> > the ppc44x processors family. I know that the "ppc" branch is for 
bug-fixing only, thus
> > the patch-set is just FYI [though enabled but non-coherent L2-cache may 
appear as a bug for
> > someone who uses one of the boards listed below :)].
> > 
> > [PATCH 1/2] [PPC 4xx] invalidate_l2cache_range() implementation for 
ppc44x;
> > [PATCH 2/2] [PPC 44x] enable L2-cache for the following ppc44x-based 
boards: ALPR,
> > Katmai, Ocotea, and Taishan.
> 
> Why is this all needed?
> 
> IIRC ibm440gx_l2c_enable() configures 64G snoop region for L2C.
> 
> Did AMCC made non-only-coherent L2C chips recently?
> 
> -- 
> Eugene
> 
> 

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
