From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Sun, 24 Mar 2002 13:20:48 +0100
Message-Id: <20020324122048.8670@smtp.wanadoo.fr>
In-Reply-To: <20020322210103.C3363@boardwalk>
References: <20020322210103.C3363@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>What added functionality does the whole "structure" concept give us?
>Here's the current bi_rec parsing code:
>
>while (rec->tag != BI_LAST) {
>  /* fiddle with each individual record */
>  rec = (struct bi_record *)((ulong)rec + rec->size);
>}
>
>The simplicity of this system is valuable - I don't want to give it up
>unless we get lots and lots of added functionality in return.  Dan
>Malek's comments suggest that bi_recs should only be used for only a
>small, simple class of information.  In this context, I don't see what
>structures buy us.
>
>I have to admit, bi_rec structures are a really cool idea, but I
>prefer simplicity over coolness. :)

Well, my "draft" proposal is indeed to complicated, I agree. Though
I want to stay in the idea that a given bi_rec can contain itself
some bi_recs.

What I now want to do is to keep the exising scheme for most
informations (that is a flat list of bi_recs), with only one
exception that doesn't affect the current parsing code, only
a couple of helpers need to be added for drivers to use the
additional information:

We define a special BI_DEVICE type of bi_rec that represents
a HW device for which the firmware provides some informations. Since
the firmware is free to provide whatever informations it want (that
set is not fully defined), the content of the BI_DEVICE record is itself
a list of bi_recs.

In there, only a couple are generically defined, BI_DEV_TYPE indicates
the "type" of device (not the class or function, but rather the type of
wiring), and an optional BI_DEV_ID, whose content depends only on BI_DEV_TYPE.

For example, a PCI device for which we want to provide some additional
informations (like an HW ethernet address) would have
BI_DEV_TYPE = BI_DEV_TYPE_PCI, and BI_DEV_ID containing a PCI bus/devfn.

On chip devices just need a specific BI_DEV_TYPE (for example
BI_DEV_TYPE_4xx_OCP), in which case BI_DEV_ID indicates what on chip
periph is designated (ex: BI_DEV_ID_4xx_ETH).
Eventually, we can also define a BI_DEV_CLASS indicating the calss
(function) of the device (ex: BI_DEV_CLASS_ETH). If we go this way, then
for things like on-chip devices, we identify them with BI_DEV_TYPE and
BI_DEV_CLASS, keeping BI_DEV_ID solely as an index number for chips that
support more than 1 instance of a given cell.

The "standard" kernel only define a few BI_DEV_TYPE's (like PCI,
4xx OCP, 8xx OCP). Drivers define attributes they can read from the
BI_DEVICE (4xx ethernet can read a HW eth adress for example).
Board vendors are free to provide additional information in the
BI_DEVICE, and add the ability to the driver (patches welcome) to
make good use of that information ;) (Could be, for example, wiring
of the PHY since it may not use MII, etc...).

What do you think ?
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
