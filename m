Return-Path: <robert.karl.berger@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D92CA2C0089
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 17:36:03 +1100 (EST)
Received: by mail-ee0-f42.google.com with SMTP id l10so39328eei.15
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2012 23:36:00 -0700 (PDT)
Message-ID: <5080F4C8.4000007@gmail.com>
Date: Fri, 19 Oct 2012 09:35:52 +0300
From: Robert Berger <robert.karl.berger@gmail.com>
MIME-Version: 1.0
To: Mai La <mla@apm.com>
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
 <50804020.30505@gmail.com> <1350587006.2476.12.camel@pasglop>
 <508060FD.3040202@gmail.com>
 <CAJ0-vuiccVbFk8=0TXO=Ak_a-0_yr55E2hs-GRVXLuKLNYjfCQ@mail.gmail.com>
In-Reply-To: <CAJ0-vuiccVbFk8=0TXO=Ak_a-0_yr55E2hs-GRVXLuKLNYjfCQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 10/19/2012 06:16 AM, Mai La wrote:
> Hi,
> 
> My patch was:
> 
> @@ -150,12 +157,11 @@ static int ppc4xx_setup_pcieh_hw(struct
> platform_device *dev,
>         if (!sdr_addr)
>                 return -1;
> 
> -       SDR0_WRITE(sdr_addr, (u64)res.start >> 32);      /*HIGH addr */
> -       SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
> -
> +       mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));      /*HIGH
> addr */
> +       mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));  /* Low
> addr */
> 
>         msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> -       if (msi->msi_dev)
> +       if (!msi->msi_dev)
>                 return -ENODEV;
> 
>         msi->msi_regs = of_iomap(msi->msi_dev, 0);
> 
> 
> 1. The first few lines: change from SDR0_WRITE to mtdcri since the old
> one cause crash. I use ELDK 4.2.

The old one does not cause a crash for me.  As I said on a kilauea board
with ELDK 4.2 a 3.6 kernel, default config and everything reverted to
the good old file I can boot happily with a rootfs from nfs.

If I use the file as it is in 3.6 I don't see the kernel booting. but it
crashes.

> 
> 2. The second one should mean that: if not find any node then return
> error. So it should be "!msi->msi_dev"

In the 3.6 kernel it's with ! the old file (which works for me) is
without the !

... very strange ...

> 
> Regards,
> Mai La.
> 
> 

Regards,

Robert
