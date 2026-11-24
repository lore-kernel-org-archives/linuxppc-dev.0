Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE5606A33F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YwhTEqPN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYmYv513qz3bjb;
	Wed, 25 Nov 2026 02:14:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795533267;
	cv=none; b=CZE3s9kajprSd3wYoOk4EA2XCUFb2/aOi9IpHQeZAG4XuWBxmSYBKvTXrcVcAqpv1mJQTZWp3qxPYkXpEz6Xv1kOl85+uoltHUu5oCr3RM1lMOVByYlOb7UAQ/BcKqc1pnxTM8dTYr7RUgpp6lsB7CbVrb4HL5q90PD85qEs8IJLNkBL3Di8DevXg5T4Wh2yByLnnTSJYrAOz4gvfcABEPCzPaTRg7TzWogdamjoBuh/tE47hXq3zHRDcb8e/JHkzoCnYR4YEaZ13ET23dMl5KuWUpiviW1gYPRlreR42rQwWj4pf3c7mLB3OiG/8VvZyFmDMITjtKoSAFwVysnr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795533267; c=relaxed/relaxed;
	bh=PVJS6gkYs1IOy2J1QEN8soh2l1ljp7ZJVoiYPlTtrQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/qFiv1w/VKYXSnXfCp7ptZW65Fpwa2Sia0mXQ4MnWuGfI39syL9R47+PQQVwDUFrm4aOOfkLD4D750nw9Q1ik3vNP+LpwrmsqtdAE0a/po+3NfpuTPxz5JRDVm86XAEalWy74lDy/F03KgWA2nGnki/Njj5FPj6OBQ9vBk34MVhcHw0TxO77rFhGlFez3M5uqgNWzF7MSvkh8FI4sJx77ZD1fwhmEyfvgjaQJHL7AgKY4/7Q/QvTMzkUmPLCcUrx7ejauDfv0IByUKqFNdJJI0lyftSKWsg2T1NUe2dQXO7MjyZM0v7CbrMuD9N/bSOLcHriBNZprtYnpwy5j4Yhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YwhTEqPN; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=jgross@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YwhTEqPN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=jgross@suse.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYmYt31ctz3bhY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 02:14:26 +1100 (AEDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-c50cc7540b7so643316366b.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795533263; x=1796138063; darn=lists.ozlabs.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PVJS6gkYs1IOy2J1QEN8soh2l1ljp7ZJVoiYPlTtrQ8=;
        b=YwhTEqPN31aS3oxP+YUpRlATBOog6UgxU17m1bBCnJqGCyqkZV8NWt7nN71BJVrnuR
         JU+vepu3VCFHY6+fW7Wv+cjF2Wfohs5vyyVUOKWkP0yGCdne4ThCMwPkE5l7p+RAyh+x
         +Z1aoFUOdz8uOmJTr9gwvLCnnD38FM642rnJwCK8p7nGbCc4bhfB24Xa7+hpQolW1/lP
         Ah+2p+Olgkl0J47o9LMvw3tJ/WnV/Rzw/xfi1kWUKw9ydkJdp5vWIuPR6A2ql7KACvpZ
         XY1nQfR/993aLysdrpBtg9+lStN9L58bVna10BwIvq91yfwh87QeyIQMRGmSxNeUufIl
         X4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533263; x=1796138063;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVJS6gkYs1IOy2J1QEN8soh2l1ljp7ZJVoiYPlTtrQ8=;
        b=saAgnd2TMjLVZcjYrC2lKW9RR5GvP5C3aqbXVQHoPbxzpgbn8qFq5xNkNJx/ZsSk9Q
         Py7H3Wms6iPW+Gz5jhmlLSNVfCo9hy11aHxgSWIEsO8pOAHHUBVMCY6Wqbt4vPE3OqPo
         JE8bIy7zAdezP7oJCSVMqQ++HGin62e4dENM1Bx3otm7zIJsduTS6+43al9B/wmMAwhS
         UT7CdezI6mDtim8AJtuOEjl9msgA3JVqeggnELoE3aMilro2LYgfna4IAet8Z+3XkQIG
         RMmXWBvG/LPObYUMLIEHutQvRE/M3LTrTP1256YfFEw9W46VST6BTK1nZlEaArNAAcIy
         KyLA==
X-Forwarded-Encrypted: i=1; AL+hErFOXBsgA29kvm2kcsa1dgSWKm+ijZtr71UVPvHNk5ZuFY51dIR6P6XA2CbM/Jcp/sQYfSt6xm4noScbdHw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8R2pC2Vo//of52Z0Cs3rgBEs89RTEYL9MLIMRBI2cAGpaxLkXx
	f2DBKRzbrNyqtx/YZh4HPyQxQN91Y6NKZALfqzEjl3bp/VuHyoOHRvhm+ZTEAx3Elq4=
X-Gm-Gg: AZFdTZfyc6DfZuJABoIoUf8CNs+kAQ4vReXEuWU6n1imeerwt4EJAe9Ce6xJG6dOQlK
	FeuFLZuNKrj1AxzbVwG6Rgx6rCKSOIebXkzTs3+sBIUsjebSGK9t+6rHMMmhPDULH8bacWL3sWk
	kQjWDAHB7g3mMls6g4T+2pDUJJjrhaD2LmXXK4AGQDXNBFxmXigV/wCVRiw9XjH4O6JZtu4RBBM
	3MFHS0v+63TxqOluzOCb7u4gFu6G8fsE/1pgitDLvmOfoZbW+Lbod5xBtN+b//HVZNvNz4s2LmB
	MVDIn2cbGGcRg0bJwgaDVrESzhYyNMRACtX8OM94yXUOHV+PRcG85IDwsesV8m1Gl7j5yjiDmCw
	aP25Do+QNG+S5Q2D7DWObvogfktZWj/Fls9zxIEekiicTl8erpsPHhgfvpbTOE0vCapoiRKS665
	N+X/U8zWgR9Bl9QMuGMGhVNoafMqU89OqGbm06kB0eq7d9mRDd6TJ1KlZj4fVWUQZKPVMLEOv8U
	Nnoxt9iVb5cTTLYY/tntAoRUv0IYzMckhfc77x8QjOPdEwpcW0mOUFJ0tbjlXR8i49uAEr9sPTw
	bSvYCJadCSkJcRCd2HiNiVN6lwLwfkunMz7TiUS5pS3c3T2mPu0RI9tqeipaLpnhyKTld4RylOW
	q2qmSAs5NjIHre70BgDKHyNeYBpkHdnJ8OnSNCQESqMBoCk3fyXQ=
X-Received: by 2002:a17:906:c14b:b0:c35:babe:ab44 with SMTP id a640c23a62f3a-c513a1e0076mr1490288666b.0.1795533262820;
        Tue, 24 Nov 2026 07:14:22 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae698ccsm534442066b.26.2026.11.24.07.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 07:14:22 -0800 (PST)
Message-ID: <589d567e-912d-4913-9949-ee28dfd7f719@suse.com>
Date: Tue, 24 Nov 2026 16:14:21 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xen: convert xenstore interface mmap hooks to
 mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
 Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Scott Branden <scott.branden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 netdev@vger.kernel.org, linux-mm@kvack.org
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
 <20261124-late-2026-mmap_prepare-v2-7-0b0d99d655f9@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-7-0b0d99d655f9@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rZw0QHKmzMvHx5VSPSOUKur0"
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rZw0QHKmzMvHx5VSPSOUKur0
Content-Type: multipart/mixed; boundary="------------1hIkmj8WyEEdRHjB5CXVAQ0q";
 protected-headers="v1"; hp="clear"
Message-ID: <589d567e-912d-4913-9949-ee28dfd7f719@suse.com>
Date: Tue, 24 Nov 2026 16:14:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xen: convert xenstore interface mmap hooks to
 mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
 Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Scott Branden <scott.branden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 netdev@vger.kernel.org, linux-mm@kvack.org
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
 <20261124-late-2026-mmap_prepare-v2-7-0b0d99d655f9@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-7-0b0d99d655f9@kernel.org>

--------------1hIkmj8WyEEdRHjB5CXVAQ0q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjYgMTU6MDIsIExvcmVuem8gU3RvYWtlcyAoQVJNKSB3cm90ZToNCj4gTW92
ZSBmcm9tIHRoZSBkZXByZWNhdGVkIG1tYXAgaG9vayB0byB0aGUgbmV3IG1tYXBfcHJlcGFy
ZSBob29rIGZvciB0aGUNCj4geGVuZnMgeHNkX2t2YSBmaWxlIGFuZCB0aGUgeGVuYnVzX2Jh
Y2tlbmQgZGV2aWNlLCBib3RoIG9mIHdoaWNoIHJlbWFwIHRoZQ0KPiB4ZW5zdG9yZSBpbnRl
cmZhY2UgcGFnZS4NCj4gDQo+IFVzZSB0aGUgUEZOIHJlbWFwIG1tYXAgYWN0aW9uIHRvIGRv
IHNvLCByZXRhaW5pbmcgdGhlIC1FQUdBSU4gZXJyb3Igb24NCj4gZmFpbHVyZSB2aWEgdGhl
IGFjdGlvbiBlcnJvciBvdmVycmlkZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvcmVuem8g
U3RvYWtlcyAoQVJNKSA8bGpzQGtlcm5lbC5vcmc+DQpBY2tlZC1ieTogSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==

--------------1hIkmj8WyEEdRHjB5CXVAQ0q--

--------------rZw0QHKmzMvHx5VSPSOUKur0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmsFqc0FAwAAAAAACgkQsN6d1ii/Ey8U
agf9EKmbZX8l548UDsdyJg6oJvCYHOXjuS/ExKBuNpmGhFgk7GREMY+3u3PwwH5i8jr55bbeWohR
PQZmJLsVx91G2Go2UnTECf+ux5hcQK/L88QRCcbKXHLPL5o2jl4qSVtCpjc4+Zq8UulQYIwYP35a
OS34bD2osQ81MOzn9C89cW+1W2vyw6436TybryP/f0H8AtinZ/cTr3yFyQO/tR2V2NBHtEzwqslP
jNDjxr1xdpiDdCL4jZ8rdh7WfCE5cgGr89hzbDR9ZyzH4ka8x2ICUX++Mym777GSOuxLf3wzSPuW
OkTRlKQEHsYqdVjYj7TAHGOBC56IwBlTfAmWefOR2g==
=vFml
-----END PGP SIGNATURE-----

--------------rZw0QHKmzMvHx5VSPSOUKur0--

