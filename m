Return-Path: <linuxppc-dev+bounces-21143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1256CD4F57
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 10:00:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKVXT6jHFz2yLB;
	Tue, 19 May 2026 20:00:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779184809;
	cv=none; b=jttMytGs41xFdQaZM60G1fMjvZhWvGK4fmyvgUEVVhjkQdBa2J0++6e6WqbpDIDxkxVbbnZjjeao9Y0LA0d6mdibut3QQv0u6U+jZsS+pnrvBTatNJegZGQehO3ghgo6cFs8cVFlG9C02Cq/AzqUbcDmev1O1bgBOd8wEbVnkcSMQrJZH3LjF0Lr/xrdgYHSzsCaz1owTE9YdHQ79vedjGoQZhWPp6rF5PQd7i6oIw+dBV7W7Hhra8dZPzp8FaK43cL8PQLvpQoytjmE/RkkvzdPKyb4+x81cd3iNH7YuR7EsC+sIW0m9CgyEnY+o8iclCXSnkumkQ4/I64FW+bk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779184809; c=relaxed/relaxed;
	bh=D7gzXatEuLuyksiod5dcl5AyLyjpiFbV5vaCOP1//zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q27RFcygxuczfxYG2d/3yTuruIv9Rm+fy01nH7lH9MnZW+sdpyNWILlBX2vhf3blols2c6BsVodOFrCUXMquYr+ViDg6XgvyoOzaeIE5KTxtJLB4j2rlSpqnbcSUrVlffMOENUywethxsfaxKUYg/EI+8CA/3HXq35UNjFoO6ZHRqtOWRME0qFKaZ5RjniJaJzvZihQu7Tvj+vvL2oQIFdEWtZkVIvI1T6gH9DLY5SCt5jV8sN01Tk147G+ZGrsvKkbS9i6/B6YuCsvKyaUjr5EJMg3++Ns2VKRSH8sACxa3OxwS9PR93RZKzPOKVauyvXw7I3Y9cBjpoFSMxMsAMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 384 seconds by postgrey-1.37 at boromir; Tue, 19 May 2026 20:00:07 AEST
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKVXR57Pnz3btP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 20:00:07 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 9BF5935C;
	Tue, 19 May 2026 11:53:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 75CC560B03E9; Tue, 19 May 2026 11:53:35 +0200 (CEST)
Date: Tue, 19 May 2026 11:53:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Yury Murashka <yurypm@arista.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
Message-ID: <agwzHzF3bpPM6jcC@wunner.de>
References: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
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
In-Reply-To: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>

On Mon, May 18, 2026 at 02:23:36PM +0100, Yury Murashka wrote:
> pci_aer_clear_nonfatal_status() is not called when AER recovery fails.
> If a new AER error is subsequently reported, the AER driver calls
> find_source_device() to find the source of the error. It rescans the
> whole bus and picks the first device reporting an AER error. Because the
> previous error was never cleared, the error is attributed to the wrong
> device and AER recovery is started for the wrong device.

I guess the rationale of the current behavior is that the devices
affected by the failed error recovery are basically in a broken
state once error recovery failed and so user intervention is
required, e.g. a remove/rescan via sysfs.

My question is, why is error recovery failing for the devices
in the first place?

And what does the hierarchy look like?
(lspci -tv and lspci -vvv output please)

I also don't quite follow your assertion that (only) the first device
reporting an error is picked.  The algorithm tries to collect *all*
error-reporting devices in the affected portion of the hierarchy.

Thanks,

Lukas

