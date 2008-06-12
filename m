Return-Path: <madhvesh.s@ap.sony.com>
Received: from mail214-va3-R.bigfish.com (mail-va3.bigfish.com
	[216.32.180.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17823DDF03
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 00:56:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC] Kprobes for book-e
Date: Thu, 12 Jun 2008 19:59:07 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D28FC85@insardxms01.ap.sony.com>
From: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, rsmadhvesh@vsnl.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote Wednesday, June 11, 2008 8:36 PM
> To: Sulibhavi, Madhvesh
> Cc: rsmadhvesh@vsnl.net; ananth@in.ibm.com;=20
> linuxppc-dev@ozlabs.org; Paul Mackerras
> Subject: Re: [RFC] Kprobes for book-e
>=20
...

> ---------------------------------------------------------------------
> > arch/powerpc/kernel/kprobes.c |   35 ++++++++++++++++++++++++++++++=20
> > +----
> > arch/powerpc/kernel/misc_32.S |    2 +-
> > arch/powerpc/kernel/traps.c   |   26 +++++++++++++++++++++++++-
> > 3 files changed, 57 insertions(+), 6 deletions(-)
>=20
> Your patch got line wrapped by your mailer.  Take a look at =20
> Documentation/email-clients.tx

Yes, i need to correct my emailer (long pending)

>=20
> > static void __kprobes prepare_singlestep(struct kprobe *p, struct
> > pt_regs *regs)
> > {
> > +#ifdef CONFIG_BOOKE
> > +	regs->msr &=3D ~(MSR_EE); /* Turn off 'Externel Interrupt' bits */
> > +	regs->msr &=3D ~(MSR_CE); /* Turn off 'Critical Interrupt' bits */
> > +	regs->msr |=3D MSR_DE;
>=20
> can we remove MSR_EE and MSR_CE here?

Ah! yes? interrupts are enabled while executing the trap
instruction in ppc unlike int3 of x86 where interupts are=20
disabled. kprobe_handler already handles the reentrancy with=20
nmissed count. I think this code can be removed and=20
I will confirm after my test.


-Madhvesh


-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
