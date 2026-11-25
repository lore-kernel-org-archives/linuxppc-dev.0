Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22261606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TrQaUotY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZDHw5gfSz2xqh;
	Wed, 25 Nov 2026 20:03:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795597436;
	cv=none; b=hferA++g/o2r7ER4H/CtsRRsT5alHCJShOAcPg1GSzrvyxHDT2R3SfbFL6HIMZhdKrRH5IjyikojPumac8r6PMFaEwMlA2Uv5xNhtTjw69Zfx2CS7wvOJq3HLAz0BiXBZ2XETFCIPspEuLTS2DtTmxA3cqcotfsgCwbNy4kvgwrQxK51NfGtXJNACG2Dm+zgOETfoqKLLPstJuGx4t/wo8uM3nAD3Ou/DaBalTW9CS8dqOVKYDKL2KHfOy9F47tPerD8B82NrniBztUdKVUsEz6Vjiuriw7cn44z066rwEhT5TnKA0GAn/Zh7nDcQ5zPaoCpUCmqY6WUzhlI6lZ9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795597436; c=relaxed/relaxed;
	bh=V5RSPGAWd3oxeQteUUuoK6f8743toWOpgplcBAfwJJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwobrN3HFs9dL2Am3r8lW9curKzp64oI8Gb/sFFeeAafNEaeLUsYvYOkmDdGIKry2eeOD1Shtms9KsHa80LeUly/ikTPRrRJ3EtYO8EsuwfTDqXst3wfnA8ObUbz6jL73rulz4ceLNoTiM/pSPAibnGvA2VKyc1/Lxe3VqGLJTUOX6foMYGc1rTsR7H3hO4viPW44X1clVb9KFZjiYqwqt+TGAb++evxgDxcarloz/RsPudN9egy/84i9ah5JhNI0V/bTvYZsU6PKgghtvx4YcDiAvUqSPP0zcHMR5WibvZ23G1FNscNagp1W3gVvpRN+qMrkdWwyLQDzfD3+lw0Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TrQaUotY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=yigejiang86@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TrQaUotY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=yigejiang86@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZDHv1DTxz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 20:03:54 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-386ab9ab619so6530039eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 01:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597431; x=1796202231; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5RSPGAWd3oxeQteUUuoK6f8743toWOpgplcBAfwJJQ=;
        b=TrQaUotYKtWfzsyDRLcrZcL4ttXqRB7KD6FcbJvlDvvvRdwrk/XpTZRTRWhJV4Fwwq
         chQ64IWCi2qOHEpEVEAL3BsAgKnvk6ZkQfmt334E+J3k0nHeCLZEP/m5nOEQTmJSrhYu
         iio08q7Pztm6WopJxZIhL60vdLqEWISX+DPm0Afmk4J2TYh2yQEh8WcDCMOgVxng2qcn
         ks+SvU/mQP7K7AjFRe5Hy6LcxGsDiaA4iuhyB9NiSmP1bsRX47xi0SUkdABH05THjFh0
         hUGubcUmt9szALh23fwnAI/iVGyppyqmAEBWiWxF+3OtAjgHC7JlF/ygFCdCrkyXBc3g
         oOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597431; x=1796202231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5RSPGAWd3oxeQteUUuoK6f8743toWOpgplcBAfwJJQ=;
        b=xH7PthsF/zHKuNyv/WWkXE8pjRDLXeM54fBG3r2kQDK4nhrK34yC160RJ065VQOBnS
         mlh99vXtRhLn3lzb2a+NGD+juyUaZVf+pwrDkSFH5tS48J3cxt881Zx/+/3lg01p1kf2
         Zo8IARMcX9dz/gsFuH6OjUBD1rmEGjtoNbe6V0HKTT+Jp4ot2u/ygICby04waL9afSxr
         YxvkvEM6ThHjwdyt+yUOL+X63Z8CTNzjghAq81aOZU4FUL7Be/VKT0Z4czDPw7pcq5/W
         ua5/Y7AxjJYXcBRjAPegNm2h0OIkj1REmoMXVRdsq7Tfv3hIA0gBLuk9UfQ+GcFtE1Ns
         wtsA==
X-Forwarded-Encrypted: i=1; AL+hErEhsxwc/iTGYetSsOk2AIzUVkn0cr4yBs/5zwNIVwkC4qKD/FQHVYXufeG+Tjsw+KCAs5lzLlh4DVZNQmU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+qc/5Dqf086DuLkH5BShRu8BAlucNTDyh5ZLILoBEv2MO5kWUp
	r1ttJuytFDcrNzQjoeyejT/Fh+wljbS0U4PRhG3lXS1tN7tIBHTbNTk=
X-Gm-Gg: AZFdTZd9OOxKpe8eDko/UDLwR7ks43QSBoUYdW6us367KxhmTyobr9z6Akksh9GOG+X
	3icw3nOcLlWjHqzx5ElTvHo9l2dg8ypA88AJ26swdeAFBT21GfIGOiK7M11vol8EuZb6+n9sadk
	q5rBeuI5flsaWvxYmRcY2FGaKouHyKnqiLW+uNmRTr9M4obg70UMS+hLPsvNnQ63IC6SwmMOoz5
	Fmds/IvfbrHIFK/ZYudp1d5x1qxu92u2dJtKexNt288Qzo22dQ7RXaFUy5BbSMkPM6xrVF25XzE
	2Yo2hZp1kQHsqhSq9WBQn8klC/A2ja8ni2EgPQYRqKmIVUBg0LKGOGWbcRFPkrFV48XXjc0SX2O
	9JvW64bW/RCzwZgQCQFoYKYmaGwjiQelEvSkRifnMvBDXZM2p5wuq3/uPG/rE45ZYkhevKJDoOY
	cswU/EGSeDL+XoXDiimK/Kv1vJC4MicCdOOXmgzrd3jOO7b9nxzxCHhZauGsii+l9o0sj9HT+A9
	H5cVqDikXZ/O73w3ixk8/nuToBD9xXO2ciGQDk05qzgSUhxa08kFjtx5Pl/dy6aIhn2oQ47xJXm
	p26DEqgbFOnXcBdVxD+H4uAVKR8SPyZnfBMhLyvq5WvXoA2hYMNdw9IBtEnFZLyk0sxbSjh0ogy
	SlrsQKfQ3m8e2Sg==
X-Received: by 2002:a05:7301:730c:b0:381:2114:99d0 with SMTP id 5a478bee46e88-38571415bdemr16715777eec.39.1795597430484;
        Wed, 25 Nov 2026 01:03:50 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:44a2:4377:d176:9ad1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm53859174eec.12.2026.11.25.01.03.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 01:03:50 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Wolfram Sang <wsa@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] macintosh: therm_windtunnel: Fix i2c adapter reference leak in probe
Date: Wed, 25 Nov 2026 17:03:43 +0800
Message-ID: <rc-b1-20261110-vc-23-41d00428efcb@gmail.com>
X-Mailer: git-send-email 2.50.1
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

therm_of_probe() walks the i2c adapters with i2c_get_adapter() and
drops each reference with i2c_put_adapter() before taking the next one.
Once do_attach() has started the control loop, however, it returns 0
while still holding the reference to the current adapter. The pointer
is not stored anywhere, so that reference is never dropped. This
happens on every successful probe, including after an unbind/rebind of
the platform device, and the extra device reference would make
i2c_del_adapter() for that bus wait forever for the adapter device to
be released.

The driver does not use the adapter after do_attach() returns; the
sensor clients it talks to afterwards are children of the adapter and
are unregistered by i2c_del_adapter(). Drop the reference right after
do_attach(), before checking x.running.

Fixes: 3e7bed52719d ("macintosh: therm_windtunnel: drop using attach_adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: powerpc (ppc32), GCC 14.2.0, W=1, pmac32_defconfig with CONFIG_THERM_WINDTUNNEL=m, CONFIG_I2C_POWERMAC=y (object only; no new warnings).
No hardware or runtime test was performed.
AI assistance was used for analysis and patch preparation.
Runs on every successful probe of the Windtunnel G4 (PowerMac3,6) fan controller, and again on each unbind/rebind.

 drivers/macintosh/therm_windtunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 0b2e08a1bee0..4f2581d9dec9 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -472,9 +472,9 @@ static int therm_of_probe(struct platform_device *dev)
 	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
 	while (adap) {
 		do_attach(adap);
+		i2c_put_adapter(adap);
 		if (x.running)
 			return 0;
-		i2c_put_adapter(adap);
 		adap = i2c_get_adapter(++i);
 	}
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47

