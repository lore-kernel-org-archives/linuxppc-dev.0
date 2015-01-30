Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A56C51A0D16
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 15:09:04 +1100 (AEDT)
In-Reply-To: <1421243519-6257-2-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
 Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/3] powerpc/pmac: Fix DT refcount imbalance in
 pmac_pic_probe_oldstyle
Message-Id: <20150130040904.8F89D1402A7@ozlabs.org>
Date: Fri, 30 Jan 2015 15:09:04 +1100 (AEDT)
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-14-01 at 13:51:57 UTC, Geert Uytterhoeven wrote:
> of_find_node_by_name() calls of_node_put() on its "from" parameter,
> which must not be done on "master", as it's still in use, and will be
> released manually later.  This may cause a zero kref refcount.
> Use of_get_child_by_name() instead to fix this.

But of_find_node_by_name() searches *all* nodes, not just the children of the
parameter.

So this is a logic change AFAICS, and I have no idea what machines we'd need to
test on to check it.

So I think an of_node_get(master) would be safer and also fix the refcounting.

cheers
