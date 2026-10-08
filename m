Return-Path: <linuxppc-dev+bounces-29062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B67CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 15:19:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0tvb0K6Wz30TY;
	Fri, 09 Oct 2026 02:19:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::122a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791472778;
	cv=pass; b=hPTGtXffxwYwovo9+nhrAqyyWzdL4IrhnekhP48Wa+yzFHI849dPBhk2X1rPwRP5fZXSFdAg4OPsWVNYH7IhbfrRDXipIyWo+CbxyCBlXZeMn7nXYlnSjMuqf2idLph96NuCFDYBedtmHOhZ90JCkKCWQatxDPBr/wGNBQc8jqg+sLPEVyyHxVv1TqZgFczr+/N0LOtxxr19n7aKILaA8d1deGE2EqGD6ZDQSNOqQ7scUjaQLcmF/zpZXDYs369Q/ss/siInQGe0v/OsZnIN0CRqdPxcPqFbpl07sTzsDWB9y3awODkiNpS1ZYhtOEDzQx1RLH5xAhVeggKwIq82/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791472778; c=relaxed/relaxed;
	bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkOCjivypu8sWqgeDrv873SRf9LcRcqPg2P5cNiqDxoxqjp2Ka66RCIiW+MOX6bYvkUwgcEwrIRsgVqi7HE8QplWyQ3JzFeaYWAeA+Fib1SKHL385ixFK7+20E/Q4kKg5FKTo/vrAAOFeUTrmmJbJiwd48wIXMr/mvtr7rvZztPXVQMqvJlcH89xYprfJ6ecsoikmVf2MTmg3uuyajcGKJ/scBtJcKkLEoDqs+6fBRz/9n9ibhKE7jUDPGBFCv6c8DgVSpXOrDRblupKdGxFmncenwOzriDYy/8Czk4rmfLkp5PGciBfJBqflluUznw30SqrsMiey/2vcavPuIGyNQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AwFCMmqU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=alexdeucher@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AwFCMmqU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=alexdeucher@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0tvY2WGGz30Nl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 02:19:36 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-150b2fbd784so56924c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 08:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791472774; cv=none;
        d=google.com; s=arc-20260327;
        b=Nj+9yAwtVaXpuTchuWZpaGmSivkoBqlRq00a31MPmN/iohYufgQ2uLnWJ7dSNmnAfW
         msO43agVgzn54Zt5DvugaFYTTU4hR4e8PZV5X+FjXUPoWFsi/VpbJV5raV8YZPasH272
         UzKatwPWc23SRIKwJnSzmDOUoOMl1B/Zb/EvV+nRIZ5Rr93Q/byOXObJ+/Uew6VUme+L
         tV+kkQDIscrERlvcW4K7OrPu8NBeg8OjEFV1sYSN2wRrxMk0obb1fPfYeEH0KrwpSk6d
         oOgk19vEvWMnNXahlPfXLZUUTbL4IW6am60pkkV4p24Ci1sSLV9vxFM+blDalli8zJpK
         fJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
        fh=GV1fB4u6R/YYzJsQtx4+EcR7ftEH7k7GwrtoNC51l08=;
        b=QmMLMYBGF62FQyeTkdhIgbB2ibOd5qMXhXk0pVni+MEO1tr/2b5L+3CcYf0NcfhcOa
         /MX8bGktyKlJ5YwMUcv45VrdemjzdvWS/gR2+v1Un/r/BAI00JzqJaJbtT7w9b7hcaF5
         QsyD8TSvY9NF0rL9vjWPsMQs4jIA3rRCePjcttuAHYJyL5WcQKaALXfxD6Hl/YBQf3Mf
         kLb/su/tAb690/LGqcv/VCtMoQ6OCfqGxn+mQjTeHck7u7Jbg6NgZgoMS0yi+FjUVZ14
         muuUgG1PSNKfzn7Ay6VoSjlWQzkICA5sPqdNnIn2zJ4gc3DFWWHPSbYylAY9ZqrF43sR
         ELQg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791472774; x=1792077574; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
        b=AwFCMmqUmNRL5KkEV85OOZSivzCr2qk3FA954hNzlRYv8sn+1pPdW62wxBWfGB3MOG
         A6dPyP3TlwwCT5pCKn+wQf667qz0LOULBNhrLkwwUish2WzczkKX497PH3V/UQmIXcEe
         fX9CtUJW0YK3uplnanESZ+CTddT40CK/N/R0M4LRqbk2qQ3FiF5LZTb5GVrZ6P47EiEp
         0dpre4II0HY5nN2v5i4ArYgg7j4HJf4mKEFJiw5e6W8HvubzIWKV/+sruk6YP6T6cem/
         JX0J1bpVPjr7ZB2Dg/KBYk0PTUsKo97gpHynJPTN85Z4VV8i8X94eD7qOhWT+XlvByiQ
         4QPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472774; x=1792077574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
        b=0OIRb7ei7KElkqcIPZLHNCh4aje87HxCltEI5hOlEcd4G45LsYBLluLAFdeFTGtW9z
         CmBC0Zhr99gp2iA0mdP1nlaLG4yOzAgscUBKiZWO1vyhOvBnUztm0H3AbVJxJ+lLQheu
         RfClhhX2LOqb+UUJ/5r5e+Oxb15azZr0vG6BYoDmUQNMUeLHsZ1Cw79D1EARQ/mISPuo
         saSWXgXa4Y9OcPRVff6lVtl+Zz9eVm4D/ENqdAAeibb8mljCHjRaOYgeyWTJS19/9pEs
         hsifmzhy/Ltdz/3w8uXnt953hsOVCBZKroMt+ebJX1DT6/j9LBCpmv7Cj3T/gSH0IRzB
         ZVcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRuo3thsj6z/o7GptfaYQe+6uhgTIuWKgyNhjjeb/uguVdozHKEPVUnV2SlZSX1NfDroUDYfjsmIQ5sQc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lDgptqdkpdnMzSWHnwM9F7nx3tCoyUhhM8DN4Gkc1+GNTtsS7D
	Cx5IaeRnX8pQFSqN/L0tL+2JUYPEiTjIGGhnU9Lvygv5dFxOHFsblYXHCl73McGkA/oQpH4uwr0
	LkiszGFNwVJ7HED8LZGV94Ll07LdQC0o=
X-Gm-Gg: AYBFou1cTdjhuwov/Y3glTywDhJ9VvZd4zV61cigbkIUgB3W7geWu8V+qZ6nu/8HtY8
	qtGBJKo/8yWCdyyVPFEB6XEhFh3JVGn3+GQN6tLWGTFVnBq0FQC/yCOIm3kevRkMN7fdhdRswFM
	btfE6kYQNtgnu2lKLE+LZWW9PCcUIKa1iHBDMPH9EEpuV1er/sD5/x3Ohgm3O+JdouSPXrVd5Ot
	0Ylw9O72uUo6n71MnMrTL39aDFxWijLWsTktD2hNvk5hZnXTdFU5XxPWpvppCecKPp3WB67MPsX
	5CkPcdK7+dzJmVXEN7tGUDomeJUK8eohOcl/kkV+KFToRSJzR83TyM40/F7FFh1uUDA8DPNhtan
	0jc0i3EQYo8IY0zSiR7o5EcXSiWwrWwSCXqNTnh3kFA==
X-Received: by 2002:a05:7022:1505:b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-1658abf47cfmr6616040c88.2.1791472774454; Thu, 08 Oct 2026
 08:19:34 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
In-Reply-To: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Oct 2026 11:19:22 -0400
X-Gm-Features: AclHuK8eqqZZwcxfnGYDRIjGfmIuea5RApPlIzK4ZWhRJY1bOeK92MqHIl3h3To
Message-ID: <CADnq5_PVD6G_VMepJ3mAz=60vM1PHtun51Kccxyz9sdBsx_7wA@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
	Jason Perlow <jperlow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 8:26=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> Alex is seeing a probe failure of the amdgpu driver after the Root Port
> above an AMD Navi10 GPU has been reset.  The reset was performed to
> recover from a Firmware First reported Fatal Error.
>
> However all status registers in the Root Port's AER Extended Capability
> are blank, so apparently the platform firmware raised a false alarm.
>
> The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
> Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> Errors causes code paths to be exercised in platform firmware which
> were never validated before.
>
> Skip error recovery on false alarms, i.e. if no unmasked errors were
> actually signaled.
>
> Note that this will also skip recovery if both the Status and Mask
> registers are "all ones", as would be the case for inaccessible devices.
> However that seems justified because it would imply either a hot-unplug
> event or a Surprise Down Error further up in the hierarchy.  Interfering
> with recovery from that seems uncalled for.
>
> Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> Reported-by: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Alex Deucher <alexander.deucher@amd.com>

FWIW, I only tested this patch in conjunction with the other two
patches you had posted on the ticket.  I haven't tried just this patch
alone.

Alex

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  When applied to pci/for-linus, this will cause a conflict during the
>  merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
>  Fix memory leak in aer_recover_work_func() when pci_dev is missing").
>
>  To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
>  and move the pci_dev_put() out of the if-clause (so that it gets
>  called if pdev !=3D NULL but err =3D=3D 0).
>
>  If this is all too complicated and/or late, I can respin on top of
>  pci/aer or v7.4-rc1.
>
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1..922a726a52a5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer_r=
ecover_entry,
>
>  static void aer_recover_work_func(struct work_struct *work)
>  {
> +       struct aer_capability_regs *regs;
>         struct aer_recover_entry entry;
>         struct pci_dev *pdev;
> +       u32 err;
>
>         while (kfifo_get(&aer_recover_ring, &entry)) {
>                 pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.=
bus,
> @@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_stru=
ct *work)
>                 }
>                 pci_print_aer(pdev, entry.severity, entry.regs);
>
> +               regs =3D entry.regs;
> +               if (entry.severity =3D=3D AER_CORRECTABLE)
> +                       err =3D regs->cor_status & ~regs->cor_mask;
> +               else
> +                       err =3D regs->uncor_status & ~regs->uncor_mask;
> +
>                 /*
>                  * Memory for aer_capability_regs(entry.regs) is being
>                  * allocated from the ghes_estatus_pool to protect it fro=
m
> @@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_str=
uct *work)
>                 ghes_estatus_pool_region_free((unsigned long)entry.regs,
>                                             sizeof(struct aer_capability_=
regs));
>
> -               if (entry.severity =3D=3D AER_NONFATAL)
> -                       pcie_do_recovery(pdev, pci_channel_io_normal,
> -                                        aer_root_reset);
> -               else if (entry.severity =3D=3D AER_FATAL)
> -                       pcie_do_recovery(pdev, pci_channel_io_frozen,
> -                                        aer_root_reset);
> +               if (err) {
> +                       if (entry.severity =3D=3D AER_NONFATAL)
> +                               pcie_do_recovery(pdev, pci_channel_io_nor=
mal,
> +                                                aer_root_reset);
> +                       else if (entry.severity =3D=3D AER_FATAL)
> +                               pcie_do_recovery(pdev, pci_channel_io_fro=
zen,
> +                                                aer_root_reset);
> +               }
>                 pci_dev_put(pdev);
>         }
>  }
> --
> 2.53.0
>

