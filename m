Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E0606A32C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=AoCACtb7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLJ6M5S3Xz2xKx;
	Fri, 06 Nov 2026 10:14:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::533" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793920459;
	cv=pass; b=e+kcTPqufLuDcTRS5S5buqvU2sdcrmpRwrEp5zGplwsQCvtbzvHJ45cpF0jNSGpNB3himjGqhgMZBmqZexhbnv2hM2MVhA3lFw7DSOzcI9zWWjvMLqeOvsj+Xitk2TPglBh/Ihh5cHyUevgeIbCo4tM9jXQgWHiy+heiHHoli5EEUApwToVBG3AKi3YUcrUXlWFvG3naro4wpZ3vDrIYQGidtqhe+ECqPYD6ZvEZK0rOl4Hdy87n4YxFgZRGORTQNgD0WA4Ca6NXbF0lHqtD1MTVlKUvwrOIwyEULd++CFfqO1EvTEMePc6gb6lUs3W6YR+By+rrwEi/lmD0mxbilQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793920459; c=relaxed/relaxed;
	bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a43Z8B/oyVPhzT1HdK/s23EJ82Z5BEZQqt0wm0rmE/THE4QIqrMVa4SUcoRlbxRpzx9+LxAebu5CFZOwgNyOOoaFos6SFlj1JHi2VEyarqZGK37iSroEkd0e80cgFIJgFqIAlxx11QFIZaiTkNnJnJw5VkQICxX3CIUiYPNySEOqiKrGd3IKG+ndawDpPEUzCW53R+tjOCDQgRKNzhPXdX1FyTQkCqi/IzYxFGCe/AvG2B1Tu4VA/UEJp2aNi224ZErEoj2qm9WgG/zLARmJpbHyl+VBnKCsZb6KsFS4U8I8hTdeSYF9w0nCxzwiwQ3I3C2hxSDPCbvKN+0IYv3Hmg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=AoCACtb7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=AoCACtb7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLJ6L6m53z2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 10:14:18 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso25700a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 15:14:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920456; cv=none;
        d=google.com; s=arc-20260327;
        b=HezyUAuYF1JMaq92ykfvS/vr44cnu45KxDjiNCZswIgPHbFyKsWUSE1NleMv9uhom6
         iyOCbbmDsgeMHwQSdGvsnYZSm2leKXKd4ogYm7hRNamVM27owVETtf59EYRrzr/Ih90B
         RgoCiI7nq6VvdqFDDpnng8XNJ7C0lYIPvTKwZicWrtiQARlExFIR/9aG+O8/6CazibpD
         /Py2wYNhNAafcifeFzPLLrIuDwcYo7WepZgZATOX3sNa8Ej6OWT0Rmxhw7rZjRKH1g/Y
         FaTOe/evH0ecGg9GWeQ96tRP36o+xRXePQ2Rc0aPlavyfdCURSxyyjdessQwxVM+T6It
         HA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        fh=kLowOwsmzSSXMZx0xSHrLUG/nfk4+fS/rFjHHJR9CRg=;
        b=czRkSOeVs4Nsm7E4SJo0OVxzBVDHCR/sf1NrTcFpjwRccxTNufR5qBw9bkf44FMGbG
         1fgHrCijxoIZRvrYQ/VRVg19IuoseuDEDE+O22Y6JoWjFJYqT5+YLiPaQM+ArA0VXcIP
         FiyNM24qo88A3LaQfzdjWdyw9EzH6UcZfRYIjn8OeM9+Tej1n/9P3r4NgqCpOwbqAZuI
         IXDeQB6UCb7Y7RH55lZWC6zXgSrRs0YRKY7RiOOZjNKllCfZlOMY+SmU+dI2nKdiKW3W
         tx/zVGvohEK6Ae/0ZA5DcO7/c+TyHWRnvoaNjhOStx4TC9OR2j5y2Y1EFHuco2vfcArF
         TQMA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920456; x=1794525256; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=AoCACtb7tXEVlMa3AfVjoh6GG2UagPSYNuEU50lil9ChBzkaqfYlxX5+y5WchUd1d5
         MQoGODWUmL44O2RWgkMJTDDX/AwnYHejo5V9MhvzMPF9Pz2HqFo1gNyi576ZAi3kxQjE
         fAZU9Ihq7m22mP5HpIWmtjt15QWybX3xDWsh2797oozel2AP8nK69mYntNBGPlsd509V
         KF76GJS2Up2n4z1DYqwtufcWlof8rkpCgtVF/Uu8T7deFFKb+Hybl+rqe8S/RqfMEVcY
         3d4sVUnXtA1QPIxTQBLMyXQG7itm54CZptVDXBcuqXuugh4xxITf7jlSIUlQQxbrlrOI
         zBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920456; x=1794525256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=IWtR3M5AycjVlKLD6bU68YsfjcY46AQjkb7DKzrL8B5HM5YLf1fuUx1CgPGYL5470g
         5IHmoMebyoOdjbpoMe1LRiFfdiOyG3NMEALAr3gTtm5fEls5zHdZ55XmsLuPW4Lu5UwA
         v8Eu9WA41J0JA4g0bz1ZGDsqlUfug6+7ZwNuZrDH4fNf+CbQ/1g8drroIXbOELR3cHAg
         cGWKyYrp8gWp4cpMDRgGqOwPTUhKmYGf27+Y6qDZk6jyP+/845IuQTGuKlbAKooowgm9
         kHn4keG2s1AF9ME5aCr8wxU/NwUq6os2+I8yX8mPmbtvVHWgcB83HBkj3qRHFGL/eOcr
         s8Kg==
X-Forwarded-Encrypted: i=1; AKwUvBwfQ5E6vdN07I43chC7AzrBsh+TnFAHCy+S4p3ZHaf8DVhfTPoqvqmYAJlYzACnnQ3ZHDN0ydcAuzkj108=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+kxMTOb4SxkKAacytPr5sfI272a744EEOzI8Nc356v0ifyGAj8
	EDgr3o9oKyqhxdteTBEn1hPSV6adHRJeXajJ8u2RXyNggQRWOkJEqBXxSdSHd6MPDWwxDcULAoW
	PsssCgd62xBF6/wZOWc1nujqO0ghk6jfa5Vzv4Cmk
X-Gm-Gg: AYBFou2BBN/knB66D0h3p4Uxx1RJ7SGG65+pkaQlnBe1U6ka7U7zyWNTTt7DA4O0Sj4
	JXL0z0zJY5BAVLL+kTzzTlF0qw+rXPFi2fWxqss25GUtmuBaz35/W2czjj85apF+ta0SRJ1/0Z0
	/Nqwa6MutJk5/FctxMwCcUB33z0M/vQNE9T7aoC1QP6XiVQlPcHcO2lV5P+5R6X0moCWfIFLti+
	QfJ8fizZUI+YfpUIPfuXkqWhAYRVeBWeKJjjyjqmBfhpsB+9PfYn8k/BwL67bc/0ZYt55VZm/oX
	mhAYuhQj+/3RLHM7mZaJ6PyfSSeQHiZeTcb4a0/WTo1yiJg6ABIwM52jpPChDGw5ie27kCIAC0Z
	uDPDkHdlF3SVdCY3BadeXkhta9M8JdbW/RKVm061v7AUtHuLVxiQNZ8qrM+pZ7VZvfPzF
X-Received: by 2002:a17:90b:48cf:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3b0db6e8ca3mr534231a91.45.1793920456567; Thu, 05 Nov 2026
 15:14:16 -0800 (PST)
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
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:14:04 -0500
X-Gm-Features: AclHuK-Yq9Ya_gmjsTlhf760be1vg51BQVbAOtNinoyo6VpZvAmG2k73A1wV2Mc
Message-ID: <CAHC9VhQcmX09Do8BmY-HYJEWKiw7Tf-ZB=EEr9K6t5dBzk0SSQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] selinuxfs: convert mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook for the
> policy and status files.
>
> The policy file only sets VMA flags and operations. The status file remap=
s
> a single page, so use the PFN remap mmap action to do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

See my comment in the cover letter.  I'd prefer to take this via the
SELinux tree so it can be included in all of our SELinux testing for
v7.5, but if this has to go through a single tree with the rest of the
changes, here is my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

