Date: Tue, 29 Feb 2000 11:44:06 -0500
From: sat <satadru@umich.edu>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: PCI Bus not recognizing cards properly
Message-ID: <2636874223.951824646@junior>
In-Reply-To: <4135654.3160384978@edit1.daily.pub.umich.edu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="==========2636891082=========="
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==========2636891082==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

FYI, I fixed the entire problem by moving all the scsi connections to a
single Adaptec 2940U2W card.   Newer kernels ( compared to the 2.2.7-vger)
work fine in recognizing the scsi and farallon ethernet card, and
everything seems to be working fine.

Does anybody have an Adaptec 2940UW card and a 2940U2W card working
together in the same machine?

My only caveat is that the 100 Mbit ethernet card seems to be choking on
the bandwidth.   The Machine is a 7600/132.   Is this too slow to properly
handle 100Mbts?  Transfers of files via netatalk seem to be very slow, far
slower than using the built in PowerMac ethernet.

The card is using the tulip driver, so if anybody can drop me some tweaking
advice or experience, I would appreciate it.

sat

--On Thursday, February 24, 2000 12:42 PM -0500 sat <satadru@umich.edu>
wrote:

> Summary:
> Two PCI SCSI Cards, one Ethernet PCI Ethernet card.
> kernel 2.2.7-vger--> ALl the scsi cards work, the ethernet card doesn't
>
> Any new kernel/ or any kernel that I compile--> The first scsi card
> doesn't whow up.
>
>
> The machine is a PowerMac 7600/132.
>
> Cards from left to right in the box:
>
> Adaptec 2940U2W
> Farallon  Fast EtherTX 10/100
> Adaptec 2940UW
> --
>
> The first SCSI card is an Adaptec 2940U2W, which is only recognized by
> booting with the vmlinux.2.2.7-vger kernel from
> ftp.linuxppc.org/linuxppc-pre-R5/kernels/old
>
> (Can somebody explain how I can get the source and .config for this
> kernel?)
>
> Since my boot parition is on a scsi hard drive connected to the U2W card,
> I can't boot unless I use this kernel.  (Open Firmware recognizes this
> card though, and is able to load the kernel off of the hard drive
> conected to this card fine.)
>
> On another note, the ethernet card is being recognized, but seems to be
> disabled.  The card is a Farallon Fast EtherTX 10/100 Card, and their web
> site seems to indicate that a Tulip driver should work for this card, so
> I'm a bit flummoxed as to what I should do to get this card working.   I
> of course would like to upgrade to a newer kernel and see if that makes
> the card work, but then the scsi card refuses to work, so that nixes any
> solution from that end.
>
>
> Any help from any angle would be appreciated.   Any kernel patches will
> be gratefully tested to fix this problem.
>
>
> Thanks again.
>
> satadru
>
> Debug info:
>
> from dmesg:
> (scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 13/0
> (scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
> (scsi0) Downloading sequencer code... 407 instructions downloaded
> (scsi1) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 15/0
> <snip>
> eth1: DC21143 at 0x0400 (PCI bus 0, device 14), h/w address
> 00:00:c6:53:27:90, and requires IRQ24 (provided by PCI BIOS).
> de4x5.c:V0.543 1998/12/30 davies@maniac.ultranet.com
>
>
> <- Note: the PCI 13/0 just doesn't show up under newer kernels, and the
> ethernet card seems to want to reassign itself to PCI 15/0.  ->
>
> (output from /sbin/lspci -v )
>
> 00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev
> 03) Flags: bus master, medium devsel, latency 32
>
> 00:0d.0 SCSI storage controller: Adaptec 2940U2
>         Subsystem: Unknown device 9005:a180
>         Flags: bus master, medium devsel, latency 32, IRQ 23
>         BIST result: 00
>         I/O ports at <unassigned>
>         Memory at 80870000 (64-bit, non-prefetchable)
>         Capabilities: [dc] Power Management version 1
>
> 00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 41) Subsystem: Unknown device 10b8:2401
>         Flags: bus master, medium devsel, latency 96, IRQ 24
>         I/O ports at 0400
>         Memory at 80871000 (32-bit, non-prefetchable) [disabled]
>
> 00:0f.0 SCSI storage controller: Adaptec AIC-7881U
>         Flags: bus master, medium devsel, latency 32, IRQ 25
>         I/O ports at <unassigned>
>         Memory at 80872000 (32-bit, non-prefetchable)
>
> 00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
>         Flags: bus master, medium devsel, latency 32
>         Memory at f3000000 (32-bit, non-prefetchable)
>
>
> /sbin/lspci -n:
>
> 00:0b.0 Class 0600: 106b:0001 (rev 03)
> 00:0d.0 Class 0100: 9005:0010
> 00:0e.0 Class 0200: 1011:0019 (rev 41)
> 00:0f.0 Class 0100: 9004:8178
> 00:10.0 Class ff00: 106b:0002 (rev 02)


--==========2636891082==========
Content-Type: text/enriched; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

<fontfamily><param>MS Sans Serif</param><flushleft>FYI, I fixed the entire =
problem by moving all the scsi connections to a single Adaptec 2940U2W =
card.   Newer kernels ( compared to the 2.2.7-vger) work fine in =
recognizing the scsi and farallon ethernet card, and everything seems to be =
working fine.


Does anybody have an Adaptec 2940UW card and a 2940U2W card working =
together in the same machine?


My only caveat is that the 100 Mbit ethernet card seems to be choking on =
the bandwidth.   The Machine is a 7600/132.   Is this too slow to properly =
handle 100Mbts?  Transfers of files via netatalk seem to be very slow, far =
slower than using the built in PowerMac ethernet.


The card is using the tulip driver, so if anybody can drop me some tweaking =
advice or experience, I would appreciate it.


sat


--On Thursday, February 24, 2000 12:42 PM -0500 sat <<satadru@umich.edu> =
wrote:


> Summary:

> Two PCI SCSI Cards, one Ethernet PCI Ethernet card.

> kernel 2.2.7-vger--> ALl the scsi cards work, the ethernet card doesn't

>

> Any new kernel/ or any kernel that I compile--> The first scsi card

> doesn't whow up.

>

>

> The machine is a PowerMac 7600/132.

>

> Cards from left to right in the box:

>

> Adaptec 2940U2W

> Farallon  Fast EtherTX 10/100

> Adaptec 2940UW

> --

>

> The first SCSI card is an Adaptec 2940U2W, which is only recognized by

> booting with the vmlinux.2.2.7-vger kernel from

> ftp.linuxppc.org/linuxppc-pre-R5/kernels/old

>

> (Can somebody explain how I can get the source and .config for this

> kernel?)

>

> Since my boot parition is on a scsi hard drive connected to the U2W card,

> I can't boot unless I use this kernel.  (Open Firmware recognizes this

> card though, and is able to load the kernel off of the hard drive

> conected to this card fine.)

>

> On another note, the ethernet card is being recognized, but seems to be

> disabled.  The card is a Farallon Fast EtherTX 10/100 Card, and their web

> site seems to indicate that a Tulip driver should work for this card, so

> I'm a bit flummoxed as to what I should do to get this card working.   I

> of course would like to upgrade to a newer kernel and see if that makes

> the card work, but then the scsi card refuses to work, so that nixes any

> solution from that end.

>

>

> Any help from any angle would be appreciated.   Any kernel patches will

> be gratefully tested to fix this problem.

>

>

> Thanks again.

>

> satadru

>

> Debug info:

>

> from dmesg:

> (scsi0) <<Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 13/0

> (scsi0) Wide Channel, SCSI ID=3D7, 32/255 SCBs

> (scsi0) Downloading sequencer code... 407 instructions downloaded

> (scsi1) <<Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 15/0

> <<snip>

> eth1: DC21143 at 0x0400 (PCI bus 0, device 14), h/w address

> 00:00:c6:53:27:90, and requires IRQ24 (provided by PCI BIOS).

> de4x5.c:V0.543 1998/12/30 davies@maniac.ultranet.com

>

>

> <<- Note: the PCI 13/0 just doesn't show up under newer kernels, and the

> ethernet card seems to want to reassign itself to PCI 15/0.  ->

>

> (output from /sbin/lspci -v )

>

> 00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev

> 03) Flags: bus master, medium devsel, latency 32

>

> 00:0d.0 SCSI storage controller: Adaptec 2940U2

>         Subsystem: Unknown device 9005:a180

>         Flags: bus master, medium devsel, latency 32, IRQ 23

>         BIST result: 00

>         I/O ports at <<unassigned>

>         Memory at 80870000 (64-bit, non-prefetchable)

>         Capabilities: [dc] Power Management version 1

>

> 00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip

> 21142/43 (rev 41) Subsystem: Unknown device 10b8:2401

>         Flags: bus master, medium devsel, latency 96, IRQ 24

>         I/O ports at 0400

>         Memory at 80871000 (32-bit, non-prefetchable) [disabled]

>

> 00:0f.0 SCSI storage controller: Adaptec AIC-7881U

>         Flags: bus master, medium devsel, latency 32, IRQ 25

>         I/O ports at <<unassigned>

>         Memory at 80872000 (32-bit, non-prefetchable)

>

> 00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)

>         Flags: bus master, medium devsel, latency 32

>         Memory at f3000000 (32-bit, non-prefetchable)

>

>

> /sbin/lspci -n:

>

> 00:0b.0 Class 0600: 106b:0001 (rev 03)

> 00:0d.0 Class 0100: 9005:0010

> 00:0e.0 Class 0200: 1011:0019 (rev 41)

> 00:0f.0 Class 0100: 9004:8178

> 00:10.0 Class ff00: 106b:0002 (rev 02)



--==========2636891082==========--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
