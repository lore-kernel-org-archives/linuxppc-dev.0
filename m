Message-ID: <3EC21651.FA433F3B@intracom.gr>
Date: Wed, 14 May 2003 13:11:29 +0300
From: Michael Grimborounis <mgry@intracom.gr>
MIME-Version: 1.0
To: t.vanremortel@ha.be
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RTAI module install problem
References: <1052901595.7115.5.camel@toni>
Content-Type: text/plain; charset=iso-8859-7
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
Try googling arround for depmod.pl by David Schleef, Erik Andersen and
Stuart Hughes. This is a Perl script you can run on your host system
(sort of a cross-platform depmod.) You will have to modify your makefile
to use that instead of depmod. I get some warnings from it, but
otherwise it works just fine for me. HTH.

Bye,
Michael

Toni Van Remortel wrote:
>
> Hi all.
>
> I'll first tell you in short what I use.
>
> Kernel: linuxppc_2_4_devel (from CVS on may 7th 2003)
> RTAI Patch: ppc_devel_patch_2003_05_04_1125
> Patch went perfect.
>
> Cross-compiler: ELDK ppc_4xx
> Target: EP405
> Host: x86
> INSTALL_MOD_PATH: /tmp/rmdisk_large
>
> Config and vmlinux-compile don't give errors, RTAI is enabled.
> Modules compile OK.
> When installing the modules, I get this error:
>
> cd /tmp/rmdisk_large/lib/modules/2.4.20-rthal5; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
> /tmp/rmdisk_large -r 2.4.20-rthal5; fi
> depmod: ELF file
> /tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/drivers/i2c/i2c-core.o not for this architecture
> depmod: ELF file
> /tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/drivers/i2c/i2c-dev.o
> not for this architecture
> depmod: ELF file
> /tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/drivers/i2c/i2c-proc.o not for this architecture
> ...
> depmod: ELF file
> /tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/net/ipv4/netfilter/iptable_filter.o not for this architecture
> depmod: ELF file
> /tmp/rmdisk_large/lib/modules/2.4.20-rthal5/kernel/net/ipv4/netfilter/iptable_nat.o not for this architecture
> make: *** [_modinst_post] Error 1
>
> OK, this tells me that I'm using a somewhat wrong architecture (probably
> wrong configured).
> Does anybody know how I can solve this?
>
> Thnx.
> --
> Toni Van Remortel <t.vanremortel@ha.be>
> D-science lab
>

--
Michael G. Grimborounis  <mgry@intracom.gr>
Intracom S.A.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
