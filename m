From: benh@kernel.crashing.org
To: <paulus@samba.org>, Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Date: Fri, 12 Apr 2002 12:57:35 +0100
Message-Id: <20020412115735.9773@mailhost.mipsys.com>
In-Reply-To: <15542.55726.605404.888541@argo.ozlabs.ibm.com>
References: <15542.55726.605404.888541@argo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I think there are two tenable positions: the first is to have very
>simple bi_recs, i.e. basically what we have at the moment, that convey
>a small number of global pieces of information about the system.  If
>we really need to convey information about individual devices then I
>think we want something approaching the OF device tree, which is a
>flexible and extensible structure that conveys arbitrary information
>about the devices and their relationships very well.  So the second
>position is to encode information about devices as a set of
>properties, each of which has a string name and a value which is an
>array of bytes.  In this case we would probably have one bi_rec per
>device.  Ideally we would also have parent/child/sibling pointers for
>each device as well.

I started with something like that, then went back to something a lot
more simple in my experiments here. The fact is that, at least on embedded,
most devices are already self-describing. In a lot of cases, you don't need
any additional informations about a device but what the PCI bus probe already
provides.

Which is why I did my "BI_DEVICE" thing the other way around: Keep the flat
bi_recs, add an arbitrary number of "BI_DEVICE" records, that contain a set
of optional informations for a given device along with whatever is needed
to actually locate this device. The location part has to be more or less
normalized though, at least for known bus types like PCI. This is the role
of the BI_DEV_TYPE and BI_DEV_ID sub-records.

Now, either using names or 4-char-codes for identifying those sub-records
is mostly a matter of taste. I tend to like 4-char-codes as they are more
efficient to process, more compact, more easy to store in flattened out
structures without dealing with pointers, while still very readable, but if
you want to go the string way, then let's do this.

The only case I see for which an actual tree of devices makes sense is the
interrupt routing (and here again, not in all cases, a hell lot of board
can very well cope with a flat interrupt number stored either as a bi_rec
for non-PCI devices or in the PCI interrult line register).

In this case, I beleive nothing prevent us to still use bi_recs. Just define
the proper BI_DEVICE record for a bridge containing the interrupt map.
If the bus type is proprietary enough to make difficult the link betweeen
a device and it's parent bridge, then those devices will need a record with
a tag (a BI_DEV_PARENT_TYPE/DEV_PARENT_ID for example) indicating where the
parent is.

What I find interesting with that bi_rec scheme is that most of it is optional
and any info that is not needed can just be ommited. For example, the generic
PCI code can well read interrupts from PCI_INTERRUPT_LINE and only override it
with bi_rec provided infos if those exist.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
