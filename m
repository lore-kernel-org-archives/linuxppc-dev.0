Return-Path: <ppc6dev@digitaldans.com>
Received: from digitaldans.com (digitaldans.com [69.36.177.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A21B4B71AB
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2011 05:04:27 +1100 (EST)
Message-Id: <9CE82FAD-2451-4253-B304-CF8BE5AC8CAC@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFAF68F93F.57D058F1-ONC1257925.005B7C6F-C1257925.005C10D7@transmode.se>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 0/3] 8xx: Large page(8MB) support for 2.4
Date: Mon, 10 Oct 2011 11:03:53 -0700
References: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <39B024CE-70A2-4D32-A29C-5702C7D2D6CF@digitaldans.com>
 <OFAF68F93F.57D058F1-ONC1257925.005B7C6F-C1257925.005C10D7@transmode.se>
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


On Oct 10, 2011, at 9:45 AM, Joakim Tjernlund wrote:

> That is an easy port but I will have to do that blind. Would you
> mind take this for a spin on 2.4 first?

My current system is running 2.6, so I don't have much
interested in testing 2.4

> The more interesting part is if one should use other sized(16K or  
> 512K) large pages too?

My thought long ago was most of the 8xx systems have rather small
real memories, so the larger pages, especially 512K may be too wasteful.
I've always been a fan of keeping the TLB handlers tiny and simple,
rather then spending the instructions doing complex replacements.
Remember, this also affects the I- and D-cache, so a more frequent
and trivial PTE update could very well gain larger system performance
than the management of larger pages with more complex code.
With all of the bug fix code in the handlers, maybe a larger page would
be better.

> Those should be useful for user space but it is a lot of work. I  
> haven't checked
> what large page support for user space is in 2.6 for ppc though.

The 2.6/3.0 kernel supports different, but fixed, page sizes.  IIRC,  
anything
over 64K may require distribution rebuilding to realign code/data  
sections
to more restrictive boundaries.  Maybe a 16K page would show some  
benefit.
I'll try to make some time to play with it.

Thanks.

	-- Dan
