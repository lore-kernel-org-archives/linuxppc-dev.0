Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBAC606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=PJvVT0Fh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWFFp4Rd7z2xpt;
	Fri, 20 Nov 2026 23:36:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795178206;
	cv=none; b=QWLbb2F9ncyNvcsSlEzW59i2ZgtDb1Idc5l1iG1PnSTgUxsM5B7T+7cTw8gl18byMKKCD1cEtff8PpCZIKeEP1aYKE+bozAUvDQngVH8Jvc/5zZLcL9yw3oPiA4ejLRBPpwktwiiwzJGDjMUQMyQ44zE5MJJqSthRzmLLox88yLlGfnkTW+5Cyfb77mzC9/Q7FV+fbZUULiymX+IHBUq02O/UT6R/V+F61jTfVuUmdATgOL4Xx1xiSj+vx7O76FQvsFHD4n+fCcG2C29CFTmMWIuY/v/GMLEijNY/xaoB3JS+RsIF7cr1Bz1hGAx19jfpv3RzEFRrmWHTdbINMDxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795178206; c=relaxed/relaxed;
	bh=WeOrsjpJfRBrNwFvy+AQY39SEDxtlUWfYfyLARDn2qU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=M54qtLseqN9L5kLAtQ3w+9aVOlkb5ECeU8MWHqWDOAmyC+4U5WfyGJ8hg9zbYhnAInC2l3dWu+ECCb3U2Kc1Z/fIB/gNI8BdYTTlhow1aSXFw/ZTTqxXYzr+wi9DbBpiQS6t8okvFGJZXC24j/Awpz1ZMgCYNejKQeLbKwtoke51M4MPqvX1bMyInUGI5F8Z1jNsd5r6whqg7qjceBieSYP5VrWmmldHHTwwnDyho1nncdzVyOqO45scsz9fw75ykQ0P4M16t71oVCN3NS6xNCz9/+1pGGuDN11h30XIl5X9Uw+IiwkyWmCNSEqHj2KS6gr5LkGNdofhL28wgBt1Hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; dkim=pass (2048-bit key; secure) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=PJvVT0Fh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2a; helo=mail-vs1-xe2a.google.com; envelope-from=pasha.tatashin@soleen.com; receiver=lists.ozlabs.org) smtp.mailfrom=soleen.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=PJvVT0Fh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=soleen.com (client-ip=2607:f8b0:4864:20::e2a; helo=mail-vs1-xe2a.google.com; envelope-from=pasha.tatashin@soleen.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWFFn2rqzz2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 23:36:45 +1100 (AEDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-7d2d95c5d81so566234137.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 04:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795178202; x=1795783002; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WeOrsjpJfRBrNwFvy+AQY39SEDxtlUWfYfyLARDn2qU=;
        b=PJvVT0Fh/cttE+F40MpKVD7r3FNk6JYL9P3AJvc3OOagPkzftViksyN78Y1GcPGlI5
         4X6pdl8aH7WhnA7zz3UjyFBJoHDxkrXMTXMrLjvkpnpMzCehkCU9o2Oad/6iW0/jW3XD
         BiLuMrbTtX5QYibK2xcSDtOMcL1CfUaUkYxeHwq0IZv76k/ieLsb9rAbrOdHIKr+7w7d
         AdY5aM94S4pfeFSy65ej25/gcJLO2C5EctqN+uF2UyarqXLcK4CEFxaUUpb2u77ISNGG
         XWuwaTt2J2Xn2S4Hjo8mGato7tLBO/SHVhm7/E5TqX2EJeraxD0d/j8yO/ZamQfLYIU3
         ophA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178202; x=1795783002;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeOrsjpJfRBrNwFvy+AQY39SEDxtlUWfYfyLARDn2qU=;
        b=MvKy4ZziOZ5qgPD8pcpkXMCg/rV4cWNIthspclofx+EvtJDOGhJxEM1B6nswd84vs8
         lSTi+yh8PqW/9l5aTnrZbG+rSbUqoEttQI9Prt/ewXO5m+0wzjmBUOPK2wDBxrlAeRPl
         QDrqWLA8unJ4+Zuyynmwg27Zovg4+5NmFP1t7RwZP27HbAeQZ0y0+O7Y0swmRwR1y/C+
         8XlNovtgjNbiSu8bNQIpGlkXGLoYbUsDsKI0ckKtE2dFUt07n2Q47nu1N0RqQ5lbSZ4v
         fqdeioxa4NMyNX2ez4XyUIktXkp0Pbb8URRxwcIY6IE1oNVgojUMYYIbvjphRBfWdLug
         BfNA==
X-Forwarded-Encrypted: i=1; AL+hErHmCsDzxGKeUDYcraBriPY9ec5QQMy+/+xB2VmxRH+P9gPvBWS3CzHmIyQVFQZIk0GxJ0uV/1C4enanOxY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/EGZb+msttxva9zUgEuilRq5zDzE47EQY1aC/YCGVPqrXj5Xd4
	i74AeehLSyHxpGVXm8mCbcbmz21Pq8UgblN33TBDRSaEUSMyStBe4V6lcPDrqKbqO6c=
X-Gm-Gg: AZFdTZf4otLo01R4C6ujKNQm/HPYT1SZvA5o9xopgEvmgUS1RtH8oae1SODpaRBlK0a
	/E5TkxfPexvZbfdfHHXwspFFu0rrCzEs3O8KjyxmoEYqNfGAhLcDU1uhF04Af9cn2wQcGZIZT9V
	qFjCX7zAQmaE75RWqkGgKg2v7NYzmmgVTY8EvGaNSVGlTTKkdUkxCza46UDgNXqA69XE/cCQ7cQ
	5oV8lMgj5kuXo2osVDwUw95hpW2acZV3ygUufcXHOQdUmBZUJcqiGjjE6FnWqwDJy5HKaXVcrET
	0gOt705jvs41CVoPLsNd9UCNMgs89g8AlSKYDhkBsCaE0vc/qfds6IbZt2NW3v5vm8g7ZkBHfOD
	DA8wXFEZO4XveHcYm04gnSUH7oqj5CPCltbcac2alSXyBOvXNhDiy8xoVnPuZpxb7+LGmza7xb6
	VRD4vUO320b+BxB8j7yhtkUauJWmslBvTOkv+7rPGZuyt6UTTINVp2L0wFm7o6FmY/pVhnr9OBF
	stgyq/nxre0/OYKjtXz0X9r5WQNLEJs4jFpl/tGWB+mUzQYEfXzvyQ75oeG0mZitidXHK/slLRa
	Iv51iOuxsHk1pT9ldsFjh2pSgBpx/27ibmTZWZPxjxcGoqePD5rg134J58PkkmHeb+R2C+LAxLJ
	6wYSpxaQ8HJW+a/9lncSXQduQoHofHpEcWVZF2mGp7RZ/tZA=
X-Received: by 2002:a05:6102:6441:b0:7cc:905a:331a with SMTP id ada2fe7eead31-7d739660c9fmr746735137.14.1795178202521;
        Fri, 20 Nov 2026 04:36:42 -0800 (PST)
Received: from soleen.c.googlers.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e80cb440sm2765262137.7.2026.11.20.04.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:36:42 -0800 (PST)
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] arch, kexec: declare kexec and crash capabilities
 in Kconfig.kexec
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, Paul Walmsley <pjw@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, 
 Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 x86@kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, 
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev
In-Reply-To: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
Date: Fri, 20 Nov 2026 07:36:31 -0500
Message-Id: <179517819160.302903.17107992182494080507.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=279;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=6sWQl9lmqjTJk3yxh91YK+fuuFKvUf1mQEwavRJAVng=;
 b=owEBbAKT/ZANAwAKAbt3KEzbc3reAcsmYgBrAD7YSNYHVf2cFGXSq25iXRKWCRXN4f0ixFmnf
 ++ItKpA2qWJAjIEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCawA+2AAKCRC7dyhM23N6
 3tiPD/d31VAJSvGrL/uVfmPyx9aQ56Xv29nKPQ6VnqwxP+xMB94zunEWD8SU+Mc33Jsi99L7q8T
 EfGGkXbTCSoGd7NQv3bSnhUhMQVXfpkd18XOnWbNd0iZdBWi4KwA6+/bOhxsYpO/vNSV52HyHUl
 YH2tsnNB0E6EUN5P7dsJ2PqcWD6QjGrbW/xN/5ItrxWqVXu7AFWAGG87321F8utMVUAjMd5pbNX
 gMmicb9aVIU7JY8k0q7PhcEcRAKBjeq1d52NlSDCQyaltHTGY5+29RgVN9juLHJk/Aqy3s15ERG
 gm7x8LUDOEKOpRB5wWYYeKgpWsUscytR/AC4OBQTujXKhQIWBnWrzxr6tjgdacQJt/i9O9RHd1G
 2mft4ocO42XqcRceZtQr6UzRDuVwoDTDwn7Tgr1GRPVmpKWKbzpatvf9WPoIEE1p4+zITr10dGz
 r/38wDLPSJghOgD31RGTysREDXP/fCAYar6DdmmMDK63vuMssMRCUOe16Xd0DOIZIG4FAZ7iix4
 P8e8ny0z7tfxqx4vm+6CsIaWgFvVAxYu7Aw1xAruadzsWe+u5UqQLLBY6z+0k76JoRaBMkkcS25
 JEuj8uFaMFXD2ei4JRlUNt57apqgQNCbvhYb6KUTHwP7pocn/UNfKH5JCi9KQCFr7OzuMoLGVJq
 hED2RJ/U2jV7C
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 08:16:56 +0200, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
> 
> The intention is to take it via kexec tree.

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


