Return-Path: <mdroth@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJmFX5S7QzDr7p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 09:03:28 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7NMwXb1145675
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 19:03:26 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 250q1m2q0d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 19:03:26 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Aug 2016 17:03:25 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8603819D803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 17:02:55 -0600 (MDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: Sahil Mehta <smehta@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <437ead25-8938-a0e8-c7cf-8ead45e5ef3b@linux.vnet.ibm.com>
 <9576c930-a87e-1d0c-e56b-7745d0b32137@linux.vnet.ibm.com>
In-Reply-To: <9576c930-a87e-1d0c-e56b-7745d0b32137@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/2] powerpc/pseries: Implement indexed-count hotplug
 memory remove
Date: Tue, 23 Aug 2016 18:03:14 -0500
Message-Id: <20160823230314.5405.81619@loki>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Sahil Mehta (2016-08-01 12:23:16)
> Indexed-count remove for memory hotplug guarantees that a contiguous block
> of <count> lmbs beginning at a specified <index> will be unassigned (NOT
> that <count> lmbs will be removed). Because of Qemu's per-DIMM memory
> management, the removal of a contiguous block of memory currently
> requires a series of individual calls. Indexed-count remove reduces
> this series into a single call.
> =

> Signed-off-by: Sahil Mehta <smehta@linux.vnet.ibm.com>
> ---
> v2:     -use u32s drc_index and count instead of u32 ic[]
>          in dlpar_memory
> v3:     -add logic to handle invalid drc_index input
> v4:     -none
> =

>  arch/powerpc/platforms/pseries/hotplug-memory.c |   90 +++++++++++++++++=
++++++
>  1 file changed, 90 insertions(+)
> =

> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/power=
pc/platforms/pseries/hotplug-memory.c
> index 2d4ceb3..dd5eb38 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -503,6 +503,92 @@ static int dlpar_memory_remove_by_index(u32 drc_inde=
x, struct property *prop)
>         return rc;
>  }
> =

> +static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index,
> +                                    struct property *prop)
> +{
> +       struct of_drconf_cell *lmbs;
> +       u32 num_lmbs, *p;
> +       int i, rc, start_lmb_found;
> +       int lmbs_available =3D 0, start_index =3D 0, end_index;
> +
> +       pr_info("Attempting to hot-remove %u LMB(s) at %x\n",
> +               lmbs_to_remove, drc_index);
> +
> +       if (lmbs_to_remove =3D=3D 0)
> +               return -EINVAL;
> +
> +       p =3D prop->value;
> +       num_lmbs =3D *p++;
> +       lmbs =3D (struct of_drconf_cell *)p;
> +       start_lmb_found =3D 0;
> +
> +       /* Navigate to drc_index */
> +       while (start_index < num_lmbs) {
> +               if (lmbs[start_index].drc_index =3D=3D drc_index) {
> +                       start_lmb_found =3D 1;
> +                       break;
> +               }
> +
> +               start_index++;
> +       }
> +
> +       if (!start_lmb_found)
> +               return -EINVAL;
> +
> +       end_index =3D start_index + lmbs_to_remove;
> +
> +       /* Validate that there are enough LMBs to satisfy the request */
> +       for (i =3D start_index; i < end_index; i++) {
> +               if (lmbs[i].flags & DRCONF_MEM_RESERVED)
> +                       break;
> +
> +               lmbs_available++;
> +       }
> +
> +       if (lmbs_available < lmbs_to_remove)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < end_index; i++) {

Shouldn't this be i =3D start_index? Otherwise it seems we'd attempt to
satisfy the request using LMBs outside of the requested range.

> +               if (!(lmbs[i].flags & DRCONF_MEM_ASSIGNED))
> +                       continue;
> +
> +               rc =3D dlpar_remove_lmb(&lmbs[i]);
> +               if (rc)
> +                       break;
> +
> +               lmbs[i].reserved =3D 1;
> +       }
> +
> +       if (rc) {
> +               pr_err("Memory indexed-count-remove failed, adding any re=
moved LMBs\n");
> +
> +               for (i =3D start_index; i < end_index; i++) {
> +                       if (!lmbs[i].reserved)
> +                               continue;
> +
> +                       rc =3D dlpar_add_lmb(&lmbs[i]);
> +                       if (rc)
> +                               pr_err("Failed to add LMB, drc index %x\n=
",
> +                                      be32_to_cpu(lmbs[i].drc_index));
> +
> +                       lmbs[i].reserved =3D 0;
> +               }
> +               rc =3D -EINVAL;
> +       } else {
> +               for (i =3D start_index; i < end_index; i++) {
> +                       if (!lmbs[i].reserved)
> +                               continue;
> +
> +                       pr_info("Memory at %llx (drc index %x) was hot-re=
moved\n",
> +                               lmbs[i].base_addr, lmbs[i].drc_index);
> +
> +                       lmbs[i].reserved =3D 0;
> +               }
> +       }
> +
> +       return rc;
> +}
> +
>  #else
>  static inline int pseries_remove_memblock(unsigned long base,
>                                           unsigned int memblock_size)
> @@ -829,6 +915,10 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>                 } else if (hp_elog->id_type =3D=3D PSERIES_HP_ELOG_ID_DRC=
_INDEX) {
>                         drc_index =3D hp_elog->_drc_u.drc_index;
>                         rc =3D dlpar_memory_remove_by_index(drc_index, pr=
op);
> +               } else if (hp_elog->id_type =3D=3D PSERIES_HP_ELOG_ID_DRC=
_IC) {
> +                       count =3D hp_elog->_drc_u.indexed_count[0];
> +                       drc_index =3D hp_elog->_drc_u.indexed_count[1];
> +                       rc =3D dlpar_memory_remove_by_ic(count, drc_index=
, prop);
>                 } else {
>                         rc =3D -EINVAL;
>                 }
> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
