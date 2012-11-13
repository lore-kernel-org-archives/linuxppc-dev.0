Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7D2D72C0093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 09:32:40 +1100 (EST)
Message-ID: <1352845961.17444.13.camel@joe-AO722>
Subject: Re: [PATCH V2] wanrouter: Remove it and the drivers that depend on it
From: Joe Perches <joe@perches.com>
To: David Miller <davem@davemloft.net>
Date: Tue, 13 Nov 2012 14:32:41 -0800
In-Reply-To: <20121113.171736.561094209116852795.davem@davemloft.net>
References: <67fe0c5701a8c7cfe06b178cf04b1c5c06592714.1352548454.git.joe@perches.com>
 <20121113.144406.1610017702502358739.davem@davemloft.net>
 <1352837845.12850.3.camel@joe-AO722>
 <20121113.171736.561094209116852795.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, jcmvbkbc@gmail.com,
 harryxiyou@gmail.com, paulus@samba.org, linux@arm.linux.org.uk, richard@nod.at,
 linux-xtensa@linux-xtensa.org, rob@landley.net,
 user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com,
 xiyoulinuxkernelgroup@googlegroups.com,
 user-mode-linux-user@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, chris@zankel.net, isdn@linux-pingi.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 linux-kernel@zh-kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-11-13 at 17:17 -0500, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Tue, 13 Nov 2012 12:17:25 -0800
> 
> > That seems an odd workflow as it leaves dangling CONFIG_<foo>
> > options set, but I guess it doesn't hurt so here it is.
> 
> As you said it's harmless, and more importantly it avoids
> unnecessary conflicts.
> 
> > I just removed the modified arch/.../<foo>defconfig files.
> 
> Something is not right here:

> [davem@drr net-next]$ git am --signoff V2-wanrouter-Remove-it-and-the-drivers-that-depend-on-it.patch 
> Applying: wanrouter: Remove it and the drivers that depend on it
> error: removal patch leaves file contents
> error: net/wanrouter/Kconfig: patch does not apply
> error: removal patch leaves file contents
> error: net/wanrouter/Makefile: patch does not apply
> error: removal patch leaves file contents
> error: net/wanrouter/patchlevel: patch does not apply
> error: removal patch leaves file contents
> error: net/wanrouter/wanmain.c: patch does not apply
> error: removal patch leaves file contents
> error: net/wanrouter/wanproc.c: patch does not apply
> error: removal patch leaves file contents
> error: drivers/net/wan/cycx_drv.c: patch does not apply
> error: removal patch leaves file contents
> error: drivers/net/wan/cycx_main.c: patch does not apply
> error: removal patch leaves file contents
> error: drivers/net/wan/cycx_x25.c: patch does not apply
> error: removal patch leaves file contents
> error: include/linux/cyclomx.h: patch does not apply
> error: removal patch leaves file contents
> error: include/linux/cycx_drv.h: patch does not apply
> error: removal patch leaves file contents
> error: include/linux/wanrouter.h: patch does not apply
> error: removal patch leaves file contents
> error: include/uapi/linux/wanrouter.h: patch does not apply

Right, that is unexpected/odd/interesting.

I was trying to save mailing list bandwidth by reducing
the patch size.

I generated this with
	$ git format-patch -M -D
but it doesn't apply here either. :(

Using
	$ git format-patch -M
does apply correctly.

It's quite a bit larger though. (120KB vs 14)
I'll send the large patch just to netdev.

Joe
