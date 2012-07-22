Return-Path: <hughd@google.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 39FBF2C013C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 00:45:14 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so9117551pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jul 2012 07:45:13 -0700 (PDT)
Date: Sun, 22 Jul 2012 07:44:29 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: next/mmotm unbootable on G5: irqdomain
In-Reply-To: <1342962554.29855.23.camel@pasglop>
Message-ID: <alpine.LSU.2.00.1207220742340.1289@eggly.anvils>
References: <alpine.LSU.2.00.1207211911160.1585@eggly.anvils>
 <1342962554.29855.23.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Paul Mundt <lethal@linux-sh.org>,
 Rob Herring <rob.herring@calxeda.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 22 Jul 2012, Benjamin Herrenschmidt wrote:
> On Sat, 2012-07-21 at 19:47 -0700, Hugh Dickins wrote:
> > I have to revert the patch below from mmotm 2012-07-20-16-30 or
> > next-20120720 in order to boot on the PowerPC G5: otherwise it
> > freezes before switching to the framebuffer console - but I'm
> > not certain where because that initial console doesn't scroll
> > (there are mpic messages at bottom and at top of screen, probably
> > later messages at the top but I don't know the sequence).
> 
> Remind me your G5 variant ? (/proc/cpuinfo will do). I'll have a look
> tomorrow (and thanks for testing !).
> 
> > commit 94f036a1f242f98cc30700b7676c07270a9c5c27
> > Author: Grant Likely <grant.likely@secretlab.ca>
> > Date:   Sun Jun 3 22:04:39 2012 -0700
> > 
> > irqdomain: eliminate slow-path revmap lookups

Thanks, Ben - here's my /proc/cpuinfo:

processor	: 0
cpu		: PPC970MP, altivec supported
clock		: 2500.000000MHz
revision	: 1.1 (pvr 0044 0101)

processor	: 1
cpu		: PPC970MP, altivec supported
clock		: 2500.000000MHz
revision	: 1.1 (pvr 0044 0101)

processor	: 2
cpu		: PPC970MP, altivec supported
clock		: 2500.000000MHz
revision	: 1.1 (pvr 0044 0101)

processor	: 3
cpu		: PPC970MP, altivec supported
clock		: 2500.000000MHz
revision	: 1.1 (pvr 0044 0101)

timebase	: 33333333
platform	: PowerMac
model		: PowerMac11,2
machine		: PowerMac11,2
motherboard	: PowerMac11,2 MacRISC4 Power Macintosh 
detected as	: 337 (PowerMac G5 Dual Core)
pmac flags	: 00000000
L2 cache	: 1024K unified
pmac-generation	: NewWorld

Hugh
