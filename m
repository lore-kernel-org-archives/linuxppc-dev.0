Return-Path: <SRS0=Xeze=HO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268CEC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 18:26:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70ADC64DE2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 18:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ADC64DE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DchlM13MBzDwwK
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Feb 2021 05:26:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q5Xl1qbg; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DchjP4KWKzDwsw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2021 05:24:25 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F051164E9A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2021 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613154263;
 bh=i59A6KsNy0tuBkPE86R7oS3fgQDlOUtW1mMckoQBugI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=q5Xl1qbg6P6X2ZkGWrGMaZyoKgfIzt1OLjTvh0D/HEjTRDrAYcwJbSF41Sk5h1nhg
 s9Z5Zhd4Z4lyRDMoesjpjxUhoXHWWMj/kvm6aeb1iRqEfMJkTThF5N6xRO8bdPXpJD
 EBS1YfYI+rh6B0uw6xhUbPbOeo8pHH9O0bmn0nGeGXA8gRWfj5X9k6e+bt+xp5JkWV
 3TcJ0g04SQ2SS+sO5I6U9Sp3UaXcND1d0h7pbys9ZvGeRQueZSOHeULFw1f1CMJCwe
 uGfehtEeKvTPwUS0MxPaMo4vEWZNWK4p/DD8uHlQv1V5YTD2sZ5CDENYAKHwnVsuC7
 AIqam4F8TK+Sg==
Received: by mail-lf1-f45.google.com with SMTP id j19so734767lfr.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2021 10:24:22 -0800 (PST)
X-Gm-Message-State: AOAM533VA8OnGc5b43/Bd2xBo3KTL6iorvXSNCmPaRwn7utqWfLx0sMe
 whNxVfMsG7DQ7YudTx+cxReLv/xWRZkv63/70g==
X-Google-Smtp-Source: ABdhPJyhoggp31g4RDWhw83ePzBTd54yx+b2MhgGQx4aizGlRuZj/as8C2cqI3V6hI+fnA4ZqS7VGuem7Oso5zN7Aec=
X-Received: by 2002:a17:906:af41:: with SMTP id
 ly1mr4076035ejb.525.1613154260106; 
 Fri, 12 Feb 2021 10:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-3-nramas@linux.microsoft.com>
 <87k0reozwh.fsf@manicouagan.localdomain>
 <8a3aa3d2-2eba-549a-9970-a2b0fe3586c9@linux.microsoft.com>
 <CAL_JsqJ3sDzjsJXtb6EzE77BL+PhUxDJYUngLTqcm0popd7Ajw@mail.gmail.com>
 <55685b61-dac0-2f24-f74a-939acf74a4f2@linux.microsoft.com>
In-Reply-To: <55685b61-dac0-2f24-f74a-939acf74a4f2@linux.microsoft.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 12 Feb 2021 12:24:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKDCgtJngxqMCRdC9evEQpHnryEaMvfgYEh0Mcto6dLHA@mail.gmail.com>
Message-ID: <CAL_JsqKDCgtJngxqMCRdC9evEQpHnryEaMvfgYEh0Mcto6dLHA@mail.gmail.com>
Subject: Re: [PATCH v17 02/10] of: Add a common kexec FDT setup function
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, tao.li@vivo.com,
 Mimi Zohar <zohar@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 vincenzo.frascino@arm.com, Frank Rowand <frowand.list@gmail.com>,
 Sasha Levin <sashal@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
 James Morris <jmorris@namei.org>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, devicetree@vger.kernel.org,
 Pavel Tatashin <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>,
 Prakhar Srivastava <prsriva@linux.microsoft.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Allison Randal <allison@lohutok.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Matthias Brugger <mbrugger@suse.com>, balajib@linux.microsoft.com,
 dmitry.kasatkin@gmail.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 James Morse <james.morse@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>,
 linux-integrity@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 12, 2021 at 11:19 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 2/12/21 6:38 AM, Rob Herring wrote:
> > On Thu, Feb 11, 2021 at 7:17 PM Lakshmi Ramasubramanian
> > <nramas@linux.microsoft.com> wrote:
> >>
> >> On 2/11/21 5:09 PM, Thiago Jung Bauermann wrote:
> >>>
> >>> There's actually a complication that I just noticed and needs to be
> >>> addressed. More below.
> >>>
> >>
> >> <...>
> >>
> >>>> +
> >>>> +/*
> >>>> + * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
> >>>> + *
> >>>> + * @image:          kexec image being loaded.
> >>>> + * @initrd_load_addr:       Address where the next initrd will be loaded.
> >>>> + * @initrd_len:             Size of the next initrd, or 0 if there will be none.
> >>>> + * @cmdline:                Command line for the next kernel, or NULL if there will
> >>>> + *                  be none.
> >>>> + *
> >>>> + * Return: fdt on success, or NULL errno on error.
> >>>> + */
> >>>> +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> >>>> +                               unsigned long initrd_load_addr,
> >>>> +                               unsigned long initrd_len,
> >>>> +                               const char *cmdline)
> >>>> +{
> >>>> +    void *fdt;
> >>>> +    int ret, chosen_node;
> >>>> +    const void *prop;
> >>>> +    unsigned long fdt_size;
> >>>> +
> >>>> +    fdt_size = fdt_totalsize(initial_boot_params) +
> >>>> +               (cmdline ? strlen(cmdline) : 0) +
> >>>> +               FDT_EXTRA_SPACE;
> >>>
> >>> Just adding 4 KB to initial_boot_params won't be enough for crash
> >>> kernels on ppc64. The current powerpc code doubles the size of
> >>> initial_boot_params (which is normally larger than 4 KB) and even that
> >>> isn't enough. A patch was added to powerpc/next today which uses a more
> >>> precise (but arch-specific) formula:
> >>>
> >>> https://lore.kernel.org/linuxppc-dev/161243826811.119001.14083048209224609814.stgit@hbathini/
> >>>
> >>> So I believe we need a hook here where architectures can provide their
> >>> own specific calculation for the size of the fdt. Perhaps a weakly
> >>> defined function providing a default implementation which an
> >>> arch-specific file can override (a la arch_kexec_kernel_image_load())?
> >>>
> >>> Then the powerpc specific hook would be the kexec_fdt_totalsize_ppc64()
> >>> function from the patch I linked above.
> >>>
> >>
> >> Do you think it'd better to add "fdt_size" parameter to
> >> of_kexec_alloc_and_setup_fdt() so that the caller can provide the
> >> desired FDT buffer size?
> >
> > Yes, I guess so. But please define the param as extra size, not total
> > size. The kernel command line size addition can be in the common code.
>
> Will do. Just to clarify -
>
> The common code will do:
>
> fdt_totalsize(initial_boot_params) + strlen(cmdline) + extra_fdt_size
>
> The caller will pass "extra_fdt_size"
> ARM64 => 4KB
> PPC64 => fdt_totalsize(initial_boot_params) - which will be updated when
> the patch Thiago had referred to is merged.

Yes, I'd leave the 4KB in there by default and arm64 use 0.

Rob
