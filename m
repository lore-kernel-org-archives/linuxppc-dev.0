Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 622C02C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Oct 2013 21:20:50 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 18949-06 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 24 Oct 2013 11:20:44 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] [RFC] Emulate "lwsync" to run standard user land on e500
 cores
Date: Thu, 24 Oct 2013 11:18:57 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B73A8@saturn3.aculab.com>
In-Reply-To: <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Kumar Gala" <galak@kernel.crashing.org>,
 "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land =
on e500 cores
>=20
>=20
> On Oct 23, 2013, at 5:15 AM, Scott Wood wrote:
>=20
> > On Wed, 2013-10-23 at 00:07 -0500, Kumar Gala wrote:
> >> On Oct 18, 2013, at 2:38 AM, Wolfgang Denk wrote:
> >>> diff --git a/arch/powerpc/kernel/traps.c =
b/arch/powerpc/kernel/traps.c
> >>> index f783c93..f330374 100644
> >>> --- a/arch/powerpc/kernel/traps.c
> >>> +++ b/arch/powerpc/kernel/traps.c
> >>> @@ -986,6 +986,13 @@ static int emulate_instruction(struct pt_regs =
*regs)
> >>> 		return 0;
> >>> 	}
> >>>
> >>> +	/* Emulating the lwsync insn as a sync insn */
> >>> +	if (instword =3D=3D PPC_INST_LWSYNC) {
> >>> +		PPC_WARN_EMULATED(lwsync, regs);
> >>> +		asm volatile("sync" : : : "memory");
...
> I'm not sure I'm a fan of doing this as it silently hides a =
significant performance impact.
>=20
> Could we possible re-write the userspace instruction to be a 'sync' =
when we hit this?

You'd need to modify the memory without marking the page dirty.
(Which might be interesting for other cpu-dependant optimisations.)

	David
