Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB5AB1A0193
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 09:11:10 +1100 (AEDT)
Date: Mon, 8 Feb 2016 22:10:54 +0000
From: Luis Henriques <luis.henriques@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] powerpc/ps3: gelic_udbg: drop local versions of
 network data structs
Message-ID: <20160208221054.GB11603@charon.olymp>
References: <1454866730-10481-1-git-send-email-luis.henriques@canonical.com>
 <CAMuHMdUjqx5sx3B2PJgK5eaef5FWRJkrGp+mM4A0KLPKjoMpkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMuHMdUjqx5sx3B2PJgK5eaef5FWRJkrGp+mM4A0KLPKjoMpkA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2016 at 09:31:21AM +0100, Geert Uytterhoeven wrote:
> On Sun, Feb 7, 2016 at 6:38 PM, Luis Henriques
> <luis.henriques@canonical.com> wrote:
> > Several network-related data structures are defined in gelic_udbg.
> > These could be easily dropped and the standard ones defined in network
> > headers could be used instead.
> >
> > The 4 patches that follow replace ethernet, vlan, ip and udp
> > structures in gelic_udbg.  Note that this has been compile-tested
> > only.
> 
> A few of these were declared __packed in the gelic driver, while that
> attribute isn't used for the standard definitions.
> 
> It probably doesn't make a difference, as there are no gaps in the structures
> when unpacked, unless pointers to the structures themselves are unaligned.
>

Thank you for your comments, Geert.  I had noticed those differences,
but the quick code review I did didn't show any issues with that could
be triggered by this change.  But as I referred, I only compile-tested
this code and didn't actually executed it in the real hw.

Cheers,
--
Luís

> > Luis Henriques (4):
> >   powerpc/ps3: gelic_udbg: use struct ethhdr from <linux/if_ether.h>
> >   powerpc/ps3: gelic_udbg: use struct vlan_hdr from <linux/if_vlan.h>
> >   powerpc/ps3: gelic_udbg: use struct iphdr from <linux/ip.h>
> >   powerpc/ps3: gelic_udbg: use struct udphdr from <linux/udp.h>
> >
> >  arch/powerpc/platforms/ps3/gelic_udbg.c | 71 +++++++++++----------------------
> >  1 file changed, 23 insertions(+), 48 deletions(-)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
