Message-ID: <3D081C8D.8070901@embeddededge.com>
Date: Thu, 13 Jun 2002 00:16:13 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax>	<3CFC0D3F.9030901@embeddededge.com>	<20020604035947.GH2762@zax>	<3CFCFC20.80101@embeddededge.com>	<15614.37065.549142.218906@argo.ozlabs.ibm.com>	<3CFEE9A3.5060300@embeddededge.com>	<15614.63160.272890.683586@argo.ozlabs.ibm.com>	<3CFF1624.2070808@embeddededge.com>	<20020612035203.GQ25800@zax>	<3D06E702.4000709@embeddededge.com>	<20020612064344.GT25800@zax>	<3D07D80F.9050306@embeddededge.com>	<15623.56408.342901.245259@argo.ozlabs.ibm.com>	<3D07E743.6090206@embeddededge.com> <15623.61149.22953.9238@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:


> Not by me, doing a range check in virt_to_* would be perfectly
> appropriate.

OK.  So, why don't we just look up the right address? :-)


> Drivers shouldn't be doing virt_to_* on the address they get from a
> consistent-alloc function.  Given that doing it the right way is easy
> (just remember the physical address that the consistent alloc function
> gives you) I don't have any qualms about breaking drivers that do it
> the wrong way.

It isn't the drivers doing it themselves.  I believe the biggest problem
was with drivers that wanted to do a scatter/gather list (like SCSI seems
to like to do).  They just stuff the virtual address, regardless of where
it came from, and expect virt_to_bus() to do the right thing.  I know,
you are going to tell me that shouldn't have been a consistent_alloc()
space, and perhaps that has been fixed by now.

> (I should note that I'm not intending to break them in 2.4, not even
> in 2_4_devel; virt_to_* can continue to use iopa there.  But in 2.5 we
> can be more brutal.)

Let's be brutal :-)

> There is the issue of making sure that we don't have DMA buffers and
> other variables in the same cache line.  This is being thrashed out on
> linux-kernel at the moment. :)

That's a totally different subject, and it comes up on many mailing lists.
There was a discussion about the eepro100 again today on a MIPS list,
where David (again :-) pointed out the problems with it on noncoherent systems.
There are enough people that know about this and the solution, I'm just
sitting back until the generic software is updated to deal with it :-)

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
