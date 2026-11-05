Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB75606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:00:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKyVN0yy7z2xN4;
	Thu, 05 Nov 2026 21:00:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793872828;
	cv=none; b=eV3P/nHoKGSBtpByeOKvCYuI679zO/Iv7IQUE2GqjYUbihP2YPn/kjMORWu7bcsM4y4Ngm2P0ktxgzO1zgB51qTQ3O2yemGVzZ9LQld32M1hw3hlh7wjYYBZ9Zl/NROmli4TVvzFarXioAYmbEYKBbcOyk5btzAtIDCgMA4HMYIoXiDPwvmZvKUSSgngr7nbbOpWxZw3H4ymroIX8bM177km4JXRHoonOJySLQm31eD5msP/nrPrVEGb3rUBz6/F0jYOl6TJvaWbczUuHFCpq/88va0vqvjPIUEPDKOeIq9/1HM1bAfX2e9cSqBaBuEMIE7lOp3zIgcDk+0piOhtig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793872828; c=relaxed/relaxed;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqPax+1K99FsBzZRhVhYkr/tb+YBz/P8ibJbWTdLXrRCopLVgtQj+SCvRBNagIqmADjoXToR5QuKAw3B1uGnMWEP/4HSDb/BzMp6IdeOWEjSOvozYX/vMTyYa4OQgymT7r76x1sfWB/wAZo2nUkbywoq4gEjCerD4rWmJrGgPakcIjoE+GFwX7CAlQ7KsuEafszi3MSamr/nyWHqh6VEEMI0l+uxN9O772xqULdN09rcuATw8SE79NW2h+GTlOwkd18CQa4jWvQoJ1Ii4AWUKxpKZKVAcU3pWmXiYzuVlfp+vFYSMeGDXGdBzV0SpVQjc1y9ADGEr8PPuHA4BHn2Bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.170; helo=mail-qk1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.170; helo=mail-qk1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKyVM2Hgmz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:00:26 +1100 (AEDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f269e335eso196540985a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872824; x=1794477624;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=Ay7hJffnOToVyYkY5RWmBQQxIrJ3KEBpHno0DZPLNBrtCmCeKhtpZ7k6c3862am9eg
         l9MF7CBE1GuKe4DOIgLTJtzsUOxviz0rH3vFEP/k0sCuJlD8nyoRzXny+wvaXPN5fYNg
         H1tkaubGLsZhV2jo+Z7hz3bB8rcmMI+N3gv2GzEMtTXjW5TFPGCc1AOkujta5eS6+oUX
         opMJGVh6sP2osU8Efx7lV5wkG1cIk3cZ/Da6c1JvrLxORLafvbDXShosq7y7USrao32V
         H5uT5SjWcyKovY4Cdr/MIy+qkY7+wp5geJDurKl+WDbqBuSI/W7iHfnkiSYG86+Qh0Kg
         0zIw==
X-Forwarded-Encrypted: i=1; AKwUvBzV+dmCtLNHBVnWs9WsQYdbT7QbBMVbeDBse4VUVb+4RfKHvmGPO52nTXEF0FaNRjircQNB7+gmk1XT35Q=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9byNoLf6eGb2R+vSsa8DDPTchoSjPP9UNK7MA8SwlzSAc+egoG
	C9t6r3h4hYW+Lpofx82u7EU8DS4aeOQZCMciOpYCjHh7Q8ulQ6Apvku9sjBss/mEXJY=
X-Gm-Gg: AYBFou1taSgNVGhMuph/oD5R4aC8OIr0sJrSlZmVoLVGieWcvfo3sJVk5jBsMgcXqc3
	UmAryYDB4al+pNOLD05ZfyxxUsr44pUX0QPV5ih06lOJDnuYnyXHmAh2ZahM5RreCfF1AxD1KMx
	UkTdkT/iz5smZfzL6OoHegceKDzRMJ7iuwfd1QH+i6EdQeUXxg05ZBlHjTXbAwRjG4DJkUX3p1U
	1VsTsTtDKlBCdkLEJYaZdfXl0MJIVHpYZbOtIZFQTLk9NwNHzINOwMLqb+jw3OG7GWumtG5CjsH
	iERUCGw8dTKDH6bBWGhnB73v0Dr7+8wpPRjK2bhUzqlP8Ki785qaJPO2sekEaxPeV7jqPFQOGhQ
	zGb8E1RN5Ggx5mqHFfkbuN9JhT5lWi9xyFnpWimYWSOgm5vWB56AkZuVow0PcCkWiIe20wIvmzG
	Bu6gabi7ggIgMurpQ2hiqBkjnUUAwMhUYGm1/H0ZJxVwZl6iE49782iKLgek+m59q0aQC9CzAnM
	Hc04l/sXbTjRkWkgnVYz2toPPUfY0kbiYcMhVq7J4Xmkw3j0r67B7pZ/2c2lkbMnaPLpSDbbu1z
	kiN1t9baTZtKnIsFOm42TI21SafVVhlc0DchdwYehoRlgkoM25ReZegXqzjwHCA/fYJD8HhvPYm
	o4TaO14LZuiTt5PE=
X-Received: by 2002:a05:620a:2a07:b0:93e:6100:6c1e with SMTP id af79cd13be357-944216770b1mr3094875885a.30.1793872824320;
        Thu, 05 Nov 2026 02:00:24 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488d41csm423852185a.38.2026.11.05.02.00.23
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:00:23 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e635220b4so159756285a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:00:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxBCsbWfYWp/PgZc0Bf44gj22nZrRn7O1HoHN5YF0x5MhXsgY9RQJBtnIxnXB+m87lUNQEG9d1lpi/wptY=@lists.ozlabs.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
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
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

