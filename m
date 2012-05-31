Return-Path: <r39252@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CBADB7000
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2012 17:04:50 +1000 (EST)
From: Wrobel Heinz-R39252 <r39252@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>, Steffen Rumler
 <steffen.rumler.ext@nsn.com>
Subject: RE: kernel panic during kernel module load (powerpc specific part)
Date: Thu, 31 May 2012 07:04:42 +0000
Message-ID: <192298D25D96A042975E372855100DB70FEA87@039-SN2MPN1-011.039d.mgd.msft.net>
References: <4FC62FB9.8010701@nsn.com> <1338420242.27402.2.camel@concordia>
In-Reply-To: <1338420242.27402.2.camel@concordia>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael,

> On Wed, 2012-05-30 at 16:33 +0200, Steffen Rumler wrote:
> > I've found the following root cause:
> >
> >      (6) Unfortunately, the trampoline code (do_plt_call()) is using
> register r11 to setup the jump.
> >            It looks like the prologue and epilogue are using also the
> register r11, in order to point to the previous stack frame.
> >            This is a conflict !!! The trampoline code is damaging the
> content of r11.
>=20
> Hi Steffen,
>=20
> Great bug report!
>=20
> I can't quite work out what the standards say, the versions I'm looking
> at are probably old anyway.

The ABI supplement from https://www.power.org/resources/downloads/ is expli=
cit about r11 being a requirement for the statically lined save/restore fun=
ctions in section 3.3.4 on page 59.

This means that any trampoline code must not ever use r11 or it can't be us=
ed to get to such save/restore functions safely from far away.

Unfortunately the same doc and predecessors show r11 in all basic examples =
for PLT/trampoline code AFAICS, which is likely why all trampoline code use=
s r11 in any known case.

I would guess that it was never envisioned that compiler generated code wou=
ld be in a different section than save/restore functions, i.e., the Linux m=
odule "__init" assumptions for Power break the ABI. Or does the ABI break t=
he __init concept?!

Using r12 in the trampoline seems to be the obvious solution for module loa=
ding.

But what about other code loading done? If, e.g., a user runs any app from =
bash it gets loaded and relocated and trampolines might get set up somehow.

Wouldn't we have to find fix ANY trampoline code generator remotely related=
 to a basic Power Architecture Linux?
Or is it a basic assumption for anything but modules that compiler generate=
d code may never ever be outside the .text section? I am not sure that woul=
d be a safe assumption.

Isn't this problem going beyond just module loading for Power Architecture =
Linux?

Regards,

Heinz
