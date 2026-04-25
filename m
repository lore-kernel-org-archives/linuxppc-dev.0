Return-Path: <linuxppc-dev+bounces-20100-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB41FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2026 10:17:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2m2y2Ft0z2ynZ;
	Sat, 25 Apr 2026 20:16:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777112218;
	cv=none; b=A8BF1s1n2pfPMH2zOM4q6gvh1YRehDqu1z2RxEVC+WYdXNhGhEk/5WG+VyudZZJQmXIn5XQHAPo8hwsgPYGPT3wfuzqcwOZgZbdIxCd26Vn/nCg0VN+4ZNqlwogNtlRwl/EOZAyPygBD7Q2atsudhidqkDJDOkvFDDRsoLIi/gryssltTZCJci87msZOlSzc+ZnmmRnC7EEwXyGoUJKokcN8y/WM3QLyngA5ETgeXupTPjMYtGli1W7SJloz1KoHjbqk2VkVSB32mhw7a/gVfb4HP6ETy44re25BX56LHYOrLPC3VQVHkC+gSIxYB5+EMBdwEWVS/gB2RH/nFiLnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777112218; c=relaxed/relaxed;
	bh=ay27/xgbcRteRj2szFYkH2f2Qgi8oI435FfF5sau420=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c5yA7ie85DK0OzpaskyoHMK2xKMPzZG7UOnwBQ8F2IVp5X6ny1P7ntK1C74f8RIOkLh16yDZfsj4ELufS3dXsXGb5lyhkoX+w1z50CiCWnID4zNCJSU9nXMbW44m7HdkUGeAHQkRAD8jb9OvE46PwUPc3bRqD23HVUZP7bN8o8oTxi4Q09UEN5b1POwb8vdbFgirj9laa64UA0bDj7iT8TNxmdhuNbkk4WGyKZHhJHZmNB1Dn9Sl4vcOhljYGnV4iuDOEFBaTkVn9MWdC/3ZkWrHRQKIhSJHd4ygBRb9+8duInO4+g0URFR5RX99d5bs3bqDr3LscfH9e+2l8GKmBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none (client-ip=78.133.224.34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org) smtp.mailfrom=orcam.me.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=orcam.me.uk (client-ip=78.133.224.34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2m2x0BBGz2ydj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 20:16:55 +1000 (AEST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1C9A99200B3; Sat, 25 Apr 2026 12:16:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 17A9992009D;
	Sat, 25 Apr 2026 11:16:50 +0100 (BST)
Date: Sat, 25 Apr 2026 11:16:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
    edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
    horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
    linux@armlinux.org.uk, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
    chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org, 
    idosch@nvidia.com, jani.nikula@intel.com, mchehab+huawei@kernel.org, 
    tytso@mit.edu, herbert@gondor.apana.org.au, 
    Geert Uytterhoeven <geert@linux-m68k.org>, ebiggers@kernel.org, 
    johannes.berg@intel.com, jonathan.cameron@huawei.com, kees@kernel.org, 
    kuniyu@google.com, fourier.thomas@gmail.com, andriy.shevchenko@intel.com, 
    rdunlap@infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
    linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev, 
    David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
In-Reply-To: <20260422041846.2035118-1-kuba@kernel.org>
Message-ID: <alpine.DEB.2.21.2604251104030.28583@angie.orcam.me.uk>
References: <20260422041846.2035118-1-kuba@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
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
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Apr 2026, Jakub Kicinski wrote:

> Removed PCI/SBUS ATM device drivers (drivers/atm/):
>  - adummy, atmtcp - software/testing ATM devices
>  - eni - Efficient Networks ENI155P (OC-3, ~1995)

 I have one of those though sadly it broke a couple years back and doesn't 
work anymore.

>  - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>  - he - ForeRunner HE (OC-3/OC-12, ~2000)
>  - idt77105 - IDT 77105 25 Mbps ATM PHY
>  - idt77252 - IDT 77252 NICStAR II (OC-3, ~2000)
>  - iphase - Interphase ATM PCI (OC-3/DS3/E3)
>  - lanai - Efficient Networks Speedstream 3010
>  - nicstar - IDT 77201 NICStAR (155/25 Mbps, ~1999)

 And I have a number of these, both 77201 and 77211 variants, scattered 
across several systems of various architectures in my lab.

>  - solos-pci - Traverse Technologies ADSL2+ PCI
>  - suni - PMC S/UNI SONET PHY library

 Plus a bunch of TURBOchannel ATM interfaces, a couple of LightStream ATM 
switches and some Ethernet switches with LANE ports.  Never found time to 
get this all set up, so I guess I can't complain really to see this stuff 
go.  Still sad to see the continuous trend to strip Linux of features. :(

  Maciej

