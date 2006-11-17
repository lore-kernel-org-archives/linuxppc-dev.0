Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B3B967BCD
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 17:41:24 +1100 (EST)
Date: Fri, 17 Nov 2006 07:41:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Message-ID: <20061117064118.GA14580@lst.de>
References: <4554DACB.8060809@am.sony.com> <20061115180440.GB18856@lst.de>
	<455BC1E1.2010300@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <455BC1E1.2010300@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 15, 2006 at 05:41:53PM -0800, Geoff Levand wrote:
> Christoph Hellwig wrote:
> >> + *  Copyright (C) 2006 Sony Computer Entertainment Inc.
> >> + *  Copyright 2006 Sony Corp.
> > 
> > One with a (C) and one without looks very odd.  Who from your corporate
> > mother Sony Corp touched this code anyway?
> 
> 
> Sony Corp. and Sony Computer Entertainment are different companies with
> different policies.  I have no choice here.

So did anyone from Sony Corp sactually touch all these files?

> I set it up that way so that the optimizer will remove the unused parts.
> This machine doesn't have much memory, and the dynamic (that's not my name
> BTW, came from your side) will normally not be used.  I don't really want
> to set it up as a runtime option unless there is a real user need.

The optimizer also optimizes away variables that can't be anything but
0.  I'm also not sure what "my side" (whatever that may be) has anything
to do with that.

> 
> 
> >> +enum allocate_memory {
> >> +	/* bit 63: transferability */
> >> +	LV1_AM_TF_NO = 0x00,
> >> +	LV1_AM_TF_YES = 0x01,
> >> +	/* bit 62: destruction scheme */
> >> +	LV1_AM_DS_NO_CONNECTIONS = 0x00,
> >> +	LV1_AM_DS_ANYTIME = 0x02,
> >> +	/* bit 61: fail or alternative */
> >> +	LV1_AM_FA_FAIL = 0x00,
> >> +	LV1_AM_FA_ALTERNATIVE = 0x04,
> >> +	/* bit 60: lpar address */
> >> +	LV1_AM_ADDR_ANY = 0x00,
> >> +	LV1_AM_ADDR_0 = 0x08,
> >> +};
> > 
> > If these are for different its they should be in different enums
> > and use different prefixes.
> 
> 
> These are all flags for lv1_allocate_memory (hence the the LV1_AM_
> prefix).  The bits are documented there in the comments, bit 60, 61, etc.

But this is just prone for users to get things wrong.  When flags
with the same prefix need to go to different locations something is
badly wrong.

> >> +#if !defined(_510B7842_EE09_4B12_BE5C_D217383D50C7)
> >> +#define _510B7842_EE09_4B12_BE5C_D217383D50C7
> > 
> > WTF?
> 
> 
> Considering your criticism earlier in this mail regarding the use of a
> file name in the file's comments, I'm wondering what your preference
> is here, since the convention is to use a symbol based on the file
> name...
> 
> BTW, I'm surprised you don't recognize it:
> uuidgen | tr 'a-z-' 'A-Z_' | sed -e 's/^/_/'

There's a good reason we don't use this elsewhere, and if you think it's a
good idea propose it for general use on lkml (and get the deserved flames)
instead of trying to sneak it in silently.  Re the filename comment:
this was mostly a thing for implementation (.c) files that get renamed
a lot so it easily gets stale and has no real value.  Headers by their
nature of beein used from various places tend to stay more stable so
this problem is not that bad. And unlike top of file comments inclusion
guards actually serve a purpose so we'll have to live with the
additional work of renaming them in case.
