Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDZ6p153QzDt2H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 05:13:22 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 7F8C62039E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 18:13:19 +0000 (UTC)
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
 [209.85.161.180])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 71ED620392
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 18:13:16 +0000 (UTC)
Received: by mail-yw0-f180.google.com with SMTP id t125so215011942ywc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 10:13:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
References: <1478562276-25539-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 9 Nov 2016 12:12:55 -0600
Message-ID: <CAL_JsqLmAv4Pueq9XveeWMD3Jn_o6mGUcyztx8OajBGTrEd0aQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] of/fdt: mark hotpluggable memory
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 7, 2016 at 5:44 PM, Reza Arbab <arbab@linux.vnet.ibm.com> wrote:
> When movable nodes are enabled, any node containing only hotpluggable
> memory is made movable at boot time.
>
> On x86, hotpluggable memory is discovered by parsing the ACPI SRAT,
> making corresponding calls to memblock_mark_hotplug().
>
> If we introduce a dt property to describe memory as hotpluggable,
> configs supporting early fdt may then also do this marking and use
> movable nodes.
>
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c | 6 ++++++
>  mm/Kconfig       | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index c89d5d2..2cf1d66 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1015,6 +1015,7 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
>         const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>         const __be32 *reg, *endp;
>         int l;
> +       bool hotpluggable;
>
>         /* We are scanning "memory" nodes only */
>         if (type == NULL) {
> @@ -1034,6 +1035,7 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
>                 return 0;
>
>         endp = reg + (l / sizeof(__be32));
> +       hotpluggable = of_get_flat_dt_prop(node, "linux,hotpluggable", NULL);

Memory being hotpluggable doesn't seem like a linux property to me.
I'd drop the linux prefix. Also, this needs to be documented.

Rob
