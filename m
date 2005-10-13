Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3EAD368570
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2005 09:31:33 +1000 (EST)
Date: Thu, 13 Oct 2005 16:27:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Message-Id: <20051013162734.615bba34.akpm@osdl.org>
In-Reply-To: <20051011190133.GA31348@suse.de>
References: <20050426211019.GA11579@suse.de> <426F9646.3000407@namesys.com>
	<20051011190133.GA31348@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, reiserfs-dev@namesys.com, reiser@namesys.com,
	jeffm@suse.de
Subject: Re: [PATCH] make gcc -O1 in fs/reiserfs optional
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering <olh@suse.de> wrote:
>
>  On Wed, Apr 27, Hans Reiser wrote:
> 
> > Olaf Hering wrote:
> > 
> > >Jeff,
> > >
> > >you added this EXTRA_CFLAGS= during 2.4 development, I think the broken
> > >compiler was gcc 3.2 on SLES8. Can we turn this -O1 into a .config
> > >option?
> 
> > Sounds reasonable.
> 
>  only compile with -O1 if the (very old) compiler is broken
>  We use reiserfs alot in SLES9 on ppc64, and it was never seen
>  with gcc33.
> 

I dunno about this.

> 
> Index: linux-2.6.12-rc3-olh/fs/reiserfs/Makefile
> ===================================================================
> --- linux-2.6.12-rc3-olh.orig/fs/reiserfs/Makefile
> +++ linux-2.6.12-rc3-olh/fs/reiserfs/Makefile
> @@ -21,13 +21,7 @@ ifeq ($(CONFIG_REISERFS_FS_POSIX_ACL),y)
>  reiserfs-objs += xattr_acl.o
>  endif
>  
> -# gcc -O2 (the kernel default)  is overaggressive on ppc32 when many inline
> -# functions are used.  This causes the compiler to advance the stack
> -# pointer out of the available stack space, corrupting kernel space,
> -# and causing a panic. Since this behavior only affects ppc32, this ifeq
> -# will work around it. If any other architecture displays this behavior,
> -# add it here.
> -ifeq ($(CONFIG_PPC32),y)
> +ifeq ($(CONFIG_REISERFS_CC_REDUCE_OPTIMZE),y)
>  EXTRA_CFLAGS := -O1
>  endif
>  
> Index: linux-2.6.12-rc3-olh/fs/Kconfig
> ===================================================================
> --- linux-2.6.12-rc3-olh.orig/fs/Kconfig
> +++ linux-2.6.12-rc3-olh/fs/Kconfig
> @@ -186,6 +186,18 @@ config REISERFS_FS
>  	  If you like it, you can pay us to add new features to it that you
>  	  need, buy a support contract, or pay us to port it to another OS.
>  
> +config REISERFS_CC_REDUCE_OPTIMZE
> +	bool "Reduce CC optimization level to workaround compiler bugs"
> +	depends on PPC32
> +	default n
> +	help
> +	  gcc -O2 (the kernel default) is overaggressive on ppc32 when many inline
> +	  functions are used.  This causes the compiler to advance the stack
> +	  pointer out of the available stack space, corrupting kernel space,
> +	  and causing a panic. Since this behavior only affects ppc32, this ifeq
> +	  will work around it. If any other architecture displays this behavior,
> +	  add it here.
> +

Are you sure it's due to inline functions?  I thought the problem was that
certain versions of gcc did automatic inlining of non-inlined functions and
we get excessive stack windup due to that.  And iirc we put in global
compiler options to defeat that behaviour.  Andi would recall.

Furthermore, we do have infrastructure for detecting the gcc version at
build time.  It would be better to use that for disabling `-O2', rather
than a config option.
