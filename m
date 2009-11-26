Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DFB511007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 15:35:50 +1100 (EST)
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0C1A25.8030401@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
	<4B0C1A25.8030401@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 15:35:42 +1100
Message-ID: <1259210142.16367.248.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-24 at 18:38 +0100, Albert Herranz wrote:
> Segher Boessenkool wrote:
> > Hi Albert,
> > 
> >> +asm ("\n\
> > 
> > 
> > A file scope asm?!  Please don't.
> > 
> 
> So what's your proposal then? Placing it within a fake func?

Just do a .S file :-)

> That asm snippet is the entry point. I took as an example how prpmc2800.c
> deals with that, providing an own version of the (weak) _zImage_start.

Right but I agree with Segher here, it would be nicer as a .S file.

> >> + * We enter with the cache enabled, the MMU enabled and some known
> >> legacy
> >> + * memory mappings active. xBAT3 is unused
> > 
> > It would be good if you could depend as little as possible on these things;
> > that makes writing another bootloader a lot easier.
> > 
> 
> Ok. I'll do a similar approach as done on the wii bootwrapper.
> 
> >> +    /* IBAT3,DBAT3 for first 16Mbytes */\n\
> >> +    li    8, 0x01ff    /* 16MB */\n\
> >> +    li      9, 0x0002    /* rw */\n\
> >> +    mtspr   0x216, 8    /* IBAT3U */\n\
> >> +    mtspr   0x217, 9    /* IBAT3L */\n\
> >> +    mtspr   0x21e, 8    /* DBAT3U */\n\
> >> +    mtspr   0x21f, 9    /* DBAT3L */\n\
> > 
> > WIMG=0000, are you sure?  Not M=1?
> > 
> 
> To be honest, I don't recall the details now.
> But it was tested in the very early days, the result was not the expected one and,
> in the end, manual cache coherency management was still needed.

Ouch. I wouldn't be surprised if those guys don't do cache coherency
in the bridge anyways.

> So everything is designed and working assuming M=0.
> This can be re-checked again later if needed.

Agreed.

> >> +    bcl-    20,4*cr7+so,1f\n\
> > 
> > Just write  bcl 20,31,1f .
> 
> Ok, I used two variants for this and I know which one you like now ;).

Cheers,
Ben.

> > 
> > 
> > Segher
> > 
> > 
> 
> Thanks,
> Albert
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
