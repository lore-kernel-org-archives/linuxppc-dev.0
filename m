From: Benjamin Herrenschmidt <bh40@calva.net>
To: Joseph Garcia <jpgarcia@execpc.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: setpramboot problems
Date: Tue, 18 Apr 2000 11:29:47 +0200
Message-Id: <20000418092948.17203@mailhost.mipsys.com>
In-Reply-To: <38FBA3AA.3864AAA0@execpc.com>
References: <38FBA3AA.3864AAA0@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 17, 2000, Joseph Garcia <jpgarcia@execpc.com> wrote:

>his weekend, I got my hands on some other systems.  I found that the linux
>kernel maps NVRAM differently on NewWorld systems (OF >= 3.0), which includes
>the 101/lombard.  As a result, the 4 bytes setpramboot modifies are in a
>different location.  What the kernel does also seems to break nvsetenv.
 using
>hexdump on /dev/nvram, the PRAM boot location is on line 0x1370 with
oldworld,
>and 0x1220 with newworld if i recall correctly.  Any kernel maintainers
>know why
>this happens?  (running Paul's 2.2.15pre17, dmesg lists where various nvram
>sections are mapped, so the kernel knows that the address is different)
>
>Regarding setpramboot, its definitely still a work in progress.  I still have
>yet to figure out the meaning of the code when the bus is scsi.  the ata
>setting
>makes sense, but the SCSI setting is still cryptic.  fyi, even if scsi,
>'System
>Disk' still only changes those 4 bytes, so a simple cut and paste of known
>correct values would work.  Maybe I should put a hexcode option in the
>/etc/pramtab.
>
>I might have a chance update setpramboot this weekend.

You may want to look at my latest rsync tree, in arch/ppc/pmac_support.c

(rsync -arvz linuxcare.com.au::linux-pmac-benh .)

I added code to correctly access the nvram (which is in fact a flash) on
new Core99 machines and code to detect the location of the PRAM partition
inside the nvram on all machines. I didn't yet have time to add ioctls to
return those infos to userland, I'll try to do this by next week end.

nvsetenv needs to be fixed too (by either using the same algorithm, or by
using the not-yet-added iotcls). Currently, nvsetenv works on oldworld,
and Marcus Volmer "nvtool" works on newworld for manipulating OF
environement variables.

Basically, the NVRAM is divided in 3 regions:

 - The OF environement variables
 - The MacOS XPRAM (flat region containing things like the "old" macos
boot device, time zone, mouse speed, sound volume, etc...)
 - The MacOS Name Registry persistent properies (a hackish mecanism to
add some persistent nodes to some device tree entries, used for the
backlight setting for example).

My current kernel code can find those 3 regions (thanks to Darwin source)
and had in-kernel accessors for the xpram. I plan to add support for the
Name Registry extensions too, but this is a bit more complicated since
there are at least 2 different formats for those entries and they are a
bit ugly.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
