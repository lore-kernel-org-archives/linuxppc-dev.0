Message-ID: <38C9967B.D3B3B478@amberdata.demon.co.uk>
Date: Sat, 11 Mar 2000 00:42:35 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: 2.3.50+vlab mvme bootload
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.

I've had a shot at booting using your prep bootloader - grabbed the
patch from vlab and dropped it into the bitkeeper 2.3.50 tree. The patch
went in cleanly and the build suceeded.

However it behaves in a strange way. I've only managed to make it
produce any output at all once, and I still don't know what I did to
make it boot that time. Normally it simply sits there and then
eventually goes beep and reboots. Below is the output from the one time
I got any:

Keyboard error 2, using serial console!

Model: IBM PPS Model 6050/6070 (E)
Serial: IBM607055372CD
Processor/Bus frequencies (Hz): 133333333/66666667
Time Base Divisor: 4000
Original MSR: 1030
Original HID0: d000c084
Original R31: 3fb268

PCI: Probing PCI hardware
Configurable PCI resources:
IO Port resources:
   00000000 007fffff 00000100 (@09ff90b8)
     00000000 00000000 40000100 (@09f43198)
       20000000 200000ff 60000101 (@09f43a74)
       01000200 0100021f 60000101 (@09f435a4)
       00001000 00001007 60000101 (@09f4333c)
IO Memory resources:
   00000000 3cffffff 00000200 (@09ff90d4)
     00000000 00000000 40000200 (@09f431b4)
       01000000 01ffffff 60000200 (@09f43cdc)
       013fff00 013fffff 60000200 (@09f43a90)
       02800000 02ffffff 60000200 (@09f4380c)
       00000000 0000001f 60000200 (@09f435c0)
     00000000 00000000 40001200 (@09f431d0)
       000c0000 000c7fff 60007200 (@09f43d84)
       000c0000 000cffff 60007200 (@09f438b4)
       00000000 0000ffff 60007200 (@09f4364c)
Allocation requirements: io=00001000, mem=01a00000
Before actual allocations:
IO Port resources:
   00000000 007fffff 00000100 (@09ff90b8)
     00010000 00010fff 40000100 (@09f43198)
       00000000 000000ff 60000101 (@09f43a74)
       00000000 0000001f 60000101 (@09f435a4)
       00000000 00000007 60000101 (@09f4333c)
IO Memory resources:
   00000000 3cffffff 00000200 (@09ff90d4)
     00000000 018fffff 40000200 (@09f431b4)
       00000000 00ffffff 60000200 (@09f43cdc)
       00000000 007fffff 60000200 (@09f4380c)
       00000000 000000ff 60000200 (@09f43a90)
       00000000 0000001f 60000200 (@09f435c0)
     00000000 000fffff 40001200 (@09f431d0)
       00000000 0000ffff 60007200 (@09f438b4)
       00000000 0000ffff 60007200 (@09f4364c)
       00000000 00007fff 60007200 (@09f43d84)
Allocated PCI resources:
IO Port resources:
   00000000 007fffff 00000100 (@09ff90b8)
     00010000 00010fff 40000100 (@09f43198)
       00010000 000100ff 40000101 (@09f43a74)
       00010100 0001011f 40000101 (@09f435a4)
       00010120 00010127 40000101 (@09f4333c)
IO Memory resources:
   00000000 3cffffff 00000200 (@09ff90d4)
     01000000 028fffff 40000200 (@09f431b4)
       01000000 01ffffff 40000200 (@09f43cdc)
       02000000 027fffff 40000200 (@09f4380c)
       02800000 028000ff 40000200 (@09f43a90)
       02800100 0280011f 40000200 (@09f435c0)
     02900000 029fffff 40001200 (@09f431d0)
       02900000 0290ffff 40007200 (@09f438b4)
       02910000 0291ffff 40007200 (@09f4364c)
       02920000 02927fff 40007200 (@09f43d84)
Calling the emulator.
ROM enabled @2920000
bad signature: 4444.

Linux/PPC load: console=ttyS0 root=/dev/hda5 hda=3079,64,32 hdc=swapdata
-b

Uncompressing the kernel...done
Now building bootinfo...
done
Now booting...
Kernel at 0x00000000, size=0x204024
Initrd at 0x09ff8af8, size=0x0
Boot info 0x00205000, size=0x78
Residual data at 0x00206000
loaded at:     00358050 0036EE70
relocated to:  00800000 00816E20
board data at: 00121FE0 001289EC
relocated to:  00810314 00816D20
zimage at:     00363050 003F0DD0
relocated to:  00817000 008A4D80
avail ram:     00400000 00800000

and then it sat there for a while, then went beep and rebooted.

I assume that the other times it booted it tried to send the output
somewhere other than the serial ports, but it didn't turn up on either
of the video ports. I even tried booting with the keyboard unplugged,
but that didn't work either.

Looks like it is doing some sort of resource reallocation, even if I
have no idea what all the numbers mean yet :-) I assume the 'Calling the
emulator' bit means it tried to execute one of the non-existent video
roms in the system and failed.

I'll try the 2.2.12 one at some point, but my SO is due back from a
business trip tomorrow so hacking productivity will now collapse back to
normal levels :-)

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
