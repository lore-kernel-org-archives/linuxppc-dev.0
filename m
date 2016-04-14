Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmGdV3CnmzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 09:11:42 +1000 (AEST)
Message-ID: <1460675502.23123.4.camel@neuling.org>
Subject: Re: [PATCH 1/3] powerpc: Complete FSCR context switch
From: Michael Neuling <mikey@neuling.org>
To: Jack Miller <jack@codezen.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 michael@ozlabs.au.ibm.com
Date: Fri, 15 Apr 2016 09:11:42 +1000
In-Reply-To: <CAGXwabSNfXNPZ1-N9f0MnNRVbarHYQY2bfvCsnvGbbQDE4qTRQ@mail.gmail.com>
References: <1460401065-10540-1-git-send-email-jack@codezen.org>
 <1460401065-10540-2-git-send-email-jack@codezen.org>
 <20160413205112.425444de@kryten>
 <CAGXwabRb-Wc8W8m0qP4kLb-oR+fZED8urYr4Asw0bq9kAc8C1w@mail.gmail.com>
 <1460591377.30121.3.camel@neuling.org>
 <CAGXwabSNfXNPZ1-N9f0MnNRVbarHYQY2bfvCsnvGbbQDE4qTRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-14 at 13:39 -0500, Jack Miller wrote:


> > I'm not sure that works on processes before power8.
> >=20
> > There DSCR SPR number 0x11 will always trap and emulate from userspace
> > (see arch/powerpc/kernel/traps.c:emulate_instruction()).  That is not
> > controlled by FSCR and should work on POWER7 where FSCR is not
> > present.  We need to set the inherit bit there too.
> >=20
> > DSCR SPR number 0x3 is controlled by fscr, but it's only avaliable on
> > POWER8.
> >=20

> > > Right now the FSCR switch is conditional on FTR_ARCH_207S which is
> > > more exclusive than FTR_DSCR, but I guess the actual FSCR register is
> > > universal to PPC64 like the fscr field in the thread struct? If so, I
> > > can just move the FSCR save/restore out of the 207 conditional.
> >=20
> > FSCR was only introduced in power8, so it needs to be 207 conditional
> >=20
>=20
> So on P6/P7 (which have FTR_DSCR) set we're potentially mtspr'ing to a
> non-existent register? Yuck. Can at least strip that logic out thanks
> to the full context switch, I think, even if dscr_inherit actually has
> a use.

Yeah, welcome to DSCR... it's horrible. :-(

It's not actually non-existent.  It's just OS only privileged.

Not that that makes much difference, as we still trap and emulate (and
set the inherent bit).

Mikey
