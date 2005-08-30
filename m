Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 2ED38681CE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 01:39:01 +1000 (EST)
Date: Tue, 30 Aug 2005 08:38:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jon Masters <jonathan@jonmasters.org>
Message-ID: <20050830083859.B5925@cox.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<35fb2e5905082808152031ef53@mail.gmail.com>
	<528646bc05082817268abfb1d@mail.gmail.com>
	<431260BA.7000107@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <431260BA.7000107@jonmasters.org>;
	from jonathan@jonmasters.org on Mon, Aug 29, 2005 at 02:11:22AM
	+0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Address mapping PPC 405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 29, 2005 at 02:11:22AM +0100, Jon Masters wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Grant Likely wrote:
> 
> | On 8/28/05, Jon Masters <jonmasters@gmail.com> wrote:
> |
> |>On 8/26/05, P. Sadik <psadik@gmail.com> wrote:
> |>
> |>Lovely. We don't do it that way on 405 but we could - since the MMU is
> |>heavy soft assisted we could do that - we actually have everything run
> |>through the MMU once we've done initial MMU setup, but we do have the
> |>ability to mark ranges of addresses for IO and have the concept of TLB
> |>pinning to lock ranges of kernel addresses in large translated (BAT
> |>like for bigger PPC users) regions using just a few TLB slots. There
> |>is also a ZPR (zone protection register), but that's mostly used to
> |>fake the usual USER/KERNEL page distinction.
> 
> | I believe TLB pinning was removed in 2.6 in favor of large TLB entries
> | for kernel space.  Matt Porter pointed this out to me about a week
> | ago.  This will not matter of course if you're not using 2.6.
> 
> Maybe so. I'm thinking this is likely on 2.4  but I'd be interested to
> know what you mean - this isn't hugetlb (that's different), and TLB
> pinning on 2.4 means you only use a couple of (large) entries anyway. I
> can go read the source I suppose :-)

The following is 405 specific.

Well, on 2.4 we have CONFIG_PIN_TLB which covers the first 32MB of
kernel lowmem with two fixed 16MB TLB entries. In 2.6, all of kernel
lowmem is mapped by large pages of 16MB and 4MB sizes.

hugetlbfs, ioremap, and io_block_map could all be hooked into the 405
large page replacement support. I've been looking at doing this for
405 and 440 in my copious spare time. :)

-Matt
