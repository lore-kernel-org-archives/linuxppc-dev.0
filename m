Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E59606A32E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Y90r2emx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNpjJ5mv0z2xf8;
	Tue, 10 Nov 2026 12:19:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794273588;
	cv=none; b=GhU7yKAXusK1KIaXzjyIxQljV/hUAE8yKe2LET0UKdL3HVTnRKeAyaG4qfl3P5vJfI/ZG0K0rw9hHb6eblaS6sc7j201uuD1EJ3diS534Yy1Bub7jOk0BP/Mj5oDdmiy576viQlYUk+u37xzYHdrqAmlcMQgEwlJmyaOoQYeMRkm7IL14k/3kzW80+N6Fbyp8s7r4PTQfPOz4PXjBS7YkVsl706aVP0ow+6JAHHP+HM3tRpHwdQvbz+cb54A1N3sVierDtO0Ta1Yz1aGVOruOUfE8ArovfxYrW6h8/niTIswLQRbpJ/twzldfKEGQUZitfjcQ2h810ZnCLDjlvho2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794273588; c=relaxed/relaxed;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JubY62jdYNjNKT6+y0Bq2Ulvu+3ouf98nT7qvP8hI/KgpkH+B+nSO99Bv90gwKHAizQSJpxVHHSlQ5UKAUfg6oVkRWNTbn41J6q0GZFiAqYXFZq2Zg+gTbzASBAEUZF2yPv6GMLbH29eXgZpIuFGoRVMh9tVGlqEt7VMq6uPAHwVuG2ODzvlOVqKe7FCG9ZdT8rFKVqVd+aWpd0RhPUQ7gpsr51dX433uPPOJEQjFy06Fbq/R1e1dS7SoF0jqyY/UR9Q2sM7EHHES9jE0d26b8vwJpD7khCnVIrLgDIeX95KqJ6aAxf7pc8yHApBWN0GZwHk0+DZOw9ujWS/i9iwww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Y90r2emx; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Y90r2emx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNpjG6CRLz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:19:46 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so2030750a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273582; x=1794878382; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=Y90r2emxjS+NIMaOkKgy4Jj202x4XD+VeErSRth4en90dOpIES0iQHT/E8ad5HBwyv
         /COXJ5W9jc6WqZ/nEgrFoqSJ3iJ1Ay5+TkLLDU6zcourqn7GRIfnjX2hHTTEyum/RCfk
         nMJB3xKmfSXVg+jce+GCx3qUjOBBUly6YMNHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273582; x=1794878382;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=n5VjStYO/itYDG5dWGwJ7X97XWVc3F7z8woVmL+c7hZwGS4A5lFjSp4QMhO/FeH2Pe
         Ibc23A+wlOYTUXifsyqiMopcfYHbvC+TQhVSkXkYT9dbU2s379tqyfQU7yysFkGJN1gL
         7KIM+EamgJ+RWDrJaHUCvq+d89CXnE38mQb18zaDHUD3HCNoUM4d0F7S9Oy0/g74CD5r
         4+KInpuGvAsei+1iM0uaYOSybMPoTrkXwyWWbzBSR7CFcyP5j0gLjxcl+WIkYy0AmPrm
         sm9N2LTStXmEzbhWotv4lmLLDllVS9WRMRlxduI84GLachf9LQz3F21zmt/Y131NhPWO
         vZHQ==
X-Forwarded-Encrypted: i=1; AL+hErEasKCcjMA57MkNiUVBxAOq+01D9YSpI90uph4nPqbeKhBFwMCVpxGxcur8LqqHtUlzaTHOwuJt3Fpnt0M=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9jdVDnSOFAKYtwOB0ZVPN7vL+laYJqRlmtIy8KpEU7n2arXeIo
	tyD9djemZ8scCmqJCjMfIwTyny90CQavUPM8KyOj8T9LPa79hDflO32NOq2vjE3TUxmEeZHJXNI
	vyBp7JX1G+Q==
X-Gm-Gg: AYBFou33jguw8gynM2ym9JfgoB5J2sUsLAObHB8gjHQv2kqZjNpPMgiVvEQL8P7tXV2
	cq4BG7MxDQZZ4h8nW1vlhOyryL9vyLhIBkuEwziuY04+vHxXDakDlsHEAR+U+0HxKVeRqzFR3kG
	K8FC1iUt6W7197QWb6k0sLrkAn6QCb8DE+ZpcsNBKD6TGfLxEv0SoR2qiuUhtWm+P8a39soQfdv
	em4kLsd9URpMU3SvFWyQNwILr/QGFhlv+geszviE/wgANr8qNb9nd2ETkLHyDZaYgTSOwhKTCsY
	y5u1WBRnNUznnX7jrKMs8zhUwFq2qd3hhspop9JPb+so6QHXqmmIoA3DfmV3lgkY8H9FAr/SPaK
	kQUnkbcIS88Mn6NEIBYqckkXKFeo3aT/MGNbOcxGw8m+RWGg9p0vZQiLGrfzSAQWV47poSEt2sE
	TNviE+OC7SMcA02GP7lYSGsFraAce2a0fFk2Qe4wLq7Yqvstw99lBnEVxfCPyl3PhjA6Xq3Ro8N
	cLoePfREM/wlQLKSDso7CyfzoMfothG3rZadSpMlDuGbF/Q/1BnApK7+eXSa0TeMhiM5znGCZqG
	s7xk8iO8k314JseCoKx2AZ5yGfCmLxOFJUHM7k9AbcNl4kayKt0siup6PJ64AIqSiCtpPKY/P/O
	QUQ==
X-Received: by 2002:a05:6402:c4cf:20b0:6b7:8b1:aa6c with SMTP id 4fb4d7f45d1cf-6b7564f9b43mr700304a12.10.1794273582054;
        Mon, 09 Nov 2026 17:19:42 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578bcc9dsm448864a12.7.2026.11.09.17.19.41
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:19:41 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4c9abc1824so221597566b.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:19:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGWdgS2I2DRsfqy2d6SPYkTEjMbDH/7ntZt+ZOky0IEv8B6O89C+DFqDMAZldCJpra4w4EQvvXA3+PI5o4=@lists.ozlabs.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
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
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus

