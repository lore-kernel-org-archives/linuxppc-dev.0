Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ADE606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qepwijkb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j98w4716Wz2xKx;
	Thu, 22 Oct 2026 13:18:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792635524;
	cv=none; b=ezipRrawJP6JtGjDPmUY5IvlobzIr40WiZetPvtOn1y0PMsluQfMjEFe2xKLkgBd8DxvijpaciyTpUFzJXmB2y0jAgUwOjxqWEkZjgAOeAmHgNNL+3PvqgFv2jkwCfCFU5FlulZ6jf6WPJLMzWvfJWP21dzkQSMqxKyUTIELxPFouyx0ztXZrBeRTl1U3PNf/KHq8USJcM77K3eAtoQGQ0GvzzxbbGl73t3ZYm53MgfWIwk7cJyhe6+cBxRcK81jil435xfRFPobYKtqZ0T0XxvAqPwvVB+CR/4taMTaFgALW5nsbJJss3WWmtf5lOgQmUBXF4Q6rXUT1oD1WHpXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792635524; c=relaxed/relaxed;
	bh=YVLKVn5aYrORuK3mJHdyAM2K05yQ1I4f1Gd2eeFrBFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5+0aZU+ukyCHJJi9RY0ZbWTY87hDsVBy5Gxm0YqwNgqGj1F2As2FRMSmVr9pI9ZJ5eL3KWiz/h+EvizMrgixzaxhT+7Hqj1UewrD6PuNAFC4M3DdPzUQusyOVSPMGoRI0bwpSK9XNSJDQMrQM/Qu+P6BHYe2AQ2ue1blHiEA422NsPPJJJkhr8VBS+x2p+ZdUrzepBR6iv3R1uCBrztDQEJdLGGvoJhJSYpOE28wyHVAy5VqQcOPUH7fTMUyZI5Dr+F32iQmsRw4AGoqR0Qtzg792t5DreN4fGUzVQi3hxuXVnmRzFFdBzUDAKdO9A4f12eCBpZu8sz+8GHMY0jMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qepwijkb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qepwijkb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j98w2573Hz2xHP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 13:18:42 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2607058eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 19:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792635519; x=1793240319; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVLKVn5aYrORuK3mJHdyAM2K05yQ1I4f1Gd2eeFrBFc=;
        b=QepwijkbmjtA87Yx02ylR+uI2YMv6BYdNv0vBQGKu1Sk/iFpHzKdRjqmeODE6N25Xr
         C2T1EI0rFO+IAeyl9n3xc9xdeT2SlPROozoLOhxRBvMNAxKpw33432rMFPyD11m4L4SG
         c5rizrXStnn+jmz0roc84NrHEWbhkk73ocTARAB2gfIACJbFgJccXA4yb51D4bzXIV5T
         Phjyl5nUuyIWnF8ahPdmWbzfzdmBjPfJKMmq9WlM7NRAD+j1xAX43oNZ4OanQmh0ebbH
         jiXbXy12FRjBhw2V+VFYYgWfOOBkVrfCxaM78B5lrHkyZR2y4pMWWxhRv4fr/EaCcPVx
         pX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635519; x=1793240319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVLKVn5aYrORuK3mJHdyAM2K05yQ1I4f1Gd2eeFrBFc=;
        b=zH9bDJWL2AV3BRTuEGegU212REYvEMREspFnohbZnWMolJ0mlNX90HawKLn68xqn2r
         acOP9hzydUynOJ1oJA68LTwO+8I8nvkl8qalXSMKkLNADjuUoj/v8cJeuujdhAysjBjp
         grbVMw5mwqCmxDhLons6tCqTfmeyAxBYcW3CAFePMKBtj5ogrJJlgaikGYzSJ8Q1UeDv
         xa5CyBQNY1Yj8c9T5eRFrHw1NcOoh7t5RE56TGS3Bx4gpY5vpyJdbTBKOh0LhHT6j7Sc
         TmFQqDGTgdqv57GCnW9c/B/VQVlnhCExpl9MpjNll7k1bhov/9URSYZyDLRI7KRkdY0L
         9W+A==
X-Forwarded-Encrypted: i=1; AKwUvBzglOIaDaSxJbwNFt42uF3XwJbSpUawXg41ZmnlRZTy0/TTWQwl4GeWie2LE797QieBd6xmDjUaLQBURXc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK64Hhn1XytgVHJ/+Lo2AzxHOsqA3ZXwlg8f6K+ij5T9rGaNpT8
	VLiHBH9kPJnfYb5ZbsuFgfaLJMwBbyK+MYjMionOtppBSRrJgEkLsiFv
X-Gm-Gg: AYBFou3FH6FsqY8pXDHiv8XhEA7Smi492hLluWzbBxj7dSr5Krt+4hPJ+BNNedaV6zg
	+2mAtVXZtCEUpJ6ReLLztFnHAX66n7VYNyk//fRZSUXBICsXoHPFxw2ltyT5lJYMNZ/cQkMRq3p
	//UdMXNgJB/n47cCM9pe6ybiLaoC1RU4g3PGTYc0rR4clpQw7FiJKEz/fzqP6lm16oryiABsZBG
	VnKzF1QnmDZrRhJMmLzU1dTnduxQDa8bcaID5u3tFCiGoWM58TJaws/oviBelVnEFHmPIA7crDh
	ax+4x0qFD1ONEbNFjU7l9eg+Zwv+f1/stzWXrv6G/0DDAnk+onkjMmk++l0NqvwPNifdQ5gRHcq
	7TXe7nucdMNUpXend0v+7URjp6Beu3x87mh0wN41uXAVCT7XI81h5YsugR5aZwWmnLWq3Zom5le
	kc1wPtKXnKo4P956PtY0EjL2+JswYAbedOEJo5aWZmPVAGI5/zdffiYJYWnCdPH9RTQNgug990t
	UR829kLTfFzD6VaqstJ11W8KdRNzcJRVFjtYA9UOEuk584=
X-Received: by 2002:a05:7301:618e:20b0:35e:2c6:d46c with SMTP id 5a478bee46e88-3674c63d579mr5523810eec.10.1792635518735;
        Wed, 21 Oct 2026 19:18:38 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368b4b8e9c6sm3556805eec.1.2026.10.21.19.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:18:38 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Peter Collingbourne <peter@pcc.me.uk>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
Date: Thu, 22 Oct 2026 10:18:20 +0800
Message-ID: <20261022021820.1789083-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com> <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com> <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 12:58:54 -0400, Andrey Ryabinin wrote:
>> +	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
>
> Why it's open-coded ?

For the same reason as read_word_at_a_time(): commit ece69af2ede1
("rwonce: handle KCSAN like KASAN in read_word_at_a_time()") open-coded
it "to avoid having to pull the entire instrumented.h header into
rwonce.h". I kept the six asm/word-at-a-time.h headers to the same two
small headers, kasan-checks.h and kcsan-checks.h, rather than pulling in
instrumented.h with linux/bug.h and kmsan-checks.h.

Thanks,
Qiliang

