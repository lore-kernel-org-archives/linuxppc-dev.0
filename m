Date: Tue, 5 Sep 2000 11:49:45 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Adrian Cox <apc@agelectronics.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: improved processor config for G3s
In-Reply-To: <20000904105446.26517@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10009041309060.15438-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 4 Sep 2000, Benjamin Herrenschmidt wrote:

> >> A rule of thumb is the following: fully SMP capable processors broadcast
> >> eieio (and tlbie for that matter), others do not at least by default. On
> >> an UP 750 (SMP 750 are an aberration in any case because of TLB issues),
> >> I'd bet that it is more efficient to let the processor perform store
> >> gathering when it can (an eieio between both stores will prevent it) and
> >> to disable both ABE in the processor and store gathering in the bridge.
> >> This will result in lower processor bus utilization.
> >
> >Remember that the processor store gathering is only capable of turning
> >two 32-bit writes to uncached, nonguarded space into one 64-bit write.
> >The bridge store gathering converts an arbitrary sequence of sequential
> >writes into a PCI burst.

Within some limits (16 bytes within a 16 byte aligned area for the
Grackle).

> >The bridge store gathering should be able to produce far more IO
> >improvement, and still works if the guard bit is set on the address
> >space.

Avess to guarded space is limited to device registers, which is not thhat
frequent with modern PCI devices. Quite often you are not even able to
acces them in increasing address order for other reasons. But read
further...


> >I should have done a set of MPC107 experiments by the start of October,
> >and I'll know for sure then.
>
> Also, are you sure, Gabriel, that eieio() not beeing broadcast to the
> bridge would harm ? The bridge is not allowed to do any re-ordering.

The absence of broadcast might definitely harm, but first the support for
store gathering in the MPC106 (Grackle) is quite poor:

"For a stream of single-beat writes, the data for the first transaction is
latched in the first buffer and the MPC106 initiates the transaction on
the PCI bus. The second single-beat write is then stored in the second
buffer. For subsequent single-beat writes, store gathering is possible if
the incoming write is to sequential bytes in the same half cache line as
the previously latched data. Store gathering is only used for writes to
PCI memory space, not for writes to PCI I/O space. The store gathering
continues until the buffer is scheduled to be flushed or until the
processor issues a synchronizing transaction.

For example, if both PRPWBs are empty and the 60x processor issues a
single-beat write to PCI, the data is latched in the first buffer and the
PCI interface of the MPC106 attempts to acquire the PCI bus for the
transfer. The data for the next 60x-to-PCI write transaction is latched in
the second buffer, even if the second transaction's address falls within
the same half cache line as the first transaction. While the PCI interface
is busy with the first transfer, any sequential processor single-beat
writes within the same half cache line as the second transfer are gathered
in the second buffer until the PCI bus becomes available. "

So you need at least 3 writes, or to have one store buffer busy with a
previous write, to trigger the store gathering mechanism. This makes it
impossible to predict whether it will be used or not, and IMO not worth
the potential trouble since it will actually happen quite infrequently.

The only case where store gathering in the processor or in the bridge
may have a significant performance impact is when accessing a frame
buffer, which should never be mapped as guarded to start with.

Note that store gathering only affects memory space, not I/O space, I
don't know whether the Adaptec drivers are affected or not.

> Maybe there are issues with devices not supporting burst access to
> registers, but shouldn't those devices abort the burst after the first
> access ?

They should, and in this case store gathering in the bridge does not
bring you any significant performance benefit.

Just a question: were the devices exhibiting the problem 64 bit devices
behind the PCI<->PCI bridge on the Macs which have 64 bit PCI slots ?

> Drivers sensitive to timing constraints must already do a read to flush
> the bridge buffer, so...

Indeed, but the problem here is completely different and I would not call
buffer flushing a timing constraint, it is rather a coherency issue.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
