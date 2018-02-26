Return-Path: <srs0=7hi6=fu=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqb2F1d9lzF1KZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 19:43:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zqb2D68Bqz8tKv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 19:43:16 +1100 (AEDT)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zqb2C5wc2z9s1l
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2018 19:43:15 +1100 (AEDT)
Date: Mon, 26 Feb 2018 09:43:14 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org,
 bernhard.kaindl@thalesgroup.com
Subject: Re: [PATCH stable v4.4] powerpc/64s: Fix RFI flush dependency on
 HARDLOCKUP_DETECTOR
Message-ID: <20180226084314.GA24511@kroah.com>
References: <20180226021317.28767-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226021317.28767-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 26, 2018 at 01:13:17PM +1100, Michael Ellerman wrote:
> The backport of commit aa8a5e0062ac ("powerpc/64s: Add support for RFI
> flush of L1-D cache"), incorrectly placed the new RFI flush code
> inside an existing #ifdef CONFIG_HARDLOCKUP_DETECTOR block.
> 
> This has the obvious effect of requiring HARDLOCKUP_DETECTOR to be
> enabled in order for RFI flush to be enabled, which is a bug.
> 
> Fix it by moving the #endif up to where it belongs.
> 
> Fixes: c3892946315e ("powerpc/64s: Add support for RFI flush of L1-D cache")
> Reported-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/setup_64.c | 2 +-

Thanks, now queued up.

greg k-h
