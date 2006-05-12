Return-Path: <nathanpilatzke@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id 99153679F3
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 22:40:11 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id x7so142748nzc
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 05:40:10 -0700 (PDT)
Message-ID: <98889dd30605120540n214800fbk8899fe9e39e972cf@mail.gmail.com>
Date: Fri, 12 May 2006 08:40:09 -0400
From: "Nathan Pilatzke" <nathanpilatzke@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: ppc32 kernel boot problem (pmu related?)
In-Reply-To: <1147403525.7343.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <98889dd30605111207g6afe6158je681717ccacb9e40@mail.gmail.com>
	<1147403525.7343.19.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/11/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Thu, 2006-05-11 at 15:07 -0400, Nathan Pilatzke wrote:
> > I am running an eMac first generation powerpc (700MHz) and the Gentoo
> > distribution.  Kernel 2.6.15 (Gentoo revision 1) is working quite well
> > for me.  A few days ago I compiled 2.6.17-rc3 from the vanilla sources
> > ebuild and am having troubles with the pmu code.
> >
> > I can boot successfully when my config has
> > # CONFIG_ADB_PMU is not set
> > but cannot boot if my config has
> > CONFIG_ADB_PMU=3Dy
>
> What happens when you enable that option ?
>
Sorry, I was a little light on details... I thought this might be a
known problem.  With the pmu option enabled (and early open firmware
messages enabled) I get:

Using PowerMac machine description
Total memory =3D 640MB; using 2048kB for hash table (at cfe00000)
Linux version 2.6.17-rc3 (root@the_emac) (gcc version 3.4.5 (Gentoo 3.4.5-r=
1, ss
p-3.4.5-1.0, pie-8.7.9)) #11 Thu May 11 09:53:39 EDT 2006
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x11
Mapped at 0xfdfc0000
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfdf40000
Processor NAP mode on idle enabled.
PowerMac motherboard: eMac
setup_arch: bootmem
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver v2 initialized for Core99, firmware: 0c
arch: exit
Top of RAM: 0x28000000, Total RAM: 0x28000000
Memory hole size: 0MB
Built 1 zonelists
Kernel command line: root=3D/dev/sda8 ro video=3Dofonly root=3D/dev/sda8 ro=
otdelay=3D10
resume=3D/dev/sda9
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
mpic: ISU size: 64, shift: 6, mask: 3f
mpic: Initializing for 64 sources
PID hash table entries: 4096 (order: 12, 16384 bytes)
time_init: decrementer frequency =3D 24.913389 MHz
time_init: processor frequency   =3D 700.000000 MHz

and then the machine freezes and requires a power cycle to restart.
Without that option enabled I get this:

 PowerMac motherboard: eMac
-setup_arch: bootmem
 Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
 Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
 Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
-via-pmu: Server Mode is disabled
-PMU driver v2 initialized for Core99, firmware: 0c
-arch: exit
+WARNING ! Your machine is PMU-based but your kernel
+          wasn't compiled with CONFIG_ADB_PMU option !
 Top of RAM: 0x28000000, Total RAM: 0x28000000
 Memory hole size: 0MB
+On node 0 totalpages: 163840
+  DMA zone: 163840 pages, LIFO batch:31
 Built 1 zonelists
 Kernel command line: root=3D/dev/sda8 ro video=3Dofonly root=3D/dev/sda8
rootdelay=3D10
resume=3D/dev/sda9
 mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
 mpic: ISU size: 64, shift: 6, mask: 3f
 mpic: Initializing for 64 sources
 PID hash table entries: 4096 (order: 12, 16384 bytes)
 time_init: decrementer frequency =3D 24.913389 MHz
 time_init: processor frequency   =3D 700.000000 MHz
+Console: colour dummy device 80x25
+Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
...

and it continues booting as normal.  As a side note it should be known
that I could not coerce the PowerMac ALSA sound driver to compile
without the PMU enabled either, so there probably should be a config
dependency on it if that is the case.

Anything else I can do?
