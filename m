Return-Path: <mitchelh@codeaurora.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA3BD1A0C65
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 04:07:43 +1100 (AEDT)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A2C691402C0
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2015 04:07:43 +1100 (AEDT)
From: Mitchel Humpherys <mitchelh@codeaurora.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@ozlabs.org>,
 frowand.list@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH] of: Fix comparison of reserved memory regions
References: <1447843598-9355-1-git-send-email-mpe@ellerman.id.au>
Date: Fri, 04 Dec 2015 09:07:39 -0800
In-Reply-To: <1447843598-9355-1-git-send-email-mpe@ellerman.id.au> (Michael
 Ellerman's message of "Wed, 18 Nov 2015 21:46:38 +1100")
Message-ID: <vnkwk2oum9b8.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 18 2015 at 09:46:38 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> In order to check for overlapping reserved memory regions, we first need
> to sort the array of memory regions. This is implemented using sort(),
> and a custom comparison function __rmem_cmp().
>
> Unfortunatley __rmem_cmp() doesn't work in all cases. Because the two
> base values are phys_addr_t, they may be u64 on some platforms, in which
> case subtracting one from the other and then (implicitly) casting to int
> does not give us the -ve/0/+ve value we need.
>
> This leads to incorrect reports about overlaps, eg:
>
>   ibm,slw-image@1ffe600000 (0x0000001ffe600000--0x0000001ffe700000) overlaps with
>   ibm,firmware-allocs-memory@1000000000 (0x0000001000000000--0x0000001000dc0200)
>
> Fix it by just doing the standard double if and return 0 logic.
>
> Fixes: ae1add247bf8 ("of: Check for overlap in reserved memory regions")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/of/of_reserved_mem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Woops, thanks.

Tested-by: Mitchel Humpherys <mitchelh@codeaurora.org>

-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
