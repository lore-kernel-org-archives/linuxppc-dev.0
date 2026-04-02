Return-Path: <linuxppc-dev+bounces-19214-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84D7D39415
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 11:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmg0r33Jyz2yhP;
	Thu, 02 Apr 2026 22:41:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775130076;
	cv=none; b=iCPHfWdZhGzWIL/Wlw2avCUmLjxF+T0pF7XqvgyAZdq2ASHXu4qfvaTb5AyhzbR+FziqxAlUUKbtjv2TkXoRsBDOshKG2jsZLecxrbxy2k5pFsJiY8Q5EL7EI0b1e7Crl4+VyID5DlhLxOiZINW77jog4MzmKfdgLXAtZPQkR6U4/PxgLzrXma7tO3pO1qzpWC63GZFFGOmYe67XfDzauzxD1Lwv13XLYsjNlB0fuU0meoSNoC4Fyqcmqc1kws2XUh6soHRrwi0HvOkfgtYJ7LUSiDVHWt3loC7TdpwqZ2u5597eUh7PivZbb4sjdGRCBcM04G4AH4bLOE4nInfJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775130076; c=relaxed/relaxed;
	bh=TIDAGUq2ox58mNj8RAJDIO3jke+fJLSXCQUmSvSgvp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atw+3d7Y46a7pjLvMvaoOYC1y5neLLHXIT9UhLydu24ku5UwHzTAoJ4sHhopOjW64xhsXaq+LzTyRu7+RiEDMm+o/XE5RBylZrdcC1qZjz80X5NEgf0jjQmGh2CrhlOqp1b94uv7vu6ATMuamS5hVLsQ2Sv2ofzglQak8Mbszf2AYG5Og/sLpHT2xufrWtSN7G/CklxdVNZupG2yffNcDAE125mn4IIbEh56YVPphboNBHV9SPRd35OxatAhdcbNg5Cpwjm3EeGc+pW7lQH6m3diBJPcRs8kAA9yXEAXfZGij1hYW8Nh86XkTBF6/Y/d8CsYsqrFzjfCeFAdUOlQxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=akAPieEE; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=akAPieEE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 487 seconds by postgrey-1.37 at boromir; Thu, 02 Apr 2026 22:41:13 AEDT
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmg0n1GTFz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 22:41:13 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4B00540E0176;
	Thu,  2 Apr 2026 11:32:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jw2z8pECY3z7; Thu,  2 Apr 2026 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1775129569; bh=TIDAGUq2ox58mNj8RAJDIO3jke+fJLSXCQUmSvSgvp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akAPieEEczl8U7UBUYzKWZHF1yo8GWIbNtqvDnuU2xvWpQOTrCJvcM5YJXF/dlYab
	 YMHcN0kOoA9PaeZnalKe3TvEQU1ba12c6CK4GXE3QzR6fDCbiJXz/9OcwPZGYsD48b
	 7pWAUdwhCHC15+ODwz9YQ8+jBPuGHlaUTU3+7GD5IOP7QpdaSdOBVzpkcEajUVKe0v
	 7IMQq9XXEz3i+9pW3Hm1PSVtRqVDSivVNRcd2mBotzDLx2HlFQ43hQbYKH+hg/AkLO
	 uH1dugwlsst3UbYPenADA3Fgpugf7XfpWVmzZWNT/LuGUn9zNqKSWlwP3inH1kH9+F
	 ZduzT3zD4Ko7hOfXj0k+tQfDczDNNOcmMtQH4Snlh/wpwrTHZHlmGjmdk469rI2Cbb
	 BxBk3megOkdnJ/Kxe+EIeFcvWANIoV5ElsZoz0AEl9W5Huuonsjm2xnvtDa1Umr2rv
	 eBlXfEfKXFM1F5VEoXOGA6AJgTkAkHfHHKhDEgI/DgERCha6jNmVJ2OXGpjZUuxn0j
	 F887snfYoARdSYw6ag7tbwdSz5idvDgTWGRJX8ciczfA0ccLSB43HzSjNzVE+ftdMz
	 vcgwLZdAi/8xzDeOc6eIboCqt6HmYZJ9Jts/xsnL0CZrD8i8WSz9YYkCdLYoAXQzEK
	 Kz4yU1iMV/H/FkYlB1wYbzNU=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 68A3940E0031;
	Thu,  2 Apr 2026 11:31:44 +0000 (UTC)
Date: Thu, 2 Apr 2026 13:31:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	rdunlap@infradead.org, peterz@infradead.org,
	pawan.kumar.gupta@linux.intel.com, feng.tang@linux.alibaba.com,
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com,
	paulmck@kernel.org, lirongqing@baidu.com, rppt@kernel.org,
	leitao@debian.org, ardb@kernel.org, jbohac@suse.cz,
	cfsworks@gmail.com, tangyouling@kylinos.cn,
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com,
	hbathini@linux.ibm.com, eajames@linux.ibm.com, guoren@kernel.org,
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com,
	vishal.moola@gmail.com, junhui.liu@pigmoral.tech, coxu@redhat.com,
	fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com,
	takahiro.akashi@linaro.org, james.morse@arm.com,
	lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <20260402113137.GAac5Tmc5b7SL98KdY@fat_crate.local>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402072701.628293-1-ruanjinjie@huawei.com>

On Thu, Apr 02, 2026 at 03:26:46PM +0800, Jinjie Ruan wrote:
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.

From: Documentation/process/submitting-patches.rst

"Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
						     ^^^^^^^^^^^^^^^^^^^^^

one week before resubmitting or pinging reviewers - possibly longer during
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

busy times like merge windows."

You need to be patient and send once a week and not spam people:

Feb 04 Jinjie Ruan ( :1.0K|) [PATCH v3 0/3] arm64/riscv: Add support for crashkernel CMA reservation
Feb 09 Jinjie Ruan ( :1.5K|) [PATCH v4 0/3] arm64/riscv: Add support for crashkernel CMA reservation
Feb 12 Jinjie Ruan ( :2.1K|) [PATCH v5 0/4] arm64/riscv: Add support for crashkernel CMA reservation
Feb 24 Jinjie Ruan ( :2.3K|) [PATCH v6 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Feb 26 Jinjie Ruan ( :2.5K|) [PATCH v7 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Mar 02 Jinjie Ruan ( :2.8K|) [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Mar 23 Jinjie Ruan ( :2.9K|) [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Mar 25 Jinjie Ruan ( :3.7K|) [PATCH v10 0/8] arm64/riscv: Add support for crashkernel CMA reservation
Mar 28 Jinjie Ruan ( :4.3K|) [PATCH v11 00/11] arm64/riscv: Add support for crashkernel CMA reservation
Apr 02 Jinjie Ruan ( :4.5K|) [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA reservation

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

