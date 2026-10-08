Return-Path: <linuxppc-dev+bounces-29068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482EBCA600D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 19:23:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j10KM6Prjz30WX;
	Fri, 09 Oct 2026 06:23:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::132a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791487431;
	cv=pass; b=WZrZAZCxyF6UwLpKJaISfX5Z1/+GdmuQOElCgOfIaxmvgUy0GDExkWT32/o7g5phSBnYl9g9sZI3p74BT1+MFvx/bJ0wj6XlJbs995QRzzxvXu54UXkQIbNUf9ieC/5gjKp+ZvoifEF0AFfVvTtAffWgeac/QPGG8Q8J9GEb4kt/EGcVXgcXJbLLXYk7tzaI8IhRAf3swlm7LiZXqGy0Y357thKLKTPUvI9i9GfEXpNHiyfbgaPcDMv/VVDxwA4sJflM+wq5aHe++Bt44khzAc4MzoF/v4KvQeBr8kADL6tITzp5fEaMkFJmLZYi0OsNTNHD+1fdF+lW9R4lK/D0xQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791487431; c=relaxed/relaxed;
	bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=al88FRZGopeBrfIS0Z/tYuhypFRdtEUoB7eAiibwZSH9dW7x4ucnfUGJdAoqidORgarLrlfYs0rYJvql/Vos2uomAH+UEeQvkGOX2wtPsVbjrRD8arbPPDg0PhiRNSV8y8TkMuk6f2BvcD18R7bTXT95E5FHZ6pYI4q5836yhV2hOWMtZ6XkOl6LaUABbdW14Asn952Dz+41prjvyQIQmYzcCY9KlmxeZTFRDA70+GTxN+/4eoGQpYZQplk/PBuin9ITkB6w5KkMAzKhCi3ZnOBV+dMRWYzNgXGK7xsIncYJzl4zSb8V1uFOoabfwnsv4OnikmxHeRXKkr0HYcQiIQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XtX/gMFm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=alexdeucher@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XtX/gMFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=alexdeucher@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j10KL0JCJz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 06:23:48 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-33c30fcf33fso173661eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 12:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791487426; cv=none;
        d=google.com; s=arc-20260327;
        b=YEvNejv4I8JKJw1iOjUhWGbY61EFtDePsaloJtRd/q91hKJHlvrozMzjw02zePg3FD
         0ox7TuDqFnqUF+iPZwbwF9ACiqEKQ5Iq2ybftgz3Mks4HMrfJOUI4MtY6ANRL2Tqz0U/
         4tbQnEQKkPq7XdnrL34zmb5lp4gC4E004BmM3vCwYnjQ9PSKK9pGgLKEPlLAzjk2xLp7
         VK+hl74oAsDGwtK9ietWZkhzrhdvl+GQtET0OvpKO5WEG3oa1pjmYEJf+Ni19YoNwBWF
         HX0L5+tJTxtVr6N6O7XVAu5W9EOmIFTmytD4zy8vs9J4ps16dymamK/0Now0zb2d95LC
         GL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
        fh=pm8RDw1y+xvmB7RkRCZw5ATWpjUFTAxE0hxFttyhi8o=;
        b=n4j5IP2crlTa3+zNenkX8pN67fbybJ8lFLFmxOMBE1WfKhqxe4Av50xk8RxwqElNl4
         F7WZkeecYitQ9st7lI725LmqxznO3Wcpxxypap31elH0R8ZxV6AYFR44ETPcyRGZcqMV
         oqrVaOgxt3yoLjnNAIj6GNOHSTdeqlo7/llOj/i2P3eY+PLemNKZEIxriK5wa6WURDtO
         0xDdb12bQFOnX8+3Ial1/RlTU533SIswWk5Tvqu+QIifudXpBVAt7tYkcaNbFzV8CcnW
         p4JZumo27K9E+pfZ5rl0eNf5wvT9FOVOkRp8SE9w8khQfqul19xrmf04IB9hCPu6jtcY
         FwXg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791487426; x=1792092226; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
        b=XtX/gMFmXJGClOJCs9H3nLiC4X+3MDPpT7/mOyRT6NnK7AfQypw1Y3V6dCPUWB4KA5
         y1SdxmT5Fcrs5X/QMIuFWHFuJYABe2Ps6QrJRpmKi3S1IzGQ84W2oD7dNRwtZKHuZxVO
         A9+wq0S5/lQPLL4Q2A/ZMJrbnviF4NI8SEVdXAObkLdQlfucJGvO2/t7szDncEOBSE2N
         ICwlqgmRvL0hNHKKTEVP+pvqf/JR7YfxpDcqr6IasSVsIuyY6/h2MUHxqIPdCwfwyBA4
         zwMoCOkNGvp7bQ81ok+3AP5YE3fAT7BEI32EYLYB557Aw7g9TMvuOSzwlqg34PU2LCCM
         SuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487426; x=1792092226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
        b=GWAuG4c3I5E1l0sArpLW1HpWFzMxtzz06IOqxnEDZJF1KHsjHex12B2JeTNTR2jSqS
         Q50Q3JNqFd4QicsFYmMhRISHEpuciwemdafVgvyf/8U2ZMgKGwOa8Upj4ga/CFSfINNI
         v75lyYezPAGwNSdp4NVj5RKuSPYO1MU0q7f49LFJ02U/j7eJAsISYOMHAy8BVLwwYAOv
         FcbjRnTX3H/hhtcV2QQUdSRs2fNIIoGfq2F5dPYzphvTlZW51faY2Cx4HZ8MBs6DzXg3
         s24s9+O1Of/InvGrNlotZs4wxS2kWnSgYWDkVgn80uEkQ5e3rumuZxmQCn1OhnfBae24
         mFxg==
X-Forwarded-Encrypted: i=1; AKwUvBy3h2txYiYjHhdiXi4S7w64iwST193rwo1Kd0XwsVxZO4YhCj4+m+JD7GWR51OoqIAyvcRnDlpPj6MSLJw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lKRalcHPPI/XDIchevAJMy+5BJbsaCp8ILBOiG4U2/W4RnSKQk
	0fORUi9v/RPJSkja1WognX4FU/AsqScuTvUZZaBuZ3QDy6doYyPCxJ3y1pqRbJft9F/F0mTecwC
	jwYzg3mZEYGKoKsEWC19LyLQyRPtslro=
X-Gm-Gg: AYBFou2qEfoMbY8/JhyliC/YRB20Lp+o8mI/aa228+ulIwpfRrUgU7bSa/31hPL3va6
	oxsHfoHPXjqqVvbhAb3KQgN54Gt8iS7LrjHeLCMn3dtxCC67GntXmkQS9caX5KhVU1MK2kjBavi
	P1pdCtE6DDAvYvEAAVLtmoUS2VlnlBGUvjsxvv04l5T6shSzjazCaLt6I96YSZQghtB6tENt7LZ
	uOhbFBd0A/3t1OgRZn9p2BrRtUuCkkOOTjDHlgM1qaauVXkf/ldHeXXzGkY4v1jwKkMlTovm8B9
	nhoQn9MEP8ddkk0x/7FRSYXZf6p+sZE55RfNGPVJxLJbC3d7PdWCwzeNSxzkHQOqxPt3QChG8gT
	p2RmWX0fE4ehg7JN6eziyapbjXMgKKFsthhccSdKsxA==
X-Received: by 2002:a05:701b:42d3:10b0:14c:f3ae:c1a1 with SMTP id
 a92af1059eb24-1657b80bf6emr6467363c88.0.1791487425985; Thu, 08 Oct 2026
 12:23:45 -0700 (PDT)
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
 <20261008191705.GA917105@bhelgaas>
In-Reply-To: <20261008191705.GA917105@bhelgaas>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Oct 2026 15:23:34 -0400
X-Gm-Features: AclHuK-jV3SbZUxMOMQXs-rSTId7Jf-E2wheC8RGkrqRF9AJfJ4NNMx1Hsaj4Lw
Message-ID: <CADnq5_P_y-6Ra4Swoxz-CmL1Q3nGhM3RVJUAB2iw1E1D-r1cjQ@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
	Jason Perlow <jperlow@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Thorsten]
>
> On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > recover from a Firmware First reported Fatal Error.
> >
> > However all status registers in the Root Port's AER Extended Capability
> > are blank, so apparently the platform firmware raised a false alarm.
> >
> > The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Suppor=
t
> > Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> > Errors causes code paths to be exercised in platform firmware which
> > were never validated before.
> >
> > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > actually signaled.
> >
> > Note that this will also skip recovery if both the Status and Mask
> > registers are "all ones", as would be the case for inaccessible devices=
.
> > However that seems justified because it would imply either a hot-unplug
> > event or a Surprise Down Error further up in the hierarchy.  Interferin=
g
> > with recovery from that seems uncalled for.
> >
> > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
>
> Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-by
> since he hasn't tested this change by itself.

FWIW, I just tested this patch by itself and it works as expected.
Feel free to add:
Tested-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thanks,

Alex

>
> If we're confident that this also fixes the MacBookPro16,1 power-off
> issue reported by Jason (it would be ideal if you could test this,
> Jason), maybe it's ok to keep eddba19b8b5f plus this patch for v7.3.
> If so, I'd like to add Jason's Reported-by and link.
>
> But if we're not sure whether this fixes the MacBookPro16,1 power-off
> issue, I think we'll have to revert eddba19b8b5f for v7.3, then squash
> it with this fix and try again for v7.4.
>
> As far as I'm aware, the reports are:
>
>   https://lore.kernel.org/all/CADnq5_MO+ZNOzW+_EH+gUYZ27X_ggWJJ0XdK6m2QW5=
3m_ThtUQ@mail.gmail.com/
>     Alex's report for AMD Navi10 and Vega20
>
>   https://lore.kernel.org/all/CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R=
7rME35_Q@mail.gmail.com
>     Jason's report of power-off issue on MacBookPro16,1
>
> > ---
> >  When applied to pci/for-linus, this will cause a conflict during the
> >  merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
> >  Fix memory leak in aer_recover_work_func() when pci_dev is missing").
> >
> >  To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
> >  and move the pci_dev_put() out of the if-clause (so that it gets
> >  called if pdev !=3D NULL but err =3D=3D 0).
> >
> >  If this is all too complicated and/or late, I can respin on top of
> >  pci/aer or v7.4-rc1.
> >
> >  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index d8dcd238fda1..922a726a52a5 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer=
_recover_entry,
> >
> >  static void aer_recover_work_func(struct work_struct *work)
> >  {
> > +     struct aer_capability_regs *regs;
> >       struct aer_recover_entry entry;
> >       struct pci_dev *pdev;
> > +     u32 err;
> >
> >       while (kfifo_get(&aer_recover_ring, &entry)) {
> >               pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.=
bus,
> > @@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_st=
ruct *work)
> >               }
> >               pci_print_aer(pdev, entry.severity, entry.regs);
> >
> > +             regs =3D entry.regs;
> > +             if (entry.severity =3D=3D AER_CORRECTABLE)
> > +                     err =3D regs->cor_status & ~regs->cor_mask;
> > +             else
> > +                     err =3D regs->uncor_status & ~regs->uncor_mask;
> > +
> >               /*
> >                * Memory for aer_capability_regs(entry.regs) is being
> >                * allocated from the ghes_estatus_pool to protect it fro=
m
> > @@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_s=
truct *work)
> >               ghes_estatus_pool_region_free((unsigned long)entry.regs,
> >                                           sizeof(struct aer_capability_=
regs));
> >
> > -             if (entry.severity =3D=3D AER_NONFATAL)
> > -                     pcie_do_recovery(pdev, pci_channel_io_normal,
> > -                                      aer_root_reset);
> > -             else if (entry.severity =3D=3D AER_FATAL)
> > -                     pcie_do_recovery(pdev, pci_channel_io_frozen,
> > -                                      aer_root_reset);
> > +             if (err) {
> > +                     if (entry.severity =3D=3D AER_NONFATAL)
> > +                             pcie_do_recovery(pdev, pci_channel_io_nor=
mal,
> > +                                              aer_root_reset);
> > +                     else if (entry.severity =3D=3D AER_FATAL)
> > +                             pcie_do_recovery(pdev, pci_channel_io_fro=
zen,
> > +                                              aer_root_reset);
> > +             }
> >               pci_dev_put(pdev);
> >       }
> >  }
> > --
> > 2.53.0
> >

