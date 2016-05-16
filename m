Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7j7V5KBfzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 00:11:33 +1000 (AEST)
Date: Mon, 16 May 2016 09:11:26 -0500
From: Rob Herring <robh@kernel.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, geert@linux-m68k.org,
 robherring2@gmail.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, bhelgaas@google.com, grant.likely@linaro.org,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH] drivers/of: Fix build warning in populate_node()
Message-ID: <20160516141126.GC21849@rob-hp-laptop>
References: <CAMuHMdUnsDhTS5-C6_SvrqGb6hVTBZOz00=HBGhtqAQbwYv6hg@mail.gmail.com>
 <1463139099-23363-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463139099-23363-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 13, 2016 at 09:31:39PM +1000, Gavin Shan wrote:
> Function populate_node() is used to unflatten FDT blob to device
> tree. It supports maximal 64 level of device nodes. There is one
> array @fpsizes[64] tracking the full name length of last unflattened
> device node in the corresponding level (index of element in the
> array - 1). Build warning is seen with CONFIG_FRAME_WARN=1024 like
> below on ARM64 as Geert reported. The issue can be reproduced on
> PPC64 as well.
> 
>   $ make drivers/of/fdt.o
>   drivers/of/fdt.c:443:1: warning: the frame size of 1136 bytes is \
>   larger than 1024 bytes [-Wframe-larger-than=]
> 
> This changes the data type of @fpsizes[i] from "unsigned long" to
> "unsigned int" to avoid the build warning. The return value type
> of populate_node() and its @fpsize argument is adjusted accordingly.
> With this applied, 256 bytes saved from the stack frame on ARM64 and
> PPC64 platforms and the above warning isn't seen.
> 
> Fixes: 9ffa9eb ("drivers/of: Avoid recursively calling unflatten_dt_node()")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

Rob
