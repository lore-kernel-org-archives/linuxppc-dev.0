Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 80774B6F68
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2011 18:43:08 +1100 (EST)
In-Reply-To: <9CE82FAD-2451-4253-B304-CF8BE5AC8CAC@digitaldans.com>
References: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <39B024CE-70A2-4D32-A29C-5702C7D2D6CF@digitaldans.com>
 <OFAF68F93F.57D058F1-ONC1257925.005B7C6F-C1257925.005C10D7@transmode.se>
 <9CE82FAD-2451-4253-B304-CF8BE5AC8CAC@digitaldans.com>
Subject: Re: [PATCH 0/3] 8xx: Large page(8MB) support for 2.4
To: Dan Malek <ppc6dev@digitaldans.com>
Message-ID: <OF5A487DD5.BE515A85-ONC1257926.0029F008-C1257926.002A6323@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 11 Oct 2011 09:42:58 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Malek <ppc6dev@digitaldans.com> wrote on 2011/10/10 20:03:53:
>
>
> On Oct 10, 2011, at 9:45 AM, Joakim Tjernlund wrote:
>
> > That is an easy port but I will have to do that blind. Would you
> > mind take this for a spin on 2.4 first?
>
> My current system is running 2.6, so I don't have much
> interested in testing 2.4

Too bad as I won't be able to run 2.6 at all.
However, I just sent you a dry port to 3.0 of the large page stuff to
you. Happy testing.

>
> > The more interesting part is if one should use other sized(16K or
> > 512K) large pages too?
>
> My thought long ago was most of the 8xx systems have rather small
> real memories, so the larger pages, especially 512K may be too wasteful.
> I've always been a fan of keeping the TLB handlers tiny and simple,
> rather then spending the instructions doing complex replacements.
> Remember, this also affects the I- and D-cache, so a more frequent
> and trivial PTE update could very well gain larger system performance
> than the management of larger pages with more complex code.
> With all of the bug fix code in the handlers, maybe a larger page would
> be better.
>
> > Those should be useful for user space but it is a lot of work. I
> > haven't checked
> > what large page support for user space is in 2.6 for ppc though.
>
> The 2.6/3.0 kernel supports different, but fixed, page sizes.  IIRC,
> anything
> over 64K may require distribution rebuilding to realign code/data
> sections
> to more restrictive boundaries.  Maybe a 16K page would show some
> benefit.
> I'll try to make some time to play with it.

Unfortunately 3.0 does not have any free PTE bits now. I had to move
_PAGE_SPECIAL to the last available one as the new _PAGE_PSE needed its place.
Don't know what _PAGE_SPECIAL is but if it cannot be removed one can always skip
_PAGE_WRITETHRU again.

 Jocke
