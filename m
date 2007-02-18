Return-Path: <dgibson@ozlabs.org>
Date: Sun, 18 Feb 2007 11:22:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 19/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070218002220.GB29434@localhost.localdomain>
References: <20070212205438.GB17285@ld0162-tx32.am.freescale.net>
	<45D0DE6C.1040207@am.sony.com>
	<20070213161337.GD24815@ld0162-tx32.am.freescale.net>
	<45D1F61B.6020104@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D1F61B.6020104@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 09:32:11AM -0800, Geoff Levand wrote:
> Scott Wood wrote:
> >> It may be better to do it like this, as there will be more platforms that
> >> need to hook in specific files.
> >> 
> >> src-plat-$(CONFIG_COMPAT_UIMAGE) += $(cuboot-plats:%=cuboot-%.c)
> >> src-plat-$(CONFIG_XXX) += ...
> >> src-plat-$(CONFIG_YYY) += ...
> >> ...
> >> src-plat := of.c $(src-plat-y)
> > 
> > Take it up with Paul.  He said that all platform files shall always be
> > built, and that the wrapper script picks which ones to link.
> 
> 
> That is what this sets up, for all platforms the kernel is built to support,
> all the corresponding wrapperbits are built.
> 
> The problem I see with what you have done is that if there is a single bug in the
> wrapperbits for any platform, all zImage builds for ANY platform will fail, even
> platforms the kernel is not configured to support.
> 
> I think most people only build for a few platforms and would not want to
> be inconvenienced buy a bug in a platform they have no interest in, and 
> in general, I don't think platform maintainers want to inconvenience people
> with platform specific bugs when they are not building for that platform.

On the other hand, this property means it's far less likely that
people will break platforms they're not actively working on at the
time.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
