Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F4606D827
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCOphDhg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJpcQ5Rd0z2xK7;
	Wed, 04 Nov 2026 00:01:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793710902;
	cv=none; b=hZqYM05IWyo7qmifRQ/pmjzgN5V2nef0S3h92bpedbqiL1Kx9QB6ltaLGc0WewkeT+Sa75B6T81Gt8yMhC5VdVo89gEBw6k3/z09QY4wT8Po6k2IaPLlxdZiJu6KsB22oUJEbAWvgNMD+bi1FhHauPU+sxnTG+8qoMAfBUIfz7QLmQ7ledq4q2V3H/7HBFNS09/FmHiVUvcdOk1UX46uIAGqPDp9SYc/Wdzvvbwon893CApjnl0Azc1EH5TbFDl/RjTaqqMy0Na/lDA/H6aYE5WhcFdctoTLEPfsS5QVBIHesDeaLt/yxbKrohDRM6Qo3W0oZYCcS8yxO0muHnVZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793710902; c=relaxed/relaxed;
	bh=MXlTLVrJ+8VyZnT5b9Rq3zNGNivlya/OsfintA2OPZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaHv/TQ1SURo728fCm12CTlkllptKWTDvdLPWhIdjB94OfL3TVRmCp5vRD7Q/O00v67CPhuseKc6fyp3ImvVeNk0AI3POZ7ufE1xWZZfWvU0vyDQv6i1aoDVygU2nZApC/8q8txF4VYEydcLAKXyxqZ62Gs1DZDTmSpxuHbSPLRvylDJdZF7HzvE0fynV699YgVzMafcg4rWH5aaAELUGGT3wDclLZaupbo2Ggx6Q129Kv0P9gY4B5ea8b7SYNT2pyhOgjk3wocg34gl/XwEFOolaKnq5JBQcy9XxYJBuF+sznnUnqTLpNbjXyvxFjN2v6oqebYi9Uimrzdl3FHUWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCOphDhg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCOphDhg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJpcQ1H5Zz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 00:01:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 88FFB43E2E;
	Tue,  3 Nov 2026 13:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D431F00A02;
	Tue,  3 Nov 2026 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710899;
	bh=MXlTLVrJ+8VyZnT5b9Rq3zNGNivlya/OsfintA2OPZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCOphDhgwQ8NGxMZqa2+B+NPzkOmO1szZRb+kGZkqho8TLMxoDAdJZPwJhNpB+IuN
	 pr/x3sk6mMUMpNrYL7weXFezxfyS0R9IUgVv+I3lCv/T3/CIzeBua199bTL7Lm6c0+
	 /PJB7T6/XEnrH7/1ANUGOHOy3Z+kbDaSvKcRuKRIaqUpfqn5nVjvV05pDD641Ufk0T
	 qWUaM0tkWNr19cF4q+v7V5wymrt4GNDg4QjRpbUEkOfQJDP8iIKqloQI7wjkq+V6p7
	 Cc/YoEACpfpvgudlj0SsAqJ2yLZe+AH8xqDhxXbAjLvkFAJAPfvBC/YbXC4u32oJE5
	 eN1MUnkMWew5Q==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	=?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] selftests: report per-suite build results without failing the build
Date: Tue,  3 Nov 2026 08:01:25 -0500
Message-ID: <20261103130131.4069212-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200115.1363363-1-sashal@kernel.org>
References: <20261014200115.1363363-1-sashal@kernel.org>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shuah,

Thanks for taking 1/7 and 2/7. 3/7 through 7/7 are still pending and
still apply on 7.4-rc1. Catalin acked and Mark reviewed the arm64 one.

Without them a failed subdirectory in futex, arm64, riscv, powerpc or
sparc64 still gets lost, and for arm64 and riscv a failure in the last
subdirectory drops the whole suite from the install. Could you pick
them up?

-- 
Thanks,
Sasha

