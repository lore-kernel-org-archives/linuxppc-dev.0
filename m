Return-Path: <tnt@246tNt.com>
Received: from outmx027.isp.belgacom.be (outmx027.isp.belgacom.be
	[195.238.4.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 929DEDDE01
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 23:54:51 +1100 (EST)
Received: from outmx027.isp.belgacom.be (localhost [127.0.0.1])
	by outmx027.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l08Cser9013249
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2007 13:54:41 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A23E8E.7010209@246tNt.com>
Date: Mon, 08 Jan 2007 13:52:30 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>	
	<1166528379.19254.69.camel@localhost.localdomain>	
	<4587D338.7060906@246tNt.com>	
	<1166538553.25827.99.camel@pmac.infradead.org>	
	<1166558300.19254.71.camel@localhost.localdomain>	
	<1167773388.22068.443.camel@pmac.infradead.org>	
	<1167773863.6165.82.camel@localhost.localdomain>	
	<1167775493.3660.23.camel@shinybook.infradead.org>	
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>	
	<45A01416.6080401@genesi-usa.com>	
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>	
	<45A1535C.1080007@genesi-usa.com>
	<1168222654.14763.92.camel@shinybook.infradead.org>
	<45A20C66.8060506@genesi-usa.com>
In-Reply-To: <45A20C66.8060506@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, bbrv@genesi-usa.com,
	David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, let's try to at least be a little productive:

Could you tell us at least what in that list will be taken care of,
what you might consider and what you really will never change
while you're standing ;)

Her we go :

1) What I think should absolutely be fixed : (non compliancy
with the ieee1275 document are marked as bug) :
 - PSC init (for PSC2 and PSC6 you said as well): Theses
   are obviously bugs, no argument there.
 - Missing IRQ for the sound node : Again, this is obviously
   missing, the interrupt does exists and it should be in the
   dt, whether or not you think the driver will use it or not.
 - Partition numbering problem (again, an obvious bug)
 - Double \0 : This one is a bug (just confirmed it re-reading
   the specs) Altough I must admit the kernel just won't care
   it's nevertheless a bug and should be
 - "chrp" type : If I understood correctly your previous mail
   you're ok with it.
 - "memory" type of the SRAM: I quote the 1275.pdf, section
   3.7.6 : "In this context, 'memory' refers to traditional
   RAM, suitable for temporary storage of data". I think we
   can agree sram is not conventionnal RAM. You're free (and
   should) still use the reg and available property but not
   the type ram. I must also say that the current fixup I
   implemented doesn't really work because this can only be
   fixed too late ... (node already processed and added as
   normal memory).

2) What I'd really like to see fixed (but that I can't mark as
'bugs' as obviously as the other)
 - The compatible properties of system node (like sram,
   bestcomm and pic) should at least include the mpc52xx-...
   strings as defined in the 'linux' bindings. Better than
   include, be exacty what has been defined but include would
   "do the trick".



3) 'real' Device compatible names : Those can be handled in
the driver, eventually differentiating from other using the
name ... (Although the ata node is really boring because it
_perfectly_ match the defined binding of the 5200 ATA ...)

Without (1), we would need a nvramrc (to fix very early stuff),
and since it's needed, might as well fix everything in nvramrc.
With only (1), we will still need a fixup, but that could
be done in efika_fixup in prom_init.c, since we need fixup
there, we will probably do everything there.
With (1) & (2) the efika will boot, just some driver won't
work so we need to add some more entry in their of_match
but that's acceptable.

> When it doesn't make any difference at all ("sram" and "memory" and
> "ac97" to "sound", the difference between mpc5200-blah and mpc5200b-blah
> and a couple of stray null characters) I feel there's no point whatsoever
> in doing it when it entails that much work.
Well, you're gonna need to change _some_ strings at least (if
not, I'm just loosing my time here ...) I can hardly believe
changing a string to another is that hard, especially if it's
to comply to the specification you claim to be compatible with ;p

(and 'ac97' should be 'sound' as it is now, certainly don't go
change it ;)

> We can't fix the 1.3 firmware, it's already on the
> first production batch, end of story. 
You mean the new firmware can't be flashed to the old boards ?



    Sylvain


PS: I know there are already fixup but ... my mistake I keep
dreaming of a world when things do get fixed without hacks ;-)
