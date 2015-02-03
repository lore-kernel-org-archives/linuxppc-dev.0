Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BA631A0B51
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 12:12:33 +1100 (AEDT)
Message-ID: <1422925952.4625.3.camel@ellerman.id.au>
Subject: Re: [1/3] powerpc/pmac: Fix DT refcount imbalance in
 pmac_pic_probe_oldstyle
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Feb 2015 12:12:32 +1100
In-Reply-To: <CAMuHMdUwQ=K7SnFvpaHzL2dCyNXGR3w-_SzFOEWb3cYCiQJfHg@mail.gmail.com>
References: <1421243519-6257-2-git-send-email-geert+renesas@glider.be>
 <20150130040904.8F89D1402A7@ozlabs.org>
 <CAMuHMdUwQ=K7SnFvpaHzL2dCyNXGR3w-_SzFOEWb3cYCiQJfHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Fri, 2015-01-30 at 10:00 +0100, Geert Uytterhoeven wrote:
> Hi Michael,
> 
> On Fri, Jan 30, 2015 at 5:09 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Wed, 2015-14-01 at 13:51:57 UTC, Geert Uytterhoeven wrote:
> >> of_find_node_by_name() calls of_node_put() on its "from" parameter,
> >> which must not be done on "master", as it's still in use, and will be
> >> released manually later.  This may cause a zero kref refcount.
> >> Use of_get_child_by_name() instead to fix this.
> >
> > But of_find_node_by_name() searches *all* nodes, not just the children of the
> > parameter.
> 
> That's correct. However, I guess the second mac-io will just be a direct child.

Yeah OK, I don't have a system or an example device tree to check.

> > So this is a logic change AFAICS, and I have no idea what machines we'd need to
> > test on to check it.
> 
> Originally it comes from arch/ppc/platforms/pmac_pic.c, added in 2002 in
> full-history-linux commit 5ea3254844ae344a
> ("Import arch/ppc and include/asm-ppc changes from linuxppc_2_5 tree").
> 
> I've also checked my linuxppc mail archives from 1997-2002, but couldn't find
> the actual patch and a description.
> 
> So I don't know on which machines it's needed.

Yep. Ben or Paul might know, but even then their memory may not be perfect :)
 
> > So I think an of_node_get(master) would be safer and also fix the refcounting.
> 
> If no one can confirm the above, that may indeed be the best solution.

I think so. Given how few of these machines are around it's easy to break them
with an inadvertent change like this, so I think it's better to be safe.

Wanna send a patch for that?

cheers
