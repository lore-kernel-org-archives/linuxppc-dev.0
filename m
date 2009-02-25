Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 7E58BDDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 21:50:59 +1100 (EST)
Date: Wed, 25 Feb 2009 11:50:57 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Mark Nelson <markn@au1.ibm.com>
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
In-Reply-To: <200902251227.38741.markn@au1.ibm.com>
Message-ID: <alpine.LRH.2.00.0902251150300.4063@vixen.sonytel.be>
References: <49A2705D.9030008@in.ibm.com>
	<18850.31567.212454.514549@cargo.ozlabs.ibm.com>
	<alpine.LRH.2.00.0902241857170.544@vixen.sonytel.be>
	<200902251227.38741.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Jan Kara <jack@ucw.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Feb 2009, Mark Nelson wrote:
> On Wed, 25 Feb 2009 05:01:59 am Geert Uytterhoeven wrote:
> > On Mon, 23 Feb 2009, Paul Mackerras wrote:
> > > Andrew Morton writes:
> > > > It looks like we died in ext3_xattr_block_get():
> > > > 
> > > > 		memcpy(buffer, bh->b_data + le16_to_cpu(entry->e_value_offs),
> > > > 		       size);
> > > > 
> > > > Perhaps entry->e_value_offs is no good.  I wonder if the filesystem is
> > > > corrupted and this snuck through the defenses.
> > > > 
> > > > I also wonder if there is enough info in that trace for a ppc person to
> > > > be able to determine whether the faulting address is in the source or
> > > > destination of the memcpy() (please)?
> > > 
> > > It appears to have faulted on a load, implicating the source.  The
> > > address being referenced (0xc00000003f380000) doesn't look
> > > outlandish.  I wonder if this kernel has CONFIG_DEBUG_PAGEALLOC turned
> > > on, and what page size is selected?
> > 
> > I'm seeing a similar thing on PS3, but not in ext3. During early userspace
> > setup (udevd), it crashes accessing a 0xc00* address in:
> > 
> > | NIP setup+0x20/0x130
> > | LR copy_user_page+0x18/0x6c
> > | Call trace:
> > | do_wp_page+0x5b4/0x89c
> > | do_page_fault+0x3a8/0x58c
> > | handle_page_fault+0x20/0x5c
> > 
> > I have CONFIG_DEBUG_PAGEALLOC=y. If I disable it, the system boots fine.
> > 
> > If needed, I can probably bisect this tomorrow. It definitely didn't happen in
> > 2.6.29-rc5.
> 
> No need to bisect - it was 25d6e2d7c58ddc4a3b614fc5381591c0cfe66556, my
> commit that "optimised" 64bit memcpy() for Power6 and Cell.
> 
> The bug was in -rc1, but if your copies were 8-byte aligned with respect
> to the source the problem wouldn't have been seen... Could this have
> been why you didn't see it in -rc5?

Hmm... I just started seeing it on older kernels (-rc5+), too...

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
