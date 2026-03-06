Return-Path: <linuxppc-dev+bounces-17819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056A5F0182F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:08:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS6DQ35ljz2xqm;
	Sat, 07 Mar 2026 00:08:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772802534;
	cv=none; b=Rj/hIFa3QjfNMOboGTTGmAFrA0VCiFOoDvIEDQuNyX9D92jRR0uLDiis6BoVhlY2a9AfUkMnXfV26gy9O5lFvzEILfAc1ee8ZoWVrxB64Fc2UxdjRt0PHNhrNzkvC5HD/LVy+bX2IlYoAoTZmLxawW0Te/VZDa1xdl66PUA6BVCp0+H9E76domVBBJTs1Wz935jQ2Pj0ALBAQh31caC7P4q6bVAt3L6HZPtb5vGNc7iay/8nB3kkMpYZ2FDwJIZRgWYk3ooEI2UWsw0SStTJNzMSU/wv6pcrxDDEPdCCO3ew18UC4g6VQqCeZMTa1llXtr9hBVVDRb+XD+0v8l1++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772802534; c=relaxed/relaxed;
	bh=u1rHxfLLP4YKNg1WjBlVzgw1fLtfT2Y/arepS+6+PYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5xq51XmjqtXICECsEk62tNIg3G7Jw8VyBHwrXGvzG28/yH5rjH5Thvpgmh+iWcYx6H78FfbrNEMPKpgVfE1jcx1Spb0sdrVY6NZ/HE7jkg9FKe/UlIoBS2QLZ0QvojR2gfzVk5quRvHRhy8dulaixCEWRTnv5XDAdwdCrR+HHJw5diKuJ7hwBKi4zkfBHkTroNUd1PvrTRbZOlnRQyjuV70te/WrSi0SdMCuvAXIFoS2L73xzuy2a1DZWidA6/MN4b843sw+TDMWdTH+YPrgbI4yaRVnBCbNlGeNs2i6O9I/8kdmcGHOSZBBM41HVOMAN2YfA6SotzlKJ+q4rFDig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EebIOyn1; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1XTZ5fbt; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EebIOyn1;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1XTZ5fbt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS6DN3gX8z2xT4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2026 00:08:52 +1100 (AEDT)
Date: Fri, 6 Mar 2026 14:08:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772802522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1rHxfLLP4YKNg1WjBlVzgw1fLtfT2Y/arepS+6+PYM=;
	b=EebIOyn1GAkztXhhb/xOs7a50yTpFmXp1eD4k+lUvkDCKBPOfjcZoid4acV7G2wCcI6U/V
	FGYlHmTgtqYBOcT5LOUcDj48GKf1xI9dsZbtHFMVDfMD8QKWZnfBhAfIsC0er950JLst3G
	6JCXw0rW8FCEIqQ4EdRofZoi+7PToRjpFsfZWgq6KSWgxM5VzOzxkvFDckuV9HuDXNJY9w
	dJkHqusUNd2P6UJhs66+UdaGK3zu2qm9NzQTl7UvcHcis/8MEhXrw7hgxaVE4raAHdHgtw
	D5zt0ivPKP6gya6n3/1XNG1t57ugX6PbBXVeZtmUSg9pkp+kzgOb6KN8X6tx8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772802522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1rHxfLLP4YKNg1WjBlVzgw1fLtfT2Y/arepS+6+PYM=;
	b=1XTZ5fbtGTrjwv0i4R2ZCuY19THERe245goUh2z2oB9xbmf1QhzB2aBzdWp3Iq8hSDD9kc
	a+BxNXuHRPasJ4BQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
	David Laight <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Sun Jian <sun.jian.kdev@gmail.com>, kernel test robot <lkp@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 0/5] vDSO: Use 32-bit CHECKFLAGS for compat vDSO
Message-ID: <20260306115350-ef265661-6d6b-4043-9bd0-8e6b437d0d67@linutronix.de>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
 <96cdd223-5139-4535-b82d-831dac472cc3@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96cdd223-5139-4535-b82d-831dac472cc3@kernel.org>

On Fri, Mar 06, 2026 at 11:43:24AM +0100, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 02/03/2026 ‡ 08:58, Thomas Weiﬂschuh a Ècrit†:
> > When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
> > are used. These are combined with the 32-bit CFLAGS. This confuses
> > sparse, producing false-positive warnings or potentially missing
> > real issues.
> > 
> > Manually override the CHECKFLAGS for the compat vDSO with the correct
> > 32-bit configuration.
> > 
> > Not all architectures are supported, as many do not use sparse for their
> > (compat) vDSO. These can be enabled later.
> > 
> > Also add some checks to bitsperlong.h to detect such issues earlier.
> > 
> > Based on tip/timers/vdso.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> > Changes in v2:
> > - Simplify __BITS_PER_LONG consistency checks
> > - Fix an inconsistency in the powerpc audit code
> 
> The powerpc audit code should be replaced by generic
> AUDIT_ARCH_COMPAT_GENERIC, as there is no difference between them
> apparently.

Agreed.

> A tentative was made in the past but was declined by audit maintainers
> because we were not able to test it allthought the failure was the same
> before and after the patch, see
> https://github.com/linuxppc/issues/issues/412

On v7.0-rc1 the test failure of filter_exclude/test is gone.
It also keeps working when applying your patch. Some other tests are
broken, but it looks that is due to missing dependencies on Debian.
So maybe it is time to resubmit your patch.

In any case, I don't really want to entangle my series with the switch
to AUDIT_ARCH_COMPAT_GENERIC. My proposed cleanup does not make the code
worse and if both patches are applied the conflict will be trivial to
resolve.


Thomas

