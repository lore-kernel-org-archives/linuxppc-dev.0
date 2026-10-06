Return-Path: <linuxppc-dev+bounces-28975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338BACA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 21:45:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzqYT4x45z2yjN;
	Wed, 07 Oct 2026 08:45:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::122c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791312119;
	cv=pass; b=kjLjptjyvBku6t3ozB2h9yA3ai+NYow7uV8p42b/tnNeEHtUpKNDcYeKolBiIloEOyvu+YEI2ZaViXhfeO53rpV6w7Ok7BthAHUgSKe9LdjfKIg1o2hmUlyLGpJxT9z23ZjU7ahyaGqVAFIP1vQ8z7lx39PRTW2nJZR8DKZ9XKRcWjf38HyaU3N4ECu0uKPQsmesg0SEtsNcTXMQfWHhxdUDFtAEbLpYXL6j4j6dw6UvbleL0qXC9G0piHiazf8N7afHMBheAMBVJUykee2YN29T3c5jEC/lBWCTn9WWFS1dihrwzjlq9Ab6dc3Trxysv3K0tLaAPUxO2XuJmCSjnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791312119; c=relaxed/relaxed;
	bh=VsySStT+bTHVUZ7K5MQkKgFZxIMQ6ua4cfuOsS0U3mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A542KVEH62SAI8fXV5zRBZBmxczwJRRgSwFJ0+9ESVLG1wwPmbQuJvaU/Vc0ddGjQwYJW3MCUqVt6fSDOcdyBtbm4AwW2TLZw6TGK0Di2h97SFFHZnUqy/U3Rmb01TEdGodyXGGedgW196YyoatFZ8UgwZzJP4RvTPt8MkQswYtdD+z/pOksN2XbQ9BXV9dgs+IzYl5jbnnEt1HXMuVUYGsworKDJw/v9ct72t2mDYEMO2F4yrtvWHOAsqOP7RmItN6/Mn4JBKduXiefdkwgsCx4OTn9cXHNePYu85vo5hBg0FqoDGP16pMzD4CpCHh9YL6HhgxdwUMWB3mx2Y9gwg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MtfQ+Znh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MtfQ+Znh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzlTz07B5z30St
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 05:41:59 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-144e1b6d52cso1231c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 11:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312117; cv=none;
        d=google.com; s=arc-20260327;
        b=Ce36e7nFYFIbc7nZNmZ00YlHW393pjQvPrUbHoqqbcxC7iSzUhUeZWTSUalb8Z9qgK
         Gop+HS74e/EGs1hOp6vT643M42aAVM9iof0Yoc7pAoNdNZvr2IaFdyYF8Yf35VuyWgAY
         SXTlvQ3MCZJGWh3uv/HmNpqjXSIVuxzNW/5FUl50Al8Kp0y0JxYgOKZmuK/Hkm3I/grs
         Go005doBhOiMPD3iyKCexsP0WS6YSvMDLJZDS1VvWDS/SrOeGL5ckGbpkBds1UMUbdUS
         Lk0xeSITaKbgUsZQBYGR9fBmbN4GEesvbCDqmX+oeXg7ZjmXs7Jt4v9s7wAEkUxBoeN1
         EekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VsySStT+bTHVUZ7K5MQkKgFZxIMQ6ua4cfuOsS0U3mo=;
        fh=Ack3POnRSKk1CczRNrsHmP+gEEIcQaKKJ35pzkA9MI8=;
        b=REl1vbKI5xbWQj9NNwOYJGkfnWTtJV9FKhhuIgieQGZDm10bdc+HIZ765lEu8Y/k+2
         DFI4xkrcx/kiRRIhFtNxe0adaoUmwXQ1LlaE5ftsNZQr70DHGayha3XUK2UiiYP2LLQl
         rS3T0WwUJ/Ijbcxt6hKSzH/6RVWk8j78CR3qd28cKNJo/0LgN51L4vV9R+EQWjdZnSpm
         zzDSSjsjFCRIS2HGnWOCNc+k6DTu68Opm7cdLJStigT9D6IgtUxhYp49Po7ieBLi2Ukg
         98LmGf0egEFcmygypkF/JSObgtZJVvMPMgYwVB5/e2Tg93j9779EhELVsJuzFMxzDNb1
         ndZA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312117; x=1791916917; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VsySStT+bTHVUZ7K5MQkKgFZxIMQ6ua4cfuOsS0U3mo=;
        b=MtfQ+ZnhdL9H4SXINP7Gb9zg5hlbId/0ud17nDQmmfiQ7ZGXzxrLtp0/FNtEpYaOle
         rk1DAg1ZeuiViGVMNH773Qnu0StPXIAMsktJLRawSy8FpIpxdT+jPz2O1GgYF4OLoBK0
         2hHXsXba54yfz0I2QCZ82EdnnzgBPCGBGOZ5+Ikt5cgmob+656SkMwrHmfw76jvbgURu
         4GAxiIPfp2NrADkg/v+iZ2eOlbPmq3vVm43xwR2ciJv5zGKi1sYwpMFNjQ83POptyTJk
         ST4eFQjr1l3aUJ3GpMTKeRy2eADM67i88w0XUTkKUs7DC/fyzdelOx4iRKT+bwS3Isam
         Hprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312117; x=1791916917;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VsySStT+bTHVUZ7K5MQkKgFZxIMQ6ua4cfuOsS0U3mo=;
        b=pV/kwrgn9FN8fOaB0viojY9Gh9LsQmCpCe3ez1x+O2p+6iHxDDZY8V6fJa1mp6hdEA
         esR5e/tCHMhiCbRUFunRAPVaZ6srZ+vgHsEcM68H4dq+OmbxgPPjiCrLf+F5yM2jobO7
         Tq0v8Aqboi4rQG6WKkDea596uiixtKG2BZEpC51fcenynbIPvLJ8Ebz6nlqi1XnjwRbW
         +guw/8ILZim+XbfWob6BYeFxXEn0UTE7Ws2s/K1lL5XbR+qgANcDK375EmRA2hJ6HMox
         VPRNBwGz3q4nyzapyCwKfFcad+5GAfyype1HvDItSJORFSDqZNQddvI8IaaY6p+NJD7t
         cm8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwmRpuD7225X8n4ZhXPkAIHZEadcIzgDBWCyBsshnvXkwppM3CtVsqDtQaRHJ154fu9SNqjXVX1/cNy7HA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mGYK84/5RZ1GWcleQiDnOGOudo0m9Fhm7cCHbqIDIx9RbxMvEA
	GwQNE0NcN4Mvz2eSrkZoFZiK3SfgjTmKWBAcyTeUU1h8hs/Ouas3evMx6UokhcUQgz5zTYdvxny
	2PseJEc9LjhNagXwKsisThZXQOei7mxUIyrCzfFE=
X-Gm-Gg: AYBFou270VmLT/xNHvbYqyLkZapQvuJMrfOhEDWGtsAQuWara5rMwxXlnIY2L1uE8Xi
	U7sVkYnX0lXY5jrMTMBpZwnSPAL2LxfQ63tnv0dyCsdi0jDaE3S/UJLKZ2Hq3R0wu7/BL+rCtEc
	t7hRPcsxQ3gMB0AiHsRUjJr52eNH243r4p+cq8cuxGRn1B3oopoRQrsPU5crg681nkuyxeZcYx5
	sVraV3pelOwEG2Jm1MkYNrufr9iwq6CLeT5zofA/ITrJO7La1+pG+bchfWC3OluXeuNmNYal3pG
	AxF5ZzLT8VLXkVEc5BJQ5Pg8N8g2RV2qufRKvxO9qFuH7B13DrHkGH1ZiVkU1auW4U4wHf/Z8rK
	+k+kH0VkzBnnY9bP+EfOqR6R1bAQDBCsToxDo4lwkqX0l+iI=
X-Received: by 2002:a05:701b:42c7:20b0:151:5aef:b375 with SMTP id
 a92af1059eb24-15df6a22909mr440182c88.15.1791312116126; Tue, 06 Oct 2026
 11:41:56 -0700 (PDT)
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
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-8-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-8-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:41:44 -0700
X-Gm-Features: AclHuK9XxyGsPYngcwP1eLyAaqdgOZtLG2-uiexY-er63NSOcNYsX4saqv5yQk8
Message-ID: <CAAdrzjs_T6PV1j-9n9vZFHLaORZQ8Py=g-Ms8F1hQq-NwPq9Uw@mail.gmail.com>
Subject: Re: [PATCH 07/15] PCI/ASPM: Save L1SS state in the saved capability store
To: David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 10:34 AM David Matlack <dmatlack@google.com> wrote:
>
> Reserve PCI_L1SS_CTL1 and PCI_L1SS_CTL2 with a single request, since
> they are adjacent DWORDs, just as the old code allocated one two-DWORD
> buffer for both. Skip the reservation entirely for devices without the
> capability, which the previous code could not do because it allocated
> the buffer through pci_add_ext_cap_save_buffer() before looking at
> pdev->l1ss.

The last sentence needs rephrasing. The previous code didn't allocate a
buffer for devices without L1SS either: _pci_add_cap_save_buffer() did
its own pci_find_ext_capability() and returned 0 when the capability was
absent. The explicit "if (!pdev->l1ss) return;" in this patch is
required because pci_reserve_saved_cap() takes an offset, and
l1ss + PCI_L1SS_CTL1 with l1ss == 0 would hit the WARN_ON for offsets
below PCI_STD_HEADER_SIZEOF.


- Josh Hilke

