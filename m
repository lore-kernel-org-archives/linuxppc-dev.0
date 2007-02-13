Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id A2A7ADDEFD
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 03:13:44 +1100 (EST)
Date: Tue, 13 Feb 2007 10:13:37 -0600
From: Scott Wood <scottwood@freescale.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 19/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070213161337.GD24815@ld0162-tx32.am.freescale.net>
References: <20070212205438.GB17285@ld0162-tx32.am.freescale.net>
	<45D0DE6C.1040207@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D0DE6C.1040207@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2007 at 01:38:52PM -0800, Geoff Levand wrote:
> Scott Wood wrote:
> > +config CUIMAGE_DTS
> 
> There is nothing CUIMAGE specific with this, so why make it so?  Other
> platforms may like to use it.

Fine, I'll make it BUILTIN_DTS or something.

> It may be better to do it like this, as there will be more platforms that
> need to hook in specific files.
> 
> src-plat-$(CONFIG_COMPAT_UIMAGE) += $(cuboot-plats:%=cuboot-%.c)
> src-plat-$(CONFIG_XXX) += ...
> src-plat-$(CONFIG_YYY) += ...
> ...
> src-plat := of.c $(src-plat-y)

Take it up with Paul.  He said that all platform files shall always be
built, and that the wrapper script picks which ones to link.

> > +ifeq ($(CONFIG_COMPAT_UIMAGE),y)
> > +cuboot-plat-$(CONFIG_83xx) += 83xx
> > +cuboot-plat-$(CONFIG_85xx) += 85xx
> > +cuboot-plat-$(CONFIG_86xx) += 86xx
> > +cuboot-plat-y += unknown-platform
> > +
> > +$(obj)/uImage: vmlinux $(wrapperbits)
> > +	$(call cmd,wrap_dt,cuboot-$(word 1,$(cuboot-plat-y)))
> > +else
> >  $(obj)/uImage: vmlinux $(wrapperbits)
> >  	$(call cmd,wrap,uboot)
> > +endif
> 
> It would be nice if you could make the logic such that you don't need this ifeq.

Do you mean naming the target something other than uImage?

-Scott
