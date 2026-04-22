Return-Path: <linuxppc-dev+bounces-19929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ABAF94CD9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 07:09:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0r1n1Bv8z2yZN;
	Wed, 22 Apr 2026 17:09:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776841757;
	cv=none; b=AHjzq0sASaAj8kZq4Aw4BXU1pP0lKMvR+F5qJ2j/Y03otIZ99qo9L8f/hYrgW35SmPjodFX8ufR5aZdSfuKikNKJIux74iTbs9ECRVjo+qScseLF3uxWm0W0cyRQl1/7tqjOG8EqP7EFTeV8Jfm3+0E9bnjhhV+DvpiLZRhj3wUojNh/L7dvZhKp4BRs0KVTkumdcv6HDd5eYG+AghpSMPOq5djoVSI/b2tf6ckM8B3Wo9iJzZ/hTVdNUEn22nqUBt6NsOPf7C4sBylQZkObX63dqA1NYkbTYjhgDzKl3RC7xwqfudF6iyqvcjgO3EQz21DYmX4BT4z2q6D9tGnXug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776841757; c=relaxed/relaxed;
	bh=Pp15Mdc4GDnLRCAiSzgGoC4eNrO2pkucMzuAKIpjgc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFvWa8o38pxgoY7m3Uqu8ntT/lKzIoRpMI8Kt/bwQd7pE8/Q4shtzZDMUQrKTK0ngpcbxw9x2s7B94EoFYDVsb1Ttd6LVMHCCd55zCX5gPaeNIlOM9hWKmgpC5Q/EUyqE8z8yBxtJ+wBBGTVO6l0blp/SfB3JMFC3oquN9Q5LNAQ1BCAtoLnDZ9aiNvdtQjdM9yOuiZnD8kpppMtknsw5qHbk9kU6CUWLY/opLeNepBqp6TF7fiAQWDedirhVmUfnzIlUb8ChiKPFEhxbyYaqklu7Q8B/SUK07qmWTm2A3fHAXEm5RuMPF5p936sQdhYfb6yjvNsajX4eq/Iph3vQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dRQ12TUB; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dRQ12TUB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0r1j603Tz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 17:09:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776841754; x=1808377754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lh8pVmomFkOo4amu9fFZXflKJKs84bSrFxYYo4jSUvY=;
  b=dRQ12TUBhfKWR59YPoCrbyq+R05Ogv2TS7AdQ51+9Hhvdg+MM+7MpbmM
   59YaTK0RdQfU/Kgrz2JhqH1izWaXYFx+2b6kG0ahLwhu6enwCeMt1DyRl
   0uby8AyFQi92h5r3P1tT4N0IqOv9lnO6EEGI5U97hfBxiVX67sVoNU8P4
   YIC3+pT5g5H/ypLl18S5ZaF0aQZNpc+hiVcbokeUoWzvKXCR+r7Y/6yUb
   wnZuOPaTrz/t842ju8z1g+kyzilVIBzTofTLSbJbbgLZ3UQoTVf8KAhca
   npj35BB8TNvj6UTyuCOsZtC/O7AAcwn1B5iaBvUZ9plty6qvQIfFemsA5
   w==;
X-CSE-ConnectionGUID: 5PPHXyeSRKqbIKqpMBKzhQ==
X-CSE-MsgGUID: PnfuuJWfTimtnAHzKVFarA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77664717"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77664717"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:09:07 -0700
X-CSE-ConnectionGUID: fjM2gdKWR9eNgwZD5Z38eQ==
X-CSE-MsgGUID: LjAD8xsKRN6CT5YLUknGHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="225777795"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:08:59 -0700
Date: Wed, 22 Apr 2026 10:08:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, linux@armlinux.org.uk,
	tsbogend@alpha.franken.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, 3chas3@gmail.com,
	razor@blackwall.org, idosch@nvidia.com, jani.nikula@intel.com,
	mchehab+huawei@kernel.org, tytso@mit.edu,
	herbert@gondor.apana.org.au, geert@linux-m68k.org,
	ebiggers@kernel.org, johannes.berg@intel.com,
	jonathan.cameron@huawei.com, kees@kernel.org, kuniyu@google.com,
	fourier.thomas@gmail.com, rdunlap@infradead.org,
	akpm@linux-foundation.org, linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	bridge@lists.linux.dev, dwmw2@infradead.org
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
Message-ID: <aeh0CV3UQw1quCXv@ashevche-desk.local>
References: <20260422041846.2035118-1-kuba@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422041846.2035118-1-kuba@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 09:18:44PM -0700, Jakub Kicinski wrote:
> Remove the ATM protocol modules and PCI/SBUS ATM device drivers
> that are no longer in active use.
> 
> The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
> drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
> over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
> 
> Removed ATM protocol modules:
>  - net/atm/clip.c - Classical IP over ATM (RFC 2225)
>  - net/atm/lec.c - LAN Emulation Client (LANE)
>  - net/atm/mpc.c, mpoa_caches.c, mpoa_proc.c - Multi-Protocol Over ATM
> 
> Removed PCI/SBUS ATM device drivers (drivers/atm/):
>  - adummy, atmtcp - software/testing ATM devices
>  - eni - Efficient Networks ENI155P (OC-3, ~1995)
>  - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>  - he - ForeRunner HE (OC-3/OC-12, ~2000)
>  - idt77105 - IDT 77105 25 Mbps ATM PHY
>  - idt77252 - IDT 77252 NICStAR II (OC-3, ~2000)
>  - iphase - Interphase ATM PCI (OC-3/DS3/E3)
>  - lanai - Efficient Networks Speedstream 3010
>  - nicstar - IDT 77201 NICStAR (155/25 Mbps, ~1999)
>  - solos-pci - Traverse Technologies ADSL2+ PCI
>  - suni - PMC S/UNI SONET PHY library
> 
> Also clean up references in:
>  - net/bridge/ - remove ATM LANE hook (br_fdb_test_addr_hook,
>    br_fdb_test_addr)
>  - net/core/dev.c - remove br_fdb_test_addr_hook export
>  - defconfig files - remove ATM driver config options
> 
> The removed code is moved to an out-of-tree module package (mod-orphan).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - keep BR2684
>  - correct the claim that Traverse Technologies is defunct,
>    I'm still deleting the solos driver, chances are nobody uses it.
>    Easy enough to revert back in since core is still around.
>    The guiding principle is to keep USB modems and delete
>    the rest as USB ADSL2+ CPEs were most popular historically.
> v1: https://lore.kernel.org/20260421021943.1295109-1-kuba@kernel.org
> 
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: linux@armlinux.org.uk
> CC: tsbogend@alpha.franken.de
> CC: maddy@linux.ibm.com
> CC: mpe@ellerman.id.au
> CC: npiggin@gmail.com
> CC: chleroy@kernel.org
> CC: 3chas3@gmail.com
> CC: razor@blackwall.org
> CC: idosch@nvidia.com
> CC: jani.nikula@intel.com
> CC: mchehab+huawei@kernel.org
> CC: tytso@mit.edu
> CC: herbert@gondor.apana.org.au
> CC: geert@linux-m68k.org
> CC: ebiggers@kernel.org
> CC: johannes.berg@intel.com
> CC: jonathan.cameron@huawei.com
> CC: kees@kernel.org
> CC: kuniyu@google.com
> CC: fourier.thomas@gmail.com
> CC: andriy.shevchenko@intel.com
> CC: rdunlap@infradead.org
> CC: akpm@linux-foundation.org
> CC: linux-doc@vger.kernel.org
> CC: linux-mips@vger.kernel.org
> CC: linuxppc-dev@lists.ozlabs.org
> CC: bridge@lists.linux.dev
> CC: dwmw2@infradead.org
> CC: herbert@gondor.apana.org.au

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

P.S.
Since it's almost removal and it will go via netdev tree (same tree you are
maintaining, I suppose) the -D would have a big help to review the changes
(and not see removals at all, as 32k lines of one email is too much).

-- 
With Best Regards,
Andy Shevchenko



