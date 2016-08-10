Return-Path: <paubert@iram.es>
Received: from villa.puc.rediris.es (villa.puc.rediris.es
 [IPv6:2001:720:418:ca00::7])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8QmH6zcTzDqSr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 19:27:43 +1000 (AEST)
Date: Wed, 10 Aug 2016 10:52:14 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christian Kujau <lists@nerdbynature.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fix crash during static key init on ppc32
Message-ID: <20160810085214.GA2117@visitor2.iram.es>
References: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
 <alpine.DEB.2.20.14.1608090157090.8131@trent.utfs.org>
 <1470743530.3015.38.camel@kernel.crashing.org>
 <87inv9te2n.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.14.1608092224220.8131@trent.utfs.org>
 <874m6tt8d0.fsf@concordia.ellerman.id.au>
 <1470814054.3015.98.camel@kernel.crashing.org>
 <alpine.DEB.2.20.14.1608100113430.8131@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.14.1608100113430.8131@trent.utfs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2016 at 01:17:55AM -0700, Christian Kujau wrote:
> On Wed, 10 Aug 2016, Benjamin Herrenschmidt wrote:
> > We cannot do those initializations from apply_feature_fixups() as
> > this function runs in a very restricted environment in 32-bit where
> > the kernel isn't running at its linked address and the PTRRELOC()
> > macro must be used for any global accesss.
> > 
> > Instead, split them into a separtate steup_feature_keys() function
> > which is called in a more suitable spot on ppc32.
> 
> Wow, cool. With that applied (on top of mainline from some minutes ago), 
> this PowerPC G4 boots again. Thanks!

Just a question, does sleep work on your PowerBook? 

It has been broken for several releases of the kernel on mine, but I've not
had time to investigate it and it might also be a distro/systemd issue.

    Regards,
    Gabriel
