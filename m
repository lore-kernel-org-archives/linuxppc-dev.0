Return-Path: <linuxppc-dev+bounces-26221-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F646C61DF0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 06:14:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYJc06f9rz2y2f;
	Mon, 31 Aug 2026 16:14:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788156864;
	cv=none; b=KfMBjolMpPJYKhBI+DoA79qJ2GvbVypIa5F8lb2PooD8HggOjIXC1PY3OyTBfWJ8C02YgHNGT5Oq6q1+ajLrlgliEEQjqMLk+tuT43QuTuKCm8bXA6fwrbk+/GL8GsnBG1VCPszcbhpTxx1jGQgS6c0QIjoczLyjRpYOfgEMtEjSTJUjewon+T7IqPKpmGg6m4pOaZUiHdXwO2U9Mx5yTmiTTjCmg5AG2rpb77jg6fvwC6lB0ugOIyZ/yhvspM0/0uYP2FUoGO2N7e86ssiU6N1Wph2QtuMLiX/CrPNi0ES0RTRh3m/t5R9QzEEhd2LefYOLXR1egehbHftNLP3hSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788156864; c=relaxed/relaxed;
	bh=qoFo7+PxqjttbtK92O/ZZGktuuQcYVg2E/w5Dp6VQ88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhatrtjwWT4kyBTJUjTUCjSkiQD/iql2TPUG443Aor0SnB++/77KHsnv7Fg3Rgh6XXN9ACCMTvD5sukzcihi9AujTHWUluGnEXrFq2Aom+t6RfUpk28GB9ChX/2X8IytczHSwrzu+q22Q5PZ68aSgydXCokAlN8m0EWbk5dQrSbd8SZWQV3h5a2juveP6K7SYTsbK8rFC/jsIbwcndkvLTi0tMkpYn8WBkfXgnOWBD68taiGOvrksZ/UiHIUSJfV/6hE2m9X9fh4A5Em1unQRybXZx4infXhMTMe2MiXZZ7Hc+uyTDpxHmyALuwR5aMXyeQiaBDK83EyOZ4a7B5+VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=hFsJ5kBQ; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=hFsJ5kBQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 301 seconds by postgrey-1.37 at boromir; Mon, 31 Aug 2026 16:14:20 AEST
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYJbw47Prz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 16:14:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=qoFo7+PxqjttbtK92O/ZZGktuuQcYVg2E/w5Dp6VQ88=; t=1788156860;
	x=1788761660; b=hFsJ5kBQ+MzZ0hy7Ru7eVfBYvh5ZJiia9QM9a0e/FNqdgVb4iysLEoFUpHCmP
	q4u6Uuw0D4IkveAFrHAn8FrBFa5Hfstwbb1dczgu6p/8mDNP0OL1pKaqkFY8MCeUTlkx5ZJNS7BU5
	ylKRkkAnt0qoGoBEYWyx8FWDfzeLzZVABQIc+gPMYyu6LQt51+jF4N+A9X3+UAaSWp0TivBEbNn6y
	LyDCmAFKIRyWvNwy7XijvTeqUITTFS45wyHb5gJRL18xT+KvyNJgR6mN00VLcWT0TJzt+FkQTRqn/
	80swxChkLmCsCXNkWD4faVKiueG9HGOUYkjWnDsIFnAitnkHNQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x0vCP-00000003S29-3Hzv; Mon, 31 Aug 2026 08:08:53 +0200
Received: from dynamic-002-242-195-014.2.242.pool.telefonica.de ([2.242.195.14] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x0vCP-00000000yAZ-2A6t; Mon, 31 Aug 2026 08:08:53 +0200
Message-ID: <d766413f91cd778912f6af372d3d5429bac7765f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: samuel.holland@sifive.com, David Hildenbrand <david@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes	 <ljs@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker	 <dalias@libc.org>, "James E.J.
 Bottomley"	 <James.Bottomley@HansenPartnership.com>, Helge Deller
 <deller@gmx.de>,  Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 31 Aug 2026 08:08:52 +0200
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
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
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 2.242.195.14
X-ZEDAT-Hint: PO

Hi Anshuman,

On Mon, 2026-08-31 at 11:13 +0530, Anshuman Khandual wrote:
> pxd_ERROR() macros have been provided by all platforms, which are very mu=
ch
> identical and can be dropped off completely if these pgtable printing cou=
ld
> be moved to callers in generic MM aka all pxd_clear_bad().

If pxd_ERROR() macros are really all identical, why not provide a common de=
finiton
of that macro? I'm always a bit concerned about such changes as there is al=
ways
a risk to oversee arch-specific peculiarities.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

