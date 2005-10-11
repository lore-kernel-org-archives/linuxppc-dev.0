Return-Path: <reiser@namesys.com>
Received: from rwcrmhc12.comcast.net (rwcrmhc14.comcast.net [204.127.198.54])
	by ozlabs.org (Postfix) with ESMTP id E735868302
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2005 06:12:59 +1000 (EST)
Message-ID: <434C1ACF.5040006@namesys.com>
Date: Tue, 11 Oct 2005 13:04:31 -0700
From: Hans Reiser <reiser@namesys.com>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
References: <20050426211019.GA11579@suse.de> <426F9646.3000407@namesys.com>
	<20051011190133.GA31348@suse.de>
In-Reply-To: <20051011190133.GA31348@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	reiserfs-dev@namesys.com, Jeff Mahoney <jeffm@suse.de>
Subject: Re: [PATCH] make gcc -O1 in fs/reiserfs optional
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sounds good to me.  Thanks Olaf!

Hans

Olaf Hering wrote:

> On Wed, Apr 27, Hans Reiser wrote:
>
>  
>
>>Olaf Hering wrote:
>>
>>    
>>
>>>Jeff,
>>>
>>>you added this EXTRA_CFLAGS= during 2.4 development, I think the broken
>>>compiler was gcc 3.2 on SLES8. Can we turn this -O1 into a .config
>>>option?
>>>      
>>>
>
>  
>
>>Sounds reasonable.
>>    
>>
>
> only compile with -O1 if the (very old) compiler is broken
> We use reiserfs alot in SLES9 on ppc64, and it was never seen
> with gcc33.
>
>Signed-off-by: Olaf Hering <olh@suse.de>
>
>Index: linux-2.6.12-rc3-olh/fs/reiserfs/Makefile
>===================================================================
>--- linux-2.6.12-rc3-olh.orig/fs/reiserfs/Makefile
>+++ linux-2.6.12-rc3-olh/fs/reiserfs/Makefile
>@@ -21,13 +21,7 @@ ifeq ($(CONFIG_REISERFS_FS_POSIX_ACL),y)
> reiserfs-objs += xattr_acl.o
> endif
> 
>-# gcc -O2 (the kernel default)  is overaggressive on ppc32 when many inline
>-# functions are used.  This causes the compiler to advance the stack
>-# pointer out of the available stack space, corrupting kernel space,
>-# and causing a panic. Since this behavior only affects ppc32, this ifeq
>-# will work around it. If any other architecture displays this behavior,
>-# add it here.
>-ifeq ($(CONFIG_PPC32),y)
>+ifeq ($(CONFIG_REISERFS_CC_REDUCE_OPTIMZE),y)
> EXTRA_CFLAGS := -O1
> endif
> 
>Index: linux-2.6.12-rc3-olh/fs/Kconfig
>===================================================================
>--- linux-2.6.12-rc3-olh.orig/fs/Kconfig
>+++ linux-2.6.12-rc3-olh/fs/Kconfig
>@@ -186,6 +186,18 @@ config REISERFS_FS
> 	  If you like it, you can pay us to add new features to it that you
> 	  need, buy a support contract, or pay us to port it to another OS.
> 
>+config REISERFS_CC_REDUCE_OPTIMZE
>+	bool "Reduce CC optimization level to workaround compiler bugs"
>+	depends on PPC32
>+	default n
>+	help
>+	  gcc -O2 (the kernel default) is overaggressive on ppc32 when many inline
>+	  functions are used.  This causes the compiler to advance the stack
>+	  pointer out of the available stack space, corrupting kernel space,
>+	  and causing a panic. Since this behavior only affects ppc32, this ifeq
>+	  will work around it. If any other architecture displays this behavior,
>+	  add it here.
>+
> config REISERFS_CHECK
> 	bool "Enable reiserfs debug mode"
> 	depends on REISERFS_FS
>  
>
