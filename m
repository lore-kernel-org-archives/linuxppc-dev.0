Subject: RE: RTAI module install problem
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3EB9EAA900014D22@mss3n.bluewin.ch>
References: <3EB9EAA900014D22@mss3n.bluewin.ch>
Content-Type: text/plain
Date: 14 May 2003 10:36:26 +0100
Message-Id: <1052904987.1838.8.camel@zambia>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I use the depmod.pl perl script that comes with busybox to create
modules.dep.  This appears to be platform independent.  You need to
apply the patch below to your linux/Makefile (and then change the
definition of DEPMOD to the path of your depmod.pl).  Then you just run

make -C linux INSTALL_MOD_PATH=path/to/target/root/fs modules_install

on your build machine.

This will create the path/to/target/root/fs/lib/modules tree which
includes the modules.dep file.

modprobe should then work on your target.

Alex

diff -u -r1.2 -r1.3
--- Makefile    2003/04/30 12:35:27     1.2
+++ Makefile    2003/05/08 14:32:44     1.3
@@ -38,7 +38,7 @@
 OBJDUMP                = $(CROSS_COMPILE)objdump
 MAKEFILES      = $(TOPDIR)/.config
 GENKSYMS       = /sbin/genksyms
-DEPMOD         = /sbin/depmod
+DEPMOD         =  $(TOPDIR)/../ramdisk/busybox/scripts/depmod.pl
 MODFLAGS       = -DMODULE
 CFLAGS_KERNEL  =
 PERL           = perl
@@ -409,11 +409,11 @@
 ifeq "$(strip $(INSTALL_MOD_PATH))" ""
 depmod_opts    :=
 else
-depmod_opts    := -b $(INSTALL_MOD_PATH) -r
+depmod_opts    := -b $(INSTALL_MOD_PATH)/lib/modules -k $(TOPDIR)/vmlinux > $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)/modules.dep
 endif
 .PHONY: _modinst_post
 _modinst_post: _modinst_post_pcmcia
-       if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
+       if [ -r System.map ]; then $(DEPMOD) -F System.map $(depmod_opts); fi

 # Backwards compatibilty symlinks for people still using old versions
 # of pcmcia-cs with hard coded pathnames on insmod.  Remove



On Wed, 2003-05-14 at 10:07, wolfgang.grandegger@bluewin.ch wrote:
>
> Hi,
>
> the problem is that depmod is for x86 and it can
> therefore not handle PPC binaries. But the errors
> should not harm. On the target you may need to install
> the modules with "insmod" because module.dep is
> not correct. Typically, on an embedded target you
> link the drivers statically into the kernel.
>
> Hope it helps,
>
> Wolfgang.
>
>
> >-- Original Message --
> >Subject: RTAI module install problem
> >From: Toni Van Remortel <t.vanremortel@ha.be>
> >Reply-To: t.vanremortel@ha.be
> >To: linuxppc-embedded@lists.linuxppc.org
> >Date: 14 May 2003 10:39:55 +0200
> >
> >
> >
> >Hi all.
> >
> >I'll first tell you in short what I use.
> >
> >Kernel: linuxppc_2_4_devel (from CVS on may 7th 2003)
> >RTAI Patch: ppc_devel_patch_2003_05_04_1125
> >Patch went perfect.
> >
> >Cross-compiler: ELDK ppc_4xx
> >Target: EP405
> >Host: x86
> >INSTALL_MOD_PATH: /tmp/rmdisk_large
> >
> >Config and vmlinux-compile don't give errors, RTAI is enabled.
> >Modules compile OK.
> >When installing the modules, I get this error:
> >
> >cd /tmp/rmdisk_large/lib/modules/2.4.20-rthal5; \
> >mkdir -p pcmcia; \
> >find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> >pcmcia
> >if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
> >/tmp/rmdisk_large -r 2.4.20-rthal5; fi
> >depmod: ELF file
> >/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/drivers/i2c/i2c-core.o
> >not for this architecture
> >depmod: ELF file
> >/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/drivers/i2c/i2c-dev.o
> >not for this architecture
> >depmod: ELF file
> >/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/drivers/i2c/i2c-proc.o
> >not for this architecture
> >...
> >depmod: ELF file
> >/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/net/ipv4/netfilter/iptable_filter.o
> >not for this architecture
> >depmod: ELF file
> >/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/net/ipv4/netfilter/iptable_nat.o
> >not for this architecture
> >make: *** [_modinst_post] Error 1
> >
> >OK, this tells me that I'm using a somewhat wrong architecture (probably
> >wrong configured).
> >Does anybody know how I can solve this?
> >
> >Thnx.
> >--
> >Toni Van Remortel <t.vanremortel@ha.be>
> >D-science lab
> >
> >
> >
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
