Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x229.google.com (mail-la0-x229.google.com
 [IPv6:2a00:1450:4010:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F3B91A0DC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 20:00:29 +1100 (AEDT)
Received: by mail-la0-f41.google.com with SMTP id gm9so22644403lab.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 01:00:24 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150130040904.8F89D1402A7@ozlabs.org>
References: <1421243519-6257-2-git-send-email-geert+renesas@glider.be>
 <20150130040904.8F89D1402A7@ozlabs.org>
Date: Fri, 30 Jan 2015 10:00:23 +0100
Message-ID: <CAMuHMdUwQ=K7SnFvpaHzL2dCyNXGR3w-_SzFOEWb3cYCiQJfHg@mail.gmail.com>
Subject: Re: [1/3] powerpc/pmac: Fix DT refcount imbalance in
 pmac_pic_probe_oldstyle
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Bryan Wu <cooloney@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Jingoo Han <jg1.han@samsung.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Richard Purdie <rpurdie@rpsys.net>, Lee Jones <lee.jones@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Fri, Jan 30, 2015 at 5:09 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Wed, 2015-14-01 at 13:51:57 UTC, Geert Uytterhoeven wrote:
>> of_find_node_by_name() calls of_node_put() on its "from" parameter,
>> which must not be done on "master", as it's still in use, and will be
>> released manually later.  This may cause a zero kref refcount.
>> Use of_get_child_by_name() instead to fix this.
>
> But of_find_node_by_name() searches *all* nodes, not just the children of the
> parameter.

That's correct. However, I guess the second mac-io will just be a direct child.

> So this is a logic change AFAICS, and I have no idea what machines we'd need to
> test on to check it.

Originally it comes from arch/ppc/platforms/pmac_pic.c, added in 2002 in
full-history-linux commit 5ea3254844ae344a
("Import arch/ppc and include/asm-ppc changes from linuxppc_2_5 tree").

I've also checked my linuxppc mail archives from 1997-2002, but couldn't find
the actual patch and a description.

So I don't know on which machines it's needed.

> So I think an of_node_get(master) would be safer and also fix the refcounting.

If no one can confirm the above, that may indeed be the best solution.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
