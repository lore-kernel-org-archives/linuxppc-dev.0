From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Val Henson <val@nmt.edu>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Sun, 24 Mar 2002 19:16:46 +0100
Message-Id: <20020324181646.5056@smtp.adsl.oleane.com>
In-Reply-To: <Pine.GSO.4.21.0203250948360.11999-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0203250948360.11999-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Alternatively, why not create a whole device tree for this? There already
>exists a standard for device trees: IEEE 1275 Open Firmware. Then you
>need only
>one extra bi_rec tag: BI_OF_TREE.

Well, BI_OF_TREE may exist if we ever decide to move the OF interface
out of the kernel and to the wrapper. Though it's not well suited for
embedded platforms where we really want something as small as possible.

The device-tree has the inconvenient of duplicating a lot of informations
that we don't necessarily need. In most embedded cases, I will only
need about 2 or 3 BI_DEVICE records, those containing only a couple
of informations.

I'm still not completely sure about the BI_DEV_TYPE/BI_DEV_ID mecanism
of retreiving a given BI_DEVICE yet. I have a case here where I want to
use BI_DEVICE to carry informations about the chip select & IRQ on which
a chip is wired on the processor external bus, along with a couple of
flags related to some broken address select on some board revs, I want my
driver to be able to lookup the chip itself, not a "location", so I'm still
thinking about the best way to provide that info. Maybe an additional (and
optional as always BI_DEV_NAME).

That would give us 2 utility routines to be used by drivers to locate
BI_DEVICE bi_recs:

  bi_find_device_type(ulong dev_type, void* dev_id, size_t dev_id_size)
  bi_find_device_name(const char* name)

The first one compares BI_DEV_TYPE with dev_type, and if dev_id is non
NULL, matches it with the variable sized BI_DEV_ID. The second one
compares BI_DEV_NAME as a C string.

The basic function for finding a bi_rec will be

  bi_find(struct bi_rec* where, ulong tag);

"where" will be NULL for a toplevel search, and will point to a bi_rec
returned by one of the 2 bi_find_device routines for looking up an
attribute within a BI_DEVICE.

Any comments ? Should I start putting this together in _2_4_devel or
only 2_5 ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
