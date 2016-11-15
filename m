Return-Path: <mdroth@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHptV5LlHzDsxl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 11:58:58 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAF0wikf076668
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 19:58:56 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qhh5a2ms-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 19:58:56 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mdroth@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 17:58:55 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20161018172053.37287.78128.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Cc: sahilmehta17@gmail.com
References: <20161018171803.37287.54834.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20161018172053.37287.78128.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Subject: Re: [PATCH v6 3/3] powerpc/pseries: Implement indexed-count hotplug
 memory remove
Date: Mon, 14 Nov 2016 18:58:46 -0600
Message-Id: <20161115005846.31168.3522@loki>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Nathan Fontenot (2016-10-18 12:21:06)
> From: Sahil Mehta <sahilmehta17@gmail.com>
> =

> Indexed-count remove for memory hotplug guarantees that a contiguous block
> of <count> lmbs beginning at a specified <index> will be unassigned (NOT
> that <count> lmbs will be removed). Because of Qemu's per-DIMM memory
> management, the removal of a contiguous block of memory currently
> requires a series of individual calls. Indexed-count remove reduces
> this series into a single call.
> =

> Signed-off-by: Sahil Mehta <sahilmehta17@gmail.com>
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
> v2:     -use u32s drc_index and count instead of u32 ic[]
>          in dlpar_memory
> v3:     -add logic to handle invalid drc_index input
> v4:     -none
> v5:     -Update for() loop to start at start_index
> v6:     -none
> =

>  arch/powerpc/platforms/pseries/hotplug-memory.c |   90 +++++++++++++++++=
++++++
>  1 file changed, 90 insertions(+)
> =

> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/power=
pc/platforms/pseries/hotplug-memory.c
> index badc66d..19ad081 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -558,6 +558,92 @@ static int dlpar_memory_remove_by_index(u32 drc_inde=
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
> +       for (i =3D start_index; i < end_index; i++) {
> +               if (!(lmbs[i].flags & DRCONF_MEM_ASSIGNED))
> +                       continue;
> +
> +               rc =3D dlpar_remove_lmb(&lmbs[i]);

dlpar_remove_lmb() currently does both offlining of the memory as well
as releasing the LMB back to the platform, but the specification for
hotplug notifications has the following verbage regarding
indexed-count/count identifiers:

'When using =E2=80=9Cdrc count=E2=80=9D or =E2=80=9Cdrc count indexed=E2=80=
=9D as the Hotplug Identifier,
the OS should take steps to verify the entirety of the request can be
satisfied before proceeding with the hotplug / unplug operations. If
only a partial count can be satisfied, the OS should ignore the entirety
of the request. If the OS cannot determine this beforehand, it should
satisfy the hotplug / unplug request for as many of the requested
resources as possible, and attempt to revert to the original OS / DRC
state.'

So doing the dlpar_remove->dlapr_add in case of failure is in line with
the spec, but it should only be done as a last-resort. To me that
suggests that we should be attempting to offline all the LMBs
beforehand, and only after that's successful should we begin attempting
to release LMBs back to the platform. Should we consider introducing
that logic in the patchset? Or maybe as a follow-up?

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
> @@ -853,6 +939,10 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
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
>=20
