Message-ID: <3A6C8248.88642C68@matrox.com>
Date: Mon, 22 Jan 2001 13:56:08 -0500
From: Sébastien Côté <scote1@matrox.com>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
CC: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems
References: <3A671191.A0254C18@matrox.com> <3A676DC6.FD21D5D8@matrox.com> <20010118130139.A5256@cx258813-a.chnd1.az.home.com> <3A6877E3.AA2238C2@matrox.com> <20010120073535.A15536@beef.az.mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:
> I've done this many times for custom board ports.  Have your JTAG
> probe configure the memory controller.  You then simply drop
> your vmlinux at physical 0.  Take your separate initrd image and
> drop it at a safe place like 0x800000.  Use the JTAG probe to set
> r4 to 0x800000 and r5 to 0x800000 + (<initrd_size> - 1).  Go at
> 0 and you'll boot then root from your initrd.

Ok, now this is exactly what I do.  The initrd doesn't get overwritten
anymore.  The function mount_root is called, the root device is opened
but I get a panic at:

	sb = get_super(ROOT_DEV);
	if (sb) { goto mount_it}
	...

	read_unlock(&file_systems_lock);
	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));

ROOT_DEV = 0x100 (RAM)

However, when I get to this point initrd_start is equal to 0.  I'm not
sure if this is ok, it could have been set to 0 by initrd_release but
I'm not sure.  I'm still fighting with the debugger to step into that
part of the code.

Still, this is better than what I had last week.  Thanks for your help!

Sébastien Côté

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
