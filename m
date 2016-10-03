Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snmDS64qVzDrDv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 02:29:12 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 6AF22202B8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 15:29:09 +0000 (UTC)
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
 [209.85.161.176])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B8BED20263
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 15:29:06 +0000 (UTC)
Received: by mail-yw0-f176.google.com with SMTP id t193so30875272ywc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Oct 2016 08:29:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1474828616-16608-2-git-send-email-arbab@linux.vnet.ibm.com>
References: <1474828616-16608-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1474828616-16608-2-git-send-email-arbab@linux.vnet.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 3 Oct 2016 10:28:45 -0500
Message-ID: <CAL_JsqKkYFeENE226QFsoqEMJEPpXET0-xJOWoA0j_tbOPu0_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drivers/of: introduce of_fdt_is_available()
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Frank Rowand <frowand.list@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 25, 2016 at 1:36 PM, Reza Arbab <arbab@linux.vnet.ibm.com> wrote:
> In __fdt_scan_reserved_mem(), the availability of a node is determined
> by testing its "status" property.
>
> Move this check into its own function, borrowing logic from the
> unflattened version, of_device_is_available().
>
> Another caller will be added in a subsequent patch.
>
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c       | 26 +++++++++++++++++++++++---
>  include/linux/of_fdt.h |  2 ++
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 085c638..9241c6e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -151,6 +151,23 @@ int of_fdt_match(const void *blob, unsigned long node,
>         return score;
>  }
>
> +bool of_fdt_is_available(const void *blob, unsigned long node)

of_fdt_device_is_available

[...]

> +bool __init of_flat_dt_is_available(unsigned long node)

And of_flat_dt_device_is_available

With that,

Acked-by: Rob Herring <robh@kernel.org>
