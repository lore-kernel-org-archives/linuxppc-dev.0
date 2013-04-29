Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F6202C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 22:10:04 +1000 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 1/3] rapidio: make enumeration/discovery configurable
Date: Mon, 29 Apr 2013 12:08:49 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D14BC271B9@corpmail1.na.ads.idt.com>
References: <1366813919-13766-1-git-send-email-alexandre.bounine@idt.com>
 <1366813919-13766-2-git-send-email-alexandre.bounine@idt.com>
 <20130426155325.09fbad8c382dc8c549d503d0@linux-foundation.org>
In-Reply-To: <20130426155325.09fbad8c382dc8c549d503d0@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Micha Nelissen <micha.nelissen@Prodrive.nl>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andre van Herk <andre.van.herk@Prodrive.nl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 26 Apr 2013 6:53 PM Andrew Morton <akpm@linux-foundation.org> wrote=
:
> Subject: Re: [PATCH 1/3] rapidio: make enumeration/discovery
> configurable
>=20
> This Kconfig change makes my kbuild do Weird Things.
>=20
> make mrproper ; yes "" | make allmodconfig ; make 2>/tmp/x
... skip ...=20
> :   DMA Engine support for RapidIO (RAPIDIO_DMA_ENGINE) [Y/n/?] y
> :   RapidIO subsystem debug messages (RAPIDIO_DEBUG) [Y/n/?] y
> :   Enumeration method [M/y/?] (NEW) aborted!
> :
> : Console input/output is redirected. Run 'make oldconfig' to update conf=
iguration.
> :
> :   SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_32.h
> :   SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_64.h
> :   SYSHDR
> arch/x86/syscalls/../include/generated/uapi/asm/unistd_x32.h
>=20
>=20
> See the "Enumeration method [M/y/?] (NEW) aborted!"
>=20
> Note that this only happens when make's stderr is redirected.
>=20
> I've no idea what's going on here.  This appears to fix things:
>=20
> --- a/drivers/rapidio/Kconfig~rapidio-make-enumeration-discovery-
> configurable-fix
> +++ a/drivers/rapidio/Kconfig
> @@ -59,7 +59,7 @@ choice
>  	  If unsure, select Basic built-in.
>=20
>  config RAPIDIO_ENUM_BASIC
> -	tristate "Basic"
> +	bool "Basic"
>  	help
>  	  This option includes basic RapidIO fabric enumeration and
> discovery
>  	  mechanism similar to one described in RapidIO specification
> Annex 1.
>=20
> but doesn't appear to be what you intended.

Goal is to build enumerator as a module or built-in.
I will retest v2 of patches for this issue.
There are some changes to Kconfig (removed AUTO_ENUM option).
