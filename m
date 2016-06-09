Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQD3B1mZpzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 15:13:10 +1000 (AEST)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rQD393x51z9t5C
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2016 15:13:09 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id 66so216832pfy.1
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Jun 2016 22:13:09 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Cyril Bur <cyrilbur@gmail.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] selftests/powerpc: Add test to check TM ucontext
 creation
In-Reply-To: <20160608040036.13064-3-cyrilbur@gmail.com>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-3-cyrilbur@gmail.com>
Date: Thu, 09 Jun 2016 15:12:51 +1000
Message-ID: <87a8ivlzcc.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

I'm trying not to be too nit picky or difficult on tests, so here's a
pre-written commit message for you:

"The kernel sets up two sets of ucontexts if the signal was to be
delivered while the thread was in a transaction. Expected behaviour is
that the currently executing code is in the first and the checkpointed
state (the state that will be rolled back to) is in the uc_link
ucontext.

The reason for this is that:

 - code which is not TM aware and installs a signal handler will expect
   to see/modify its currently running state in the uc.

 - but, that TM-unaware code may have dynamicially linked against code
   which is TM aware and is doing HTM under the hood, so the
   checkpointed state needs to be made available somewhere

Test if the live and checkpointed state is made stored correctly.
Test:
 - GPRs
 - FP registers
 - VMX
 - VSX
"

> +#define TBEGIN .long 0x7C00051D
> +#define TSUSPEND .long 0x7C0005DD
> +#define TRESUME .long 0x7C2005DD
You define these 3 opcodes in a number of files. I assume you're going
to consolidate them in v2?

> + * The kernel sets up two sets of ucontexts if the signal was to be delivered
> + * while the thread was in a transaction. Expected behaviour is that the
> + * currently executing code is in the first and the checkpointed state (the
> + * state that will be rolled back to) is in the uc_link ucontext.
> + *
> + * The reason for this is that code which is not TM aware and installs a signal
> + * handler will expect to see/modify its currently running state in the uc,
> + * this code may have dynamicially linked against code which is TM aware and is
> + * doing HTM under the hood.

I had real trouble parsing this sentence the first few times. I think
it's missing a while:

The reason for this is that _while_ code which is not TM aware...

(Although it would be better in several sentences :P)

> +++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
> @@ -0,0 +1,96 @@
> +/*
> + * Copyright 2016, Cyril Bur, IBM Corp.
> + * Licensed under GPLv2.
Ironically, it seems this now needs to be GPLv2+, probably with the
regular license grant paragraph.

> +	/* Always be 64bit, don't really care about 32bit */
Forgive my ignorance of the test suite: are we guaranteed this by the
build system, or should we add a SKIP_IF() for it?
> +	for (i = 0; i < NV_GPR_REGS && !fail; i++) {
> +		fail = (ucp->uc_mcontext.gp_regs[i + 14] != gps[i]);
> +		fail |= (tm_ucp->uc_mcontext.gp_regs[i + 14] != gps[i + NV_GPR_REGS]);
> +	}
> +	if (fail)
> +		printf("Failed on %d GPR %lu or %lu\n", i - 1,
> +				ucp->uc_mcontext.gp_regs[i + 13], tm_ucp->uc_mcontext.gp_regs[i + 13]);
> +}
> +

Looking good otherwise!

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXWPrTAAoJEPC3R3P2I92FQWIP/RH3rLRv64p94xGh5JPeALw2
znvpEKMFTo9gw/3CLMXya2nCUPcsmHa7Kpu8ChENYYYczwcCHMc6pNfBHQYZb35O
fR2zMZ8fXZZoj3YwtNUYeDnn5I4ikam6jhKVHPow1Ks85Ct1MTmPbinAlmmCfwjs
PmvgeN25xrIBAE1w3d+uylyexid+ADgejFWDFW7DAHMfbxDbs1IxIpmWG4RRuk16
sL+khVHJB1j6xTk41QuCeO/VdPlRhcIcflGz6DxpKk1YLFv/B2vL6egs/BVUmCsz
Pj897t9GHhqSOZoIs1j/3zAGQ0CuMN7lz0TYg4Y5TtkmaN0b8T/iKDx6hrBe7tRF
Zwed9aixEK1PTfhiTLdr/p1AF3dNvZIsjEfu+0JSJPXIhNMd7a/LAxO76ZrfzC0U
JtC0fPeLadS5fZkaQ/bF6yU5/blbbmItoraUQVf3oLzM1XjISsCzSRIt5U8varbf
En1dzzFukTwuseo8fQsm/hCVcenHAzJcx650kBGm92YahyK4SALfyuZJtIMgaq6G
UynC4+Ea4RMj8kmLuwkpXGPoSV9Rc/ayMg47SyXvXasH5wXMm9e4QgrN5aQXjpgr
sHUgU85CBC4UEzY8WncHd7vKB8dUd6Y45HjmSSG+g9hfi1BoHqMdcTBPvVOeFkZq
dfMw9jhgoPiCvk0qqPGm
=s0ln
-----END PGP SIGNATURE-----
--=-=-=--
