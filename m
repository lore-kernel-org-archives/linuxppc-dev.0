Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D6F21A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 21:28:06 +1100 (AEDT)
Message-ID: <1457519279.8111.2.camel@ellerman.id.au>
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>, Petr Mladek <pmladek@suse.com>
Cc: jeyu@redhat.com, jkosina@suse.cz, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Date: Wed, 09 Mar 2016 21:27:59 +1100
In-Reply-To: <20160309100328.GB23039@lst.de>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
 <20160309091904.GA23039@lst.de> <20160309094423.GH10940@pathway.suse.cz>
 <20160309100328.GB23039@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-09 at 11:03 +0100, Torsten Duwe wrote:

> On Wed, Mar 09, 2016 at 10:44:23AM +0100, Petr Mladek wrote:

> > find a solution that would work transparently. I mean that adding
> > an extra hacks into selected functions in the patch might be quite
> > error prone and problems hard to debug. I think that we all want this
> > but I wanted to be sure :-)
>
> Full ACK. Again, the TOC restore needs to go _after_ the replacement function,
> and the klp_return_helper works as transparently as possible, so this
> was my first choice. Arguments on the stack? I thought we'll deal with them
> once we get there (e.g. _really_ need to patch a varargs function or one
> with a silly signature).

I agree it's unlikely many people will want to patch varargs functions, or
functions with stupid numbers of parameters.

But at least with the current proposals, we have no way of preventing them from
doing so. Which means the first sign they'll get that it doesn't work is when
they've applied the patch and their production system goes down. And not even
when they insert the patch, only when the patched function is called, possibly
some time later.

Now perhaps in reality most people are only applying livepatches from their
distro, in which case the distro should have tested it. But I don't know for
sure.

Still I'm happy for the current solution to go in (klp_return_helper creating a
minimal frame).

I think we can probably come up with a fully robust solution. But not tonight,
and not this week :)

cheers
