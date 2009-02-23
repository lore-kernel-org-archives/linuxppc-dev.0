Return-Path: <jack+f-230209@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193]) by ozlabs.org (Postfix) with ESMTP id 40CB7DDEFA
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 03:18:54 +1100 (EST)
Date: Mon, 23 Feb 2009 16:51:16 +0100
From: Jan Kara <jack@suse.cz>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
Message-ID: <20090223155116.GB5764@atrey.karlin.mff.cuni.cz>
References: <49A2705D.9030008@in.ibm.com>
	<20090223021320.11019d64.akpm@linux-foundation.org>
	<18850.31567.212454.514549@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18850.31567.212454.514549@cargo.ozlabs.ibm.com>
Cc: Jan Kara <jack@ucw.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Andrew Morton writes:
> 
> > It looks like we died in ext3_xattr_block_get():
> > 
> > 		memcpy(buffer, bh->b_data + le16_to_cpu(entry->e_value_offs),
> > 		       size);
> > 
> > Perhaps entry->e_value_offs is no good.  I wonder if the filesystem is
> > corrupted and this snuck through the defenses.
> > 
> > I also wonder if there is enough info in that trace for a ppc person to
> > be able to determine whether the faulting address is in the source or
> > destination of the memcpy() (please)?
> 
> It appears to have faulted on a load, implicating the source.  The
> address being referenced (0xc00000003f380000) doesn't look
> outlandish.  I wonder if this kernel has CONFIG_DEBUG_PAGEALLOC turned
> on, and what page size is selected?
  Hmm, OK. But then I'm not sure how that can happen. Obviously, memcpy
somehow got beyond end of the page referenced by bh->b_data. So it means
that le16_to_cpu(entry->e_value_offs) + size > page_size. But
ext3_xattr_find_entry() calls ext3_xattr_check_entry() which in
particular checks whether e_value_offs + e_value_size isn't greater than
bh->b_size. So I see no way how memcpy can get beyond end of the page.
  Sachin, is the problem reproducible? If yes, can you send us contents
of the page just before the faulting address (i.e., for current fault it
would be 0xc00000003f370000-0xc00000003f37ffff). As far as I can
remember powerpc monitor could dump it.
  BTW, I suppose you use 4KB blocksize on the filesystem, right?

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
