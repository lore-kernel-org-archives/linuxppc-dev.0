Return-Path: <srs0=tlxh=e6=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZ7yG29TDzDqHt
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:14 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zZ7yF3SJXz8wGm
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:13 +1100 (AEDT)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zZ7yD5qglz9t3C
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2018 22:38:11 +1100 (AEDT)
Date: Sun, 4 Feb 2018 11:58:45 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4.4 backport 10/16] powerpc/64s: Convert slb_miss_common
 to use RFI_TO_USER/KERNEL
Message-ID: <20180204105845.GG7519@kroah.com>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
 <20180204050010.13669-11-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204050010.13669-11-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2018 at 04:00:04PM +1100, Michael Ellerman wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> commit c7305645eb0c1621351cfc104038831ae87c0053 upstream.
> 
> In the SLB miss handler we may be returning to user or kernel. We need
> to add a check early on and save the result in the cr4 register, and
> then we bifurcate the return path based on that.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [mpe: Backport to 4.4 based on patch from Balbir]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

also applied to 4.9.y
