Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 14B422BDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 22:46:51 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Sep 2004 08:07:16 EDT."
	<Pine.LNX.4.60.0409210741150.9337@dell.enoriver.com>
Date: Tue, 21 Sep 2004 14:45:58 +0200
Sender: wd@denx.de
Message-Id: <20040921124603.C7B49C108D@atlas.denx.de>
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0409210741150.9337@dell.enoriver.com> you wrote:
> 
> > These things have nothing to do with each other.
> 
>    ok, i was definitely unclear about the point i was trying to make, 
> so let me rephrase.  i understand that the patch itself is independent 
> from the code to copy/install it -- your point is well taken, and i 
> accept that the ucode patch itself works just fine.  but, in this 
> context, it's premature to say that it clearly "obsoletes" the older 
> patch given that micropatch.c could never have installed it 

I repeat: these things have nothing to do with each other.

The uCode patch may even be used in a completely different  OS  where
there  is no such thing like micropatch.c. and still the I2C/SPI/SMC1
obsoletes the older I2C/SPI  patch.  Your  terms  "presumptuous"  and
"premature" are inappropriate.

> been tested in the current situation.  that's all i meant.  anyone who 
> took your advice and moved up to the newer patch and installed it 
> would have been in for a rude awakening.

We were discussiong a NEW implementation for 2.6,  right?  Of  course
you  will  have  to fix the known problems. Anybody who is trying the
old code on - say - a MPC859 will experience much severe problems.

>    and, besides, who's to say that the new I2C/SPI/SMC1 patch 
> "obsoletes" the older I2C/SPI patch?  what if someone *wants* just the 

Motorola/Freescale ?

> older relocation and has no need to move SMC1?  the older patch works. 

What does it hurt?

> observation.  i've been told, more than once, that my suggestions 
> regarding applying microcode patches are not viable -- that it's "not 
> that easy".  but no one seems prepared to explain exactly why.

Arg... You must have bad memory. For example:

> Subject: Re: more questions about 8xx microcode patches
> From: Wolfgang Denk <wd@denx.de>
> Date: Wed, 28 Jul 2004 00:30:28 +0200
> To: "Robert P. J. Day" <rpjday@mindspring.com>
> Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
...
> Just to add to the complexity: are you aware that the  parameter  RAM
> relocation  may  be  different between 8xx processors? For example it
> seems that on the 866 family  you  can  relocate  PRAM  even  without
> loading any uCode by just writing the correct offset to (for example)
> the spi_rpbase register.

I also explained to you that the assumption that *_rpbase == 0  means
that no uCode patch is installed is wrong, and that code which writes
0 into this register will crash on such processors.

And so on. You received similar explanations why selecting a specific
processor model is complicated. 

>    i've proposed a simple, *workable* solution for selecting ucode 
> patches from a short, established list.  if you don't think it will 
> work, by all means, explain why, without resorting to "it's not that 
> easy" or "it's just magic, don't ask."

It will not work, because in the example you showed it does not  take
into  account the complexity of this issue. It's not magic, but there
exisit many differenc combinations which you did not deal with.  Just
two examples: (1) differenrt versions of the uCode patch are required
for  MPC850  vs.  other  processors, and (2) you may need to relocate
your parameter RAM on systems which actually don't use any  microcode
for this (like MPC866 and other processors of this family).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The POP3 server service depends on the SMTP  server  service,  which
failed to start because of the following error: The operation comple-
ted successfully."                         -- Windows NT Server v3.51
