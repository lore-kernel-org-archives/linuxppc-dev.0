Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1801E606A32D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=XB0/B+Gl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJKPQ3w7Gz2xdb;
	Tue, 03 Nov 2026 05:05:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::12c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793642730;
	cv=none; b=kAOHHAMer1T4Rlieyzt0mCBhG8yE7be3Ly1Fq5OfhlF2LwEcnoJdW2tagk9irRnYlWOIKeaSbffw5jMA2a9r/y80IsHyTQbKVOwIji7oZ9Ki723TdAGKHRGPGq1+vtqWh6WF23sOjFxy8rSTvCOeSTdqjzSS8Bq6I4I45G+aDfBf/+9h5dv4nyTAIMvUl+P/qGgBWwqOVY0cMjvPoYoEGVSVLaaOrF5xXViBrS+vx1hur4+55J4xJV9d4hU5tjHG66k4acToWtZGU8orrc0hp0jlMAifFFi3H4j6ZbH3+p4fuyTk14gyeADplwGPxvaV3toSqrU5JQt8n01dAwh9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793642730; c=relaxed/relaxed;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZHQUazpprvKFnuXbV5ZrcoJXPXHQ9qMKISkcY27hFXecBzJjl7/VVEzZM/9GA4uEZegY2DvEFU25PbXKlEjxfIDsfrFoc7o4bsDFL+DnjzauLnZ6PuVuHsENgQ+oNe6ROK5MWnjesTl31wJ4dEeVoQQTiCxuaVZ3A86qbK7vpYezfBYSANXjNknQsMW4/xoqC27Xw6L8kxl8Ne8t8oWTx7T5oAYHBGm0cv/2jVCwnM38MW+BoWaoo17sfof0v2DPlaYyVbwH/+XPdHdr1MdJZNhB/JeAdd9Q7Uub+xrAguNFwoAEz2vpQ+8YZ+v/JxRu7TCp9d8Zc4vEo0AtKErBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=XB0/B+Gl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=XB0/B+Gl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJKPP1TdTz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 05:05:28 +1100 (AEDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5bfc32574e7so1753231e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 10:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642723; x=1794247523; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=XB0/B+GlQO6ptNJmSMU267v0Me2mh7kT3dlcY2Lh0Q6n5cD/vozFS95O7AJc7/o1Mg
         7cxmEO+vCYQLqPKB4Du+utK6Z51gDTGpshZ7b+x1ktvyZcIAN6NeduEX2RTiWolf9vQ5
         LB2/gJtHcbQgQLb48bCJmKEqCFxXUZTAfgclA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642723; x=1794247523;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=AL0aoO77yn7Vim4iaySv7mXXHmzeRXr42KajMBeP/HmPggH9q8c5YkAqYWee40Tiwj
         ByDu/OcgZ1FtbvxJhRUMMWovagE2RohDGtmpJDS120Y8N65ruSLwU404qFmWGwHbrge2
         SaJg+ayhF+zZ9lxvloQh4J8pfWYL93pedaJ6D8xeHYBi20OtxOLt3zs05VUfybz7gG4j
         H+afsQPmCz8kEoJkLQe8Ml4e2zipdlNakGdD62U+uQGkIhwW0A2AMwzd+Ca90/QSRnUh
         UIwRWRsKfl7gEX/WwTBG6guv2RHKhw+iOpyUWO1GLkyp0OviIJHYKK26gn6naDJvRXdB
         +xPw==
X-Forwarded-Encrypted: i=1; AKwUvByfrspa6LkE7K+4t0MP2THLBBKsYWrw4BEH9wrLrXNnSmqnGy1TJSdBrXd951uxvOFPC2STfm4u0xql+60=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8zfYpVNRY+UWCJVHYxgt1uGooV5XVu9Ys/m+JLWxpwlJCOT+Lj
	KTIhzrSxDZozAp2RQ0uKP4umFjFdXHClZSBN36ffxSgzSmI5PnKmr8YaIoLFd6IrAWGJY5vD4gS
	NBgeAUZ8alg==
X-Gm-Gg: AYBFou1Xi1ipsJBxdK38z9mBcELcLhUVbE+839UbTgLGekQCMCMvoJPnuPq9Agrynse
	x4bTV1httNGPUmciI52uhB5M/IrohlPQm71QQ+BdGBCe8+kUwajU+hclsVRA6xNmURxEPyycVr+
	e7W+Oxdl0EZpbeXKbS0IPmdQuQ5cD7NVigPBjyDTy1LeQFHjGB0oSZ2ksnwHGxGAVYnQ9TUrRDX
	3VNjTlNVbZelUFGAp7O1DR+V48VbNO+ErdcmCsmSnNYYZf5MiMKIx/XtmgfqvcoAZKdzVbgAoSf
	kuNBKRZRf0+EwZzNZr3gPm/qK/UoEe3qXL6Nh1+D9sYVD9COjxJywxeOdkABSDQd+235eAHlSUI
	HwKPdrwIuzlhsBARFnWeAe1tD9+8cyQF1kp8wZOM7Wf2pWqdNrSVUjSovNVHdPjSmsrk1/syqRO
	UuKR+aJ5kbOMJNyWftKPGi2NvgN4G+mux/WK6l86GMPHDXPlupoPZLAA2VDj67TnCFYqMVwGmTt
	fMQhLywV/sicg5Ohm3lVDarS9YmX6QDfcd20vDcI5AjipM3Rpe74/e8xvrRa9B87dsiFd1lQvGr
	6O1GloZwqhk/uotaxT1iV88QOCetETpPEtZmYOCXBa8xpOQTHC/BkAAvNo3twzs6HLj43U8nsVA
	euPHxTQSrh6E856CVxKBLQhxDabc=
X-Received: by 2002:a05:6512:1093:b0:5bf:d70d:8a01 with SMTP id 2adb3069b0e04-5bfd70d8a5amr3139150e87.15.1793642722830;
        Mon, 02 Nov 2026 10:05:22 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe04a4c16sm1931690e87.0.2026.11.02.10.05.22
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:05:22 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ac65e845a8so38017501fa.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 10:05:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxOk3MakBzINrC0qsOMAnC9+yOKO7VykTAImYFuMjMImLTq2chTCKMwfd8UpEHQaRiyaOOdzI9XFNuX/j0=@lists.ozlabs.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
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
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus

