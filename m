Date: Fri, 9 Feb 2001 11:57:18 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: David Edelsohn <dje@watson.ibm.com>, Cort Dougan <cort@fsmlabs.com>,
        Dan Malek <dan@mvista.com>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: <14979.48995.833510.969973@gargle.gargle.HOWL>
Message-ID: <Pine.HPX.4.10.10102091147560.16861-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 9 Feb 2001, Paul Mackerras wrote:

> Gabriel Paubert writes:
>
> > I agree with you, but that's only a gut feeling. Did you also notice that
> > Linux/PPC only uses half the recommended hash table size unless I'm
> > grossly mistaken ?
> >
> > My feeling is that the hash table should be rather over- than under-sized,
> > especially with the amount of sharing there is between all the
> > applications running on "modern" desktops (large shared libraries for
> > X/KDE/GNOME among other things).
>
> We use a smaller than recommended hash table size for a couple of reasons:
>
> - The hash table occupancy rates measured by Cort were very small,
>   typically less than 10% IIRC.

Then it means that the mm system is completely screwed up, even more than
I thought. I have to study first how VSID are handled, but this smells
definitively wrong.

>
> - A bigger hash table takes longer to clear when you have to do a
>   flush_tlb_all().   Fortunately there are only a couple of places
>   where flush_tlb_all is called, and they can both easily be changed
>   to flush_tlb_range.  However, it is still necessary to clear the
>   hash table on a MMU context overflow.

Yes, I was always worried by the added latency when a hash table clear
comes in. But the question is why do we have to do it ? Actually the
question is whether flush_tlb_all is even necessary.

> - The recommended sizes are based on the idea that you have to try
>   quite hard to keep all the active PTEs in the hash table.  We don't,
>   we can quickly fault PTEs into the hash table on demand so it is
>   less important for us to try to keep all the active PTEs in the hash
>   table.

I believe that this is a big mistake, faulting a PTE in the hash table is
an exception and wil never be as fast as having the entry already in the
PTE. And on SMP, you acquire hash_table_lock, an unnecessary variable BTW
but let us leave it for a later discussion, which will be very contended
and ping pong like mad between processors.

 In short in all the previous discussion you had with Dan, I stand with
him and against you in all and every single aspect, except for the TLB
preloading thing.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
