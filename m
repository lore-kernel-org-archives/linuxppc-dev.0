From: wolfgang.grandegger@bluewin.ch
Date: Wed, 14 May 2003 11:07:29 +0200
Message-ID: <3EB9EAA900014D22@mss3n.bluewin.ch>
In-Reply-To: <1052901595.7115.5.camel@toni>
Subject: RE: RTAI module install problem
To: t.vanremortel@ha.be
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

the problem is that depmod is for x86 and it can
therefore not handle PPC binaries. But the errors
should not harm. On the target you may need to install
the modules with "insmod" because module.dep is
not correct. Typically, on an embedded target you
link the drivers statically into the kernel.

Hope it helps,

Wolfgang.


>-- Original Message --
>Subject: RTAI module install problem
>From: Toni Van Remortel <t.vanremortel@ha.be>
>Reply-To: t.vanremortel@ha.be
>To: linuxppc-embedded@lists.linuxppc.org
>Date: 14 May 2003 10:39:55 +0200
>
>
>
>Hi all.
>
>I'll first tell you in short what I use.
>
>Kernel: linuxppc_2_4_devel (from CVS on may 7th 2003)
>RTAI Patch: ppc_devel_patch_2003_05_04_1125
>Patch went perfect.
>
>Cross-compiler: ELDK ppc_4xx
>Target: EP405
>Host: x86
>INSTALL_MOD_PATH: /tmp/rmdisk_large
>
>Config and vmlinux-compile don't give errors, RTAI is enabled.
>Modules compile OK.
>When installing the modules, I get this error:
>
>cd /tmp/rmdisk_large/lib/modules/2.4.20-rthal5; \
>mkdir -p pcmcia; \
>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
>pcmcia
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
>/tmp/rmdisk_large -r 2.4.20-rthal5; fi
>depmod: ELF file
>/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/drivers/i2c/i2c-core.o
>not for this architecture
>depmod: ELF file
>/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/drivers/i2c/i2c-dev.o
>not for this architecture
>depmod: ELF file
>/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/drivers/i2c/i2c-proc.o
>not for this architecture
>...
>depmod: ELF file
>/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/net/ipv4/netfilter/iptable_filter.o
>not for this architecture
>depmod: ELF file
>/tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/net/ipv4/netfilter/iptable_nat.o
>not for this architecture
>make: *** [_modinst_post] Error 1
>
>OK, this tells me that I'm using a somewhat wrong architecture (probably
>wrong configured).
>Does anybody know how I can solve this?
>
>Thnx.
>--
>Toni Van Remortel <t.vanremortel@ha.be>
>D-science lab
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
