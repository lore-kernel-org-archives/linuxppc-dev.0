Return-Path: <linuxppc-dev+bounces-18760-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5819DFEA806
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 04:14:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgYTB03z4z2yTK;
	Wed, 25 Mar 2026 15:14:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774412077;
	cv=none; b=kABoYSGe2IKqVCC+ZFIzF19/1hWvEgzleF618SjLyiVY8hYMwV0itXINT3CjsR5mCh1e/kSGHvVLQWuRm6KldymxSCQ6OjGEysU6sc/2MPgfGooxIoMAaWYfk8c6zxLDzJfYj2PrHv+TQCVzLW6bAUa+QrjYF5/c23mDpYhSY82Z3El+WRmBivmLJ3HIj5l9ywXDio+UCWP/rcw9IqltwK+P2bKzx14A4fFdLVwaYKDdglkqn+cinfVHctK9wHC7RgC6PMBLctspiFYllezky9bCA/swOfM1rP1M+5r177/exrtTBkrPyBqj8nqtQ74qlhh5Lg7QwdmHBJbUqlEoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774412077; c=relaxed/relaxed;
	bh=27fWtX4e+LV3z70kuuRuZ5e8ys9OszIAeG99fDZYuvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3RaFo4lVzWko90aZnm5V8nLqvOKM3sD4hYq+Hz+LiJWrLxvJXsmVw0ZOq4xIMX2fqkzQz5+BtYtdj/1eKG9dUtTQeOunXV+YJnrZTc54SNTTWUKnzyAbWM/JRK1CLah5OwvGw0Ctmw6398rMiBGsp0jxoK3RpIoUgtfsCnVL7NwgrH/xBVQDhlHe1mNOUjeRFxlkvJndgw3qyVZW2RyN5jPyBZEAtMoX+nrxXClQGN6EO2lfmiXDTEUPKg0ifQS52NOnK5ifK0IxKkvfOhxoSSP2TQ696gLaMjwzGDHHmCJYUWZPtTG1n/7ORh4sF4kQiSMxc5l6qDh/uHb2nKhYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SRN8ph0p; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SRN8ph0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgYT92CP2z2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 15:14:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E09BA44182;
	Wed, 25 Mar 2026 04:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C4AC4CEF7;
	Wed, 25 Mar 2026 04:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774412074;
	bh=DjQNBELJeTo8/+IvhIZ195gGXomNRX+U9eI4gj1CDvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRN8ph0pe1XZdbFseT7tE70r/KjEUXruc5OYrwNk9RqqxCpNBz3lKttBmjvyR/V+F
	 LtJrTZ+7anfXtgnic7l5VIoLbzWClqhGy86LYc5jTJ5WiLlspuvWPVcH7tVEo3bTZQ
	 B3/V2PjFQujB3TmjH/YZDXYjGSvefpMLSF6ujW4kNal6dqlrgdyZy3xe5uuN8qioVt
	 C5T8kZxf9GojeAa9XddOx6PZakiiMDHaZ25yl5D3ZSoIxAugmHnvVJo6l2b5/Lv/S0
	 upiARQ+JCWrFKrTEs9313xFN7iKFbUBGQMZ2Z6A7i8ktSdEYDHgVOSA3WjPwRHv5Xc
	 ZaeMKZnXKgm0Q==
From: Kees Cook <kees@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Fix bugs and performance of kstack offset randomisation
Date: Tue, 24 Mar 2026 21:14:20 -0700
Message-Id: <177441205756.1333400.7749975219620417508.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303150840.3789438-1-ryan.roberts@arm.com>
References: <20260303150840.3789438-1-ryan.roberts@arm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Mar 2026 15:08:37 +0000, Ryan Roberts wrote:
> [Kees; I'm hoping this is now good-to-go via your hardening tree? It would be
> good to get some linux-next testing.]
> 
> Hi All,
> 
> As I reported at [1], kstack offset randomisation suffers from a couple of bugs
> and, on arm64 at least, the performance is poor. This series attempts to fix
> both; patch 1 provides back-portable fixes for the functional bugs. Patch 2
> proposes a performance improvement approach.
> 
> [...]

Sorry for the delay! Applied to for-next/hardening, thanks. :)

[1/2] randomize_kstack: Maintain kstack_offset per task
      https://git.kernel.org/kees/c/37beb4256016
[2/2] randomize_kstack: Unify random source across arches
      https://git.kernel.org/kees/c/a96ef5848cb0

Take care,

-- 
Kees Cook


