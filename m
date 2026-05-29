Return-Path: <linuxppc-dev+bounces-21695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359AFCD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:32:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc6r6gymz2xnZ;
	Fri, 29 May 2026 18:32:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780043556;
	cv=none; b=HwmGCLHGFf1ko90uT8BNYDEiJHdLzro6DZVI3mJT9q/MZ3mSXgIqW1wjW2Q1N9MuO/yvAbyhZD6uoJa/R/24Y75med2Q4l0giEYIKiUQ8eXO9xGlc47loTU41l4wnzVMTyZpaQgOVVi+VGVLfvrOiOMVbG2bEGWbNsbCc5vCB6iFLXFeF0NT6q4DRY+Ajy3pR/cJ4Rp91OIxthd7y2//wGHk1uftT+eV/IUhMuVfQ6pt7YlWE+6h4rbX1CQu/BgiHI8I3e1xCGb0GlZW6ioGIOHuWkD3q7Jl6u7OBQvyhdIxJBVibl2uuj9lEdHxMs/Ny7abK9Jj53TfR2qCLTrjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780043556; c=relaxed/relaxed;
	bh=HCFl9tIcUOt3miefEeSoEF7h8rFNw+sRT0B6NcU/2J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThjuGBKf23mGAv+XGUp+2X2aj/zxZ09aBW83MMs89ZZx4DV6nbnws9FlL9KGX+CO1gT431lon5Oh7jhpoMIsDoRDqbf6Qmtha2p3Fyw3nCQARFC0F7XeHUBDPVqxUajAkmdfYY0ZXMX9Xwgo32EbzapZdYO5oHsL2w6k6OBikjFDOqbaKtONqtqXKkl1Tip/NyPq8OW7O9mF6Hvo9Stb9TTeYwvRRHTR1VarOo0r8k+RbbLfS87u7fkVJCVsE5LvWESbl6ROeHDzviEFIxvm2Zj5Dk7UIGI/HxzRXGgKsTlwO/VMVxJRuZxTvazZYoMwvT9sUhCqp5EDx75FcQx0Ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TV+/R2Zq; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TV+/R2Zq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc6r1f9nz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:32:35 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E3C201B;
	Fri, 29 May 2026 01:31:59 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 273AF3F632;
	Fri, 29 May 2026 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780043524; bh=6FINnAeejbCpxEsJKKtRLyzzbDAImuU1hMJl2QkGje0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TV+/R2ZqySGE36yEvr5DLTOVlwuwSWVBVD3mZtBpqf8v0rbiwgfcbKu6cuFovDtpi
	 GaHm0tH/kehwWUycIvD+JGIA723f23KKbNPAGoLtZw8LFIA0m7DdkzlVGMwTtlPKMn
	 fsVLYwoh7j6HcLdUiAn+UEYC9Fs7vc4gZXqUTNVU=
Message-ID: <3b2d27ee-28d5-43ef-9d45-038b147d04b1@arm.com>
Date: Fri, 29 May 2026 10:31:55 +0200
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
Subject: Re: [PATCH v6 00/15] arm64: Unmap linear alias of kernel data/bss
To: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20260526175846.2694125-17-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2026 19:58, Ard Biesheuvel wrote:
> Changes since v5:
> - Reorder series in ascending order of impact, so that the first few can
>   be merged earlier if desired. This also makes the patch that remaps
>   the data/bss linear alias as tagged redundant, which is therefore
>   dropped.

Definitely makes the series easier to review as well, it's all looking
pretty good now :)

- Kevin

