Message-ID: <3857F56C.65411CA4@netx4.com>
Date: Wed, 15 Dec 1999 15:09:16 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: Jim Chapman <jim.chapman@iname.com>, bsimon@ctam.com.au,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au> <385774B8.3405494B@iname.com> <99121511085505.00750@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:


> Can you elaborate on the CPU flavors that do and don't work?  I just bought a
> pair of RPXCLLF boards from Embedded Planet which have XPC860TZP50B3 on them.


Those are fine, except I am going to add the Rev. B.3 silicon
errata patches into the kernel (again).  I discovered the EP
design has finally encroached upon some of the errata due to
voltage/timing specs.

If they boot Linux/PPC, they will run fine.  If they don't, it
is likely this software workaround.

Just use them.  If you have trouble, let me know.


> What is the issue with the "optimized" cache hardware?


Nothing for Linux.


> .....  Is it possible that they have gone to a newer more superscalar
> implementation of the 8xx core with the 8xxP parts that does more out of order
> operations?


Nope, just a bigger cache.  Some of the bits in the cache
registers now have meaning where they didn't before.


> ...  Or did simply doubling the cache size break something that had
> been lurking around waiting to bite us?  Do you know what is wrong?


Relax :-).  If there was trouble, I would be one of the first to
know and I would be working to correct it.


> Dan, can you tell us if the DMA operations on the 8xx processors are cache
> coherent?


Yes, I can tell you, and no they are not.



> ..... so I have erred on the conservative side and in my drivers
> have done cache flushing operations before/after each DMA as appropriate for
> DMA direction.


What kind of drivers are you using?  The only thing likely to
perform DMA on the 8xx is the CPM.  There are already CPM functions
for managing this stuff, which is a combination of uncached
memory and cache management.  Try to use something that already
exists, or at least use it as a model for something special
you are doing.



> ....  MOT sent us 40 chips of which 4 or 5 were rev A.


Cool.  Make key chains out of them.  Seriously, depending upon
what you are trying to accomplish, the Rev. A parts should work
fine.  It may take a few software patches, but they will work.


> wait for the boards to which rev A 850s had been nailed to be reworked (several
> days' turnaround) to get working boards so I can bring them up and give them to
> the other software folks.


There are advantages to working with people with Motorola connections.


> It also appears that there are a lot of errata associated with the MPC850 rev
> A parts which are ostensibly fixed (and, in my experience, ARE fixed) in rev B.


Every revision is better, but Rev. B still has some things to work
around.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
