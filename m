Message-ID: <39D68EB8.4CAD5168@mvista.com>
Date: Sat, 30 Sep 2000 21:09:12 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
CC: paulus@linuxcare.com.au, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <19340822040932.8760@mailhost.mipsys.com>
			<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
			<14803.57550.118150.759977@argo.linuxcare.com.au>
			<39D41AA2.C586D738@mvista.com>
			<14804.7238.688771.238444@argo.linuxcare.com.au>
			<39D4E85F.926CFD5B@mvista.com> <14805.17492.766815.388301@argo.linuxcare.com.au> <39D66E4D.4364FC8B@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:

> This raises a question about equivalent mapping though.  Everything above
> ioremap_base is equivalently mapped by ioremap().  In 2.4.0-test2
> ioremap_base is initialized in MMU_init():

This "equivalent" mapping is going to be the greatest challenge.  The
reason this happens is because we need access through the MMU before
the kernel has initialized the kernel VM allocator.  Parts of the early
kernel initialization that have to access control/status registers of
various types are going to be mapped 1:1.  After some of these proposed
changes, these mappings are going to be destroyed and remapped (to get
the "standard" 0xff000000 address).  This is really bad for the
integrated
devices since any that used the original mapping, either in the hardware
registers or in data structures, must be tracked down, changed and
initialized all over again.  Either the "iobase" variable is going to
continue to live, or io.h is going to be filled with lots of #ifdefs
with different constants (again).


> So to answer your question, I arbitrarilly chose 0xe8000000 as ioremap_base
> because it seemed within reason, given other existing values.  I can move
> ioremap_base to lots of other places if I need to.

The 0xff000000 simply isn't workable on many of the embedded 8xx
and cPCI prep/chrp boards for the reason I mentioned above.  If Paul
wants to do this on the PMacs to assist the problem he is trying to
solve, that's fine.  I don't see any value, and only lots of time spent
in both coding and processors cycles, in trying to make this a common
VM mapping across all PowerPC platforms.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
