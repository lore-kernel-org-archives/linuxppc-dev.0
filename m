Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C7606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VV7auLi3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPTkp4XQhz2xWR;
	Wed, 11 Nov 2026 14:38:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794368306;
	cv=none; b=W2WuOPdiYUpvjyvevhX3OcrCda0cNEFd6uSyA+WNxyCpHNA/URkrznJY6F3Pnk0GFufysDoMCY/TksWGEu9yhy9tF5Q1Y5utVHS6tL41G1uwdik1+VgEjIZkgGysTUF8VoXj4GNbsiabhLUlkLB0dcTW/89VDng8js/FkVrT7bjIWv7lbaatE+n+kTbnDiz0H80snMHUYmLfjACJ+ZsYjTgZloXvh1AOW/zM7PW3Rl6PVkAoFO7Td0dz/2gn+EBqx8Cny2ZdZHTpF7+YUceaHK3YBMGN+X3urszIZ6F+60VQrulLhxm2cnRS6/iGnGdFnokfKkQVt7Jkx9spdoAJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794368306; c=relaxed/relaxed;
	bh=Pzim6goyEt9kVT6V/QtQQEQa4Z94Iu/LPgGVG9QuKw0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=K1osCsQF5daIsplf39c+aN184eOwMUj/W3WosmbxJ2q0F9QpO2atUR2hVhB+87zE++gYdgvGVTmVREyKNZlgeIdMHVpAVF0KTnQEHC8DSDYweUnslboe4rzw0xUZgzEp0Hd1W1R8IgnzMgmUkzj8HIIf4g6ZvHdaSQFLEz7scLTRsHjwaFSF8s+sHwtAf472KVBnmVxTRKtzGq6HslgG0N+0dK39woDSFRH1/mUrWwHLfki4aAWd13Fo4fT1WxHByAEJjHin0XsD+rHTN8XUES/4DcDQU2BlcSi0e3OOtaVzHWX6sdOK0BW6HbrJJfoxEE/Rc2UmN3NTJdW5jWXObg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VV7auLi3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VV7auLi3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPTkn3fxDz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:38:24 +1100 (AEDT)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-170135e43c7so193616c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 19:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794368302; x=1794973102; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Pzim6goyEt9kVT6V/QtQQEQa4Z94Iu/LPgGVG9QuKw0=;
        b=VV7auLi3HY69d2n9zIQf6HGF2OJXgaOWwwn50tlrDc0ZilJl9UBt/q8d3Q+DVbXlCI
         fDsnJIkd4DgWioqcFbzUV7RgyyTNaYfTDNU+qX2mj+OSqAi2RhFvqp3xRQLGO1GTpww8
         Dew8owJDXUc0X8gq4SnfIsAxq956S9583N1cpHiS13F3S8l/6ZITSOvca5EKGAyTKBhU
         ZfsWOhN49M1XSYuTQ5nzJIBcyHH6x19qMNsKGGNN0fB5/OV7tZ6HuL6BR6Wk+lxxdM0h
         PKK1P9urA1zzjOml9tFU2i67aZ5PAO7DlOzYQQQ1bxSKheW3kwMzNjlyl379/nO/schH
         SQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368302; x=1794973102;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pzim6goyEt9kVT6V/QtQQEQa4Z94Iu/LPgGVG9QuKw0=;
        b=xam1zFj9FZWDY0auR1wdL4oP83KhaHccQzYazKSY7w286hzJamA5liOfh74kdBM7xD
         PQ2EYqp41Oa/R1KTmltGeryAw2P5qypi/79D/ymDGRt35Ae89fe8VSDLRaOMBFP4tx3P
         ZHQJGi7TPmB77nV0wAJGtYgtqUuK76i14Zqnr6avbWX4fmyfvQVZoRAm+tIM+kQS70MW
         k1q6Q77VbUFtinaa9aS0rg4tIYZ+SjArkBY0JXu0M3CPo8jCa0naM+HqX8Dm3RnXOx7/
         1yijzLONk/yc+ih7qVTJcVc5CmZ1lIN1UbThBsJt8AS8GKPGwg+B4lwULIhGtIJ6QpLq
         GnXw==
X-Forwarded-Encrypted: i=1; AL+hErFEEDpfQmLG9bBUXer3hCaGYJFzkxyHqBQgZ3unbMBiH8gsDue2+mTuXnJdkRCIdqSxgubX8/MDp/2SbvA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9E1tVjnPmKG7puJhmYPAdbf9QGdGat4sHg4TU/XLfh/GbU4h4C
	KEosja+wfQc5ff8XuzVzG/6woMGd9QYqHHQNYJoXgq1g2m3s0hxr5sjY
X-Gm-Gg: AYBFou0jAF60SwxlVBpUNw2Bv2teajI2ORjPfemo0GgoPvh/hIsOo2R0112642W9Oya
	VVxb/PH+1rhm0Rldxpm2u6cggOoWNNwHwis3vvW5hqPNiCO16ILnyiwz3syXU+oi7VRL9bTa3cn
	HIC9OJ+eS5kylzJI+m/33au6riIM77B10lhSXvfbskIkp7Yef5rcGAG9gEs1LP/yCql5xho8HpA
	0tpApPpigRnK9JbYzWuhr1J68gMDBqemVZw8Y6Eisg3iSWG1ARjiY0MsOa8nkesWZ2rgaFnuAzC
	GM9SYTGVKdCZ4QyhE4Ch8MTHtN72JaDBixmTfpKWhaOzKyX2OtorZ7tBP+TS01cEdSJtc0VpQdX
	aHaHSrCjhQJrveMeGWbWXqsUedHSfF8Dvxc8N55sfK+VR+b4WyYIQt4fVzM5JeWU+Fay7C9CQEb
	9qzze2ijfjTqejNsgb2QiDUr/pysupmfj6+9/p/cmC4kozwb1yfSBsITTubz6qg8jWG/IzG/2IO
	BhFTVq0aEeKvwubZL0oXyU7fvN1ZDQONOry5GOP5VBk0KmdRrC4B6MX+z1C1EI6/yzUX1CoQl3+
	GcfwHHMhJ8dYdNTjIG1i7ho0OKB+h6bGDFfJafhI6MU+4+fSpg==
X-Received: by 2002:a05:7022:296:10b0:190:d0d9:3110 with SMTP id a92af1059eb24-1b3c0365599mr1047190c88.45.1794368301885;
        Tue, 10 Nov 2026 19:38:21 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc09sm23606052c88.10.2026.11.10.19.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:38:20 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: mdshahid03@gmail.com, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Mohammad Shahid <mdshahid03@gmail.com>
Subject: Re: [PATCH] powerpc/perf/vpa-dtl: use GFP_ATOMIC for DTL buffer allocation
In-Reply-To: <20261102143719.165508-1-mdshahid03@gmail.com>
Date: Wed, 11 Nov 2026 09:04:47 +0530
Message-ID: <ld7082i0.ritesh.list@gmail.com>
References: <20261102143719.165508-1-mdshahid03@gmail.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

mdshahid03@gmail.com writes:

> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> The DTL buffer is allocated while holding dtl_global_lock, which
> is spinlock.
>
> GFP_KERNEL allow direct memory reclaim and may sleep. Combining
> GFP_KERNEL with GFP_ATOMIC does not remove the direct reclaim.
>
> Use GFP_ATOMIC alone to ensure the allocation does not sleep
> while the spinlock is held.
>
> The issue is reported by script coccinelle call_kern.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

This make sense. However we should also add fixes tag and tag stable
so it gets backported to stable trees as well.

Fixes: 4708fba19ade ("powerpc/vpa_dtl: Add interface to expose vpa dtl counters via perf")
Cc: stable@vger.kernel.org

LGTM, so feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


