Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15304.9109.488577.697206@cargo.ozlabs.ibm.com>
Date: Sat, 13 Oct 2001 21:20:53 +1000 (EST)
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods 
In-Reply-To: <20011012091659.B6D6910887@denx.denx.de>
References: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
	<20011012091659.B6D6910887@denx.denx.de>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk writes:

> The following systems are supported by PPCBoot:

Am I right in thinking that you are the author of PPCBoot?

> But that would just shift  the  problem  from  the  kernel  into  the
> wrapper:  you'd still need a standard way to pass information between
> the firmware and  the  wrapper.  I  don't  see  where  there  is  any
> improvement, then.

There is improvement because you can have a separate wrapper for each
firmware, if necessary.  At present if we want to change the way
information is passed into the kernel, we have to synchronously change
several different firmware/booter implementations, which are
maintained in separate places by separate people.  The list includes
(at least) BootX, miboot, yaboot, PPCBoot, and Michael Sokolov's VAX
console.  This is a logistical nightmare.  Just getting the updates
into the firmware/booters is bad enough, but then you create problems
for users who then can't boot old kernels with the new firmware or new
kernels with the old firmware.

I know that if you are the firmware author, it seems easy to you to
change the firmware and install a new version.  But please look at it
from the users' point of view.

The thing about the wrappers is that they are all maintained in the
one tree along with the kernel.  If we want to make a change to the
interface between the wrappers and the kernel we can easily do that in
a coordinated fashion, without creating any compatibility problems -
old kernels naturally use the old wrapper and new kernels use the new
wrapper.  The wrapper can provide any translation necessary between
what the firmware passes in and what the kernel expects.

> The bi_record discussion comes to mind. Is this what you are thinking
> of? As soon as such an interface is well defined we  will  make  sure
> that it is directly supported by PPCBoot, too.

That's great, but I wonder what happens when someone upgrades their
PPCBoot to your new version and then wants to boot the old 2.4.2
kernel that they have lying around to check whether it shows a
particular problem they're chasing.

> There have already been several rounds of  similar  discussions,  but
> AFAIK  they  all  ended  with  just  a  declaration  of  intend to do
> "something,  sometime".  Is  your  proposal  a  follow-up  to   these
> discussions, or a new approach?

The reason that nothing has been done is precisely because it is so
hard at present to change the way that information is passed into the
kernel, because we still boot the vmlinux directly in some situations.

I am speaking from bitter experience here.  As another example, we
wanted to change the structure used to represent the OF device tree
node in the kernel.  We couldn't because that structure was also
passed in from BootX, not without implementing a translation layer.

If we absolutely *have* to boot a vmlinux directly without a wrapper,
then probably the best thing is to use bi_recs and pass in a pointer
to them, since that is reasonably flexible and can be made to be
forwards and backwards compatible without too much pain.  Changing to
this scheme is going to cause considerable pain in the short term,
though.

Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
