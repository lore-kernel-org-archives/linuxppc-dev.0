Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D6A2A2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 03:58:11 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Fri, 5 Jul 2013 14:58:04 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 1980E3520027
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 13:58:01 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r65Huj9L23658540
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jul 2013 14:56:46 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r65Hvxu7009925
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jul 2013 14:57:59 -0300
Message-ID: <51D70927.3070909@linux.vnet.ibm.com>
Date: Fri, 05 Jul 2013 14:57:59 -0300
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 8/8] powerpc/perf: Add power8 EBB support
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-8-git-send-email-michael@ellerman.id.au>
 <51CABB56.9010105@linux.vnet.ibm.com> <1372333965.29229.26.camel@concordia>
 <51CD0DC7.7020702@linux.vnet.ibm.com> <51D5C5B9.4070005@linux.vnet.ibm.com>
 <20130705025427.GA27319@concordia>
In-Reply-To: <20130705025427.GA27319@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ryanarn@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04-07-2013 23:54, Michael Ellerman wrote:
> On Thu, Jul 04, 2013 at 03:58:01PM -0300, Adhemerval Zanella wrote:
>> Hi Michael,
>>
>> I believe you forgot to add the cpu_user_features2 bit to announce the EBB support
>> for P8, patch following:
> Hi Adhemerval,
>
> You're right, I haven't added it. I was wondering how best to do it.
>
> It's possible to configure the kernel so that it doesn't have PMU
> support, and in that case EBB is unsupported. It's also possible that something
> goes wrong with the PMU registration (kernel bug or OOM), and again EBB is then
> unsupported.
>
> So I think it might be better if we add PPC_FEATURE2_EBB at runtime in
> init_power8_pmu().
>
> What do you think?
Indeed your approach seems better (I wasn't aware you could configure
kernel with perf subsystem).

>
> Something like:
>
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
> index c7f8ccc..fd9ed89 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -620,10 +682,19 @@ static struct power_pmu power8_pmu = {
>
>  static int __init init_power8_pmu(void)
>  {
> +       int rc;
> +
>         if (!cur_cpu_spec->oprofile_cpu_type ||
>             strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8"))
>                 return -ENODEV;
>
> -       return register_power_pmu(&power8_pmu);
> +       rc = register_power_pmu(&power8_pmu);
> +       if (rc)
> +               return rc;
> +
> +       /* Tell userspace that EBB is supported */
> +       cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_EBB;
> +
> +       return 0;
>  }
>  early_initcall(init_power8_pmu);
>
>
> cheers
>
