Message-ID: <408E879A.6070606@fh-landshut.de>
Date: Tue, 27 Apr 2004 18:17:30 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: Magnus Damm <damm@opensource.se>
Cc: mgroeger@sysgo.com, linuxppc-embedded@lists.linuxppc.org
Subject: Different solution
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1>	<20040426220944.GI19246@smtp.west.cox.net>	<408E000A.6040303@fh-landshut.de>	<Pine.LNX.4.56.0404270913230.2035@mag.sysgo.com>	<408E1ED0.4050404@fh-landshut.de>	<Pine.LNX.4.56.0404271119270.2567@mag.sysgo.com>	<408E2AF4.2050907@fh-landshut.de>	<Pine.LNX.4.56.0404271313190.3729@mag.sysgo.com>	<408E55DD.7080806@fh-landshut.de> <20040427153908.4f1eeb8a.damm@opensource.se>
In-Reply-To: <20040427153908.4f1eeb8a.damm@opensource.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Magnus Damm wrote:
>
> I don't know what magic patches that are applied to the mvl-3.1 kernel
> that a customer of mine use, but we use one kernel with initrd (ext2fs)
> and nfs root + ip pnp support. Then we select at boot-time how we want
> to boot the system:
>
> Development: "noinitrd ip=on nfsroot=192.168.1.1:/home/nfs/foobar"
> Standalone: "ip=off"
>
> We boot a "Gzipped Multi-File Image" from u-boot, but I guess that booting
> a standard zImage from anywhere would do too.
>

A quicker solution was to use my flash as a JFFS2 root filesystem (it
was actually quite complicated, because write support in the kernel
(MTD) is broken for the onboard flash chip - well, read it on the
linux-mtd ;) ). I now mount this readonly, and I have a filesystem
without needing to reserve RAM for it - where the initrd resides. So
this is actually a better solution, that utilizes my ressources better. :)

I would like to still found a solution incorporating an initrd, but in
this case only for completeness' sake.


Anybody ideas about how of if to set the following parameters:

root, rootfstype, keepinitrd

and any others needed to use the initrd?

Residual-Data Located at: $01F5511C
loaded at: 00005400 001655BC
relocated to: 00800000 009601BC
zimage at: 008058B0 008C16FA
initrd at: 008C2000 0095D000
avail ram: 00400000 00800000

I'm a bit unsure whether these are good values, or if the place the
initrd is relocated to at loading is actually problematic - e.g.
problematic with regards to HIGHMEM, or end of memory. I have 32MB of
physical mem.

Hope I didn't demotivate anyone to find a solution, though! ;)

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
