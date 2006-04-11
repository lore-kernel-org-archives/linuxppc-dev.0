Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3167B67B24
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 04:42:15 +1000 (EST)
Date: Tue, 11 Apr 2006 20:42:08 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
Message-ID: <20060411184208.GA12171@suse.de>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<20060402194044.GA866@suse.de>
	<17460.39696.910677.444426@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17460.39696.910677.444426@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Thu, Apr 06, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > --- linux-2.6.16-olh.orig/arch/powerpc/Makefile
> > +++ linux-2.6.16-olh/arch/powerpc/Makefile
> > @@ -107,6 +107,7 @@ endif
> >  cpu-as-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
> >  cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
> >  cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
> > +cpu-as-$(CONFIG_6xx)		+= -mcpu=powerpc
> 
> Is this really the right place for this?  The cpu-as- thing is really
> for assembler options.



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
 arch/powerpc/Makefile |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.16-olh/arch/powerpc/Makefile
===================================================================
--- linux-2.6.16-olh.orig/arch/powerpc/Makefile
+++ linux-2.6.16-olh/arch/powerpc/Makefile
@@ -104,6 +104,10 @@ ifndef CONFIG_FSL_BOOKE
 CFLAGS		+= -mstring
 endif
 
+ifeq ($(CONFIG_6xx),y)
+CFLAGS		+= -mcpu=powerpc
+endif
+
 cpu-as-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
