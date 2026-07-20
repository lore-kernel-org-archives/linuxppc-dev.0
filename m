Return-Path: <linuxppc-dev+bounces-24486-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8E4C44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:32:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3fz23Bfqz2y8F;
	Mon, 20 Jul 2026 22:31:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.227.64.183
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784550718;
	cv=none; b=e4v4iR6vYTmC/G8g+d6GJ8V2A4J/XJPhIN/AiV9y7LA/oVeCtZL3dVNrd3zzMt5ZMPIgJNbBImEBq81zsuheY3k0xpgBPm5Vl97v4XvvcZ3u1Av5eoklH6+8IVKHpgas6T5hWZv/JGM6R51nnUuD02rRSds6Zq8ME53IYCgTdFCv9rZTLBgRDlLMJhKBPgMfbBSDrDOB4ew205t+AAfmD9OqcNfm0zQkHKY2BjYHizsviGtmtVdtq2hsVrdZsrKwaJBKgiaauIicLLkQ/DoIn6FpDrOmvCFo0HAuDd7aq3df6XmYk1lTIqRdGyuWioKA35IItO2LiTXpUAb9/LSnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784550718; c=relaxed/relaxed;
	bh=4h7lrIf9PRDMtbnlndZvMTQVVwXKsC+4scb8WpCIpuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTGb+wRHOlDf2BhtU8HmxddPw0ON66HB1eDF3GORmxierptqkFC3Mg0Sn0+bTnnVLqlOEZH6WeAg4MGfa8JT9CV1u11lZmnj3qAKFqXAhSkTwID2Msv8RiLSDZxKpN4tZVpsmPUq4iWiXEzAeIiE1eCQ2OOaL9QW8vN+t+yIIJDpTmlg1zZUimxPw0mreDPxZLBQViXRPKNBGXEZureHP31ufUKip9uTkOpLCklbPRJFm0WpdhadbBvAnF/7XkXD7uJz7qI293HwaZkUm3Q+PkMtU7KaLfFtE8AOgY3JXSdqDP2Jb9mld2JqwIBOUPgARL3zUydfZg/zfFhe0KWL5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; dkim=pass (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.a=rsa-sha256 header.s=1 header.b=rOiZ/TDN; dkim-atps=neutral; spf=pass (client-ip=91.227.64.183; helo=rere.qmqm.pl; envelope-from=mirq-linux@rere.qmqm.pl; receiver=lists.ozlabs.org) smtp.mailfrom=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.a=rsa-sha256 header.s=1 header.b=rOiZ/TDN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rere.qmqm.pl (client-ip=91.227.64.183; helo=rere.qmqm.pl; envelope-from=mirq-linux@rere.qmqm.pl; receiver=lists.ozlabs.org)
X-Greylist: delayed 584 seconds by postgrey-1.37 at boromir; Mon, 20 Jul 2026 22:31:54 AEST
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3fyy6rHxz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 22:31:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1784550093; bh=mpzeQFeBiZtBhhEHtYlPNFCKYBTEvp7YO2yAx1Er92o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOiZ/TDNVYhrYWlHPrF4vSoQjuhgrl8oQCOhNZSl/8jcZyMJSJYa+irgnfSe/G2d9
	 K0KssMuPsJtQHjl3muCZi3beTLlP600jcWK89EtM8k1svtVJGpUIYPf0siKsMeRpo3
	 ae96Id6W9cEOn3Z+6MCMOTuxeM/XrhjZCb9sjN48tkyp2F+aSFyKJJ/pwzJz/34Xs3
	 +TYnMljB8pAgRmY7z/O5i3pehQvoDmUQHonI8wLwWHPgCHg6KbXZL3VyT2STE2XvAu
	 aB+9UFWdtSBrBnqvMj+JzTLfZzzxhfHKocZaenXaUVgtu91NQC1wqyCulC5+k6t2/h
	 ApXF3UxNlgudA==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4h3fkz14Dpz3C;
	Mon, 20 Jul 2026 14:21:31 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Mon, 20 Jul 2026 14:21:29 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Uwe =?iso-8859-2?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Keng-Yu Lin <keng-yu.lin@hpe.com>,
	"Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Alexander Graf <graf@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?iso-8859-2?Q?Wilczy=F1ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Akshay Gupta <Akshay.Gupta@amd.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 12/12] misc: Unify code style for various *_device_id
 arrays
Message-ID: <al4SyY2G8eD5O9Ms@qmqm.qmqm.pl>
References: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
 <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>
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
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>

On Fri, Jul 17, 2026 at 04:50:58PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
>  - Add a trailing comma for initializers unless the closing brace is on
>    the same line and for the list terminator;
>  - Use a single space in the list terminator;
>  - A space after an opening { and before a closing };
>  - Use the PCI_DEVICE* macro in two drivers for pci_device_id entry
>    which is usual for these arrays
>  - No explicit zeros in the list terminator;
> 
> None of these changes introduces changes to the compiled result.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
...
>  drivers/misc/cb710/core.c                     |   5 +-

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

