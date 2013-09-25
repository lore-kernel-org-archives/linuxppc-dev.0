Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-bk0-x229.google.com (mail-bk0-x229.google.com
 [IPv6:2a00:1450:4008:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2ED222C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 03:44:46 +1000 (EST)
Received: by mail-bk0-f41.google.com with SMTP id na10so14bkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 10:44:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 25 Sep 2013 19:44:36 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Timothy Pepper <timothy.c.pepper@linux.intel.com>
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-ID: <20130925174436.GA14037@gmail.com>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
 <20130925073048.GB27960@gmail.com>
 <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Michel Lespinasse <walken@google.com>,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, James Morris <james.l.morris@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Ralf Baechle <ralf@linux-mips.org>,
 Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Timothy Pepper <timothy.c.pepper@linux.intel.com> wrote:

> On Wed 25 Sep at 09:30:49 +0200 mingo@kernel.org said:
> > >  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> > >  	info.length = len;
> > > -	info.low_limit = PAGE_SIZE;
> > > +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
> > >  	info.high_limit = mm->mmap_base;
> > >  	info.align_mask = filp ? get_align_mask() : 0;
> > >  	info.align_offset = pgoff << PAGE_SHIFT;
> > 
> > There appears to be a lot of repetition in these methods - instead of 
> > changing 6 places it would be more future-proof to first factor out the 
> > common bits and then to apply the fix to the shared implementation.
> 
> Besides that existing redundancy in the multiple somewhat similar
> arch_get_unmapped_area_topdown() functions, I was expecting people might
> question the added redundancy of the six instances of:
> 
> 	max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));

That redundancy would be automatically addressed by my suggestion.

Thanks,

	Ingo
