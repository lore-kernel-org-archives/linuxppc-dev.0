Message-ID: <40C534B7.1090902@mvista.com>
Date: Mon, 07 Jun 2004 22:38:31 -0500
From: Mark Hatle <mhatle@mvista.com>
MIME-Version: 1.0
To: "Kevin P. Dankwardt" <k@kcomputing.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Fast boot times
References: <KCEOLLHGFJIAFNAMGACHIEGADMAA.k@kcomputing.com>
In-Reply-To: <KCEOLLHGFJIAFNAMGACHIEGADMAA.k@kcomputing.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There are some simple things you need to do for this.  The first is
abondon the idea that EVERYTHING needs to be done in 50msec!  What you
really want is a base set of functionality that exists in the 50msec
range, then you bring up the rest of the functionality either as
required or in parallel with other system tasks.

What you want to do is have a minimal driver set built into the kernel.
  Also, get your firmware optimized as much as possible.  A lot of the
time, the firmware can eat a large chunk of time.

Basically you will boot the kernel with minimal drivers (perhaps just a
single filesystem driver).  Once the kernel hits userspace, load the
driver modules in an appropriate order.  If that is still not fast
enough, you will have to modify the drivers to allow for parallel system
initialization.

So my point in all of the above is figure out the exact minimum
requirements you have.  Work on getting that up "first".  Then expand to
your full compliment of drivers and userspace applications.

--Mark

Kevin P. Dankwardt wrote:
> I am participating in a project that has a challenging boot time
> requirement. We need a Linux boot solution where we have booted in the
> 50msec range, talking on a protocol stack, from a COLD Start (power being
> applied to the board.) The loading of the drivers and the stack
> initialization has to occur within 50msec.
>
> Does anyone have any leads/ideas for being able to meet this deadline?
>
> Thanks,
> Kevin Dankwardt
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
