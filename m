Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2EA15DDEDE
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 09:23:19 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions
	and -Os
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
References: <Pine.LNX.4.64.0805020920120.1141@blarg.am.freescale.net>
	<20080502150753.GA7753@ld0162-tx32.am.freescale.net>
	<F62A680D-C2D8-42B0-B4D6-F3A00F228EB1@kernel.crashing.org>
	<03e9cbca081bff8f6db9862bf3d8d028@kernel.crashing.org>
	<BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 03 May 2008 09:23:04 +1000
Message-Id: <1209770584.26383.8.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-02 at 16:34 -0500, Kumar Gala wrote:
> On May 2, 2008, at 12:34 PM, Segher Boessenkool wrote:
> 
> >>> <brokenrecord>
> >>> Why don't we just link with libgcc?
> >>> </brokenrecord>
> >>
> >> Its something of a PITA to do that in the kernel at this point  
> >> since we've duplicated libgcc functionality in it.  I'm sure there  
> >> are some historical reasons this wasn't done to start with.
> >
> > That's the same as saying that it would be a nice cleanup to remove  
> > all
> > that duplicated code now...
> 
> We'll hopefully this thread might spark either an explanation for why  
> we aren't just linking libgcc in a statement that says we should and  
> we can remove the code that implements libgcc functionality.
> 
> How would libgcc linking intermix with modules?  Would we have to  
> EXPORT_SYMBOL() all functions that libgcc implements?  I'm guessing  
> that's varies w/different gcc versions.

The historical reason for not linking with libgcc was around the lines
of "we want to catch when people do stupid things like 64 bits divides
in the kernel".

Nowadays, this is mostly moot and it's accepted that things might want
to do such operations here or there.

I personally don't see any problem with a patch that would make us link
with libgcc and get rid of the hacks.

Ben.
