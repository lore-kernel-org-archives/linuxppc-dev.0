Date: Wed, 30 Aug 2000 22:02:10 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
Message-ID: <20000830220210.C5340@hectic.net>
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC2AB9.D47ADE73@mvista.com> <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC0BF9.38DB6A9A@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39AC0BF9.38DB6A9A@mvista.com>; from mgreer@mvista.com on Tue, Aug 29, 2000 at 12:16:09PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi again,

I'm trying to load a kernel with an initrd image. I have two questions.

First, I'm locating the kernel (via the s-records) at 400000. It then
relocates to 800000. I'm refering to this output:

DINK32_MAX >>go 400000
loaded at:     00400000 00414E20
relocated to:  00800000 00814E20
zimage at:     0040B000 00489577
relocated to:  00815000 00893577
initrd at:     00489577 00533299
relocated to:  00893577 0093D299
avail ram:     00400000 00800000

After that it boots fine.

If I try to locate it at 800000 to begin with, it fails like this:

DINK32_MAX >>go 800000
loaded at:     00800000 00814E20
zimage at:     0080B000 00889577
initrd at:     00889577 00933299
avail ram:     00400000 00800000

Linux/PPC load: root=/dev/ram
Uncompressing Linux...bad gzipped data
exit

Does that make sense to anyone? Not that it disturbs me, but I'm just
curious.

Second, I'm trying to load an initrd image. I put the compressed
filesystem image in arch/ppc/boot/ramdisk.image.gz and then did "make
zImage.initrd", which created zvmlinux.initrd which I'm loading.
However during bootup it says this:

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 4194301k freed

Why does it look at offset 0? Isn't "make zImage.initrd" supposed to
update the ramdisk word to the correct offset?

I tried to pass offsets with the ramdisk_start parameter, but I don't
know exactly what to put there. I tried different byte offsets
(e.g. take the offset from the above relocation messages, or the
offset from objdump extracting the initrd section from
zvmlinux.initrd), but then thought that probably this parameter
expects block offsets. Now, none of these numbers divide by 1024 so I
can't make block numbers out of them.

What am I doing wrong?


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

"Everything that can be invented has been invented."
	-- Charles Duell, head of the U.S. Patent Office, 1899

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
