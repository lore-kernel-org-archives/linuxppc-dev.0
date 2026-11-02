Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF4606A326
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8T78wQi;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8T78wQi;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8T78wQi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJRy15BYZz3c4f;
	Tue, 03 Nov 2026 10:00:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793652869;
	cv=none; b=ePU3QdlyfS+GHE034JkRouo/T9UWpQaFBpD9NXLmyopdyHLmCUQxvHZEunT8TQTeLfS9Ra8BDqx2QsNYirhflboT476kB7FaTvnahwgeg8+CNGA8YNJBM8NEEAg2oUMNO2WqYhiy2uV0jexR6RWV51a26dsl84kZIcgZwM9qG4zdStHouCXdl6+tKtlR1O2/UCy0Znc58+H84IvqMJxHd5aKpQfVR/bGGQmBBA3xhoBoR0no+1ZWw6ctbo5tWChqzf001Po0GAPq32ZEcuxJpkbrIWUSN3rU5o1r2970ea6VWVqAP17eG55ch8w6Le+RpUOrVLWMoAgGX7yyXRK55w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793652869; c=relaxed/relaxed;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUENbFJIbtLXQMePH/3WPdEqlrlACye2IIwE7f2OBngOrp+5VdHNbUbijEz+lSxNzHdKnnUOYfQxz3KwqUKfj/I+s17TxZsUrkx1HoAO1iilVOtVxv/myDZ0hKHwWBf0bgbTxKa5LtysTWMJo8fcgQwd+qTId2INWZvsM4UBkqq5Py9pU80ab7yti9gu9EUBWm00hCTP4lbPY37O8ALjETdIXWs8cxFV5Im+YxjTSPL/d0SrtDSWox8tOfnO+bvOeC/SaDuT6A9BXCfukvaoX16bfhcJBTRiCqdqmbpQoARe+s4aRRpIXVfK3dy2RrOJ8BMb2uvmmQxUKhKkIhtnww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8T78wQi; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8T78wQi; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8T78wQi; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aahringo@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8T78wQi;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8T78wQi;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L8T78wQi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aahringo@redhat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 66 seconds by postgrey-1.37 at boromir; Tue, 03 Nov 2026 07:54:28 AEDT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJP8N11s4z2xb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 07:54:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=L8T78wQivf3NqLICNSI78PhvEv7mIxxYhKJliXqH1IS5vfuwoGBdqTi1uB+JjGFZ4CHb54
	6ZbzR8skJsT8aCgm+Squ5ZT92WSLjikMeBZ4rN5IATGp4OePiCRgu60R88by8FSAjqZWYe
	J0UpUR59lbcKElW4KPGHtArz1Q4VHWU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=L8T78wQivf3NqLICNSI78PhvEv7mIxxYhKJliXqH1IS5vfuwoGBdqTi1uB+JjGFZ4CHb54
	6ZbzR8skJsT8aCgm+Squ5ZT92WSLjikMeBZ4rN5IATGp4OePiCRgu60R88by8FSAjqZWYe
	J0UpUR59lbcKElW4KPGHtArz1Q4VHWU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=L8T78wQivf3NqLICNSI78PhvEv7mIxxYhKJliXqH1IS5vfuwoGBdqTi1uB+JjGFZ4CHb54
	6ZbzR8skJsT8aCgm+Squ5ZT92WSLjikMeBZ4rN5IATGp4OePiCRgu60R88by8FSAjqZWYe
	J0UpUR59lbcKElW4KPGHtArz1Q4VHWU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-EgdrIUwuPaSkdx2IVo06ag-1; Mon, 02 Nov 2026 15:53:10 -0500
X-MC-Unique: EgdrIUwuPaSkdx2IVo06ag-1
X-Mimecast-MFC-AGG-ID: EgdrIUwuPaSkdx2IVo06ag_1793652789
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3ab3fc6e459so290221fa.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 12:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652788; x=1794257588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=MKmKFc4qU6AzV00TAEMiyxbwQhXTK5ES9o/b4ic5EPvHMTkcZoJ5Mf+GzUBY3K0c/I
         kV2eGUpfyGKhep49AE56HelkL9tqEhiYGawUflXIfeW3Zo9hS2JcpKDCAm2mX8fzTzUO
         EmjnwVLsxgZX1eMAlUudwL2cX1nKl8rJm2HirjiLKQr8bAQc6A9DriBeSC0InUYYgXEY
         jdJT11aA6821yDz/JWczY+8WyDQrZMXTXUcUMJlS0mvoeHnlWnHguxZqCl4ONYQ6GMUl
         x5vj5BZfaQdzPCMPnW70++M37icKnLGqcRez/uF7e10XbE5llFnYrD6lKE2ZyQJruwK8
         PbrA==
X-Forwarded-Encrypted: i=1; AKwUvBxdup6VnXrqBM4uD72TR74RLMuDk68LVWRy6u1982bPksfVOHAOYV4U4eMcSw4ot+YAOarlaOwj2CjjIrs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8oi/replbjE5vvQpc8E2twiMcNHDyZ7N5fmIsCw2uOaxqUoFZ8
	g1ZxRTxD4ZpvwHNCnOcW0dYAcmclp+Gku6wgWpyKSWD9i13dRmIRXXDse6mNgmE6YXpNhLkq9No
	nEctBjBOz+JY6QBVzNOousO+EpC3BXmTLF99Yon2nsIu36QFOkpNBQx9Ng5B3WzieKPfBy1F2v9
	1hqu3I+ax4ltSHyf66+fKRRZtKGU7d68l0b16klAH8Fg==
X-Gm-Gg: AYBFou3xW+lhdkhN8kucmFCcYzHfRqQI2ytJLEvAhlj4HG79ydS9/1xx74LezfWHPha
	VMxtPu8XuRBdYCMWMsY9q9obIPjOJ6DinyIFt8+C8C439wy+o2yQo6WC4+tqVyT/Lf1+lLQyUVU
	8oghlSXEXiexjCI2/i7DOWjwLc5aTB3jtFg4EpJ18d/D07crHUHrByRU3x
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id 38308e7fff4ca-3acb7aa83b1mr20499381fa.13.1793652788457;
        Mon, 02 Nov 2026 12:53:08 -0800 (PST)
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id
 38308e7fff4ca-3acb7aa83b1mr20499011fa.13.1793652787872; Mon, 02 Nov 2026
 12:53:07 -0800 (PST)
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
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-6-irogers@google.com>
In-Reply-To: <20261027223847.652884-6-irogers@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:52:55 -0500
X-Gm-Features: AclHuK8pGzNf4aGPekLa6NQcs521xOugw8djA3E8ZMCjZ7yn89XzG5j_wIaQNFk
Message-ID: <CAK-6q+j-MS_5St04YFU11LG_Cjf1jOuS3q33qk_iK=7TE-iuBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WO3gsF3MnFOTSL9kpKxuIv34Kbs7BOtZfK3QoMXxuCw_1793652789
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, Oct 27, 2026 at 6:39=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Signed-off-by: Ian Rogers <irogers@google.com>

A somewhat "big change" for just a debug functionality. Althrough I
agree we shout call "kobject_del()" early to avoid additional sysfs
changes during removal.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex


