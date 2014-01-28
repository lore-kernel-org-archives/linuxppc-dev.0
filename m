Return-Path: <cengelma@gmx.at>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F2BE62C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 08:19:43 +1100 (EST)
Received: from spike ([81.217.122.98]) by mail.gmx.com (mrgmx002) with ESMTPSA
 (Nemesis) id 0LoE4f-1VbdzY3gGf-00gDBO for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:30 +0100
Date: Tue, 28 Jan 2014 22:14:28 +0100
From: Christian Engelmayer <cengelma@gmx.at>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/sysdev: Fix a mpic section mismatch for MPC85xx
Message-ID: <20140128221428.4c5b49f2@spike>
In-Reply-To: <20131220000041.05da4209@spike>
References: <20131215193856.1637accd@spike>
 <1387152653.15730.175.camel@pasglop>
 <20131220000041.05da4209@spike>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 Dec 2013 00:00:41 +0100, Christian Engelmayer <cengelma@gmx.at> wrote:
> On Mon, 16 Dec 2013 11:10:53 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Sun, 2013-12-15 at 19:38 +0100, Christian Engelmayer wrote:
> > > Moved arch/powerpc/sysdev/mpic.c : smp_mpic_probe() out of the __init section.
> > > It is referenced by arch/powerpc/platforms/85xx/smp.c : smp_85xx_setup_cpu().
> > 
> > I don't like this. The reference is not actually going to call into the
> > code at all and as such is not an error, it's just a pointer comparison.
> 
> That's correct. I proposed it that way because on first sight I was concerned
> that there is an address of an __init function assigned to a function pointer
> within a non __initdata struct at all that can be compared against. However,
> further usage of smp_ops->probe is currently safe of course and *_ops symbols
> within .data are whitelisted to refer to init sections.
> 
> > If there is no way to silence the warning, then I'd suggest to use a
> > global flag, something like mpc85xx_pic_type and test that instead
> > of comparing the pointers.
> 
> I've seen that there is currently a patch proposed against
> 
>    commit dc2c9c52b604f51b1416ed87ff54a1c77a1a8b5b
>    powerpc/85xx: Set up doorbells even with no mpic
> 
> that introduced the section causing the warning:
> 
>    http://patchwork.ozlabs.org/patch/289214/
>    powerpc/85xx: don't init the mpic ipi for the SoC which has doorbell support
> 
> This patch also removes the affected pointer comparison and if accepted would
> thus also silence this warning.

Kevin's change (powerpc/85xx: don't init the mpic ipi for the SoC which has
doorbell support) entered mainline by merge 1b17366d. I verified that the
issue is thereby solved and my patch obsolete.

   http://patchwork.ozlabs.org/patch/301402/

Regards,
Christian
