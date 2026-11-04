Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE67606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW2ZyrP2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK6FM5cDDz2xpv;
	Wed, 04 Nov 2026 11:46:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793753175;
	cv=none; b=eSilmlNWvBFJd31rEZsq/nauf2KFpeBbIdFjktrE2GjG9mK9ZZwUUtdmy3E6tew7rmOiPiHjQ0zxC2ctPcPwulgzPdTR1R0SjT3r0bmWvcAs1Gneh38Xw84wPEgnS4OqzUJMSDJ1X1jbpjV0EukSHy7qmxqxBlR8ASyzU1tkGc2W48qSi2mr8swYWCpaRxatAucsUoQk6MjQJvz8vSRXma2dwN7AXiWYx4it1A5Iz+qkrVlF+rHpdCr10hs+AUg7Ga7z5blditHRBv2QNFiVja5KMwQCwf+/Z9wJjKCubSJ8tzYy9/EdO5G5/9dufUm23Pc19bSQrefN0p/i71ZgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793753175; c=relaxed/relaxed;
	bh=qotwDIV+dwawUH4U9PtLZflu8IFLEqef+DT+z1ntPP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WLAW421gu0Mjj6h0wP85zzZiF6+hGDrmzvcysxgUbdk/iCUA6oCoHWyhzqvDXqvXxZ46i28Rzg6syWCFGESeq9SnjHlBquzRAgGPPnrvdKFQUjXITEJBIg+WTQf+ZhVd4Apvh7ccTi0120Wh58grpfSokIlJ3B9inSuk2WBjtVV6XLzj4+Kd+BFMdvL+aLsJPtrzaB1Plx0XiDwS/dsH0aMOMxmP/LMchcir6/NwpjRIcaYuCntDSNeQvi9bAtGjCduhKW61O+GWkaFyPfjDz4IhndVzssg3LDgFFOvs3sRFlhCC+Ao59Pu8wcYBMdGasPZpGou5uWHF0ry260Q4LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW2ZyrP2; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW2ZyrP2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK6FL26D2z2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 11:46:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EF63C60D82;
	Wed,  4 Nov 2026 00:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C1B1F000C1;
	Wed,  4 Nov 2026 00:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793753170;
	bh=qotwDIV+dwawUH4U9PtLZflu8IFLEqef+DT+z1ntPP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=YW2ZyrP2jAETL09SS7CObYbWB2IReAHHxNvB4BBaEfkJHs5+00wllPtJkfcta+9DS
	 ngTWktlv/14hH+cm10zxyvcjyZ6Anj04x2yXZ88/pefNyaqP3ExFKIpwr5YJl5zQcH
	 oZNTC25/eZkOcQFV1NjrnSsKBvlVV/aJXjfdHs3tpSTeDHgpS09jibEBqiU86/kYjd
	 oGIRzICBOX8bPQQTILKGonEQkgtYg2L+DaoirtqCLTBOmGQnAWWodIqsjqVKkzp/GC
	 aPq0ZLuPdxwbNoZj+d0roZcXy7+RjptQtm9j8i/LGlv84rRAfepM2XLPjWsvWmabiD
	 K19WyAoYkJ4wg==
Date: Tue, 3 Nov 2026 18:46:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH 2/2] PCI/AER: Check validity of Error Source ID register
Message-ID: <20261104004609.GA1167435@bhelgaas>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97e38070-1ad1-74d3-3b60-7fd2ead00c42@linux.intel.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 02:57:58PM +0200, Ilpo Järvinen wrote:
> On Tue, 3 Nov 2026, Lukas Wunner wrote:
> 
> > Certain Intel and AMD Root Ports are known to populate the Error Source ID
> > register with an invalid value.  The AER driver seeks to recognize such
> > buggy silicon by assuming invalidity if the bus number is zero.  It then
> > searches for the error-signaling device in the hierarchy below the Root
> > Port.  This was introduced by commit 28eb27cf0839 ("PCI AER: support
> > invalid error source IDs").
> > 
> > Alex has provided dmesg output which shows an invalid Error Source ID with
> > a non-zero bus number.  The AER driver's heuristic fails to recognize its
> > invalidity:
> > 
> >   pcieport 0000:00:07.1: AER: Correctable Error message received from 0000:01:00.0 (no details found)
> > 
> > The Root Port at 0000:00:07.1 has subordinate bus 04, so an error source

I always think "subordinate" is just slightly ambiguous because it's
used for both "anything below this bridge" and the more specific
"Subordinate Bus Number" (the highest numbered bus below the bridge).

It's perfectly accurate as-is especially because in this case it looks
like Secondary Bus Number and Subordinate Bus Number are *both* 04 for
00:07.1.  But "secondary bus 04" seems less ambiguous to me.

> > on bus 01 is obviously invalid.  The range of subordinate buses is cached
> > and checking against it is cheap.
> ...

> > +	return root->subordinate->busn_res.start <= PCI_BUS_NUM(id) &&
> > +	       root->subordinate->busn_res.end   >= PCI_BUS_NUM(id);
> 
> I kind of hate the order of this logic. I understand you're probably 
> doing it for the alignment which has some value but...
> 
> ...For me, the more logical order would be to keep these in increasing 
> order even if doing it results in losing the alignment:
> 
>    start <= val &&
>    val <= end
> 
> Maybe that's just me and it's not an end of the world either way.

I agree, I think "start <= val && val <= end" is more readable, though
not quite as pretty.

