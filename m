Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8272679FF
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 05:40:50 +1000 (EST)
Date: Sun, 2 Apr 2006 21:40:45 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Set cpu explicitly in kernel compiles
Message-ID: <20060402194044.GA866@suse.de>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, 2005-05-04, Paul Mackeras wrote:

> What do people think of this patch?  The motivation for it is that a
> biarch gcc-4.0 will by default tune for POWER4, even for a 32-bit
> compile, meaning that we end up with a lot of nops we don't need.
> This also takes out -mstring.
> 
> With this, the text size reduces by about 120k for my normal config
> when compiling with a biarch gcc-4.0.  The text size also reduces
> slightly when compiling with the Debian gcc-3.3.5 (32-bit only, not
> biarch).


Compile the 32bit kernel with -mcpu=powerpc. This reduces the imagesize
when a compiler is used that defaults to -mtune=power4. It inserts lots 
of nops to please the 64bit cpu instruction scheduling. But all these nops
are not needed for 32bit kernels.

Example with SLES10 gcc 4.1.0 and arch/powerpc/configs/pmac32_defconfig:

                    vmlinux  vmlinux.strip  vmlinux.gz
 -O2                4980515     4187528      1846829
 -Os                4618801     3827084      1673333
 -O2 -mcpu=powerpc  4738851     3945868      1816253
 -Os -mcpu=powerpc  4532785     3741068      1664688


Signed-off-by: Olaf Hering <olh@suse.de>

---
 arch/powerpc/Makefile |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.16-olh/arch/powerpc/Makefile
===================================================================
--- linux-2.6.16-olh.orig/arch/powerpc/Makefile
+++ linux-2.6.16-olh/arch/powerpc/Makefile
@@ -107,6 +107,7 @@ endif
 cpu-as-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
+cpu-as-$(CONFIG_6xx)		+= -mcpu=powerpc
 cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
