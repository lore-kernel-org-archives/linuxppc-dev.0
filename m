Message-ID: <38BE953F.5CA6C079@netx4.com>
Date: Thu, 02 Mar 2000 11:22:23 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Calfee <calfee@kerbango.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: commproc.c
References: <4.2.2.20000302111129.00a638d0@mail.kerbango.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Calfee wrote:

> I have been working on doing a 823 USB driver.


I find it interesting there is a sudden interest in the 8xx USB
interface.......

I recently hired someone to do this work for a customer.  We have
slave working fine, and host mostly works (some hubs give us fits).
The goal is an isochronous connection for some device to stream
data over a variety of communication links (it's an 850).

We still have a little distance to cover.  If someone needs this
for a product and wants to invest in speeding up the develpment,
let me know.  Once it is more useful I suppose it will find its
way into the source tree.

> m8xx_cpm_dpalloc(uint size)

> This is a primitive routine to allocate CPM memory. It allocates size bytes
> of CPM memory. Even a good citizen that lives by the CPM imposed
> constraints of alignment


I had some pretty bad hacks for ATM interfaces due to its alignment
restrictions, and have since added a second parameter to define alignment.
I have played with masks and byte counts, one will win.  This will
be in an upcoming patch.


> .... We also need a m8xx_cpm_free() function to give back CPM
> memory when we are done.


For lack of a better thought, I have resurrected the old *NIX resource
map allocator.  Seems to work.



> .... I agree that it is a rare use,

It's not only rare, but I don't see any use for it.


> .... but if I want to
> backtrace the interrupted stack from my interrupt routine for profiling...


You have to explain this one to me.  I don't understand how passing
the register set pointer has any effect on this operation.

Show me you need it and we can add it as a parameter.  There aren't
that many places to change the code.  I just didn't need it, and due
to your rant about interrupt overhead why add something not needed?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
