Date: Thu, 3 Apr 2003 10:26:00 +0200
From: Toni Van Remortel <t.vanremortel@ha.be>
To: Mark Hatle <fray@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EP405 Kernel Panic
Message-Id: <20030403102600.5c1587b7.t.vanremortel@ha.be>
In-Reply-To: <3E8B0058.4030503@mvista.com>
References: <20030402140215.47965273.t.vanremortel@ha.be>
	<3E8B0058.4030503@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 02 Apr 2003 09:23:04 -0600
Mark Hatle <fray@mvista.com> wrote:

>
> This comes up weekly on the mailing list, if you search the archives you'll find
> the canned response:
>
> Make sure you have all of the libraries required by your shell.  If there are
> missing libraries it will return back no init found.
>
> Use objdump or ldd to get a list of the required libraries.  (At the minimum you
> will need /lib/ld.so and /lib/libc.so.)  Alternative is to statically link your
> shell.

[root@toni bin]# ppc_4xx-ldd bash
	libtermcap.so.2 => libtermcap.so.2 (0x0)
	libdl.so.2 => libdl.so.2 (0x0)
	libc.so.6 => libc.so.6 (0x0)
	/lib/ld.so.1 => /lib/ld.so.1 (0x0)

All libs are present in /lib, but why does the last line has /lib explicit here, and the others not?
My system bash has explicit /lib in all of them.

> > RAMDISK: Compressed image found at block 0
> > Freeing initrd memory: 1771k freed
> > VFS: Mounted root (ext2 filesystem) readonly.
> > Freeing unused kernel memory: 76k init
> > Kernel panic: No init found.  Try passing init= option to kernel.
> >
> >
> > So as you can see, the kernel parameters are root=/dev/ram
> > init=/bin/bash, but why does the kernel panic on No init!?
> > /bin/bash does exist in the initrd.
> >
> > Anybody an idea where to look?
> >
> > # file bin/bash
> > bin/bash: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), for GNU/Linux 2.2.5, dynamically linked (uses shared libs), stripped
> > Needed libs are in /lib.
>
>
>


--
Toni Van Remortel - Scientific Researcher
D-science lab (Hogeschool Antwerpen)
Phone: +32 (0) 3 205 61 72
Fax  : +32 (0) 3 205 61 95

Current project:
LinEmb: RealTime and Embedded Linux
(http://linemb.d-sciencelab.com)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
