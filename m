Message-ID: <38FBA3AA.3864AAA0@execpc.com>
Date: Mon, 17 Apr 2000 18:52:10 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: setpramboot problems
References: <38E6B0BF.1A3FECC5@execpc.com> <38FB9AF7.4E541642@dana.ucc.nau.edu>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tim Wojtulewicz wrote:
> I'm having a small problem wit h SetPRAMBoot.  This is most likely an error on my
> part (doh!).  I used it to set the boot PRAM so I could boot back to macos.  The
> values I used were 2 0 0 9.  I'm thinking this is /dev/hda9.  Is this incorrect?
> Anyways,  I tried to use the zap-PRAM keys to reset the thing, but it doesn't
> recognize that I'm holding them down, and just boots directly back to linux.
> Tried to boot from a cd, computer ignores that I'm holding C down.  System is a
> Pismo Powerbook, Linux PPC 2000, with Ben's 2.2.15-pre14 kernel.  Any ideas?

yaBoot is probably what you use on a pismo, which is an OF booter.  setpramboot
might not effect that.  I think 'C' might be another of the MacOS ROM things,
like the PRAM boot value.  Using OF directly can bypass the ROM, but im not sure
exactly how yaBoot works.  Though a few issues have popped up with setpramboot.

This weekend, I got my hands on some other systems.  I found that the linux
kernel maps NVRAM differently on NewWorld systems (OF >= 3.0), which includes
the 101/lombard.  As a result, the 4 bytes setpramboot modifies are in a
different location.  What the kernel does also seems to break nvsetenv.  using
hexdump on /dev/nvram, the PRAM boot location is on line 0x1370 with oldworld,
and 0x1220 with newworld if i recall correctly.  Any kernel maintainers know why
this happens?  (running Paul's 2.2.15pre17, dmesg lists where various nvram
sections are mapped, so the kernel knows that the address is different)

Regarding setpramboot, its definitely still a work in progress.  I still have
yet to figure out the meaning of the code when the bus is scsi.  the ata setting
makes sense, but the SCSI setting is still cryptic.  fyi, even if scsi, 'System
Disk' still only changes those 4 bytes, so a simple cut and paste of known
correct values would work.  Maybe I should put a hexcode option in the
/etc/pramtab.

I might have a chance update setpramboot this weekend.

Thanks.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

"Did you ever notice how the Chinese Abacus, with 2 '5' beads and 5 '1'
beads, is perfect for hexidecimal math?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
