Return-Path: <markn@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 571ECDDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 12:26:08 +1100 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n1P1PgU6025627
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 12:25:42 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n1P1QKAh1167426
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 12:26:20 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1P1Q23S020177
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 12:26:02 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
Date: Wed, 25 Feb 2009 12:27:38 +1100
References: <49A2705D.9030008@in.ibm.com>
	<18850.31567.212454.514549@cargo.ozlabs.ibm.com>
	<alpine.LRH.2.00.0902241857170.544@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0902241857170.544@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200902251227.38741.markn@au1.ibm.com>
Cc: Jan Kara <jack@ucw.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Feb 2009 05:01:59 am Geert Uytterhoeven wrote:
> On Mon, 23 Feb 2009, Paul Mackerras wrote:
> > Andrew Morton writes:
> > > It looks like we died in ext3_xattr_block_get():
> > > 
> > > 		memcpy(buffer, bh->b_data + le16_to_cpu(entry->e_value_offs),
> > > 		       size);
> > > 
> > > Perhaps entry->e_value_offs is no good.  I wonder if the filesystem is
> > > corrupted and this snuck through the defenses.
> > > 
> > > I also wonder if there is enough info in that trace for a ppc person to
> > > be able to determine whether the faulting address is in the source or
> > > destination of the memcpy() (please)?
> > 
> > It appears to have faulted on a load, implicating the source.  The
> > address being referenced (0xc00000003f380000) doesn't look
> > outlandish.  I wonder if this kernel has CONFIG_DEBUG_PAGEALLOC turned
> > on, and what page size is selected?
> 
> I'm seeing a similar thing on PS3, but not in ext3. During early userspace
> setup (udevd), it crashes accessing a 0xc00* address in:
> 
> | NIP setup+0x20/0x130
> | LR copy_user_page+0x18/0x6c
> | Call trace:
> | do_wp_page+0x5b4/0x89c
> | do_page_fault+0x3a8/0x58c
> | handle_page_fault+0x20/0x5c
> 
> I have CONFIG_DEBUG_PAGEALLOC=y. If I disable it, the system boots fine.
> 
> If needed, I can probably bisect this tomorrow. It definitely didn't happen in
> 2.6.29-rc5.

No need to bisect - it was 25d6e2d7c58ddc4a3b614fc5381591c0cfe66556, my
commit that "optimised" 64bit memcpy() for Power6 and Cell.

The bug was in -rc1, but if your copies were 8-byte aligned with respect
to the source the problem wouldn't have been seen... Could this have
been why you didn't see it in -rc5?

I'll work on a fix now.

Thanks!

Mark
