Return-Path: <michael@ellerman.id.au>
Subject: Re: [Fastboot] Documentation feedback request.
From: Michael Ellerman <michael@ellerman.id.au>
To: David Wilder <dwilder@us.ibm.com>
In-Reply-To: <444FB2AF.3020802@us.ibm.com>
References: <444FB2AF.3020802@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-21zlVN4+iSfsWeMNNJSr"
Date: Thu, 27 Apr 2006 09:44:31 +1000
Message-Id: <1146095071.29876.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, fastboot@lists.osdl.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-21zlVN4+iSfsWeMNNJSr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

Nice work. Few comments below ...

On Wed, 2006-04-26 at 10:49 -0700, David Wilder wrote:
> Attached is a updated  Documentation/kdump/kdump.txt.  Please provide=20
> comments.  I will incorporate your feedback and send up to Linus.
>=20
> plain text document attachment (kdump-final-20060425.txt)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Documentation for Kdump - The kexec-based Crash Dumping Solution
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This document includes overview, setup and installation, and analysis
> information.
>=20
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Kdump uses kexec to quickly boot to a dump-capture kernel whenever a
> dump of the system kernel's memory needs to be taken (for example, when
> the system panics). The system kernel's memory image is preserved across
> the reboot and is accessible to the dump-capture kernel.
>=20
> You can use common Linux commands, such as cp and scp, to copy the
> memory image to a dump file on the local disk, or across the network to
> a remote system.
>=20
> Kdump and kexec are currently supported on the x86, x86_64, and ppc64
> architectures.

s/ppc64/64-bit powerpc/ ?

> When the system kernel boots, it reserves a small section of memory for
> the dump-capture kernel. This ensures that ongoing Direct Memory Access
> (DMA) from the system kernel does not corrupt the dump-capture kernel.=20
> The kexec -p command loads the dump-capture kernel into this reserved
> memory.

Well hopefully ;)

> On x86 machines, the first 640 KB of physical memory is needed to boot,
> regardless of where the kernel loads. Therefore, kexec backs up this
> region just before rebooting into the dump-capture kernel.
>=20
> All of the necessary information about the system kernel's core image is
> encoded in the ELF format, and stored in a reserved area of memory
> before a crash. The physical address of the start of the ELF header is
> passed to the dump-capture kernel through the elfcorehdr=3D boot
> parameter.
>=20
> With the dump-capture kernel, you can access the memory image, or "old
> memory," in two ways:
>=20
> - Through a /dev/oldmem device interface. A capture utility can read the
>   device file and write out the memory in raw format. This is a raw dump
>   of memory. Analysis and capture tools must be intelligent enough to
>   determine where to look for the right information.
>=20
> - Through /proc/vmcore. This exports the dump as an ELF-format file that
>   you can write out using file copy commands such as cp or scp. Further,
>   you can use analysis tools such as the GNU Debugger (GDB) and the Crash
>   tool to debug the dump file. This method ensures that the dump pages ar=
e
>   correctly ordered.
>=20
>=20
> Setup and Installation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Install kexec-tools and the Kdump patch
> ---------------------------------------
>=20
> 1) Login as the root user.
>=20
> 2) Download the kexec-tools user-space package from the following URL:
>=20
>    http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz
>=20
> 3) Unpack the tarball with the tar command, as follows:
>=20
>    tar xvpzf kexec-tools-1.101.tar.gz
>=20
> 4) Download the latest consolidated Kdump patch from the following URL:
>=20
>    http://lse.sourceforge.net/kdump/
>   =20
>    (This location is being used until all the user-space Kdump patches
>    are integrated with the kexec-tools package.)
>   =20
> 5) Change to the kexec-tools-1.101 directory, as follows:
>=20
>    cd kexec-tools-1.101
>=20
> 6) Apply the consolidated patch to the kexec-tools-1.101 source tree
>    with the patch command, as follows. (Modify the path to the downloaded
>    patch as necessary.)
>   =20
>    patch -p1 < /path-to-kdump-patch/kexec-tools-1.101-kdump.patch
>=20
> 7) Configure the package, as follows:
>=20
>    ./configure
>=20
> 8) Compile the package, as follows:
>=20
>    make
>=20
> 9) Install the package, as follows:
>=20
>    make install
>=20
>=20
> Download and build the system and dump-capture kernels
> ------------------------------------------------------
>=20
> Download the mainline (vanilla) kernel source code (2.6.13-rc1 or newer)
> from http://www.kernel.org. Two kernels must be built: a system kernel
> and a dump-capture kernel. Use the following steps to configure these
> kernels with the necessary kexec and Kdump features:
>=20
> System kernel
> -------------
>=20
> 1) Enable "kexec system call" in "Processor type and features."
>=20
>    CONFIG_KEXEC=3Dy
>=20
> 2) Enable "sysfs file system support" in "Filesystem" -> "Pseudo
>    filesystems." This is usually enabled by default.
>=20
>    CONFIG_SYSFS=3Dy
>=20
>    Note that "sysfs file system support" might not appear in the "Pseudo
>    filesystems" menu if "Configure standard kernel features (for small
>    systems)" is not enabled in "General Setup." In this case, check the
>    .config file itself to ensure that sysfs is turned on, as follows:
>=20
>    grep 'CONFIG_SYSFS' .config

Is there a particular requirement for sysfs?

> 3) Enable "Compile the kernel with debug info" in "Kernel hacking."
>=20
>    CONFIG_DEBUG_INFO=3DY
>=20
>    This causes the kernel to be built with debug symbols. The dump
>    analysis tools require a vmlinux with debug symbols in order to read
>    and analyze a dump file.
>           =20
> 4) Make and install the kernel and its modules. Update the boot loader
>    (such as grub, yaboot, or lilo) configuration files as necessary.
>=20
> 5) Boot the system kernel with the boot parameter "crashkernel=3DY@X",
>    where Y specifies how much memory to reserve for the dump-capture kern=
el
>    and X specifies the beginning of this reserved memory. For example,
>    "crashkernel=3D64M@16M" tells the system kernel to reserve 64 MB of me=
mory
>    starting at physical address 0x01000000 for the dump-capture kernel.

Most of this doesn't apply to powerpc.

>    On x86 and x86_64, use "crashkernel=3D64M@16M".
>=20
>    On ppc64, use "crashkernel=3D128M@32M".

No just use "crashkernel=3D128M".

> The dump-capture kernel
> -----------------------
>=20
> 1) Under "General setup," append "-kdump" to the current string in
>    "Local version."
>=20
> 2) On x86, enable high memory support under "Processor type and
>    features":
>=20
>    CONFIG_HIGHMEM=3Dy
>=20
> 3) On x86 and x86_64, disable symmetric multi-processing support
>    under "Processor type and features":
>   =20
>    CONFIG_SMP=3Dn
>=20
> 4) On ppc64, disable NUMA support and enable EMBEDDED support:
>   =20
>    CONFIG_NUMA=3Dn
>    CONFIG_EMBEDDED=3Dy
>    CONFIG_EEH=3DN for the dump-capture kernel

Why are we disabling NUMA? AFAIK we work on more systems with NUMA than
without?
And why are we turning off EMBEDDED and EEH?

> 5) Enable "kernel crash dumps" support under "Processor type and
>    features":
>=20
>    CONFIG_CRASH_DUMP=3Dy
>=20
> 6) Use a suitable value for "Physical address where the kernel is
>    loaded" (under "Processor type and features"). This only appears when
>    "kernel crash dumps" is enabled. By default this value is 0x1000000
>    (16MB). It should be the same as X in the "crashkernel=3DY@X" boot
>    parameter discussed above.
>=20
>    On x86 and x86_64, use "CONFIG_PHYSICAL_START=3D0x1000000".
>      =20
>    On ppc64 the value is automatically set at 32MB when
>    CONFIG_CRASH_DUMP is set.

This whole step should start "On x86 ..."

> 6) Optionally enable "/proc/vmcore support" under "Filesystems" ->
>    "Pseudo filesystems".

6 + 1 =3D 6 :D

>    CONFIG_PROC_VMCORE=3Dy
>      =20
> 7) Make and install the kernel and its modules. DO NOT add this kernel
>    to the boot loader configuration files.
>   =20
>=20
> Load the Dump-capture Kernel
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
> After booting to the system kernel, load the dump-capture kernel using
> the following command:
>=20
>    kexec -p <dump-capture-kernel> \
>    --initrd=3D<initrd-for-dump-capture-kernel> --args-linux \
>    --append=3D"root=3D<root-dev> init 1 irqpoll"

I've never tested irqpoll on powerpc, I'm not sure we want to recommend
it, has someone tested it?

> Notes on loading the dump-capture kernel:
>=20
> * <dump-capture-kernel> must be a vmlinux image (that is, an
>   uncompressed ELF image). bzImage does not work at this time.
>=20
> * By default, the ELF headers are stored in ELF64 format to support
>   systems with more than 4GB memory. The --elf32-core-headers option can
>   be used to force the generation of ELF32 headers. This is necessary
>   because GDB currently cannot open vmcore files with ELF64 headers on
>   32-bit systems. ELF32 headers can be used on non-PAE systems (that is,
>   less than 4GB of memory).
> 		=20
> * The "irqpoll" boot parameter reduces driver initialization failures
>   due to shared interrupts in the dump-capture kernel.
> 		 =20
> * You must specify <root-dev> in the format corresponding to the root
>   device name in the output of mount command.

> * "init 1" boots the dump-capture kernel into single-user mode without
>   networking. If you want networking, use "init 3."
>=20
>=20
> Kernel Panic
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> After successfully loading the dump-capture kernel as previously
> described, the system will reboot into the dump-capture kernel if a
> panic occurs. You can write a module to force the panic, or use
> "ALT-SysRq-c" to initiate a crash dump for testing purposes.
>=20
>=20
> Write Out the Dump File
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> After the dump-capture kernel is booted, write out the dump file with
> the following command:
>=20
>    cp /proc/vmcore <dump-file>
>=20
> You can also access dumped memory as a /dev/oldmem device for a linear
> and raw view. To create the device, use the following command:
>=20
>     mknod /dev/oldmem c 1 12
>=20
> Use the dd command with suitable options for count, bs, and skip to
> access specific portions of the dump.
>=20
> To see the entire memory, use the following command:
>   =20
>    dd if=3D/dev/oldmem of=3Doldmem.001
>=20
>=20
> Analysis
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Before analyzing the dump image, you should reboot into a stable kernel.
>=20
> You can do limited analysis using GDB on the dump file copied out of
> /proc/vmcore. Use the debug vmlinux built with -g and run the following
> command:
>=20
>    gdb vmlinux <dump-file>
>=20
> Stack trace for the task on processor 0, register display, and memory
> display work fine.
>=20
> Note: GDB cannot analyze core files generated in ELF64 format for x86.=20
> On systems with a maximum of 4GB of memory, you can generate
> ELF32-format headers using the --elf32-core-headers kernel option on the
> dump kernel.
>=20
> You can also use the Crash utility to analyze dump files in Kdump
> format. Crash is available on Dave Anderson's site at the following URL:
>=20
>    http://people.redhat.com/~anderson/
>=20
>=20
> To Do
> =3D=3D=3D=3D=3D
>=20
> 1) Provide a kernel pages filtering mechanism, so core file size is not
>    extreme on systems with huge memory banks.
>=20
> 2) Relocatable kernel can help in maintaining multiple kernels for
>    crash_dump, and the same kernel as the system kernel can be used to
>    capture the dump.
>=20
>=20
> Contact
> =3D=3D=3D=3D=3D=3D=3D
>=20
> Vivek Goyal (vgoyal@in.ibm.com)
> Maneesh Soni (maneesh@in.ibm.com)

fastboot@lists.osdl.org


cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-21zlVN4+iSfsWeMNNJSr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEUAXfdSjSd0sB4dIRAqp+AKDHyCZAYGd1Yk3pW6RyhJr4B4GNGACgsqjl
RSo4qo+ICX2Wzyp770m+K6g=
=dixm
-----END PGP SIGNATURE-----

--=-21zlVN4+iSfsWeMNNJSr--
