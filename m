Message-ID: <3909F5E0.E4725B71@ccrl.mot.com>
Date: Fri, 28 Apr 2000 15:34:40 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: sym53c8xx SCSI on 8xx?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone every used the sym53c8xx driver in an 8xx system? I seem
to be having several problems - if anyone can offer any insight perhaps
I won't have to re-invent the wheel - though I'm guessing I'll have a
good chunk of work to do anyway.

The first problem seems to be with the way the driver assumes that the
PCI chipset offers access to the (L2 I'm guessing) cache. My take on
this
is that the driver stores "SCRIPTS" in main memory which the controller
directly accesses and executes. The only problem is that the scripts are
actually
cached so when the SCSI controller reads the main memory (through
the PCI bridge - in my case QSPAN II) it doesn't see the data that it
should.
I tested this by adding a flush_dcache_range to the driver before the
SCSI chip accessed that memory - after doing so it read the right data.
So is it true that in a desktop system the PCI chipset would normally be

smart enought to know what is cached and to fetch data from the cache if

appropriate? Do I have to remove this assumption from the driver for
8xx?

My second problem is with endianness. The PCI bridge is doing byte
reversing, so in the driver I've made sure that I/O functions are not
byte
reversed. That works fine - registers on the SCSI chip get the correct
values - except when the value that a register is getting is an address
-
for instance into main memory. It appears that, for instance the dsp
register
on the sym53c8xx controllers is stored big endian though the rest of the
chip
is little endian. So although the driver uses the same I/O macros for
acceses
to the controllers registers - regardless of whether it a regular data
register
or a register containing an address into PPC memory - it appears to me
that
it should be doing something different for these two cases. If anyone is

familiar with this chip (particulary the 53c895A) and can offer insight
into this
I would appreciate it.

Thanks!
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
