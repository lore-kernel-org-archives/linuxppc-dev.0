Return-Path: <bharata.rao@gmail.com>
Received: from mail-vc0-x22b.google.com (mail-vc0-x22b.google.com
 [IPv6:2607:f8b0:400c:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCA691A007F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:46:34 +1000 (EST)
Received: by mail-vc0-f171.google.com with SMTP id im17so3006902vcb.30
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Sep 2014 23:46:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1410549102-8410-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1410549102-8410-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1410549102-8410-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 12:16:31 +0530
Message-ID: <CAGZKiBoaXLc3dKGu5HGbU57+Lvi1KDUX=EYoi54PjYmEUjVUDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pseries: Fix endian issues in cpu hot-removal
From: Bharata B Rao <bharata.rao@gmail.com>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 13, 2014 at 12:41 AM, Thomas Falcon
<tlfalcon@linux.vnet.ibm.com> wrote:
> When removing a cpu, this patch makes sure that values
> gotten from or passed to firmware are in the correct
> endian format.
>
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> ---
> Changes in v2:
>
>  Followed suggestions from Michael Ellerman:
>    Conversion of intserv to cpu endian occurs once.
>    Conversion of drc_index to cpu endian occurs once
>    using of_property_read_u32.
> ---
>  arch/powerpc/platforms/pseries/dlpar.c       | 20 +++++++++++---------
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 ++++++----
>  2 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platfo=
rms/pseries/dlpar.c
> index 9e9f30b2..343dfdf 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -444,7 +444,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
>         int rc =3D 0;
>         unsigned int cpu;
>         int len, nthreads, i;
> -       const u32 *intserv;
> +       const __be32 *intserv;
> +       u32 thread;
>
>         intserv =3D of_get_property(dn, "ibm,ppc-interrupt-server#s", &le=
n);
>         if (!intserv)
> @@ -454,8 +455,9 @@ static int dlpar_offline_cpu(struct device_node *dn)
>
>         cpu_maps_update_begin();
>         for (i =3D 0; i < nthreads; i++) {
> +               thread =3D be32_to_cpu(intserv[i]);
>                 for_each_present_cpu(cpu) {
> -                       if (get_hard_smp_processor_id(cpu) !=3D intserv[i=
])
> +                       if (get_hard_smp_processor_id(cpu) !=3D thread)
>                                 continue;
>
>                         if (get_cpu_current_state(cpu) =3D=3D CPU_STATE_O=
FFLINE)
> @@ -477,14 +479,14 @@ static int dlpar_offline_cpu(struct device_node *dn=
)
>                          * Upgrade it's state to CPU_STATE_OFFLINE.
>                          */
>                         set_preferred_offline_state(cpu, CPU_STATE_OFFLIN=
E);
> -                       BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
> +                       BUG_ON(plpar_hcall_norets(H_PROD, thread)
>                                                                 !=3D H_SU=
CCESS);
>                         __cpu_die(cpu);
>                         break;
>                 }
>                 if (cpu =3D=3D num_possible_cpus())
>                         printk(KERN_WARNING "Could not find cpu to offlin=
e "
> -                              "with physical id 0x%x\n", intserv[i]);
> +                              "with physical id 0x%x\n", thread);
>         }
>         cpu_maps_update_done();
>
> @@ -496,15 +498,15 @@ out:
>  static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>  {
>         struct device_node *dn;
> -       const u32 *drc_index;
> +       const u32 drc_index;
>         int rc;
>
>         dn =3D of_find_node_by_path(buf);
>         if (!dn)
>                 return -EINVAL;
>
> -       drc_index =3D of_get_property(dn, "ibm,my-drc-index", NULL);
> -       if (!drc_index) {
> +       rc =3D of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);

Use of const for drc_index causes compilation problems.

Warning on Fedora 20 BE

arch/powerpc/platforms/pseries/dlpar.c: In function =E2=80=98dlpar_cpu_rele=
ase=E2=80=99:
arch/powerpc/platforms/pseries/dlpar.c:508:2: warning: passing
argument 3 of =E2=80=98of_property_read_u32=E2=80=99 discards =E2=80=98cons=
t=E2=80=99 qualifier from
pointer target type [enabled by default]
  rc =3D of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
  ^
In file included from arch/powerpc/platforms/pseries/dlpar.c:18:0:
include/linux/of.h:699:19: note: expected =E2=80=98u32 *=E2=80=99 but argum=
ent is of
type =E2=80=98const u32 *=E2=80=99
 static inline int of_property_read_u32(const struct device_node *np,

Error on Ubuntu 14.04 LE

arch/powerpc/platforms/pseries/dlpar.c: In function =E2=80=98dlpar_cpu_rele=
ase=E2=80=99:
arch/powerpc/platforms/pseries/dlpar.c:508:2: error: passing argument
3 of =E2=80=98of_property_read_u32=E2=80=99 discards =E2=80=98const=E2=80=
=99 qualifier from pointer
target type [-Werror]
  rc =3D of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
  ^
In file included from arch/powerpc/platforms/pseries/dlpar.c:18:0:
include/linux/of.h:699:19: note: expected =E2=80=98u32 *=E2=80=99 but argum=
ent is of
type =E2=80=98const u32 *=E2=80=99
 static inline int of_property_read_u32(const struct device_node *np,
                   ^
cc1: all warnings being treated as errors

Regards,
Bharata.
