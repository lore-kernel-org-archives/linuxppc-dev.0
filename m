Date: Mon, 18 Dec 2000 19:24:56 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Torsten Rissel <torsten.rissel@t-online.de>
cc: Matt Porter <mporter@mvista.com>,
        "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: AW: MVME 5100
In-Reply-To: <01C0691A.F7322A20@NB1>
Message-ID: <Pine.HPX.4.10.10012181803410.3991-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 18 Dec 2000, Torsten Rissel wrote:

> [Torsten Rissel]  As I said, this is my first adventure in the wonderful world of PowerPC's,
> but you can judge yourself by a listing of the residual data, as passed over by PPCBUG:

Yes, thanks....

> ProcBus Device, Bus 0, BUID 0:  PNP0A03, BridgeController, PCIBridge, PCIBridgeIndirect
>   Packets describing allocated resources:
>     I/O address (16 bits), at 0xcf8 size 0x8 bytes
>     Chip identification: MOT3131
>     PCI Bridge parameters
>       ConfigBaseAddress fe000cf8
>       ConfigBaseData fe000cfc
>       Bus number 0
>       PCI Slot 1 DevFunc 0x80 interrupt line(s) A/B/C/D routed to MPIC line(s) 9(L)/10(L)/11(L)/12(L)
>       PCI Slot 2 DevFunc 0x88 interrupt line(s) A/B/C/D routed to MPIC line(s) 12(L)/9(L)/10(L)/11(L)
>       Integrated PCI device DevFunc 0x68 interrupt line(s) A/B/C/D routed to MPIC line(s) 5(L)/6(L)/7(L)/8(L)

The first two lines are the PMC modules and the last one the Universe.
Motorola forgot to put the routing for the network interfaces, what's the
point of residual data if you don't even get the interrupt routing correct
(something probably absolutely trivial to add).

>     Bus speed 33333036 Hz, 2 slot(s)
>     Bridge address translation, positive decoding:
>       Processor  Bus        Size       Conversion Translation
>       0x80000000 0x80000000 0x3d000000 Bus Memory direct
>     Bridge address translation, positive decoding:
>       Processor  Bus        Size       Conversion Translation
>       0xfe000000 0x00000000 0x00010000 Bus I/O direct
>     Bridge address translation, positive decoding:
>       Processor  Bus        Size       Conversion Translation
>       0xfe010000 0x00800000 0x007f0000 Bus I/O direct
>     Bridge address translation, positive decoding:
>       Processor  Bus        Size       Conversion Translation
>       0x00000000 0x00000000 0x80000000 DMA direct

Looks like CHRP, DMA addresses are not translated (contrary to what I said
in previous email, sorry I misread the last line), mmio is transparent but
looks limited to less than 1 Gb (0x80000000-0xbd000000), unless the
residual data is wrong which is still a possibility (I still have to see a
100% correct residual data, even trivial things are often obviously wrong
and I have strong suspiscions that this is the case here, since otherwise
the OpenPIC at 0xf3f80000 would not even be accessible).

The only way to know for sure is to dump the Hawk registers in the
0xfeff0040 range (MD feff0040) and the PCI config space of the host bridge
(VER ;E should work, I just need the line at 0x80 for the first device).



>   No packets describing possible resources.
>   No packets describing compatible resources.
> PCI Device, Bus 0, DevFunc 0x0: IBM000D, SystemPeripheral, ProgrammableInterruptController, MPIC
>   Packets describing allocated resources:
>     Memory address (32 bits), at 0xf3f80000 size 0x40000 bytes
>   No packets describing possible resources.
>   No packets describing compatible resources.
> PCI Device, Bus 0, DevFunc 0x68: MOT3101, BridgeController, VMEBridge, GeneralVMEBridge
>   Packets describing allocated resources:
>     Chip identification: MOT3101
>     Bus speed 33333036 Hz, 255 slot(s)
>   No packets describing possible resources.
>   No packets describing compatible resources.
> PCI Device, Bus 0, DevFunc 0x70: DPI8086, NetworkInterfaceController, EthernetController, GeneralEther
>   No packets describing allocated resources.
>   No packets describing possible resources.
>   No packets describing compatible resources.
> PCI Device, Bus 0, DevFunc 0x98: DPI8086, NetworkInterfaceController, EthernetController, GeneralEther
>   No packets describing allocated resources.
>   No packets describing possible resources.
>   No packets describing compatible resources.

No interrupt routing for these 2 in the earlier part. That's likely the
problem as explained.

> ProcBus Device, Bus 0, BUID 0:  MOT3F00, SystemPeripheral, SystemPlanar, GeneralSystemPlanar
>   Packets describing allocated resources:
>     Chip identification: MOT3F0E
>   No packets describing possible resources.
>   No packets describing compatible resources.
> ISA Device, Slot 0, LogicalDev 0: IBM0008, SystemPeripheral, NVRAM, IndirectNVRAM
>   Packets describing allocated resources:
>     Variable (16 decoded bits) I/O port
>       from 0x80c8 to 0x80c8, alignment 1, 2 ports
>     Variable (16 decoded bits) I/O port
>       from 0x80d8 to 0x80d8, alignment 1, 1 ports

Muddy definition of I/O port, these are on the X bus of the Hawk, not an
ISA device. Once again residual data is only half right...


>   No packets describing possible resources.
>   No packets describing compatible resources.
> ISA Device, Slot 0, LogicalDev 0: PNP0B00, SystemPeripheral, RealTimeClock, interface 129
>   Packets describing allocated resources:
>     Variable (16 decoded bits) I/O port
>       from 0x80c8 to 0x80c8, alignment 1, 2 ports
>     Variable (16 decoded bits) I/O port
>       from 0x80d8 to 0x80d8, alignment 1, 1 ports

Same remark since it is the same chip as the NVRAM.

>     Chip identification: MOT3040
>     Small vendor item type 0x00, data (hex): 01 f8 1f 00 00

I thought that this means that the RTC is at offset 0x1ff8 in the NVRAM
but this is wrong for this particular model (straight copy from the
machines which have 8kB NVRAM, the 5100 has 32 kB).

>   No packets describing possible resources.
>   No packets describing compatible resources.
> ProcBus Device, Bus 0, BUID 0:  IBM000B, SystemPeripheral, OperatorPanel, interface 129
>   Packets describing allocated resources:
>     System address (32 bits), at 0xfe0008c0 size 0x2 bytes
>     Chip identification: MOT3000
>   No packets describing possible resources.
>   No packets describing compatible resources.
> ISA Device, Slot 0, LogicalDev 0: PNP0501, CommunicationsDevice, RS232Device, NS398SerPort
>   Packets describing allocated resources:
>     IRQ Mask 0x0010, high edge sensitive
>     I/O address (11 bits), at 0x3f8 size 0x8 bytes

Do you have an PMC761 or not ? This is the COM1 behind an ISA bridge.
Probably again a residual data approximation...

> ISA Device, Slot 0, LogicalDev 0: IBM000B, SystemPeripheral, OperatorPanel, interface 131
>   Packets describing allocated resources:
>     IRQ Mask 0x0100, low edge sensitive
>     Chip identification: MOT3001
>   No packets describing possible resources.
>   No packets describing compatible resources.

The abort switch !

> OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at f3f80000
> OpenPIC timer frequency is 4166640 Hz
> time_init: decrementer frequency = 1044544800/60 (16MHz)
> Memory: 62828k available (1076k kernel code, 1564k data, 68k init) [c0000000,c4000000]
> Dentry hash table entries: 8192 (order 4, 64k)
> Buffer cache hash table entries: 65536 (order 6, 256k)
> Page cache hash table entries: 16384 (order 4, 64k)
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> Linux NET4.0 for Linux 2.2
> Based upon Swansea University Computer Society NET3.039
> NET4: Unix domain sockets 1.0 for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> TCP: Hash tables configured (ehash 65536 bhash 65536)
> Starting kswapd v 1.5
> Serial driver version 4.27 with no serial options enabled
> pty: 256 Unix98 ptys configured
> RAM disk driver initialized:  16 RAM disks of 4096K size
> loop: registered device at major 7
> scsi : 0 hosts.
> scsi : detected total.
> Found Intel i82557 PCI Speedo at I/O 0x77efc0, IRQ 0.

You have some interrupt routing problem, I have code to assign interrupts
from residual data is in my patches at ftp://vlab1.iram.es but it won't
help in this case since I've note seen any code telling where the
interrupts from PCI devfn 0x70 and 0x98 are connected.

>   PCI latency timer (CFLT) is 0x80.
> eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
> eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
> eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
> eth0: Intel PCI EtherExpress Pro100 82559ER, 00:01:AF:01:7A:1D, I/O at 0x77efc0, IRQ 0.
>   Board assembly 000000-000, Physical connectors present:
>   Primary interface chip None PHY #1.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0x1d68d8db).
>   Receiver lock-up workaround activated.
> Found Intel i82557 PCI Speedo at I/O 0x77ef80, IRQ 0.


	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
