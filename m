Date: Tue, 22 Feb 2000 18:59:07 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: eieio & ld_le, ld_be
In-Reply-To: <20000222152443.010969@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10002221644450.4957-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 22 Feb 2000, Benjamin Herrenschmidt wrote:

>
> On Tue, Feb 22, 2000, FASSINO Jean-Philippe
> <jeanphilippe.fassino@cnet.francetelecom.fr> wrote:
>
> >Just a question about ld_le* and ld_be*.
> >This function do a io read and enforce in-order execution with eieio.
> >
> >Does eieio is really necessary when load value from IO ??
> >Maybe some computer (SMP, pci, ...) require that !
> >But, i try ld_* without eieio on my computer (G4) and that work well.
>
> Neither ld_le* nor ld_be* should do any eieio (and they don't in the
> kernel sources I just checked).

No, of course.

> Howeverm in_le*/out_le* etc... do it. Those are necessary to enforce
> ordering of accesses when manipulating a hardware device. It's possible
> that the non-cachable & guarded state of io pages make it less important
> on G3, but it's definitely necessary to be completely safe.

Actually it depends on the order of accesses, assuming that I/O is mapped
cache-inhibited and guarded: - between two I/O read accesses it should no
be necessary on current processors and host bridges since they don't seem
to fold/reorder (reordering from very different areas does not make
sense from a HW point of view actually but you never know) non cachable
loads (not 100% sure about the 7400),

- between two I/O write accesses it may be necessary to avoid merging in
the host bridge and it is safer to insert an eieio,

- between two accesses (read followed by write or write followed by read)
to the same address with same size eieio is never necessary. I do it
currently to synchronize interrupt masking on OpenPIC and it seems to
work (I simply added openpic_sync_write* functions in openpic.c).

- generally speaking, let the macros add an eieio unless you know what you
do. Then optimize the critical cases, note that the critical cases might
include ins[bwl] and outs[bwl] where, depending on processors, doubling
the number of bus operations is not exactly enhancing the available
bandwidth, but you have to make sure that the host bridge does not
collapse writes (I think it's safe for the reads).

Note that this is sometimes tricky even on a lowly 603E, a few days ago I
was chasing a bug in early boot on PrePboot (my bootloader) so I disabled
the data-cache and the MMU. Disabling translation means that the accesses
are guarded but the processor does not enforce eieio ordering since the
cache inhibition is not associated with the memory access, this had funny
effects on PCI configuration accesses:

	stw to config_address
	eieio
        lwbrx from config_data

actually the load appeared on the bus before the store, the effect was
that it always read the value from the previous config_address access.
Changing to sync fixed it while I was chasing the bug (BTW my 750 seem to
be also working fine now).

> If you are maniuplating in-memory datas that are not related to any io
> hardware device, then you don't need eieio.

Except on SMP to synchronize writes to shared structures, there should be
an eieio at least before spin_unlock and write_unlock.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
