Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B9606A32C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbtzPR2g
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXFXb0w3zz2xnn;
	Sun, 22 Nov 2026 14:53:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795319583;
	cv=none; b=XY7kCEIrrGQPrHltorI7DP2ebwXynGE/GzEoP+Zd4YawVJs52pUTMWt4URgaeVe1CYZompmwaAKhn/jYmoCaZ8a1f9jO+a8upPYESczwsCMzW3wWrcNPgQwKiQr8NoGLyUDq9Fvnsi2Sx4vizwvcH4F0M/IerFM1uJH74PpmhbTSsd3kaWfzmCAUA4+P4ZWLabFHX4tHKIp1qkhkLp1aqKAyUMsHOcQR0QDvlbsJtyCg9YastOMjq6gJOSqlutkc2vDHIUs2qd1ffXYV/k/VJJJztDePD8LmVTSdMezwzMXbhkWRr6nEKVIkd0ofdZiN3WI6Az+tctQr0HghpOWFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795319583; c=relaxed/relaxed;
	bh=3/acJDvQZeUDuSHYPSXBbXR1HyKyAQ1dnjG4woxCX1E=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References; b=D6riMuZxDXW1SsmLIplTnLTIjaoqNr0JyCC3qepPcE278HpmnsipqeWLYK2rQ6luB1F7zjf6Kuzov//cD2bnayW622BhGVBfLoG9xpW5EhPD8CvDaoRQFwnBv3dodFhGO0ii1SHWhuYJ8Mmpre/TwT1CrJKZrlChRHyNJwdYyiL4JjyDvMIThR85EtCnrKwMS/VX0pGNiLam/+0FZHQ+7YO0MDdDO3Bh3n327M+8oFL5p4t4rm879t6ms+QyWGJHt6f2YsmiLjZbG63WkGA8+zow4g2kJyUTu0MHmIlQQa9OGkvYf/HiWkG5gVYcpDw2aBL6N6nqvh71RNeSpVh+Vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbtzPR2g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbtzPR2g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXFXY3Fyvz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 14:53:00 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-38190551625so4507594eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 19:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795319577; x=1795924377; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3/acJDvQZeUDuSHYPSXBbXR1HyKyAQ1dnjG4woxCX1E=;
        b=PbtzPR2gw4uLCIWDjN1zmRkhcYcNMU5WIOvQ9f0LAaQ5M7ORK03gOvhLOqx3gEcZy3
         jVHh2y2jG83IUVPiQF3dfBnqg12niVEukG83r3I7zEX1RlFW83TQctEVF9x25X11pNFC
         JFn1mzPtQ1gch7S9OrBBmeG/I3mCUcALg6z6QFH3/4ZIlRDS0mU+F7uhKPey5XVItUS5
         Y+4mzojekqUTMtj+dRO8cQgoah42mESWM2TXzaz83SgmHGSl1Zrr0EZmQFCXBp9G4A2a
         xUAmNqa+djhFBn7syOkgKSUY/f/sNJzGh+T6JlUGIoBOR1q62obRqPWAJGgR/EOmZCV8
         89zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795319577; x=1795924377;
        h=references:message-id:date:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/acJDvQZeUDuSHYPSXBbXR1HyKyAQ1dnjG4woxCX1E=;
        b=0YZB/gf2OhA17fOMBQh+GLj5TsgieffFHlUUSt85G4eLy2PJou7Q8oW8Q6VbmxNXN/
         EE43ZrW/0CpIQeYF35QsweSqfLVkwcBj6TyR2O9maoEKcxDnCD2nkBjXRKp1yN/jr7CU
         iiLF7rBeHflLa52RAR1rQHK3IwKwEbJlDVP0P05JVG5WmshWb4pY3Cq5xz1ROJBZXudK
         bk7M9oSJd0KaDDmbnwrIsxAd5kz3ZtVvWL6F9k7CF10no2sYMi0yiUvR/hSGxPw69lWd
         b1mPWiXL0BrfhY1AcGbiqggH/iwgBGw/imPWuxUOUBaDox9tHfU3bAVOHot24JKbcp/d
         sUUQ==
X-Forwarded-Encrypted: i=1; AL+hErEgax+2FbQ9rw8CyAkf0aqIBvNKSc2qgb6IUBK564va/VQgKMGuD+W/yu2f7BLmdvbhNoXMHo6fGuT0hlo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+jzlXIaii795uNIggccNF+5vRmgESwHxD5052na4OiuJqCr3db
	3bJRruWIZvBil/u64A4jnhhgasmcmwnUPhZ/WyufUFBq5u632gwWp1Avof1lwQ==
X-Gm-Gg: AZFdTZcCdxq7Q/rmuZGmIkWOAwrK3Vr9FZQeOqIQ2G4z1Buu3qm4Y6Us6NTdYqEaM55
	PxG7lJJ7cyZVmpuFWeXGiGJBOpBruVDyl5+3lTbG/yRDnyjgdoIfTxF8NLRQ9ln9Wypyq32xSnS
	BjEDigg6Tnsci8EXOkpYX7XOLVoFNwrKwChbuIDwj/dsJlkqrHh5fwZtCLpOzeTD81S6vbwSrH7
	aTN8oxP3R6ipj2JHaQI2zGZglr2ZkKHswFp+pFOOlAPXM9pajZirVqlHejvczfcFbzg3ZHDRKWF
	CVKUeB2r0Wj1QFr30stZA61HYS0Y+nPZgILoB2r1Uea2XRiIW3wdAvrGpbg5WMIvn5ZSoLGYInI
	uIrgH1bMC3DEybW2qzFx5JH3FA3p1x6H1C+CRJK3viqGyuhR8R8OxMIFxMUEXMXIjziLSR3yzEb
	ZGkB+teZn7DmrucMxbMseqIbTYmADqhZXxwPY/M7Ha1qM0kNg9y0Y73/XDzS++9COH+77mWBM/T
	782Nyd64g4dfdHFj5XvKRjIXz4thJ6jszSfdrGOqpSJE2BqpVzlrW3ZFqQlfvNs+ASprK9vrPCX
	lgs03IcFw+tPV8SO13KqHzbjby7JVjOMo84lALwmWVHSHAR2
X-Received: by 2002:a05:7300:e9ce:10b0:385:2564:c509 with SMTP id 5a478bee46e88-385700541a6mr9198641eec.24.1795319577262;
        Sat, 21 Nov 2026 19:52:57 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm22045349eec.23.2026.11.21.19.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 19:52:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: remove unnecessary #ifdef
In-Reply-To: <20261120133413.475489-1-pbonzini@redhat.com>
Date: Sun, 22 Nov 2026 09:13:29 +0530
Message-ID: <tsl9jztq.ritesh.list@gmail.com>
References: <20261120133413.475489-1-pbonzini@redhat.com>
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


++ linuxppc-dev 

Paolo Bonzini <pbonzini@redhat.com> writes:

> booke.o is only built as part of kvm-e500-objs (which is conditional
> on $(CONFIG_KVM_E500V2)) or kvm-e500mc-objs (likewise conditional
> on $(CONFIG_KVM_E500MC)).  Thus, the #ifdef in kvmppc_core_check_requests
> is always true.  Remove it.
>

That is correct. Looks like after KVM_440 removal via the following
commit, the above is always true.

commit b2677b8dd8de0dc1496ede4da09b9dfd59f15cea
Author: Alexander Graf <agraf@suse.de>
Date:   Fri Jul 25 10:38:59 2014 +0200

    KVM: PPC: Remove 440 support
 

Thanks for spotting it. LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


