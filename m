Message-ID: <3D0823D3.4000909@embeddededge.com>
Date: Thu, 13 Jun 2002 00:47:15 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax>	<3CFC0D3F.9030901@embeddededge.com>	<20020604035947.GH2762@zax>	<3CFCFC20.80101@embeddededge.com>	<15614.37065.549142.218906@argo.ozlabs.ibm.com>	<3CFEE9A3.5060300@embeddededge.com>	<15614.63160.272890.683586@argo.ozlabs.ibm.com>	<3CFF1624.2070808@embeddededge.com>	<20020612035203.GQ25800@zax>	<3D06E702.4000709@embeddededge.com>	<20020612064344.GT25800@zax>	<3D07D80F.9050306@embeddededge.com> <15623.63352.516734.245869@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> I think this deserves some discussion, on a couple of levels, for the
> sake of the other people who are on this list and following this
> discussion.

I really don't want to discuss it anymore here, but I'll add just a
few comments.

> .... It is a mindset which highly values
> simplicity and clarity of code, and in particular being able to
> understand what a piece of code is doing, in considerable detail, when
> you read it.

I dislike it at the times it costs us features compared to other
operating systems.  We are caught between being better than a minimal RTOS,
but really lacking when compared to commercial/mature systems.

> I think this mindset is the reason why we have an efficient and
> maintainable kernel rather than a microkernel-based system written in
> C++.

I'm not proposing we do such a thing, although some of the nicest features
have been implemented in such systems :-)  What we need to do is learn
about these systems and bring some of the concepts home.


> In the context of drivers doing DMA, ......

> (1) kernel lowmem
> (2) other kernel virtual addresses
> (3) user addresses
>
> Thinking about this from the driver's perspective, (1) is easy.
 > .... (2) is a little harder
 > ...... And (3) is harder still because the buffer may move
> or disappear.  In this case we need to pin the buffer as well as
> handling the fact that it may be physically discontiguous.

So?  All of this has been solved before in other systems.  Just solve
for (3) and you have everything covered.  This isn't an unusual implementation
detail.  In this case, the driver simply asks for the S/G list associated
with the VM range (the triplet I mentioned earlier).  In case (1), there
is just one entry, in case (2) there could be multiple entries, and in
case (3) you usually see the non-zero offsets and non-page size lengths.
The user page locking can be done by the underlying DMA support functions,
so the driver doesn't care about that.  If you don't have S/G hardware support
the driver has to break up the transfers, which is really the only complexity.
This is what other systems have been doing for decades, and it really
simplifies what the driver has to know (or doesn't need to know :-) about
the underlying VM implementation.  Of course, it would mean modification of
existing drivers, so this will never happen :-)  Maybe we could just do it
in the 4xx OCP stuff as proof of concept :-)

> Given this, I would claim that an abstraction that tries to hide the
> differences between different kinds of virtual address is one that
> hides details that are relevant to drivers, and that that is one
> reason why Linux doesn't have such an abstraction.

What do drivers care about how or where physical memory is allocated and
mapped to virtual addresses?  All they want is an address that allows DMA :-)
A driver will only care about this if you force it to do so.

> .....  Instead, when
> drivers are required to handle physically discontiguous buffers, we
> make that apparent up front and provide the drivers with the details
> they need to handle that case efficiently as well as the contiguous
> case.

Doesn't my description do that?  Seems pretty simple to me, but then
I'm a computer scientist and not a hacker :-)


Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
