Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF9CE1A0190
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 19:31:23 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id l127so791866iof.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Feb 2016 00:31:23 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1454866730-10481-1-git-send-email-luis.henriques@canonical.com>
References: <1454866730-10481-1-git-send-email-luis.henriques@canonical.com>
Date: Mon, 8 Feb 2016 09:31:21 +0100
Message-ID: <CAMuHMdUjqx5sx3B2PJgK5eaef5FWRJkrGp+mM4A0KLPKjoMpkA@mail.gmail.com>
Subject: Re: [PATCH 0/4] powerpc/ps3: gelic_udbg: drop local versions of
 network data structs
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Luis Henriques <luis.henriques@canonical.com>
Cc: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 7, 2016 at 6:38 PM, Luis Henriques
<luis.henriques@canonical.com> wrote:
> Several network-related data structures are defined in gelic_udbg.
> These could be easily dropped and the standard ones defined in network
> headers could be used instead.
>
> The 4 patches that follow replace ethernet, vlan, ip and udp
> structures in gelic_udbg.  Note that this has been compile-tested
> only.

A few of these were declared __packed in the gelic driver, while that
attribute isn't used for the standard definitions.

It probably doesn't make a difference, as there are no gaps in the structures
when unpacked, unless pointers to the structures themselves are unaligned.

> Luis Henriques (4):
>   powerpc/ps3: gelic_udbg: use struct ethhdr from <linux/if_ether.h>
>   powerpc/ps3: gelic_udbg: use struct vlan_hdr from <linux/if_vlan.h>
>   powerpc/ps3: gelic_udbg: use struct iphdr from <linux/ip.h>
>   powerpc/ps3: gelic_udbg: use struct udphdr from <linux/udp.h>
>
>  arch/powerpc/platforms/ps3/gelic_udbg.c | 71 +++++++++++----------------------
>  1 file changed, 23 insertions(+), 48 deletions(-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
