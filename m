Return-Path: <robherring2@gmail.com>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lMx20w05zDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 04:09:41 +1000 (AEST)
Received: by mail-it0-f68.google.com with SMTP id d9-v6so60322itf.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 11:09:41 -0700 (PDT)
Date: Tue, 7 Aug 2018 12:09:38 -0600
From: Rob Herring <robh@kernel.org>
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
 kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, keescook@chromium.org,
 tyreld@linux.vnet.ibm.com, joe@perches.com
Subject: Re: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq ranges
Message-ID: <20180807180938.GA13623@rob-hp-laptop>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
 <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2018 at 03:17:59PM +0530, Bharat Bhushan wrote:
> Freescale MPIC h/w may not support all interrupt sources reported
> by hardware, "last-interrupt-source" or platform. On these platforms
> a misconfigured device tree that assigns one of the reserved
> interrupts leaves a non-functioning system without warning.

There are lots of ways to misconfigure DTs. I don't think this is 
special and needs a property. We've had some interrupt mask or valid 
properties in the past, but generally don't accept those.

> 
> This patch adds "supported-irq-ranges" property in device tree to
> provide the range of supported source of interrupts. If a reserved
> interrupt used then it will not be programming h/w, which it does
> currently, and through warning.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/mpic.txt       |   8 ++
>  arch/powerpc/include/asm/mpic.h                    |   9 ++
>  arch/powerpc/sysdev/mpic.c                         | 113 +++++++++++++++++++--
>  3 files changed, 121 insertions(+), 9 deletions(-)
