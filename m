Message-ID: <3DA6CA28.4F84FDFB@ardistech.com>
Date: Fri, 11 Oct 2002 14:55:04 +0200
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx i2c refers to unspecified chip errata
References: <IGEFJKJNHJDCBKALBJLLEEAPFHAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> Look in cpm_iic_read() for:
> /* flush will invalidate too. */
> flush_dcache_range((unsigned long)buf, (unsigned long)(buf+count));
>
> You can't just do invalidate_dcache_range() since it will invalidate more than your buffer
>
In my case it did invalidate the stack :(

> if it's not cache line aligned. Therefore you must flush to memory first and then invalidate.
> But you don't need an explicit invalidate_dcache_range() since flush_dcache_range() will flush to
> memory AND invalidate.
>
Better would be to have a special DMA region for this. Or as Dan suggest forget the
whole CPM IIC and do it by software.

Cheers,
	Bart

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
