Date: Thu, 13 Jun 2002 15:12:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@au1.ibm.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
Message-ID: <20020613051250.GE4228@zax>
References: <15614.63160.272890.683586@argo.ozlabs.ibm.com> <3CFF1624.2070808@embeddededge.com> <20020612035203.GQ25800@zax> <3D06E702.4000709@embeddededge.com> <20020612064344.GT25800@zax> <3D07D80F.9050306@embeddededge.com> <15623.56408.342901.245259@argo.ozlabs.ibm.com> <3D07E743.6090206@embeddededge.com> <15623.61149.22953.9238@argo.ozlabs.ibm.com> <3D081C8D.8070901@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D081C8D.8070901@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 12:16:13AM -0400, Dan Malek wrote:
> Paul Mackerras wrote:
>
>
> >Not by me, doing a range check in virt_to_* would be perfectly
> >appropriate.
>
> OK.  So, why don't we just look up the right address? :-)

Because any driver that relies on it working (for non-lowmem
addresses) is very likely broken in other ways, and at best completely
non-portable.  Not doing it lets us get rid of iopa() (less code +
same features == good) which has basically no other users (a few 8xx
drivers, which I'm sure can be fixed not to and that's it).

Besides which virt_to_bus() is clearly ill-defined in general, since
which bus we're talking about is not specified.  iopa() has the same
problem.  So drivers really need to use the pci consistent functions
or (in future) the unified device model consistent allocation /
mapping functions.

> >Drivers shouldn't be doing virt_to_* on the address they get from a
> >consistent-alloc function.  Given that doing it the right way is easy
> >(just remember the physical address that the consistent alloc function
> >gives you) I don't have any qualms about breaking drivers that do it
> >the wrong way.
>
> It isn't the drivers doing it themselves.  I believe the biggest problem
> was with drivers that wanted to do a scatter/gather list (like SCSI seems
> to like to do).  They just stuff the virtual address, regardless of where
> it came from, and expect virt_to_bus() to do the right thing.  I know,
> you are going to tell me that shouldn't have been a consistent_alloc()
> space, and perhaps that has been fixed by now.

Huh?  First you say it isn't the drivers, then you say it is the
drivers.  From what I can see virt_to_bus still appears a hell of a
lot in drivers/scsi, so they haven't been fixed yet.  But do you have
any real case where one of the virt_to_bus()es is being called on a
non-lowmem address?

> >(I should note that I'm not intending to break them in 2.4, not even
> >in 2_4_devel; virt_to_* can continue to use iopa there.  But in 2.5 we
> >can be more brutal.)
>
> Let's be brutal :-)
>
> >There is the issue of making sure that we don't have DMA buffers and
> >other variables in the same cache line.  This is being thrashed out on
> >linux-kernel at the moment. :)
>
> That's a totally different subject, and it comes up on many mailing lists.
> There was a discussion about the eepro100 again today on a MIPS list,
> where David (again :-) pointed out the problems with it on noncoherent
> systems.

Err.. not me.  I ain't on any MIPS lists.  Nor do I recall writing
anything about the eepre100 driver recently.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
