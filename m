From: acmay@acmay.homeip.net
Date: Thu, 22 Mar 2001 14:06:00 -0800
To: Dan Malek <dan@mvista.com>
Cc: Ralph Blach <rblach@intrex.net>, frowand@mvista.com,
	linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Re: Proposed new kernel noncaching memory allocator for the 405gp
Message-ID: <20010322140600.A670@sink.san.rr.com>
References: <3ABA1B6A.87C5FE9B@intrex.net> <3ABA5152.34E4F5B4@mvista.com> <3ABA6746.4BB8DF7@intrex.net> <3ABA6D60.46D844F3@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ABA6D60.46D844F3@mvista.com>; from dan@mvista.com on Thu, Mar 22, 2001 at 04:23:44PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 22, 2001 at 04:23:44PM -0500, Dan Malek wrote:
>
> Ralph Blach wrote:
>
> > Yes, but these allocate on a page boundry and I was thinking of something a
> > little more granular.
>
> You can only control cache behavior on page boundaries at best, and
> from the few drivers I have looked at, this is exactly what they
> expect.

In the ppc405_enet driver both the Tx & Rx Desc Tables need to be
4kb aligned but only 130 bytes of the 2 pages are used. The max
the chip will even try to use is around 1k of the 8k.

If other chips don't need the 4k alignment requirement for their
data it would be a win to provide uncached mem from the same 2
pages needed for the enet chip.

--
Andrew May

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
