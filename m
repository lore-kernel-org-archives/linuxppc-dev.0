Date: Mon, 31 Mar 2003 11:35:52 +0200
From: Toni Van Remortel <t.vanremortel@ha.be>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EP405 linker error.
Message-Id: <20030331113552.58ceec69.t.vanremortel@ha.be>
In-Reply-To: <5.1.0.14.2.20030331011506.02cd4d78@mail.ebshome.net>
References: <20030331111051.74af0790.t.vanremortel@ha.be>
	<5.1.0.14.2.20030331011506.02cd4d78@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 31 Mar 2003 01:17:30 -0800
Eugene Surovegin <ebs@ebshome.net> wrote:

>
> At 01:10 AM 3/31/2003, Toni Van Remortel wrote:
> ....
>
> >  arch/ppc/platforms/platform.o: In function `bios_fixup':
> >  arch/ppc/platforms/platform.o(.text.init+0x23c): undefined reference to
> > `early_write_config_dword'
> >  arch/ppc/platforms/platform.o(.text.init+0x23c): relocation truncated to
> > fit: R_PPC_REL24 early_write_config_dword
> >  arch/ppc/platforms/platform.o(.text.init+0x254): undefined reference to
> > `early_read_config_dword'
> >  arch/ppc/platforms/platform.o(.text.init+0x254): relocation truncated to
> > fit: R_PPC_REL24 early_read_config_dword
> >  make: *** [vmlinux] Error 1
> >
> >So it's a link problem at the final linkage to vmlinux. Does anybody have
> >an idea how I can solve this one? I haven't found anything on Google.
>
> Most probably you have disabled PCI support.
>
> These missing functions are defined in arch/ppc/kernel/pci.c (funny macros
> at the file end)
>
> Eugene

Correct, I disabled PCI because if I enable PCI, I got his error:

 ppc_4xx-gcc -D__KERNEL__ -I/opt/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/opt/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -Wa,-m405   -nostdinc -I /opt/eldk/usr/lib/gcc-lib/ppc-linux/2.95.4/include -DKBUILD_BASENAME=quirks  -c -o quirks.o quirks.c
 quirks.c:693: `PCI_DEVICE_ID_ATI_RADEON_IGP' undeclared here (not in a function)
 quirks.c:693: initializer element is not constant
 quirks.c:693: (near initialization for `pci_fixups[45].device')
 make[3]: *** [quirks.o] Error 1
 make[3]: Leaving directory `/opt/linuxppc_2_4_devel/drivers/pci'
 make[2]: *** [first_rule] Error 2
 make[2]: Leaving directory `/opt/linuxppc_2_4_devel/drivers/pci'
 make[1]: *** [_subdir_pci] Error 2
 make[1]: Leaving directory `/opt/linuxppc_2_4_devel/drivers'
 make: *** [_dir_drivers] Error 2

I didn't know that there was an ATI RADEON on this EP405 ;-) How come that it seeks for that? Wrong .config?

--
Toni Van Remortel - Scientific Researcher
D-science lab (Hogeschool Antwerpen)
Phone: +32 (0) 3 205 61 72
Fax  : +32 (0) 3 205 61 95

Current project:
LinEmb: RealTime and Embedded Linux
(http://linemb.d-sciencelab.com)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
