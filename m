Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A1606A32F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UHpVSS9c
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSmfP5fDLz3cG8;
	Mon, 16 Nov 2026 23:01:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::446"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794830461;
	cv=none; b=htruvlh3GIOGt1kWzPwzX51tMxBq5mef7riN7A0knaUsJpg0BbhUClQsJFuBa621J9Ipxz5HVMZEgdCB3kf0Lezckxpu4wfoGKdgthvBvIYX9EDZYxFMGy9zhjFsDAJ/LcD1kriffBXgFIg/KTAIAdh6pAzdVZ2sghAnAYN/FN6DmQEehlWl/vLmAkxI9LC6WkgQg68/9W1gv92UI94W1su+1unw0/zqei3Vua0nvqR34eEY2msjxQijE6AtYJCbmBqnqT8abQdy/C3q30KH6hALUa3HT33SAhOF6bcoboBiV1jYqWaarBkpBYWoxujZ/YF99RDOEflVbTSrzLHTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794830461; c=relaxed/relaxed;
	bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I1g1h0c7ek3bGEHpfEU25uBpcNCOuRyHZI4aN6TGrhAIRCg/sYXSkmz9Ujqg0vG0JSkfLQIZEf1VMydfAVJMgdzU+2OHqu18IJ5O9kK5Ior8EB46F8eWMsTbr+k4cstTR4ismSKhYtQF/MZcieE7qwxsWhcIqNOyRuDAgUpob93ceQEnNbDgDy6dDIAXVQjjkg3m+IrtfzR6yBGJwQZQXJhnS8Soz3fZzqk6U5gyiz+3Qwy7HzZJaYk2MxS2idnM+DeGr9Ew/L0TFI1w7qqcmY3B8E7RPgb6VSg4tSMKldHmuVKNgCpD/zoWp1yn094/2+M3yhNR0CbwhvH+5JXMXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UHpVSS9c; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::446; helo=mail-wr1-x446.google.com; envelope-from=3d_d6agkkdkicnkegtajniqqing.eqonkpwzrre-fgxnkuvu.qbncdu.qti@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UHpVSS9c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--aliceryhl.bounces.google.com (client-ip=2a00:1450:4864:20::446; helo=mail-wr1-x446.google.com; envelope-from=3d_d6agkkdkicnkegtajniqqing.eqonkpwzrre-fgxnkuvu.qbncdu.qti@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x446.google.com (mail-wr1-x446.google.com [IPv6:2a00:1450:4864:20::446])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSmfN2Cw1z3cDk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 23:00:59 +1100 (AEDT)
Received: by mail-wr1-x446.google.com with SMTP id ffacd0b85a97d-48e0461e040so2973443f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 04:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794830456; x=1795435256; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=UHpVSS9cnlJh5s4tmJYgQA/CRXayM5CzW2tJvM1HfJnLjCE1UyRvu2tlMJPeEuPTg5
         pLeonrS1tx9uF9k6VXMgp6fY+Y+d2wNQf3/XFHsrENYQbGgGMELq0mMsFU6pLvQ02aCo
         JaJJnq4SMaAHSpclbeIrcaXz51BCbD2E6uktIPntN2mrhw8Du9eOndMM6ijMvH+PmfEG
         PYt2NPDjNtp75VdkB1aSKQhFEh0967qXrhbv4+u5OmEWZT4Ib0zOZPMupyJPAX0RjasZ
         ztlFHUr51rUIKEUg8HxWKKXjn5LhxT5FyQ96gPbiU866bgjvLwAmFJOKbPRDgaElLnJU
         /VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830456; x=1795435256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=pVBhZaDHOagOEMIN/IlcDCX9VPphVFdt+ETVPeCL/3OgBnNQvanp6CcgZXJXF3Fw7f
         72Bso2Jn2gsigFRc+9ttPIdy3Es6XZ6q/rP2uVa/O825/nHkZbhd4fIothcWDU2liy+a
         G26TuQRJTDEcOy/ztYOuukP0y1TWSA1c0X4LJ/hP9OPLvsNl0PJdEI1+VssCwfsA7Uko
         5/qzKgZH1ZAKRaKlgYOfYPw0rNiPk462698Iwn1onl6+ZlIWvb1BfhLaI6BkljSmA9zE
         Wrk6C7t0XUndwwJuc6WAysBDPA8baKkxOKKTOUOjagLCPyrMA3smyi3EEfg9xDfzx82C
         ij7g==
X-Forwarded-Encrypted: i=1; AL+hErFq/E3NWvu6IsdQ2rfcfrBISv3+UJZ2/qetTh8+KCDxjm8ExxwDFnokdo3IFOwcRCDnTOAsHnDmXzIT49w=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+Aiqm0N5A3Xj8gJNFyllfdUcv+Svyyf6xriVNg4NBlzJ0cji0W
	2YF7kcSvU4eXEhXcFolnBfZVjW5+R3+atnPpd2IUa/9gxcuewqGv6NrkxK2MFcT2om5dkpYc6QN
	ZRIpv8KOlk+nSdG91Ug==
X-Received: from wrso13.prod.google.com ([2002:a5d:474d:0:b0:493:3d97:6e88])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e007:0:20b0:48e:3697:708d with SMTP id ffacd0b85a97d-49c70ed8e41mr16698595f8f.12.1794830455230;
 Mon, 16 Nov 2026 04:00:55 -0800 (PST)
Date: Mon, 16 Nov 2026 12:00:53 +0000
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
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
Mime-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116120053.371591-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 12:04:45PM +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

