Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by ozlabs.org (Postfix) with SMTP id 0D189B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Jan 2011 06:05:17 +1100 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Tue, 11 Jan 2011 20:05:10 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1294532641.3283.70.camel@localhost>
Message-ID: <20110111190510.154630@gmx.net>
MIME-Version: 1.0
References: <1294532641.3283.70.camel@localhost>
Subject: Re: [PATCH 1/2] powerpc/boot/dts: Install dts from the right directory
To: Ben Hutchings <ben@decadent.org.uk>, paulus@samba.org,
	benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Sun, 09 Jan 2011 00:24:01 +0000
> Von: Ben Hutchings <ben@decadent.org.uk>
> An: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
> CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@lists.ozlabs.org
> Betreff: [PATCH 1/2] powerpc/boot/dts: Install dts from the right directory

> The dts-installed variable is initialised using a wildcard path that
> will be expanded relative to the build directory.  Use the existing
> variable dtstree to generate an absolute wildcard path that will work
> when building in a separate directory.

Wouldn't this patch be a good candidate for the stable kernel series?

> Reported-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Tested-by: Gerhard Pircher <gerhard_pircher@gmx.net> [against 2.6.32]
> ---
>  arch/powerpc/boot/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 96deec6..8917816 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -368,7 +368,7 @@ INSTALL := install
>  extra-installed		:= $(patsubst $(obj)/%, $(DESTDIR)$(WRAPPER_OBJDIR)/%,
> $(extra-y))
>  hostprogs-installed	:= $(patsubst %, $(DESTDIR)$(WRAPPER_BINDIR)/%,
> $(hostprogs-y))
>  wrapper-installed	:= $(DESTDIR)$(WRAPPER_BINDIR)/wrapper
> -dts-installed		:= $(patsubst $(obj)/dts/%, $(DESTDIR)$(WRAPPER_DTSDIR)/%,
> $(wildcard $(obj)/dts/*.dts))
> +dts-installed		:= $(patsubst $(dtstree)/%, $(DESTDIR)$(WRAPPER_DTSDIR)/%,
> $(wildcard $(dtstree)/*.dts))
>  
>  all-installed		:= $(extra-installed) $(hostprogs-installed)
> $(wrapper-installed) $(dts-installed)
>  
> -- 
> 1.7.2.3

Gerhard

-- 
NEU: FreePhone - kostenlos mobil telefonieren und surfen!			
Jetzt informieren: http://www.gmx.net/de/go/freephone
