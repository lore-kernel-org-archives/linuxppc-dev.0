Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE10F1A0220
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 10:07:19 +1100 (AEDT)
Received: by mail-wm0-x22e.google.com with SMTP id r129so4057063wmr.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 15:07:19 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1454481372-10288-1-git-send-email-raghav@freescale.com>
References: <1454481372-10288-1-git-send-email-raghav@freescale.com>
Date: Thu, 4 Feb 2016 17:07:16 -0600
Message-ID: <CADRPPNTKFA8rkynJR4wCNgAmqvmiwYwTi2Uk9hDUMB4+N7ST_Q@mail.gmail.com>
Subject: Re: [PATCH] mtd/ifc: Add support for IFC controller version 2.0
From: Li Yang <leoli@freescale.com>
To: Raghav Dogra <raghav@freescale.com>
Cc: linux-mtd@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, oss@buserror.net,
 prabhakar.kushwaha@nxp.com, Brian Norris <computersforpeace@gmail.com>,
 Jaiprakash Singh <b44839@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 3, 2016 at 12:36 AM, Raghav Dogra <raghav@freescale.com> wrote:
> The new IFC controller version 2.0 has a different memory map page.
> Upto IFC 1.4 PAGE size is 4 KB and from IFC2.0 PAGE size is 64KB.
> This patch segregates the IFC global and runtime registers to appropriate
> PAGE sizes.

If the global registers and the runtime registers are so independent
that they have to be on different page boundaries, it would make more
sense for them to be defined as separate reg regions in the device
tree at the very beginning.  Then we would only need to change the
device tree now and it would be future proof for any page size.

>
> Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
> Signed-off-by: Raghav Dogra <raghav@freescale.com>

The patch cannot apply on latest 4.5-rc cleanly either.  Otherwise,

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
> This patch is the new version of following patch with changed title:
> https://patchwork.ozlabs.org/patch/557391/
>
> This patch is dependent on the
> "drivers/memory: Add deep sleep support for IFC" patch:
> https://patchwork.ozlabs.org/patch/564785/
>
>  drivers/memory/fsl_ifc.c        | 250 +++++++++++++++++++++-------------------
>  drivers/mtd/nand/fsl_ifc_nand.c |  72 ++++++------
>  include/linux/fsl_ifc.h         |  48 +++++---
>  3 files changed, 202 insertions(+), 168 deletions(-)

Regards,
Leo
