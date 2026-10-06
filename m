Return-Path: <linuxppc-dev+bounces-28974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB26CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 21:44:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzqXN5VMfz2yjN;
	Wed, 07 Oct 2026 08:44:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1231" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791312116;
	cv=pass; b=n4504eAWUbjrqb1CFYEx74TD+aCgxgtcSTKKsVsIoQ5VLaVZrb7BRIJ+QefUIBoSTLV6NlqSs0MJX1CT/fO5gJKKxNVx1E7S6p1n8pmzM/uO16eNFWxi98zYqXtU5kQjdY9HPHNQqkqBFcHLqQHDontZCSGgimUDvuvdyjltldGmZTclxbIdncPi5XRZEJr/rGOJSz8T/1iLXkqEOwB0ALglhic3V5mC7mihWR/0rEvveAmoEk8a+D8vxapvxoltnqTlOVP7JORx1uWfbQ3bj+ayCBkBMwQ3g9OyJqDJRPLxokUvwdK2NKJ9yIYfojavx/Z95XjQxfmfHJJcgf9WQg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791312116; c=relaxed/relaxed;
	bh=7ndOBpyUVrvLUL8/BucAq7YTN0AfiGwI+dPlm0Y1IOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKusPnLgqlZo9LSOtVJJCUJ/xTF8GDgQRyWJqjSRsMHyPKkxfNjTyz67shAMTWS27Fir2iZUFGtX5QPAf8YsaL3pbpZmR+JBXsdzK4um91v7aAEw0vbyuXstRfwpPvK/KE3AqH8taVryZdBOZPOq6JhOaC6YKV/RDqOXgkTh7pbaipiPMGtMI7CdcdRJL/3MBplyN0/+UfOxzAKWQZbFL4Q8oXIImbDZe4jnFALl52YYP1ANruJIQjCT9o2ScaBRWWdirlDuf06z5DfzBkondebb4KPCPM17uf03qTbC8Dva7DkOhH2tryIq3sGtXffnUzAj5xPaV9k+WImNHNbDXw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dkBADaPZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dkBADaPZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzlTt4KvSz30St
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 05:41:53 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-143941c2aebso1218c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 11:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312110; cv=none;
        d=google.com; s=arc-20260327;
        b=CNNr+ZLqLdRFNdk0HIpyBZuue2NOyFnQBJyb8FRFVzNwv568S6YOK3dXy1zHiuI3t/
         LVY5gpbiy0s9uMpizIxK0PoS1DJxEZEdffbDg95VS3edMg8So1ZiWHhsXruGLSIBu6yS
         b9KfhIKuJChjxfWycDkqN1RXh0VG0meDzs2lhHDwhgjPJCQVj6cBAztOaCI+nFF/DXhl
         76s9cjY77He7xSQLnVkkDiQb8ScwUm0XkCiYPzHPWaeH/V8FXBK32rhBSiK/1ZiOf48Z
         8rtNMYQznhOBOElJnhY7mlZ5oWdb9W++ZKaIOjzclMhEGWgkbGSPu+XVbOy7MoG2MYwz
         fntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7ndOBpyUVrvLUL8/BucAq7YTN0AfiGwI+dPlm0Y1IOo=;
        fh=kx7YApww97cnzKIiOGOOsEZvzpzX3LcwACOTTUwPrsU=;
        b=Bbq9dFIGcE9iNwijFR+lrcSV+QKS9ad4GO0Ged0Upu7DknRClEdLDBYQYNpKC4IVGW
         m9ZIBM9sGcsjsSpF4jCIkWt5jrAN4PJ05KIJj7k1LsZdXxKJtEhJ2NuSFfL3UWKDVYEe
         QtR1Qd7kUN4jhfappd5hZ6sYJETVZsGXzduwjeC2NWOGvIWyc1misQdaO/8u9ctk4KCE
         huNiAhcNbLGL+suaa3p/sTSftALaEwIjAVes1TdWNxzwPp0t5gCAn3rqFzWMbipcfy20
         UuGsZ/2pVH4njk0iIS8qbeMeKC26QoN7lrvfInvuyoJS0m50ZMLZ8dtVuy7z3d92Jmx1
         6UVg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312110; x=1791916910; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ndOBpyUVrvLUL8/BucAq7YTN0AfiGwI+dPlm0Y1IOo=;
        b=dkBADaPZ6vP8uPxkrgtmnP+8gY2dJByKcMp/KdvTnazpUAyzHRbhp3vRfoe1lg5W0c
         /KbNRmkY2GfytOpctx29LgkJ5LKp6mL2G0yozZsfAZ36rRiDFvndeu5xzHVduHC4HtWu
         M5jblp2fidxNdQ5ECDt2MgTih+12d2pJVHUxSU8TQzAb8xYzzcRJ7SJaa18QCGP9uVDM
         k5/Dk8HawjOi7T1aVDi6Atxg1yPbj8V3zlnDA/Zu1LMJRUnkfFNkGMFUjAfFiMI8fFoj
         I1uXsXDkBCsVkkEMQZqq9WYd+PeenYfFlvD+W2ecx/L/QgafU0nXr54OWTGywpA92fp9
         3b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312110; x=1791916910;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7ndOBpyUVrvLUL8/BucAq7YTN0AfiGwI+dPlm0Y1IOo=;
        b=E0SocxN8jX79br1CwjOu36lFlP+2NMT4LUpy+0kAF9JwysFemlcRMvtVwspmVH8/Dq
         aIq5q6gfDgDEAtTPZq4oWCbrNZGzvpB1GPJ1wp3+SU7XoYL2JTlfEOO8dAQ0YfuJCqmh
         YcFkKoCGYxeQ8/n10I2OBZb9DuV15HLhU+Wnq0tU2W8NXDBncUb0KyWOQ47JC6xS6vDW
         XecchiufcR8P/nCBBjh6ZrMffDBBx2TH8FrmRa31x1n7udN7JzzOYnWmTdNa6taC5t7M
         1IZ1puZ/us2hbn1MrxUmbfIXIarVhPWwSJ+NSs5T3v0xRqc2wX0mtn6kPviRFTwyOQ10
         3IKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsblaMbEhlgR5TwJuFjoR/A4/4D93POMO3CcLOTR4fH03QPSsWgCKSvA3hRCucLk7kTkrogWIULiY1f54=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kKlqs91HghU6SS6fpDA4Q/2sjHE3WlY0TjOH+FhOFDou/4v59O
	AVHDhzwL+QhwE5jeloZun91Udhpx4IPJBZwA/6vy5KUO2PW3qFDWlBwqZ4KnwLrRylN/EwsX4BU
	47zZJkmhtGesiuomG4qJSigDUnsj+eor9uPtXkj8=
X-Gm-Gg: AYBFou3dN19auC51feTpXFukpsVuZXHMbIb2qqEYgG1YOUtbsQCOJklsCpJd0x2r1+w
	CZ52HIHGWivAqGnhKOIKI22CAd0oDZjpXVLu5s7E4L4B6UAlcVrszpUgwR2LIw4d8FJ8/ie/dlR
	jVVjJ5s7YYh06ri5XlfQVFTIWSCy/G+pBixbVcCzWsBKE2rnqviTxJm/mdiAg8IUzfqxeaPerPa
	ECxc4rg4CTlbFRruqggozXg3kCtEKBuj2W1wWhslX0ZfjPmBOzbUZg3bz/BiLcZzDosmvRFLrco
	dIFiv+Ircai5lp6OtIW8Yp13rtR1F8OFqMkitkuZ42uhi9CTqMLuRcNvKvKPpD9nYFU1iPaHgBY
	yJs+WqS0x6DMBrotJN9lUjkik1QRLcid8pASg
X-Received: by 2002:a05:7022:28b:10b0:138:38c7:6adb with SMTP id
 a92af1059eb24-15df40d24b7mr384153c88.7.1791312109409; Tue, 06 Oct 2026
 11:41:49 -0700 (PDT)
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
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-3-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-3-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:41:38 -0700
X-Gm-Features: AclHuK9FyS0I6QMmX8Zk3xjrz1tbTyWGWZU5DOqGZ_KGJ50pE4yWQNuil68MSKM
Message-ID: <CAAdrzjt51Rduf556+BjDb6-M2mfDEgnTsbxTO3JHn70uu7sr5w@mail.gmail.com>
Subject: Re: [PATCH 02/15] PCI: Add an offset-indexed store for saved
 capability registers
To: David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 10:34 AM David Matlack <dmatlack@google.com> wrote:
>   - Each capability allocates its own buffer, at nine call sites (plus
>     one hand-built by a quirk) that can each fail independently. Four of
>     them (AER, DPC, PTM, TPH) ignore the failure

 After patch 1, DPC reports the failure with pci_err(), so at this
point only AER, PTM and TPH ignore it.

> +     *val = dword >> (8 * (off & (sizeof(u32) - 1)));

[...]

> +     unsigned int shift = 8 * (off & (sizeof(u32) - 1));

Nit: please put this shift in one small helper so the two copies can't
drift.

- Josh Hilke





- Josh Hilke

