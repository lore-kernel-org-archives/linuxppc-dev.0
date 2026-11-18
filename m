Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818A60A2609
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8rhOii4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVBtq0gYPz2xSl;
	Thu, 19 Nov 2026 06:46:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795031203;
	cv=none; b=bE0tgOvMiBfEnMjoIVAbK/tTzq4/1+B06vj/5QgBlZksjZoWe0msKIkUlg/i00CvK4h5/X5QKaj5UFkg+ZPbCRvmRAOOl6OPPppYVjgcoqz2dKDWf+t/uLzbb+tA4oLQV5IMtI5V/7NNkkLp+b+HYEI+2blx7HA+71wy2xh5FVXHcMpz9++Fre9mkU/HaAoYtWRAXUDCLsiIEPNPwfrdShEnrZbwsqEvY+UGGFy1Pz7a1hXCPww8d8QrYLV6pju/j5Vh29CZVWLAabP6DEekDCKEck4FmsfPtSFdsJqd47jqRU5gN5RJlZ7BgVnFTyXVZ7O2JzYkC5Dk0gCOZWKVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795031203; c=relaxed/relaxed;
	bh=FraNARuPZ3tZqbt90b68MTJtjCSnJWUqeang1fd2yUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GP4W7Tb/C1sbdivVjZWhoNOng3UAOExQarIRUFvQVxET4To9p2wK3fN8xn36Hh3YGwwoP0Z5Dx6pmL9dqFUZzofhKHXISl4OPJt2Ts8IWYVIgR7ur1+qUmlb1x2X/zkWEwailXcZYvRnhMLEYh+SV7qc2T9TA5qjUPlZnUaQhn+ukmThvfxkI1EkTUxSYZezM0IQY55alqiCiaKvfFR0oKI/elaN7/jIrevWoIOK7QgVZmfZF8VKOHbC1HBSWgS1lJvYNBGpZsRhgxAJYl8XIalKcPYJGOKk1MBn2Y82TjfKbT8voaXZM38m4WmT2oCZYOhCLbxNPioY17txsRqlvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8rhOii4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8rhOii4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVBtp3W51z2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:46:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B077472F3;
	Wed, 18 Nov 2026 19:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C5E1F000C6;
	Wed, 18 Nov 2026 19:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031200;
	bh=FraNARuPZ3tZqbt90b68MTJtjCSnJWUqeang1fd2yUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k8rhOii4GBidYBHAj6OybYKjTi95/OE4IutpnAuro0koyhgtSDGMrHBqjxr2sRagl
	 xsXin4sy87M6WN68cIHkqd3YIiqDzzLGmqRMy0dAcmgLOjmMTijhTQf7Uj4/jUmVrN
	 lwFMRFnl/uAjRVANuBcqyW7GFSh2cKjw7odg8pFJGFKroRsjqyyWye4YpEJ5E5X0mu
	 SpQubNXz2Pii6uA+K9BywHWQWqD72reCnZILizmgwg+ld1G//C9l325rWrKrAVwdna
	 pRjtmXTtrY8/Az4tAbLk4ZVbgV2OY6SA2/k3co8e/Kq7g+ymgLGiZqR4I0uKOjOlcP
	 screbGc9dWcmw==
Date: Wed, 18 Nov 2026 19:46:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Dave Jiang <dave.jiang@intel.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Breno Leitao <leitao@debian.org>,
 Terry Bowman <terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Williams
 <djbw@kernel.org>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 10/19] ACPI: extlog: Simplify fatal record printing
Message-ID: <20261118194628.30ad2621@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-11-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-11-pierre.gondois@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 12:10:20 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Only fatal CPER records reach print_extlog_rcd().

Maybe mention that is only true due to an earlier patch
(just refer to it by title). This kind of reads like
it has been true for ages and you are just tidying it up.

> Merge the two helpers, remove the unused prefix argument
> and return value, and keep a single rate limiter.

I love the trivial sometimes.  Short wrap.  Go to 75ish chars.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
With any background you can add (or none if it seems it was never
any different). 

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


