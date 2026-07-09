Return-Path: <linuxppc-dev+bounces-23901-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1DAC44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:46:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwlqM12T1z3c9k;
	Thu, 09 Jul 2026 16:46:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783579583;
	cv=none; b=K/9JklJ1eImkwzzStJ3Ht8tQAQSI1a4B0HtbjfLoJM1HkqwJ5BQJ/4EWajTPpApRHyGPvZUdc/ZqrcZCLATSqbOeJuLWBJp1oFN2/P/RqewagFdFHW6StrqFEvD9FWubcBCq2jlLa6Ku4SLLxa0jKEBv/SkKjvTo4UR8PQ6i0V9bwdMM8DtSaQZ/sOyWH7lpjC8JL6nEtoP9X7REgijx6e45ITr+hOnJ/ceuDcsLm23vCofycwqbTDRnLb5YHZb6+rXEom2q6e7B3KQXJNV6nz5ZAHiWK1FJosauo6QKwuK6tq6fKo2Dg/ArYzU6reEEK4rALE+8LaVfnPCp3N3faw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783579583; c=relaxed/relaxed;
	bh=PijaR+i+qGvmTzV/7mms0G50C4ct+YrEuCBRWkaZdrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJB5UNHSzgoSk8pkQ+nU4NvJZ4TzNMx6nq3dLaupATz33FkHyPvTQRmvIFypk1E3CFSSdO/t5QvH8IUiap9lsskwnJvn0MUJp5m0tEDw1aXQAHVi1mbIO+XlW4HsFpU+M8LYX+926xjmWmz9sqBJUWi/Wqu/wIg2EEZFpafnrClKLs5wm/wHErWxUqPCl5B3xQVVBE/WTmqTaqZKy+Aq3mXneCCOF8/ljRyBbQbev6BXSUrB9leFtR+cbzFJMkV5PH1FDf05jTnzPwB1G4QsbqY9yFWjUz4f8E9GIf+DYCyaecjDKuCHVXdnYdeKHTxrdYPQPVy/Bz6rmTqIHbVk2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O+WaQfXm; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O+WaQfXm; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O+WaQfXm;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O+WaQfXm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwlqK6Xy2z3c0H
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:46:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783579577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PijaR+i+qGvmTzV/7mms0G50C4ct+YrEuCBRWkaZdrk=;
	b=O+WaQfXmLjNJNblxDvbqWYhCmyTmPNIKSH785DQseu3lybQSJItVHb/UCKdLunTU4eF3yG
	WMtz6qm1kq2J4l4XmxK+0hvtLHuHpRHpE8GDd9t112n8o3UTgv3pgpbWSRAJZjsgCTxa/4
	c8hS6hgMPBG51MCzpk/G4opuCK/5roY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783579577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PijaR+i+qGvmTzV/7mms0G50C4ct+YrEuCBRWkaZdrk=;
	b=O+WaQfXmLjNJNblxDvbqWYhCmyTmPNIKSH785DQseu3lybQSJItVHb/UCKdLunTU4eF3yG
	WMtz6qm1kq2J4l4XmxK+0hvtLHuHpRHpE8GDd9t112n8o3UTgv3pgpbWSRAJZjsgCTxa/4
	c8hS6hgMPBG51MCzpk/G4opuCK/5roY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-pflArkrcN-C7I1oRfLoGIw-1; Thu, 09 Jul 2026 02:46:15 -0400
X-MC-Unique: pflArkrcN-C7I1oRfLoGIw-1
X-Mimecast-MFC-AGG-ID: pflArkrcN-C7I1oRfLoGIw_1783579575
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47127ee7e07so1308600f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 23:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783579575; x=1784184375;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PijaR+i+qGvmTzV/7mms0G50C4ct+YrEuCBRWkaZdrk=;
        b=tENeXxBFEpJfx8hMmP+tXhxAsIpHBqQ6IVrkpzNpsS3WtQk6zAHX1GxeHUWsgB5to8
         33EDIypmlX3Jx55DbiGShVgl4jyYL9C8DBetWNlZuwO9dYTHfk/FQ71sFhwrBbech1DE
         HeZf6xO71WJ8goVfPbSpDiAkRJ2gpS6gW2/gT9SobmzGcJrUmDM7e4+dj3jVGQMdic1F
         7A1fbmyCs6uqX/aeDme9KxXcyzj0L/R6f4KcJWcUY8McP6LRSLy/odc0/v16gKea2kZh
         cpqM4+ABCYoa/JECKX9YPLoMtOMHyIImmjjMuLC/R91xYA/iyiY8gEGT9yGZ7IaSRqw1
         yj8w==
X-Forwarded-Encrypted: i=1; AHgh+RrrUlLtu5U+5jhngPIKXf5+Rx6vZ6dqG8JthxkBW8WZgdzYZqDb/ns3qkvz9I48weraL2Mk1EhA5PT299I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzeCm80jrzeLpiFWf6rka+cgoS4ltQ/4ZijWrmqB5OjzRiJHZ1/
	sopiAYEUTBWFnkTnj6JCpIE+6uS1MixoUxDT7/6yyUKIjuxyhKR+euJFfIL6zgl/sucHui6Xrjw
	dTbapULqBp8XZkZqeQWktPO15Oas/Twe6Yg1FANdIsPrJXStsWxLu1xWLexBnXOtPUOs=
X-Gm-Gg: AfdE7cmX3n67J4lWc6M2RhY8XXoMtOGJR0PjHdu6nr+pwe/bfUi6yRI9a9GraQg9tmQ
	aY11Y8GyL2RlmI0ZGN18qQx00ktEzdrsXB21yzbLc/UmXD+Q2NjhbO62j9tUWCiJCrWwsx7gOpN
	5AAPIfgMi1XQnD/PcV+Y/I8aDUz5yjoWNCJzxbr16+N3fpNMnSlyOEjMiNUkBh+jVYmLNTpcddo
	R3nrhUlTb//yd771ES1j4RJCKNfeDz6n4dfJWUNVaHXW6HfuNGHzXQQQYzS/oraESdPTRETKNFe
	mN+CjcDEVvXVpd4Icy/nfHnyrwJGMbFVAjNzRyBlXYIlghRMymJjkIsSs+eNBJjslaNEOLqUbXp
	eZTn7zDzc
X-Received: by 2002:a05:6000:4b09:b0:47d:e813:4f6d with SMTP id ffacd0b85a97d-47df07a83e4mr5864627f8f.1.1783579574737;
        Wed, 08 Jul 2026 23:46:14 -0700 (PDT)
X-Received: by 2002:a05:6000:4b09:b0:47d:e813:4f6d with SMTP id ffacd0b85a97d-47df07a83e4mr5864589f8f.1.1783579574340;
        Wed, 08 Jul 2026 23:46:14 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm47603396f8f.36.2026.07.08.23.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 23:46:13 -0700 (PDT)
Message-ID: <bd10e435-de06-4b67-962c-b520a43a8280@redhat.com>
Date: Thu, 9 Jul 2026 08:46:12 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 4/6] powerpc: gitlab CI update
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
 <20260708105122.1177210-5-rathc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260708105122.1177210-5-rathc@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -Bw36mWzGS0Hf6lCTEg6ZJoZUaakoTVnm5ATDIco9p0_1783579575
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2026 12.51, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Adds a few additional tests that are known to work in CI.
> 
> To control overhead, ppc64be is used to test 64k page size, ppc64le is
> used to test 4k page size.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   .gitlab-ci.yml        | 19 ++++++++++++++-----
>   powerpc/unittests.cfg |  9 ++++++++-
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ab1be5f4..b28d1eb5 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -190,18 +190,21 @@ build-ppc64be:
>    - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
>    - mkdir build
>    - cd build
> - - ../configure --arch=ppc64 --endian=big --cross-prefix=powerpc64-linux-gnu-
> + - ../configure --arch=ppc64 --endian=big --page-size=64k --cross-prefix=powerpc64-linux-gnu-
>    - make -j2
> - - ACCEL=tcg ./run_tests.sh
> + - ACCEL=tcg MAX_SMP=8 ./run_tests.sh
>         atomics
> +      atomics-migration
>         emulator
>         interrupts
>         mmu
> +      pmu
>         rtas-get-time-of-day
>         rtas-get-time-of-day-base
>         rtas-set-time-of-day
>         selftest-migration
>         selftest-migration-skip
> +      selftest-migration-ci
>         selftest-setup
>         sieve
>         smp
> @@ -209,10 +212,12 @@ build-ppc64be:
>         spapr_hcall
>         spapr_vpa
>         sprs
> +      sprs-migration
>         timebase
>         timebase-icount
>         | tee results.txt
> - - if grep -q FAIL results.txt ; then exit 1 ; fi
> + - grep -q PASS results.txt && ! grep -q FAIL results.txt
> +

Remove the superfluous empty line, please. We don't do this in other spots 
between the jobs in this file, so let's stay consistent here, too.

>   
>   build-ppc64le:
>    extends: .intree_template
> @@ -220,16 +225,19 @@ build-ppc64le:
>    - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
>    - ./configure --arch=ppc64 --endian=little --cross-prefix=powerpc64-linux-gnu-
>    - make -j2
> - - ACCEL=tcg ./run_tests.sh
> + - ACCEL=tcg MAX_SMP=8 ./run_tests.sh
>         atomics
> +      atomics-migration
>         emulator
>         interrupts
>         mmu
> +      pmu
>         rtas-get-time-of-day
>         rtas-get-time-of-day-base
>         rtas-set-time-of-day
>         selftest-migration
>         selftest-migration-skip
> +      selftest-migration-ci
>         selftest-setup
>         sieve
>         smp
> @@ -237,10 +245,11 @@ build-ppc64le:
>         spapr_hcall
>         spapr_vpa
>         sprs
> +      sprs-migration
>         timebase
>         timebase-icount
>         | tee results.txt
> - - if grep -q FAIL results.txt ; then exit 1 ; fi
> + - grep -q PASS results.txt && ! grep -q FAIL results.txt
>   
>   build-riscv32:
>    extends: .outoftree_template
> diff --git a/powerpc/unittests.cfg b/powerpc/unittests.cfg
> index 60c73086..62630ead 100644
> --- a/powerpc/unittests.cfg
> +++ b/powerpc/unittests.cfg
> @@ -24,6 +24,14 @@ file = selftest-migration.elf
>   machine = pseries
>   groups = selftest migration
>   
> +# make a kvm-only version for CI for now
> +# TCG accel support with Qemu and distro release used in gitlab CI needs to checked.
> +[selftest-migration-ci]
> +file = selftest-migration.elf
> +machine = pseries
> +groups = nodefault selftest migration
> +accel = kvm

This does not make sense (or I don't understand it) - gitlab-CI currently 
only runs with TCG for the ppc64 jobs, so adding a separate test for this 
with "accel = kvm" just adds a job there that will always be skipped. What 
should this be good for?

>   [selftest-migration-skip]
>   file = selftest-migration.elf
>   machine = pseries
> @@ -94,7 +102,6 @@ accel = tcg,thread=single
>   
>   [atomics]
>   file = atomics.elf
> -smp = 2
Why are you removing the smp = 2 here? As far as I can see, the atomics test 
uses multiple CPUs, so this looks wrong?

  Thomas


