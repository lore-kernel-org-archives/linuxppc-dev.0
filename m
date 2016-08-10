Return-Path: <ak@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s8C0n4NQwzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 10:37:45 +1000 (AEST)
Date: Tue, 9 Aug 2016 17:37:42 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Modra <amodra@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Message-ID: <20160810003742.GI3078@tassilo.jf.intel.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1882847.dG563Vieov@wuerfel>
 <20160809031605.GF3078@tassilo.jf.intel.com>
 <3076474.M72Ro1h3RL@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3076474.M72Ro1h3RL@wuerfel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2016 at 12:29:29AM +0200, Arnd Bergmann wrote:
> On Monday, August 8, 2016 8:16:05 PM CEST Andi Kleen wrote:
> > > I don't understand what led Andi Kleen to also move .text.hot and
> > > .text.unlikely together with .text [2], but this may have
> > > been a related issue.
> > >
> > > [2] https://lkml.org/lkml/2015/7/19/377
> >
> > The goal was just to move .hot and .unlikely all together, so that
> > they are clustered and use the minimum amount of cache. On x86 doesn't
> > matter where they are exactly, as long as each is together.
> > If they are not explicitely listed then the linker interleaves
> > them with the normal text, which defeats the purpose.
> 
> I still don't see it, my reading of your patch is that you did
> the opposite, by changing the description that puts all .text.hot
> in front of .text, and all .text.unlikely after exit.text into
> one that mixes them with .text. What am I missing here?

No it doesn't mix .unlikely with .text, .unlikely is all in one place.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
