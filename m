Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B1606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jP8hgk9r
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXp2P5k52z2xdb;
	Mon, 23 Nov 2026 12:17:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795396637;
	cv=none; b=bt6UfkIZcArmVaGZNRHeEHE6/xsliM/w3NjD+ypwnRT1Xd55WfQl3UoRPYit10ivx3ZmSiY4Q6c4OdRl9eb7uHqQ97/knRQu/Yp2k5oLbd1C39PqMiI/EWAGxCemvX2sBEC9u/EyRJ0PTobyoSImLv74pHc30u9SRX+qgjvnSokSS6jTASrCFb8mE2DQLAiIhY/uMVp4tJjWcIrDaKyNeOAcNa9Y3MNtjxj6EZnwi+7UNOmxwnV0C8nPkK6FtqqRYky136rA6qQMWJgReeFH8g3lZw5R/RmsOvX/G8sicnS6xEg0w2fnnX+doY/ImZPrBnBBpdaG9GOPHR3XL9bgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795396637; c=relaxed/relaxed;
	bh=7UgZ/UaOfprcYE1+TJLcwuO2nl1zM9v7WpMLhsF+tYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0rM3qrk9GFdWuo2T5ru3A415MG4bpf5cHCs5hypAqwUErProivPo26q/56ZvUgLdtEydwT9FsaNL1NsP63wOW+XsxUld98557KJ+5L5emp4TmlgbzxdyOTkiSaJ1GvAMg17tllJY1YMXHWwpyIkuzx5CYB/aeuDIIbRoLQq4uFdXkL+BTvkGGhh5REODA/SdgiXp6YmARDA6UD/zvf1TC9nkLuBrjLmFw4NdnLdCMMhDX06JmERkPWHXisojTNcDevWdd5XCd2UHZxOMe7yzELA9CF9qilmcwgtg2IFidnNsR1h/zHKNJqRC5KttTyjHR+vig0cvoS2S3tX6Yo5yA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jP8hgk9r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jP8hgk9r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com [IPv6:2607:f8b0:4864:20::1233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXp2N31Nfz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 12:17:15 +1100 (AEDT)
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1b546061d58so6280291c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 17:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795396632; x=1796001432; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7UgZ/UaOfprcYE1+TJLcwuO2nl1zM9v7WpMLhsF+tYU=;
        b=jP8hgk9r7JZ52kR/DaKhp052N3FeYtabmy6sCw8dgRKLlUHfkbJAyVlvE65DNmNK67
         Bh8puos5mI0PPMR4ugPrmKsTYOQmm4SIGbuj3CE5Re/ZVFzgZr3s+S7i2Uf8E1EbRGGf
         JkGYfcWC0mrpOqCYcBBAgbyJxxJa6uO7b0MPbOpfDAAWTFWcvLttmuQWUW+OxLwVihF2
         b8qxi/ntJR/+UCzftkLX4kM5LNvAbCKMvBfuYL3HmRDdbkhcQV/fFJHMMtl9qk/odUbx
         Hkd3mALjVkRwZGXbUEpYVhm63uRjeBwuDMVbYKqant2Sb/aPXWmdlxygn4AjVHJVqY7O
         4OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795396632; x=1796001432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7UgZ/UaOfprcYE1+TJLcwuO2nl1zM9v7WpMLhsF+tYU=;
        b=Ql2I697sDLBRu8JQRVaSqi5skHV0hbB6OITuda6HX4aACVmyVKTwopxQHn4e7sIRGk
         q7imnDp1Pu77E8fUcOl1D30PQjAORued3xgwK1/Nof3h8cBSvmV0BVM+HoYUOFczh9ET
         J1yKnYIIDo/T4gm2/fqWBPcNL8v53NAKr82lqg+3wS2+Ij85P5gUoNRY1MdG7TVRTxix
         JOy3XAq1rDWtKNl8tABdF52Ecm9giJQh4n3605xMWUhxJuhfNcyLhqOzWxRbFlLISWaE
         s74MfBit23xwELDUE4IF78hdCRRh53Pt3x3bseMdIoyPHoDJ1S888Fhmqgx70JZDqG4e
         2ZmA==
X-Forwarded-Encrypted: i=1; AL+hErG2IiIxKgOUBE0QUsF9uwrEXpAr4esObm0QjysMTT2PGR5JYkNDXXj9XNSiW0kk/snAbmOt6qvpFji8EIU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9/1KSthSZ+FlKqp4JanihcJpsG2CWroPFOo0MBFa3ynEjY7FiW
	hOBAbyi+rHBao9RpCZeihKfyEJGQHbgylA4dwwfj1oZotIg6ToV1Q7b6
X-Gm-Gg: AZFdTZdIEIhjojePHw09lmXZgXwhIDLPiWBvyXMXKXOgC8Mj7EmCBi48GKc09vuMuE3
	bB58xy1ce11NhtNpK2OAR2HPZzqENeuaJCwr++TgDdqetO1Qh7j8CNzsUGLLDx9ecwdgncxTlvY
	gNtVNNUuOHfsdlv6jcTYsE+81WD7qSJg+PLd00399+fACIOukUNigGAIOlE3K67jlmTWZVYg3OF
	1VkXwCoNalKMHtHejuIfnx1sWdX2Ic5osk0jhlIxdjBk5T/jxl14aTGflMpe2vAqs9k4jmOBt+4
	IZJ9a27Mpt3tNO72oHjoGVTorozmzn9J8m/J/CG08HvAaMYs0tCAQ00yCJVwHFfK6wIk8JV++Yj
	EGcgNrDmWVFMtlQaoRPs9WqU374YdwBkvuNECq+It0PTFhADjEX+dn8a8KFwoWrA8//NfbgzmVm
	LqiYN9wEO/KNzpQ8udPva6a7eMfwIrfPcHmiWmBgqK1ypiqc5ECxfJI6axLKygQoDkppKbTAYI9
	AH+LH1Sq5JLlUajHFzNdH9EcGjB21m0q3TxC0SwBR3RCsoFU2zOViVah/OaK7L1xIXcbMvwIi5r
	YBMPFSuxWp/6KyVjhJEAToKgn+gmrBbirRSfoBq19WlQNz6GJEh2GmWut9NrpyORwFEYyhY=
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id a92af1059eb24-1b5568ba440mr16998658c88.17.1795396632411;
        Sun, 22 Nov 2026 17:17:12 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm23764321c88.1.2026.11.22.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 17:17:11 -0800 (PST)
Date: Sun, 22 Nov 2026 17:17:07 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, Martin Diehl <m-diehl@gmx.de>, 
	"Alfred E . Heggestad" <aeh@db.org>, Thomas Reitmayr <treitmayr@devbase.at>, 
	Slawomir Stepien <sst@poczta.fm>, Jie Wang <jie.wang@intel.com>, 
	Manuel Ebner <manuelebnerli@mailbox.org>, Randy Dunlap <rdunlap@infradead.org>, usbb2k-api-dev@nongnu.org, 
	linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: remove obsolete yealink USB phone driver
Message-ID: <awOT9WG0ZdNkIm69@google.com>
References: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
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
In-Reply-To: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 01:57:21PM -0800, Dmitry Torokhov wrote:
> This short series removes the obsolete yealink driver for the mid-2000s
> Yealink USB-P1K (0x6993:0xb001) USB 1.1 Skype/VoIP telephone handset
> and drops its module selection from ppc6xx_defconfig.
> 
> The hardware relied on dedicated userspace bridge utilities (such as
> usbb2k-api / kb2kskype for the defunct legacy Skype desktop API, or
> yeaphone for liblinphone) to drive its keypad, segmented LCD, and tones
> through custom sysfs attributes. That userspace ecosystem has been
> unmaintained for over 15 years, and the driver itself has seen no
> functional updates, hardware testing, or new device IDs since 2008
> while continuing to attract syzbot USB fuzzing reports and drive-by
> cleanup patches.
> 
> Thanks.
> 
> Dmitry Torokhov (2):
>   powerpc/configs: drop CONFIG_INPUT_YEALINK from ppc6xx_defconfig
>   Input: yealink - remove driver

Applied the lot.

-- 
Dmitry

