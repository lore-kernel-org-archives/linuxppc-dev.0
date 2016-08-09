Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s87lZ1GLszDqh7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 08:11:05 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alan Modra <amodra@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Date: Wed, 10 Aug 2016 00:10:51 +0200
Message-ID: <4272416.nR10D7I1gD@wuerfel>
In-Reply-To: <20160808235016.GD20904@bubble.grove.modra.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1882847.dG563Vieov@wuerfel> <20160808235016.GD20904@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, August 9, 2016 9:20:16 AM CEST Alan Modra wrote:
> On Mon, Aug 08, 2016 at 05:14:27PM +0200, Arnd Bergmann wrote:
> > I have reverted that patch now, so ARM uses ".fixup" again like every
> > other architecture does, and now "*(.fixup) *(.text .text.*)" works
> > correctly, while ""*(.fixup) *(.text .fixup .text.*)" also fails
> > the same way that I saw before:
> 
> That is really odd.  The linker isn't supposed to treat those script
> snippets differently.  First match for .fixup wins.

Sorry for my mistake. I checked again and cannot reproduce what I
thought I saw earlier. "*(.fixup) *(.text .text.*)" fails
as would be expected.

	Arnd
