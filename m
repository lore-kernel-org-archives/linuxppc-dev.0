Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050519231446.29487C1512@atlas.denx.de>
References: <20050519231446.29487C1512@atlas.denx.de>
Content-Type: text/plain
Date: Fri, 20 May 2005 09:28:29 +1000
Message-Id: <1116545309.5153.58.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, u-boot-users@lists.sourceforge.net
Subject: Re: [U-Boot-Users] RFC: Booting the Linux/ppc64 kernel without
	Open Firmware HOWTO (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I am aware that you think so, and I try to raise  your  awareness  of
> the fact that there is a huge number of small machines out there.
> 
> Please keep in mind that the same interface will be forced sooner  or
> later  on small 8xx systems with maybe just 4 MB flash and 8 or 16 MB
> RAM.

I will not force it, but others may find it a good idea to do so :)

> It is IMHO wrong to have only the boot loader side in mind. We should
> consider the whole system.

I do have the kernel in mind as well. The fact is the ppc64 kernel
relies on an Open Firmware device tree and we do not want at any cost to
get into the mess that is ppc32. We decided to define this flattened
format for that purpose, and to allow kexec functionality. I did my best
to keep the format as compact as possible (maybe a little bit more could
be saved by changing the way the full path are layed out, maybe we could
even do a new version which gzip's the while blob, but overall, it's
fairly small).

On the kernel side, as I wrote as well, the code for dealing with the
device-tree isn't that big, and will get smaller as I remove the
post-processing of nodes in prom.c that we still have here. And as I
wrote, if other platforms want to re-use that mecanism, they may want to
just use the compact/flattened format directly. The function for
scanning nodes in the flattened tree is about 40 lines of C and the
function for accessing a property in a flattened node is about as much. 
 
> 
> I think you are aware that there are several people out there working
> on a similar boot interface for the "small" PPC systems, too.

I know, and I was at the origin of the bi_rec proposal, a few years ago.
I've simply never seen anything actually happening.

> > No other solution will be accepted on the kernel side. At least for
> > ppc64
> 
> This is not exactly a constructive position. When  each  architecture
> comes  up with it's own solution for the same problem and then claims
> that no other solution will be accepted we will stick  with  what  we
> have now: a mess.
> 
> If this is really your position we may as well stop here.

The ppc64 kernel relies on an open firmware style device tree. That will
not change any time soon. This proposal is a way to define a subset of
this device-tree along with a compact & flattened format so that one
don't have to do a full Open Firmware implementation and so that mimal
trees can be used.

> Yes, of course. And using ATAGS is the only supported way to boot  an
> ARM kernel, and so on.
> 
> If everybody claims that his way of doing things is the only accepted
> solution we can really save all the time we are  wasting  on  such  a
> discussion.

Maybe. I'd rather have this proposal completed and have actual comments
about the _content_ of it rather than such a debate at this point. Once
we have that working, we can talk about extending it.

> > talks about backporting support for that to ppc32 as well. Other
> > architectures are welcome to use it too though :) The device-tree in the
> 
> Ummm.. Ben, I have really high respect for you, but such  a  position
> is  simply  arrogant.  With the same right the ARM folks can say that
> ATAGS is the way to go and other architectures are welcome to use it.
> Actually they might have older rights.

May well be. But that out of topic. The decision has been made already.

> > > Why don't we try to come up with a solution that is acceptable to the
> > > other architectures as well? 
> > 
> > This has been discussed over and over again, that is the best way to
> > never come up with a solution as everybody will want something different
> > and nobody will ever agree.
> 
> With such a position I really wonder why you ever asked?

I'm asking for comments about the content of the proposal and posting to
inform people of what's going on. You are the one wanting to extend it
to other architectures :)

> > The present proposal is implemented today on the ppc64 kernel already,
> > and we have decided to not go backward on this requirement. 
> 
> The why the heck do you call this a RFC or a proposal? To me it seems
> that you don't propose but dictate a  solution  -  a  solution  which
> pretty   much  ignores  everything  but  your  own  requirements.  If
> everything has been decided already I can as well shut up.

I'm asking for comments about the actual details of it, if something was
overlooked in the format (though that actually works today), if my
wording is wrong in parts, if we should define in more details some
aspect of it.

> But please never claim that this has been _discusssed_.

No, what I meant earlier is that trying to come up with something like
that, as you stated earlier, has been discussed again and again and
again without any useful result.
