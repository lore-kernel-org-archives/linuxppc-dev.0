Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3C606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 17:59:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSJf26w54z2xcB;
	Mon, 16 Nov 2026 04:59:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794765546;
	cv=none; b=P6+lAtCL7BaI4aIOHFZYoL3Ptw+CpIaHMzPVFWscIQSP7A0yKqoCzGJlNN6MvwHHhYbxYOm8f34NY3Tt93Yi/b9BiPVmWgjKEUVLFlkvzh/OoXwzILZXvJ2uOCSghs3/pXGhJnCFjTvMPGAblsfNH2silNDgDLOzjD9dZlNTJbKEdWC5uvGraZpIeX/K2zDLDXzYyGklBTAMIQmzpd3BpBf6a4otfaE9GW5V/x9I70uhsMIlZzsf/kZduzdL4zOo/bcbPRfwynIcGi1jdd54gsE33vRdhQGfMsTaFx5GuwbtvtRD32OQX48Gh7XvYvjld1o2R37rcCGuy21dNxYgew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794765546; c=relaxed/relaxed;
	bh=pZAgF01SM5lIexqBmUoxE9oWzEW7iDQOMWgBWjnXcuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsqvnRtwNWKkeMzqWhZpinB8gigUdrf4ZC58vvp1hp8HEvDv890xv/11tr4h/DOfu8i/11V2yXa+Crfn7R1AgZukicZs9KmzS+ZtHlphJkAGzPm1btPlMqpxlSBoau3Pp5tkYNhcXaTfa8BssWUt7wmJH2woJ7Bp0I0wqF0pBlmYOD2m3ICcIPEau577+LqbgOE1gOLPc4/KhpmG0gElP9yd63NtNK7Ou0/h2cKYJObDkiG2w8ZVR3HZY40EOXVKkABPtFueWDYYlXvUC99skMtwZkzcYaeLRJ0sX8pK34UtCkVH+IBKfS9frI8hf4+1oSk345BeYa3L46BlaydhVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.95.204; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.95.204; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 570 seconds by postgrey-1.37 at boromir; Mon, 16 Nov 2026 04:59:05 AEDT
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSJf15Xm8z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 04:59:05 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 2BAD5F62;
	Sun, 15 Nov 2026 18:49:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 14ECF6024661; Sun, 15 Nov 2026 18:49:23 +0100 (CET)
Date: Sun, 15 Nov 2026 18:49:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/7] PCI/DPC: Avoid access to non-existent AER capability
Message-ID: <avnwo7TeDBimPwWG@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <ae05fe2df3a3182594c4a9638daba1c72cf40358.1790531238.git.lukas@wunner.de>
 <74fe0d79-dc90-4c05-ba9c-9a0eec1ada48@linux.intel.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74fe0d79-dc90-4c05-ba9c-9a0eec1ada48@linux.intel.com>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 29, 2026 at 11:49:40AM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> > Downstream Port Containment does not mandate presence of an Advanced Error
> > Reporting capability, so a Downstream Port may support DPC, but not AER
> > (PCIe r7.1 sec 6.2.11.2).
[...]
> > - dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
> >   Non-Fatal Error triggered DPC.  Access the Device Status Register
> >   instead, in accordance with PCIe r7.1 sec 6.2.5.
> 
> This changes behavior not only for AER-incapable ports, but also for
> the AER-capable ones.  PCIe r7.1 sec 7.5.3.5 says for the Fatal/
> Non-Fatal Error Detected bits:
> 
>   "For Functions supporting Advanced Error Handling, errors are logged
>    in this register regardless of the settings of the Uncorrectable
>    Error Mask register."
> 
> The old code only considered unmasked errors, the new code also picks
> up masked ones.  So a masked Fatal error (e.g. Surprise Down) alongside
> the unmasked Non-Fatal error which triggered DPC is now reported as
> Fatal.  Stale bits from earlier masked errors can have the same effect.
> 
> Since this is tagged for stable, how about keeping the AER-based logic
> when dev->aer_cap is present and using DEVSTA only as a fallback?

An excellent observation, I've changed it as you've suggested.
Thanks for the thoughtful review!

Lukas

