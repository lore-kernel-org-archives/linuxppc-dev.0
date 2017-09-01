Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKpy0vkyzDqfx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:29:46 +1000 (AEST)
In-Reply-To: <1477769829-22230-9-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, kernel-janitors@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [08/15] powerpc/iommu: use permission-specific DEVICE_ATTR
 variants
Message-Id: <3xkKpy0Lxrz9t2d@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-10-29 at 19:37:02 UTC, Julia Lawall wrote:
> Use DEVICE_ATTR_RW for read-write attributes.  This simplifies the
> source code, improves readbility, and reduces the chance of
> inconsistencies.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @rw@
> declarer name DEVICE_ATTR;
> identifier x,x_show,x_store;
> @@
> 
> DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
> 
> @script:ocaml@
> x << rw.x;
> x_show << rw.x_show;
> x_store << rw.x_store;
> @@
> 
> if not (x^"_show" = x_show && x^"_store" = x_store)
> then Coccilib.include_match false
> 
> @@
> declarer name DEVICE_ATTR_RW;
> identifier rw.x,rw.x_show,rw.x_store;
> @@
> 
> - DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
> + DEVICE_ATTR_RW(x);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a7aef2cb3dafd2e8560750f4e5ad2

cheers
