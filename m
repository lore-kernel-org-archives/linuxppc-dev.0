Message-ID: <3ACC0989.4BAA6CB9@mvista.com>
Date: Thu, 05 Apr 2001 01:58:33 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: jerry <jerry.nguyen@serialsystem.com.sg>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to get the physival address
References: <20010404155419.8B369281DB@denx.denx.de> <001001c0bd86$c54562a0$de0fa8c0@mystore>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


jerry wrote:


> I try to print out:  buffer_array = 0xC4056220

To get an address like this, you must be loading the
driver as a module.  There are a variety of opinions about
how to do this, like using kmalloc() to dynamically allocate
the space after the module is loaded.  In the linuxppc_2_5
kernel from FSM Labs are some VM modifications I have started.
The virt_to_phys() is appropriate to use on the MPC8xx for this
sort of thing, and you can even do consistent_alloc() if you want
cache inhibited pages.  In older kernels, there are no functions
that will provide this for you (well, you can trudge through the
page tables, get the PTE and convert it yourself, but that sucks :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
