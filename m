Date: Thu, 5 Apr 2001 11:16:59 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
Cc: jerry <jerry.nguyen@serialsystem.com.sg>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to get the physival address
In-Reply-To: <3ACC0989.4BAA6CB9@mvista.com>
Message-ID: <Pine.HPX.4.10.10104051112160.18432-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 5 Apr 2001, Dan Malek wrote:

>
> jerry wrote:
>
>
> > I try to print out:  buffer_array = 0xC4056220
>
> To get an address like this, you must be loading the
> driver as a module.  There are a variety of opinions about
> how to do this, like using kmalloc() to dynamically allocate
> the space after the module is loaded.  In the linuxppc_2_5
> kernel from FSM Labs are some VM modifications I have started.
> The virt_to_phys() is appropriate to use on the MPC8xx for this
> sort of thing, and you can even do consistent_alloc() if you want
> cache inhibited pages.  In older kernels, there are no functions
> that will provide this for you (well, you can trudge through the
> page tables, get the PTE and convert it yourself, but that sucks :-).
>

Furthermre there is no guarantee that the memory will be physically
contiguous. Unless magically aligned, a 4096 bytes buffer will almost
always span 2 pages.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
