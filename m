Return-Path: <linuxppc-dev+bounces-29274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBF2CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 17:27:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3PYm0k7vz30DY;
	Tue, 13 Oct 2026 04:27:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791826076;
	cv=pass; b=KXARVLgkUObGUoit9mIbDRs3nyEGBs5TndYXDfQERiUEMmZYMEuCNGKuF9ArgR2bsn57npAzgHCojFL3qr14wJf0NZvWHydWcLPsTkCwuxRK4DznU7vmIEnfiBp33y7LlEIaOBElvveVawRcJxbn3rhCclPDBFva6/rBjWiIK66D0f4v21+Pza8X7+NQoiUweoT8DU7UsrnfS/O2zJfofDdYhGd+2QaAj01jx1X0vLd5CDS8nxBraVH1XiQhTTmt2ct6/icsMHAi+wL8DWEDgyR8tUZ2O5JUUqyYuQPsQtXgH+DqaYujBtLPg1cUfgnfbYDW04CoCPhjig8zwl48nA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791826076; c=relaxed/relaxed;
	bh=OtJOsVO1K2acZAU4qcatnAuGrI6UgGvUj/f3n1t6+og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPP9KSPYfXJAMeZTbt4GH6CG6AU+9doENxV3YvOlTYs//KOMKdh45lwLUB2om7XjYnYQ1m6byzCSf3MI77Buu4whJm5yEsvHNFOH10WSax/YaBirzrdL3YeofSJQ9euYKNFC28EYn89BJxd0QLDJGGi77FrJbJxoQTBLcp74Yq0/M9DK8krJbh+1ddtdq7gBumVPlZ7yZ4bp+yJDDRFO7C1mvN4uuGSeHMQZFlJL1DSYTucRKz7W+0kqhita8c71aXYBxCz1sH5SuiuV8yptxFroN7zbOGxp9yudX2Cehy4sQfd2r8Bn5Aocuzg8bIlBHqxFU+/Nuegbxo3iuftRtQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NH+64nGo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=jperlow@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NH+64nGo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=jperlow@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3PYj3nvYz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 04:27:52 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-c2a4e013a44so312086066b.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 10:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791826069; cv=none;
        d=google.com; s=arc-20260327;
        b=kX4oJ1emEagB1E1iy9PCKL5sftOIkgNVzh+KUqApQrVhPYbWRfvYhJilFqnPSgAbFV
         bp7CfYoVaPvKfo2JwC1k7RsmWAmu4r453WrQ5oxrCKNwxoHXfG4t5vZmaEHoh36k35Ns
         XfDxxXenU1K8SA88pB6kjgvKNfdxbibFrHIR97AOJFLsFDK0FBGQs5Xupg3Ww/cSyCZg
         5N6DOlu7CPYvEDB0wTMSDkwUnwzogSm4MkgGd63ltvfuZcXgw0iOx71KFfVPmCyt9VFD
         BcRSBHA3nAgUBi5Mlm/TqJsAS1qED7m4mIlwWL3iJAzw7Uo7ZeDHggOeYzjdcL9vuxwC
         fY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OtJOsVO1K2acZAU4qcatnAuGrI6UgGvUj/f3n1t6+og=;
        fh=XIh41z6BmKllZa4VNS0ds4v8Ri3jCwR6m3eP41ku/Zk=;
        b=bjrItNmAmVgL09Uf3cCq3y9RiJmzBzhkHsUa193XfgNphd2iONlo2OuvqjJUg/WcTJ
         IXPGhk91/yYG4ngVDcdqq0//lkf3cL5k/By6Pq8ePnUcxyXBqfPp8y8PZeFZzLq9rlDF
         AP7EgoA4urwRbzhViDRyHyD8BXgQBCkO9nwMhjAFbQosOhf65LRPOdPzajsah7kkjKtB
         V0++DURvAL1jPnLZUH7Xxnzjo8pkPfZt12tov5uEYeN9064BZodzZLMlqw15peapTC0k
         nwe05XuZ+WY4V/vkl8eftKEV/zxm7uL73nx77EyKbI6MwWv8YkzpbA6aC7CVO/krdIZ4
         zOAA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791826069; x=1792430869; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtJOsVO1K2acZAU4qcatnAuGrI6UgGvUj/f3n1t6+og=;
        b=NH+64nGohDDebsiua2kCMGJ6BNSKcRkzMycchmoxnoX21kC6DO+7vr6+cV5V4VeaEv
         S12ITMrzSJJ3vK0QsIDXaIH0XPqAWaBnX4zRsfElhzI+H7lZqugUWIsAHKR+4Naoi1Up
         pXHhx1yr73jGHu4gf1I6nxZteDh3WhMtysNkxOq9dRACqxQSffRJu8me71WuJchot9Ri
         LNxSQLcRJL1+kw1sa6gCGnkB/Jlr0BcEiI8n1xL2ynMwVLZJevoOZ26US+H/LjI1XQMu
         jXC3gH7vRgLhBJWXFWIDSIQhFbVnzpuH9pQu0hVDNU1XAN16ZAp50ypfMga5lftw2jDM
         H5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826069; x=1792430869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtJOsVO1K2acZAU4qcatnAuGrI6UgGvUj/f3n1t6+og=;
        b=Cjc0VvuASkJc6oR20n/36jOtUzXQEcNe9Ok3MU7mxsKDHB1GLkt3M2bQSKeEJSi7Hx
         tikKGAPoiOex8S8Ze//BLGTZQBeUpd7Zm0oqGwE8i3JQeZUl/jhMXnODx3CZ0KMaNxdY
         e3gMfNw49Fcmf6vgcYexHPOQu5a4BArKWIQZaOuCZ3DX+JYgwc1s4yZjKQZCLNCXfD89
         e12skBf+HmsBjnJ0Efwz1NT2HHUXMYePBXOSR5QCFha4lMarzZnKMVeiYybyWYsazrCC
         UsCou2LN5MU3XBsAzp0WIHjh2XBJ/72HBdg3kGKzkC65NbBd6lylr7He9vk40nyfvjDU
         N37g==
X-Forwarded-Encrypted: i=1; AKwUvBzLhZCnDmd2ehkQP+85KuuDFFfvkaQqqq+5aHYIcH0M4PTd3bo2+ULuySWUlGcZHp+9aYQ+2v2otDPIPWI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIOx0phHoc2fBXVa6oz4rqeQwrFceqTCXGBvWdvO7v4DAZzRk4H
	wdelwQNw0n4AJBJjMLrpU1eXlmUiob/5RY3diRsgOmadZRU5HoQM5ZRvKCw1qhxPEmORzkOCCIV
	ulNG8NOklTVBYI1qPgzyk+vD/zg/GqDE=
X-Gm-Gg: AYBFou1NAGnQ7vlpGMslgixGhhc3KWLy3ECC0NyqXIWVvo+KiPTzjJzssEDoBuwA5pe
	8oVfi05fkQnopJEUhJd0zA9Tn516PIOaF/o3zjdZudRacWyNZYsvB7N0z+sIvV26fA0l/lZP8Hc
	6fjsjgFwzU/KkX1JgJNrnT6OnAV/34vGVHvMYJiYgbzZFvcM0xVhyXiBlXDaYTkOshuf1ZcNK5J
	FoNnfYPr9x50L5tjfJjsXON8V6R3UhRhk8cYcu5ZTQ6+EQt9OJcTMO+0qujN3vXbILjf7GlOExl
	+yUj0k6ftiC3ShFj/G8rC1yHN68+im8z8YB/1GClYVY1YgWuIt98Cc6Rj5k4Fb9Nii0va+MiZdp
	v2mrgdzdOsDrwJDa0C/3N/WUIcxo4zkYD5jXfj6GYvXYVssLCDhp9YH9M2JEvzAib4cGp+EB+7O
	4M56gKn9yHnW0lehK0CntI2Q==
X-Received: by 2002:a17:907:1c89:b0:c2e:2d8c:4585 with SMTP id
 a640c23a62f3a-c31a9fdb266mr1030063566b.36.1791826068900; Mon, 12 Oct 2026
 10:27:48 -0700 (PDT)
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
References: <CABZrw2EfeChvuWDJ_hiwr9Oh_QpyrfZKLq_-jOxkzZH=fr575Q@mail.gmail.com>
In-Reply-To: <CABZrw2EfeChvuWDJ_hiwr9Oh_QpyrfZKLq_-jOxkzZH=fr575Q@mail.gmail.com>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Mon, 12 Oct 2026 13:27:37 -0400
X-Gm-Features: AclHuK_bqLyPVGQ-mr7n1NMFfYWUOt-_0I21LZphufLfVxtdEishkHylWbha0rs
Message-ID: <CABZrw2H0ArT0nJdMGe5zXZOrfxD79NZc84PZVfCPmWzUfvyhRg@mail.gmail.com>
Subject: Re: PCI/AER: MacBookPro16,1 test results with Apple SEP ANFE quirk
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <aditya.garg@linux.dev>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bjorn, Lukas,

Follow-up to my October 10 report. I have now tested the quirk on v7.3-rc7,
which already contains 79c168e2aa95 ("PCI/AER: Skip error recovery on false
alarms").

Kernel: v7.3-rc7 (24a19b953e2a) with the Apple T2 patch stack and the SEP A=
NFE
quirk. The quirk is an EARLY fixup on Apple [106b:1802] that sets a per-dev=
ice
flag, so pci_aer_init() leaves ANFE masked on that one function. ANFE handl=
ing
is unchanged everywhere else. There is no global revert of eddba19b8b5f in
this kernel.

Systems: two MacBookPro16,1 (Core i7-9750H and Core i9-9980HK), freshly
installed on this kernel.

Results, both machines:

  - Boots to the graphical session, confirmed on the panel (not only by
    service state).
  - Suspend and resume complete with the session intact.
  - Cold boot from power off works (both machines).
  - 2 hour idle soak: no AER, GHES or MCE report, oops, BUG or call trace i=
n
    the journal.
  - Read-only config space check of the correctable error mask:
        04:00.2 [106b:1802]  0x00006000   (ANFE, bit 13, masked)
        04:00.0 / .1 / .3    0x00004000   (ANFE unmasked)

Controls: an ASUS GU502LV and an Intel Arrow Lake desktop boot the same ker=
nel
with no SEP device present. The quirk does nothing there and nothing regres=
ses.

Limits: two units of one model. No AER error injection, kexec or other T2
models. The test kernel was built with gcc 16.2; the release kernel I compa=
red
against used gcc 14. The quirk matches on vendor/device ID, which the T2 te=
am
says is the same on all T2 models, not on DMI. I still do not know why
unmasking ANFE on this function powers the machine off; the quirk is a
targeted workaround, not an explanation.


On Fri, Oct 9, 2026 at 11:49=E2=80=AFPM Perlow, Jason <jperlow@gmail.com> w=
rote:
>
> Bjorn, Lukas,
>
> I have tested the Apple SEP ANFE quirk together with Lukas's false-alarm
> recovery fix on two MacBookPro16,1 systems. Both stayed up for over two
> hours after booting the candidate kernel. The patch is being prepared
> against pci/for-linus at 79c168e2aa957ed0054c93db17caba653b95e377.
>
> The candidate retains eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
> Errors"), adds 79c168e2aa95 ("PCI/AER: Skip error recovery on false
> alarms"), and leaves the ANFE mask unchanged only on the Apple T2 Secure
> Enclave Processor [106b:1802]. The global ANFE revert is absent from the
> test kernel. The per-device flag approach follows Aditya's earlier
> proposal, with an EARLY fixup so the flag is set before pci_aer_init().
>
> The test systems are:
>
>   MEDUSA:  MacBookPro16,1, Core i7-9750H
>   CHIMERA: MacBookPro16,1, Core i9-9980HK
>
> Both ran 7.3.0-rc6-6-t2-edge-apple-sep-anfe-test, confirmed by uname and
> the kernel banner in each current boot journal. At the 23:24 EDT check
> on October 9, MEDUSA had 2 hours 22 minutes uptime and Chimera had
> 2 hours 21 minutes. Their boot IDs were unchanged from the initial
> successful candidate boots. graphical.target and the display manager
> were active on both, and neither had failed systemd units.
>
> Read-only config-space checks gave the same results on both systems:
>
>   Function                    Correctable error mask
>   Apple SEP, 04:00.2           0x00006000
>   Apple function, 04:00.0      0x00004000
>   Apple function, 04:00.1      0x00004000
>   AMD GPU, 03:00.0             0x00000000
>
> ANFE bit 13 is therefore masked on the SEP and unmasked on the other
> observed functions. No config-register writes were used in these checks.
> The implementation matches vendor/device ID, not these bus addresses.
>
> Neither candidate boot journal contains an AER/GHES report, kernel
> panic, oops, BUG or call trace. Neither recorded additional kernel
> messages after the initial 21:04 checks through the 23:24 check.
>
> The earlier Wunner-only candidate booted on MEDUSA but then powered off,
> as I reported on October 8. Its retained journal ended before that event;
> there was no recorded shutdown sequence or panic. The cause of the power
> loss is still unknown, and this quirk does not establish a firmware
> mechanism. The combined candidate has not reproduced that symptom within
> the observed interval.
>
> There are remaining boot warnings unrelated to the reported AER symptom:
> ACPI duplicate-table/method errors, AMD SDMA fence fallback warnings,
> HID rotation probe failures, and Broadcom P2P failures. Chimera also logs
> CPU 0 machine-check records in banks 12 and 13. These warning categories,
> including the same machine-check status/address records, appear in the
> previous boot logs. I am retaining them as separate follow-up issues.
>
> This was a v7.3-rc6 test build with the existing T2 driver/patch stack,
> using Debian Forky GCC 16.2 and binutils 2.47. It was not a vanilla
> upstream kernel or an identical-toolchain comparison to the older GCC 14
> release image. Artifact checksums, exact source/provenance, config checks=
,
> t2gmux/t2smc builds and imported-symbol CRC checks passed. A generic
> KVM/OVMF boot also passed; the hardware observations above come from the
> two physical systems, not KVM.
>
> The T2 team reports that [106b:1802] identifies the SEP across T2 models,
> but this report covers only these two MacBookPro16,1 machines. I have not
> tested other T2 models, power-off/cold-start, suspend/resume, reset, kexe=
c
> or deliberate AER error injection. Physical confirmation of the rendered
> GUI is not included in this report; desktop service state was checked
> remotely. The existing release/rescue boot files were preserved.
>
> The patch (enclosed) leaves other ANFE handling enabled and is idempotent=
 across
> repeated fixup/AER initialization. Please review it as a targeted workaro=
und
> for the MacBookPro16,1 regression, with the testing limits above.
> I also have a zip file with all logs/evidence if needed.
>
> Thanks,
> Jason



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp

