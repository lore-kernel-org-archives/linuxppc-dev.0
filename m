Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB39606A327
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kW3pt4wo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXp8K06k8z2xdb;
	Mon, 23 Nov 2026 12:22:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795396944;
	cv=none; b=KrBxMcGFt5vDynd09x4fz3NBmJONN2tnbgUobrUEIiO1SsMCmHCT/7pxVM59AeITFtR8N0eH0xXhsM9VSczFIhlSLUh53IQX/Xhmvcry4opvuA885v8Wp6ib2/PSq0Alj6pLcejqax3UM87aM92+7e0OAWkLz3lnXIytrxB7MKimOdPdOebT74YM+8DYcKfGf68Ni4ak9orL2qMtAgAdavze8vV5BufS3IDKnybH6QYXArnWd3zsUJvW53GsShcZ51WuCpVDw7/cGhO5UyHQm/KiaQKmwkoomc9FiPS65CFQ7w//EsoUvq31rNgZuoq5loeJYFgbbvK8Ct4cYHp8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795396944; c=relaxed/relaxed;
	bh=2Q8qQWgKcP+xT57roRgQ8IJ3xXja0pQGrqCS2TbAAfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bztsMZSKAvZiwwihLt+7zTcNK77zeF3i48OKtzUr+dSOwUSJVya9buS5EJd+Qm+1i9hpk0NuTD19xKdeumxO7YyEtRziRu9CHue+NkMY/oi/7C/ouzEw4+nmQgAn6CI5l6ILOibOG/nvMfjW1NLpk9WuFkGl/jNe3xLNuPnrLUKcMHqNgFRNjYt8y10st6QpGDWXJjsR8Lj9FKfCjsJHlmkPsEaq9nih9bNSQH0+m///74qB9eGcwQ4o3XqsgZyr12aP16AT+0OQyvgTgIoYfROX3LB5OJ2IpsgkNZGQCp8PlFKMvE07xV0zAvrbEGJLwnncB8gaxtbKYEZR5rCRjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kW3pt4wo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kW3pt4wo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXp8H55xzz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 12:22:22 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so3305574c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 17:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795396940; x=1796001740; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Q8qQWgKcP+xT57roRgQ8IJ3xXja0pQGrqCS2TbAAfE=;
        b=kW3pt4wo9DJaQJM/sHU1KkVZw6wiVPbI6K7HoX66WljBScZ3GDMeV7pmFGyYY4JNhT
         T+qsOQXHFE7qU79tAdF0LwoAsEJr6t0X3VqZPEnoNz1WZls3vIGRWDd24pGQzb3sBVei
         4+ua/vmae9cQNDwZtACOvHygwHlrObmBsKb7O6PH2Ijgb0q59R7ZFd5OIAwLtVdgc1aY
         oBcWwmqxOmA9k7T5jqgqbDjtsjEP8YPqG3aNhjG52XR4d+ot7CSko4/ON6m2bfBLiUb9
         htIs+F2xS+hiVhDWfLTGZB1NYq/xUCz2yAnzt6zL2K/Qovg5YzBROlWSYr7RUrO0L5JK
         eR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795396941; x=1796001741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Q8qQWgKcP+xT57roRgQ8IJ3xXja0pQGrqCS2TbAAfE=;
        b=lmR3fQ434hniyGQ0n9yNw3PugbjSxys58Q4qr9rW4jCwytwxN+8ofKh+nB9AEr9PO1
         EzX8Sq31TKLKkUyzS2TXare+ogNGn+MxxHHO0LHdAo7zFrmvVpDcL0z9m9DlEtthhGqA
         KJTGp5UyMngR7ftSGQHrCvKd1Y2JqLQfjtjno8lLDkDaDlhEahZ8A8jPGrXkRrj0RuFl
         42FvbgxULMZL3Tc8GlTIL6QLYM/HKfKQwd7hZfa2ff2rL3I8hrEIDujh6YemsKirQtC7
         lQP4uT7WBmGgRcJh52fI8BR75HiQReOTmpf1U4KBaTv4D5pqMbM4gtAvDz3rguDed2Bk
         TCPg==
X-Forwarded-Encrypted: i=1; AL+hErGpPZu11Awe1usiUZBiCpBnN+wbVIJQIV2H+OP3gmtkIiC2VD/l713plJ/FxwgVcsPvZqdteZ7BcwXddxo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9OT5hjYwMNY0s+orMBstue2YaqWzDmQNhqlqsRbv8LNbaUFuWl
	pUGLpO8Mzumt5KxLcjLJE3vhmBMNagDibrDxJ4757i+SnRgW9heMdGgU
X-Gm-Gg: AZFdTZd6S9Je8/K0UX+o42VA3jZxSXhmyULDpDW4ONDmgq7hqPdbxVKCnlVy7psD++X
	IlhGQ5jYRF7h3Qa+fhUQr6EqtuL0bg8GY2KrSV1ydhKaxmqxKo67Di/pjHGW9/EnHz1KhnFtTPD
	K+Wsg0ptY/YTWqjr2RsJga5YQyavzpjpYqmcm5+upZRetkUqpjKKBT/h8QlHQc9sjCpW6XnGlOt
	XYJY2e6TDUIRKa4BTaFGo7lP6Am/2AypzU9p79nwheTp/Wd8xtTaRNr5MiHUT4L9P/Lt/boEJPH
	ejYyrh+8PY55k7GkPgS2JObN+GDlBYiRjmL4JrjCsBUjQmSmN3x+V4rxYCXfMeUknsjneQjGi8v
	uR/oq80YhUjCjGXuPdcJ0tIDV2ruF7qjAlQSQhgLGP4tsnESmRJRJ/QWZvNLVe4d6NmrVq1nv4k
	09sw0m2bCkqt1LlKMnAWP9ACjQiO8Ed/FldZEstNgCajRmZTFOqEtKOzboBaHNGzdihDiyxcG7p
	rC0hUVySVucAsSv6YSN1Y5xBe7LFnSUyNeCqr/XVrWBuDC6gjROCyk1ZXCK0i5evYv/y6zTepvj
	YbsL9/cmcibjNq5lj1ldcqlOBVV5/O6Hg1qi+G++LKSDRvgxeyIQYJ2kwu3OY0QKmsM4gtk=
X-Received: by 2002:a05:701a:ccca:20b0:1b5:71bb:6800 with SMTP id a92af1059eb24-1b571bb698bmr1863335c88.3.1795396940552;
        Sun, 22 Nov 2026 17:22:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm22955681c88.2.2026.11.22.17.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 17:22:19 -0800 (PST)
Date: Sun, 22 Nov 2026 17:22:16 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Alfred E . Heggestad" <aeh@db.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, 
	Thomas Reitmayr <treitmayr@devbase.at>, Shaun Jackman <sjackman@gmail.com>, 
	Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, Florian Euchner <florian.euchner@gmail.com>, 
	Johan Hovold <johan@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Xue Lei <Xue.Lei@windriver.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: remove obsolete cm109 USB phone driver
Message-ID: <awOVNaQM8_Hb5E3H@google.com>
References: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
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
In-Reply-To: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 04:16:40PM -0800, Dmitry Torokhov wrote:
> This short series removes the obsolete cm109 driver for mid-2000s USB
> VoIP/Skype handsets based on the C-Media CM109 USB audio and HID
> controller (0x0d8c:0x000e) and drops its module selection from
> ppc6xx_defconfig.
> 
> The driver was written in 2007-2008 (modeled after yealink) to poll a
> 4x4 phone keypad matrix and toggle a buzzer wired to the chip's GPIO
> pins across four phone models (Komunikate KIP1000, Genius G-talk,
> Allied-Telesis Corega USBPH01, and ATCom AU-100), relying on a module
> parameter (phone=...) to choose the keymap. The mid-2000s userspace
> VoIP/Skype bridge ecosystem for these handsets is long defunct, and the
> driver has seen no new hardware support since 2008 while continuing to
> attract syzbot crashes in its custom URB state machine.
> 
> Furthermore, because 0x0d8c:0x000e is the generic default C-Media CM109
> VID:PID and was added to hid_ignore_list[] so cm109 could claim the USB
> interface, cm109 actively interferes with non-phone CM109 devices still
> in use today: amateur radio interfaces (Direwolf, AllStarLink, SVXLink,
> UniPager, Hamlib) have to blacklist cm109 so usbhid can expose
> /dev/hidraw* and so opening the input device does not pulse the GPIO
> pins and key the radio transmitter's PTT line, while standard USB
> headsets with 0x0d8c:0x000e can bind to usbhid directly via the chip's
> standard HID Consumer Page volume and mute descriptors once the
> hid_ignore_list[] entry is dropped.
> 
> Thanks.
> 
> Dmitry Torokhov (2):
>   powerpc/configs: drop CONFIG_INPUT_CM109 from ppc6xx_defconfig
>   Input: cm109 - remove driver

Applied the lot.

-- 
Dmitry

