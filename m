Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com
 [IPv6:2607:f8b0:400c:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsNdW4WjJzF1jC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 18:01:35 +1100 (AEDT)
Received: by mail-vk0-x241.google.com with SMTP id b65so3094433vka.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 23:01:35 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <87woyw8pxe.fsf@concordia.ellerman.id.au>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
 <87woyw8pxe.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 1 Mar 2018 08:01:12 +0100
Message-ID: <CA+7wUsxsZrjHY8=TSUiMEgGMm72XyQRW47b7oqNjFGeFKLMd+w@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 1, 2018 at 3:55 AM, Michael Ellerman <mpe@ellerman.id.au> wrote=
:
> Mathieu Malaterre <malat@debian.org> writes:
>
>> When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, =
the
>> array feature_properties is defined as an empty array, which in turn
>> triggers the following warning (treated as error on W=3D1):
>>
>>   CC      arch/powerpc/kernel/prom.o
>> arch/powerpc/kernel/prom.c: In function =E2=80=98check_cpu_feature_prope=
rties=E2=80=99:
>> arch/powerpc/kernel/prom.c:298:16: error: comparison of unsigned express=
ion < 0 is always false [-Werror=3Dtype-limits]
>>   for (i =3D 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>>                 ^
>> cc1: all warnings being treated as errors
>
> Ugh, that's annoying.
>
> This seems to work?
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 4dffef947b8a..5215119e249c 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -291,11 +291,11 @@ static inline void identical_pvr_fixup(unsigned lon=
g node)
>
>  static void __init check_cpu_feature_properties(unsigned long node)
>  {
> -       unsigned long i;
>         struct feature_property *fp =3D feature_properties;
>         const __be32 *prop;
> +       int i;
>
> -       for (i =3D 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
> +       for (i =3D 0; i < (int)ARRAY_SIZE(feature_properties); ++i, ++fp)=
 {
>                 prop =3D of_get_flat_dt_prop(node, fp->name, NULL);
>                 if (prop && be32_to_cpup(prop) >=3D fp->min_value) {
>                         cur_cpu_spec->cpu_features |=3D fp->cpu_feature;
>

Indeed that looks like the less invasive solution, I'll re-submit.

Should I resubmit the entire patch series (21 indep patches) or
re-submit only the 3 patches that were discussed (as part of a
different series) ?

Thanks
