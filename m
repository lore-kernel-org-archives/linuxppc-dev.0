Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 66914DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Mar 2007 05:01:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Reading and writing from/to VME device
Date: Tue, 27 Mar 2007 12:02:44 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871088C81DA@VCAEXCH01.hq.corp.viasat.com>
In-reply-to: <929bf310703270847k364986cbrbe70f0e726ab487f@mail.gmail.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Konstantin Boyanov" <kkboyanov@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>I tried to assign it to some other value (just a guess like 0x10000000,
which I think is
> 0x1000 in A16), and then try to read through as many  addresses as the
size of the
> window contains.

Your code indicated said you're using A24 addressing.  You should assign
an A24 address.
=09
> I get the following output (source again @EOM):=09
...
> repeatedly for all addresses up to 0xFD04F when I get a Segmentation
fault. At least now
> I got something, but I just cannot figure out why the output repeats
again and again about
> 20-30. The ADC board is in slot 4, and it's CSR space is available at
0x10100000 (set by junpers)
>, containing 15 registers. Is it possible that I'm actualy accessing
them, or I just read garbage?=20
=09
Looks like you're reading something.  Address 0x10100000 is larger than
a 24 bit address.  Perhaps you should be using A32 transfers instead of
A24?

>>Typically, the VME address space is partitioned by VME chassis slot
number or some=20
>>other application-specific scheme.

>Does this mean that (theoretically) all slots (respectively boards in
them) are visible
> through a single outbound window? Or one must configure one outbound
window per slot?

Yes, theoretically, all boards could be visible through one outbound
window, IF
1. The boards are configured to respond to an address in that window
2. None of the boards address spaces overlap.

> I tried ot find some more info on this issue but with no success. I
only found something
> similar to what you are refering in the driver documentation, but it
is about the inbound
> windows, not the outbound ones. The schema for the inbound wins is the
following:=20
>=09
> Each of the inbound windows is mapped into A32/D32 space at an address
determined by the
> boards slot number. The address is calculated as
0x80000000+(0x20000000*slotnum)+(0x400000*inboundnum).=20
> Thus, in total, each board responds to a 32 MB chunk of VME address
space.=20

I don't believe there are any VITA / VME requirements for a particular
addressing scheme.  The one above looks reasonable...I've used other
schemes as well.  It depends on your system configuration.

> I don't know whether the schema for the outbound wins is the same, or
where to find it.
> Maybe its driver specific, in other words defined by some driver
function?
> Can somebody shed some light on this please?

I believe Outbound/Inbound windows in the Tundra chip refer to the bus
mastership, not direction of data transfer.
VME Bus Master	VME Target	Data Direction	Window
Self			Other		Read			Outbound
Self			Other		Write			Outbound
Other			Self		Read			Inbound
Other			Self		Write			Inbound

You would configure an Inbound window if you want some other board in
the system to be able to read/write your local address space.  You would
configure an Outbound window if you want to read/write some other
board's address space.

Tim	=09
=09
=09
