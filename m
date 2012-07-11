Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A8F7E2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 10:54:24 +1000 (EST)
Message-ID: <1341968057.18850.21.camel@pasglop>
Subject: Re: [PATCH] powerpc/booke: Eliminate rfi from exception entry path.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 11 Jul 2012 10:54:17 +1000
In-Reply-To: <4FFCCD2D.20407@freescale.com>
References: <20120711003454.GA22757@tyr.buserror.net>
 <E139BF8E-A72C-4977-8FB9-6EED5803AB9A@suse.de>
 <4FFCCD2D.20407@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-07-10 at 19:47 -0500, Scott Wood wrote:
> On 07/10/2012 07:44 PM, Alexander Graf wrote:
> > 
> > On 11.07.2012, at 02:34, Scott Wood wrote:
> >> +#ifdef CONFIG_BOOKE
> >> +	/*
> >> +	 * We're not changing address space on Book E, and the extra rfi
> >> +	 * can hurt when virtualized without hardware support -- whereas
> >> +	 * mtmsr can be paravirtualized.
> > 
> > We can always paravirtualize RFI as well if it makes sense.
> 
> I'm not sure that's possible.  We thought about it a while back, but
> IIRC the difficulty was not leaving a register clobbered.

Besides mtmsr is slow on real HW as well. Also paravirt as done today
for complex instructions like mtmsr is racy :-) (I already had a chat
about that with Alex a while back, we might want to re-consider what
kind of fix can be done at some point).

Cheers,
Ben.
