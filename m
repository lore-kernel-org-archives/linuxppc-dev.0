Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F7606D839
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:07:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKyfv1Kq0z2xN4;
	Thu, 05 Nov 2026 21:07:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793873271;
	cv=none; b=H9lmmtuVTiQv9aJXsLXGSRLlSfEd24HL5enaQR9z31V3Fr3RZuY2PVi9hqisBfRcm2LcN2ZC+Nw3o4ycf6pSVN3JKtfNKguq3PhHw472q3xqNUhhLvyoGcTI5Zd5q1fOEs27asx31KHXsqvNxHki6RDplAdeDYEqGrKIDM2ELX7493x4WioRtuWB2N5UBciPrGvF5U/xCXDG96bZFyYORT4FHG4UpmPlMoXDQC0XIsWp3KwRwQMRjHlyJx+7faYwQv58eImYVD/KiP/Jx0k0mq6mkAUhwtZeUJJnonwLxyev0v8wo1T8mShSHiKEinRKJ9jWW01c1dsvUTRTJQey7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793873271; c=relaxed/relaxed;
	bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHKsZjeiv4VvVSlMo1GAh8FC6pfuwgH1s5sMKyOqO7uniHouH3YcHdSurPwGOgOlskTeEIA3+Yst+kv7Le+sVlPPPLVK75Lc9m2xLihVwSwUbGUQL0Lm4K6XDQjulNC/2BgeTc8UdEY69FGmLxTialBaKxS3I96ywSuJWEsXHuFsrz3ANRVn+obFRyp4875pPsvYgUXmLE8s5yUTjmPd++glKA2LsW2oUxiypxsiX0vuWys5m/tSqkFqXGUELMxnDZYXoe4myAAJ7DiOvfZJwWaD/b1zVYgFaClygLbc8djtURO1Di+433R5llsd8Ij8efEIh+8gerWPzd5Y2xFi+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.44; helo=mail-vs1-f44.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.44; helo=mail-vs1-f44.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKyfs6S4Dz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:07:48 +1100 (AEDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so583581137.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873266; x=1794478066;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
        b=PNIPTuPG9BfQc3UKoQ0OmWXm0dyOW6hQx+3PK7QDiU4kC2emCHb/Dm5wktf/YFyNDb
         r6daGT1A5PZD8wMgdxkjnm6ipuPOUZSmmKaGllVzubH39v2A9XPcsINuhIW1NzZu8F8A
         ZIBoxeDvW4RGdRmx5Dz9IPC5HS+BkMWtOkjUUpiG6dm+DQbyIvgZyeHMhB8Ok9lvyScx
         ZRwSjAMfAaxvpL9amHWS9mu/5LMPY4NeFmxst+SevPsoggsePagrxEcQDOOGuiEXIzi9
         qMLleiN/eMwes7Ind3avZQNHN1vWVCieDHk/r311ilVnRMMQR7x28GckhkisEKgp8Ggz
         RcLg==
X-Forwarded-Encrypted: i=1; AKwUvBznOqVoXyGZw4YIsYwbwoLFv4EUpAKzvwP022eNIjsvHq3l+yjoB9imTkdfZZgCPODhfnYuJ4hNOrl/FX0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/CdbqWW22856XRXZJVM00bX1bgNnkhpzMzW7QH5Ky2nnyXZWns
	ZKUQnobqWZiT57k2qSYJr6U7dkBlUFOZTD10+QHbQ17P7bYtt4gW+XTgUvBXnnnZ8MU=
X-Gm-Gg: AYBFou0LlufbREtBZMe96muFzfjbuFxqO1eNLshLR9okD/r41Tg3gepxc9NyNxeaBxl
	7PkZ5Aw6olUx6pyiaTE1r5kuQDG8InMKxfqf8Hbns9347ENnqk81tOZNp7bj0NsKoH5Ykuvr4eh
	wcnogrl0BbOwulIvctlewzsag8dxjfAgSVlDSkRXdysME1YHu+hxj+W2CDdgPVhpqsuTde6N3uu
	casZgesP1JuH9aR7g2IbDm96N1PDMmuJ5q/IfwXBMLyI6mYBQCu6RZ4ddnHSYtv0VEUi7masbl2
	KiKLLptuXnScIWYIDkzDJlI67HymdGk6cZ58oFYKyi60+x+FAZW1O+XtiP+8LyRVA5dbAXfNTVq
	fT6ozdmmryFV+UTbTBYtnbV9eo36/kEQFN6SnXrTxjldIEpIu5pTExZXlaDe2G3HBY7AyH5//cH
	sGYcE/OD0cK42BLWzj4OwpZouldkvlPh0QkR/Jk7TwtWiPFlBoIhxSCoaHt2RqrZXCE98kNNnom
	jSjo1oqA9wC/nYXbE7z60eu6kVgY7esRwTGT8a4PIgqkw5aNHxpE8v58oKoFEVw4u/LIwMVhlwQ
	yzuWIyf7NdBmBCWGTIyhBC5+F0wpLQ+5DzS5tzRytJ7xSwczsQbrR3mYk7EluJHMqnBZig==
X-Received: by 2002:a05:6102:5126:b0:7cc:9f01:1378 with SMTP id ada2fe7eead31-7d07227aa1bmr7675323137.1.1793873265805;
        Thu, 05 Nov 2026 02:07:45 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm3744734137.3.2026.11.05.02.07.43
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:07:44 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eac4855401so599759e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:07:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwfnAcP/Y+R44X6S7c+bYQw51Fh10k7mmEdE0k3SYi9a3uSBiKJEQWn8q32HsxT/wW/Lokly0AD28GMfSg=@lists.ozlabs.org
X-Received: by 2002:a05:6102:374c:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d07227a940mr8060714137.5.1793873263361; Thu, 05 Nov 2026
 02:07:43 -0800 (PST)
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
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:07:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
X-Gm-Features: AclHuK9naqg5CZQ7lhJVrMhg9TNH44f-SpA5WbUGCGBsAlcoOw2midTd7doJSmk
Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On Wed, 4 Nov 2026 at 20:32, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_write() pins the entry and calls ->proc_write() which copies
> from userspace itself. A page fault in that copy can take as long as
> the writer wants, just like the copy to userspace of a read, and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for writes as well. An entry that implements
> ->proc_write_buf() gets a NUL-terminated kernel copy of what was
> written. procfs makes that copy before it pins the entry. The copy is
> capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
> proc_simple_write() if the entry doesn't care. Larger writes fail with
> -EINVAL. The proc_ops go away with the entry, so procfs remembers the
> limit in the entry when it is registered, like the size of the seq_file
> state, instead of pinning the entry just to look up a number.
>
> Entries that take binary data in pieces, like the PCI config space,
> ALSA's data entries or a firmware image, can ask for
> PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
> ->proc_write_size bytes and the write comes up short.
>
> ->proc_write_buf() gets the position like ->proc_write() so entries
> that write at an offset keep working.
>
> Note that procfs copies in the whole write before the entry looks at any
> of it. So a write that is too large or whose buffer can't be read fails
> before the entry's own checks run, permission checks included, even
> where the entry only ever looked at the first few bytes.
>
> An entry that implements ->proc_write_buf() and still has a
> ->proc_write() fails to register.
>
> No users yet.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -67,6 +74,16 @@ struct proc_ops {
>         const struct seq_operations *proc_seq_ops;
>         int     (*proc_show)(struct seq_file *, void *);
>         unsigned int proc_state_size;
> +       /*
> +        * procfs copies what is written into a kernel buffer and calls
> +        * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
> +        * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
> +        * writes fail with -EINVAL unless the entry asks for
> +        * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
> +        * for ->write().
> +        */
> +       ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);

"const char *"?

Seems like you have to drop several const attributes during the
conversion from "const char __user *buf" to "char *buf".

While at it, I think it would be good to use this conversion as an
opportunity to replace "char *" by "void *", which will probably let
you drop several casts from users.

> +       unsigned int proc_write_size;
>  } __randomize_layout;
>
>  /* definitions for hide_pid field */
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

