Return-Path: <srs0=jxmh=cs=gmail.com=jwboyer@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygbz26Mm2zDrRY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 04:57:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ygbz227r7z8t4g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 04:57:34 +1100 (AEDT)
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ygbz13cwFz9s7C
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2017 04:57:33 +1100 (AEDT)
Received: by mail-qk0-x244.google.com with SMTP id j202so8505248qke.10
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2017 09:57:33 -0800 (PST)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <1510107838-15181-11-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1510107838-15181-11-git-send-email-sukadev@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@fedoraproject.org>
Date: Mon, 20 Nov 2017 12:57:30 -0500
Message-ID: <CA+5PVA7k+6kWoD2moFVjM9X=B3fZJxGrM=C6EVw9UtjEYrk6fQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/18] powerpc/vas,
 nx-842: Define and use chip_to_vas_id()
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, hbabu@us.ibm.com,
 nicholas.piggin@gmail.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 "kernel-team@fedoraproject.org" <kernel-team@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 7, 2017 at 9:23 PM, Sukadev Bhattiprolu
<sukadev@linux.vnet.ibm.com> wrote:
> Define a helper, chip_to_vas_id() to map a given chip id to corresponding
> vas id.
>
> Normally, callers of vas_rx_win_open() and vas_tx_win_open() want the VAS
> window to be on the same chip where the calling thread is executing. These
> callers can pass in -1 for the VAS id.
>
> This interface will be useful if a thread running on one chip wants to open
> a window on another chip (like the NX-842 driver does during start up).
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

The Fedora kernel team seems to have hit an issue with this commit
when trying to build a rawhide kernel that includes it.  The failure
is:

ERROR: "chip_to_vas_id" [drivers/crypto/nx/nx-compress-powernv.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
make: *** [Makefile:1218: modules] Error 2
+ exit 1
error: Bad exit status from /var/tmp/rpm-tmp.dmbw5D (%build)
RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.dmbw5D (%build)
Child return code was: 1
EXCEPTION: [Error()]

> ---
>  arch/powerpc/include/asm/vas.h       |  9 +++++++++
>  arch/powerpc/platforms/powernv/vas.c | 11 +++++++++++
>  drivers/crypto/nx/nx-842-powernv.c   | 18 +++---------------
>  3 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
> index fd5963a..044748f 100644
> --- a/arch/powerpc/include/asm/vas.h
> +++ b/arch/powerpc/include/asm/vas.h
> @@ -104,6 +104,15 @@ struct vas_tx_win_attr {
>  };
>
>  /*
> + * Helper to map a chip id to VAS id.
> + * For POWER9, this is a 1:1 mapping. In the future this maybe a 1:N
> + * mapping in which case, we will need to update this helper.
> + *
> + * Return the VAS id or -1 if no matching vasid is found.
> + */
> +int chip_to_vas_id(int chipid);
> +
> +/*
>   * Helper to initialize receive window attributes to defaults for an
>   * NX window.
>   */
> diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
> index abb7090..cd9a733 100644
> --- a/arch/powerpc/platforms/powernv/vas.c
> +++ b/arch/powerpc/platforms/powernv/vas.c
> @@ -123,6 +123,17 @@ struct vas_instance *find_vas_instance(int vasid)
>         return NULL;
>  }
>
> +int chip_to_vas_id(int chipid)
> +{
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               if (cpu_to_chip_id(cpu) == chipid)
> +                       return per_cpu(cpu_vas_id, cpu);
> +       }
> +       return -1;
> +}
> +

Likely need an EXPORT_SYMBOL here?

>  static int vas_probe(struct platform_device *pdev)
>  {
>         return init_vas_instance(pdev);
> diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
> index 874ddf5..eb221ed 100644
> --- a/drivers/crypto/nx/nx-842-powernv.c
> +++ b/drivers/crypto/nx/nx-842-powernv.c

Did anyone test this driver built as a module with this commit included?

josh

> @@ -847,24 +847,12 @@ static int __init nx842_powernv_probe_vas(struct device_node *pn)
>                 return -EINVAL;
>         }
>
> -       for_each_compatible_node(dn, NULL, "ibm,power9-vas-x") {
> -               if (of_get_ibm_chip_id(dn) == chip_id)
> -                       break;
> -       }
> -
> -       if (!dn) {
> -               pr_err("Missing VAS device node\n");
> +       vasid = chip_to_vas_id(chip_id);
> +       if (vasid < 0) {
> +               pr_err("Unable to map chip_id %d to vasid\n", chip_id);
>                 return -EINVAL;
>         }
>
> -       if (of_property_read_u32(dn, "ibm,vas-id", &vasid)) {
> -               pr_err("Missing ibm,vas-id device property\n");
> -               of_node_put(dn);
> -               return -EINVAL;
> -       }
> -
> -       of_node_put(dn);
> -
>         for_each_child_of_node(pn, dn) {
>                 if (of_device_is_compatible(dn, "ibm,p9-nx-842")) {
>                         ret = vas_cfg_coproc_info(dn, chip_id, vasid);
> --
> 2.7.4
>
