Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 7C090B7D59
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 15:40:15 +1000 (EST)
Received: by wyb34 with SMTP id 34so1082999wyb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Apr 2010 22:40:13 -0700 (PDT)
Date: Fri, 16 Apr 2010 09:40:10 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc: Add hibernation support for FSL BookE
	processors
Message-ID: <20100416054010.GA391@oksana.dev.rtsoft.ru>
References: <20100224213802.GA12843@oksana.dev.rtsoft.ru>
	<20100415184513.GA27101@oksana.dev.rtsoft.ru>
	<2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
	<4BC77174.1020305@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4BC77174.1020305@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 15, 2010 at 03:05:08PM -0500, Scott Wood wrote:
> Kumar Gala wrote:
> >On Apr 15, 2010, at 1:45 PM, Anton Vorontsov wrote:
> >>Kumar,
> >>
> >>According to patchwork, this is now delegated to you. Do you
> >>have any objections to merge this?
> >
> >Would like Scott's Ack.
> 
> I think we need to save IACn, DACn, DBCRn,

Does the kernel actually need these registers? I mean, they're
saved per thread anyway.

> PID0,

Kernel clears it early at boot, why would we save it?

> and USPRG0.

Currently this isn't used at all.

> Might want to also save TLB1 contents, and maybe things like HIDn,
> cache registers, etc. -- I don't think they're changeable post-boot
> currently, but it'd be good to avoid surprises if that were to
> change.

Hm. I don't really like the idea of doing things 'just in case',
it just adds a code which functionality isn't tested, and which
we will might never actually need.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
