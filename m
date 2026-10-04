Return-Path: <linuxppc-dev+bounces-28877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFE2CA5FE6
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 11:54:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyLY60K6Tz30Sx;
	Sun, 04 Oct 2026 22:54:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791111092;
	cv=none; b=AdyEb5lmwLBaxcmfVh5Fxncn8O1Y7GJjlJqc8h98xfSKtzn+NnhDgtbxGg2G5/+Ky3qwAFErGZs9IwvJHaXcC+2qFhbVusL09Ox11fnCv7nUhvtlK88u7CqL8kvoFuQFce5XNej2c3IGq/2MGoJ0xlmuGH3adEleFIVwtuglGHOBBFByGnL5o46byaK5koKYC018nXWVGifD5iO1Jb1tCbk8hPnMhRwRKKPRkxLBw5QbYFlJb8uhND6RRwYBGkyokJO8qEZpQugeK6Ek69xJpJFhBI63jQ4TxmGvN4ZsLAqI1j3ikbDKuuOpsMEei486nWOvrzOtaRpDocC5gxK/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791111092; c=relaxed/relaxed;
	bh=OU10JUkOnCjExkP9pLJslSiL15VSpV7uAw3VaBnuTMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3vfYHhN0mID6IfP7iQAKVEIYkjEvwvD8AAZ9mloo6DGoYVtusbvxHVj0XWCCEI9zC5ZySdH8tAdYsQeZuhMBOyJDIYNw2+9kUS/SufZP/pViOi500aRXKe/cjFvi7bvq6PdYSV+QhvIas/FCZjX5FNwgwWfmqtVQkqAQ7t2wDkDte72CeLVE5P7OWh6kDIGfu2QRoO/Te1+EF77kXhnFUDJZMnhGlB1boSU0xRvu7uToerQYdQh3IRZP4TrOOxszQgFmGVOEJWYKWsqFAHsFBwCrYDX9Yx3HcNwfXn6AZwkI/npZOr5zI7hkYXdDzdORvGd9VBKZgLrLAAAif1ENg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aH0caraf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=anshumantewari123@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aH0caraf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=anshumantewari123@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyK830lBTz30RN
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 21:51:29 +1100 (AEDT)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-34b1743e9c7so736112eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791111087; x=1791715887; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OU10JUkOnCjExkP9pLJslSiL15VSpV7uAw3VaBnuTMo=;
        b=aH0carafeEiH+t/ZQcfmiS12Gr4DcyR6lmWSbcyqAckPNIiRiAB4CQ4VlcOMAFpbXd
         ZMkKU2WovMBYr3gGOF9VXlVs7tV2D/v4TNs4YV4VdP8KcGh6KgmIxTGFOCXKL7aLw0gC
         RyzG8Rvi6kUaigUnpkNJ+b072ffnOkMa4pIYuvN2Q9sQ4L1W+YVoa9roe0BdiZiJJcLZ
         dJPnA5WJzMz/Cuv3JTDccex7ScMrIcisp5Q4UtV8Ym/23vctDBYsnBEdGzOuaOzuYYem
         QaAp2Pm0JVAVKRYSQzrihxGfVYqahP/8CAmZ7w+3rFZ/kWiO69bJ1WsoewivvbyxuHc4
         FgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791111087; x=1791715887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OU10JUkOnCjExkP9pLJslSiL15VSpV7uAw3VaBnuTMo=;
        b=s8a6E5naKZ3Kd86Y1B0BzDWafMny9AhF31AFhaWsHM7XZ7EhYu/Y/wdta06AGo3am1
         bKBZHmwTgOikU+ORywF+zhnblGPoeEBs1KT0V2zM2xwnO9ZCxCRZP6p89yzjcjhQq1Vl
         QS9OHFP8qy1Vl2TjCOqglXgDRwLl5pQG1VG7eFuHKVj64U+o4p559Aegq9drE3NepyH7
         vl3RP/ab06NriKqXeOQqDZmJRxZj0TxUrV0WvxfVqEkiIQxnlYEH51/CtlHc53wWefOi
         ifpJ0h4CsifjsIDxIYCur0jxo/AwwNr0LWVARTd8jCfZvT+3t7xYlTsviO0scZUg7pNb
         4wdw==
X-Forwarded-Encrypted: i=1; AKwUvBxTALz7GKJ2wuKS0l30Ypov6lbSfMVovKEuAnOMCT+sgYayLow/NAaZdGgpWmqF7nRWENBOa1QvCMxHF88=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIeTk6kPsS8R7CTKtA1fl61zXzVXmvmQzr8ZJT8QjIlZWSDcmYu
	XBdXE/Kswi41P1wceBUA4Aif2v80n30tk1ZjHANb1q3aJn6JKNpBclNZ
X-Gm-Gg: AYBFou1xjB3kDTdtTARRkjj04gda6S+/nAN1eK9jkn7OSVln9MNXQwE3m/svLZFlXKd
	CELfqj9JZv7tObzavucNc8ETBkMZxg5m2gpgBz1yVbn6nvjW8vPuwVnC2KQ9h1mfAto0CXdD1Tz
	J88lIhv5YbAoCU/maFneGk0KpI+6w4J942q2o5++kX5P+Rgit8QUYEy6tewZt2EzzVUlHGMHFIh
	9cAvawh90oyudPdjqw4pC84fDXVLkR1wTvZs3lv/vmoK5luE70v4qepFX6u7CT4inkrci/S/iEG
	zJQU6Ah8ZwwS145i/hSALnvb3mqA0hb2AF2S5b431TcYIUevP4hT0xryYT7R6ShSk1M1uDbu87y
	gTiY2VF0RxtF9vSrcU8+f9q7qC8r6DSPFIvi9icohKfaambnSWCLOa4fnA+0h3s12RE0aH/hz0B
	rxmAMbyrh/s4GefKYHqsgcRwwdLE+khWlfoN3y+DbepEYXxxNmpWTt3XpfP9kqaZucQTu7soJd1
	EL+W7DNIYGu03yLsX3qrHQ7Aax3QlRQEF2EAkQwv0JzwN8=
X-Received: by 2002:a05:7300:e5c2:b0:341:3ca2:de2d with SMTP id 5a478bee46e88-34f15077edfmr9383419eec.6.1791111087081;
        Sun, 04 Oct 2026 03:51:27 -0700 (PDT)
Received: from Anshuman ([123.63.59.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127161474sm3815965eec.13.2026.10.04.03.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 03:51:26 -0700 (PDT)
From: Anshuman <anshumantewari123@gmail.com>
To: kees@kernel.org
Cc: Frank.Li@kernel.org,
	James.Bottomley@HansenPartnership.com,
	airlied@gmail.com,
	akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com,
	anton.ivanov@cambridgegreys.com,
	apparmor@lists.ubuntu.com,
	atomlin@atomlin.com,
	benjamin.berg@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	bvanassche@acm.org,
	corey@minyard.net,
	da.gomez@kernel.org,
	daniel.lezcano@kernel.org,
	dave.hansen@linux.intel.com,
	david.e.box@linux.intel.com,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	dvyukov@google.com,
	elver@google.com,
	eperezma@redhat.com,
	georgia.garcia@canonical.com,
	glider@google.com,
	gor@linux.ibm.com,
	gregkh@linuxfoundation.org,
	hansg@kernel.org,
	hare@suse.de,
	hca@linux.ibm.com,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	jasowang@redhat.com,
	jbaron@akamai.com,
	jgg@ziepe.ca,
	jim.cromie@gmail.com,
	jirislaby@kernel.org,
	jmorris@namei.org,
	johannes@sipsolutions.net,
	john.johansen@canonical.com,
	joonas.lahtinen@linux.intel.com,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	laurent.pinchart@ideasonboard.com,
	lenb@kernel.org,
	leon@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukasz.luba@arm.com,
	macro@orcam.me.uk,
	martin.petersen@oracle.com,
	mcgrof@kernel.org,
	mchehab@kernel.org,
	mingo@redhat.com,
	mst@redhat.com,
	netdev@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	paul@paul-moore.com,
	pbonzini@redhat.com,
	pengpeng@iscas.ac.cn,
	peterz@infradead.org,
	petr.pavlu@suse.com,
	qemu-devel@nongnu.org,
	rafael@kernel.org,
	richard@nod.at,
	rodrigo.vivi@intel.com,
	rui.zhang@intel.com,
	samitolvanen@google.com,
	seanjc@google.com,
	serge@hallyn.com,
	simona@ffwll.ch,
	somlo@cmu.edu,
	srinivas.pandruvada@linux.intel.com,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	tglx@kernel.org,
	tiwei.btw@antgroup.com,
	tursulin@ursulin.net,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev,
	vkoul@kernel.org,
	x86@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's page buffer
Date: Sun,  4 Oct 2026 16:17:41 +0530
Message-ID: <20261004104741.51238-1-anshumantewari123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260521133326.2465264-1-kees@kernel.org>
References: <20260521133326.2465264-1-kees@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> if (!ret)
> 	break;

One question about the truncation behavior here: when an element does
not fully fit in the remaining buffer, this min() can cause only part
of that element to be copied. For example, if the remaining space is
4 bytes and the next element produces "123456789\n", the resulting
output could contain only "1234".

This leaves the reader with no way to distinguish a genuinely short
value from one that was truncated due to the PAGE_SIZE limit, while
the array otherwise still looks like a normal comma-separated list.

Is this partial-element truncation intentional for this patch, or is
the expectation that it gets handled as part of the later seq_buf
conversion? Would it be preferable to avoid copying an element unless
it fits completely, and leave the larger-buffer case to be addressed
later in the series?

