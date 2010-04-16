Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9C156B7D97
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Apr 2010 05:03:30 +1000 (EST)
Date: Fri, 16 Apr 2010 23:03:29 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc: Add hibernation support for FSL BookE
	processors
Message-ID: <20100416190329.GA3464@oksana.dev.rtsoft.ru>
References: <20100224213802.GA12843@oksana.dev.rtsoft.ru>
	<20100415184513.GA27101@oksana.dev.rtsoft.ru>
	<2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
	<4BC77174.1020305@freescale.com>
	<20100416054010.GA391@oksana.dev.rtsoft.ru>
	<4BC886B9.7080202@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4BC886B9.7080202@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 16, 2010 at 10:48:09AM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
> >On Thu, Apr 15, 2010 at 03:05:08PM -0500, Scott Wood wrote:
> >>Kumar Gala wrote:
> >>>On Apr 15, 2010, at 1:45 PM, Anton Vorontsov wrote:
> >>>>Kumar,
> >>>>
> >>>>According to patchwork, this is now delegated to you. Do you
> >>>>have any objections to merge this?
> >>>Would like Scott's Ack.
> >>I think we need to save IACn, DACn, DBCRn,
> >
> >Does the kernel actually need these registers? I mean, they're
> >saved per thread anyway.
> >
> >>PID0,
> >
> >Kernel clears it early at boot, why would we save it?
> 
> What context are we in when we suspend, and what context is expected
> after resume?  If we're guaranteed not to be on a thread that cares
> about any of this, then OK.

Yeah, we're in the kernel context on suspend and resume.

> >>and USPRG0.
> >
> >Currently this isn't used at all.
> 
> Was thinking that it's up to userspace whether to use it or not --
> though it ought to be saved on thread switch instead.
> 
> >>Might want to also save TLB1 contents, and maybe things like HIDn,
> >>cache registers, etc. -- I don't think they're changeable post-boot
> >>currently, but it'd be good to avoid surprises if that were to
> >>change.
> >
> >Hm. I don't really like the idea of doing things 'just in case',
> >it just adds a code which functionality isn't tested, and which
> >we will might never actually need.
> 
> The intent was to reduce dependencies between the suspend code and
> what the rest of the kernel does -- it's likely that someone adding
> some runtime manipulation of one of these things (e.g. hugetlbfs
> modifying TLB1) would not think to check suspend/hibernation code.
> It would still be somewhat tested, in that you would see problems if
> you restored the wrong values (just not if you failed to restore at
> all).

Yep, I understand the intent, though, I'd like 'git reset --hard
this_commit' to bring a minimal, but still fully functional hibernate,
without unneeded cruft. We might add more savings/restores later [or
sooner, when needed], but that won't matter that much since we'll
have a point in the git history with that minimal support.

I could even implement more savings and restores on top of this
patch, but really, I don't see a hurry in doing this now. :-)
So that's why I don't.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
