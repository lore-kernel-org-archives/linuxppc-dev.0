Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8A6070F57
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:08:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKygw6bJTz2xN4;
	Thu, 05 Nov 2026 21:08:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793873324;
	cv=none; b=m9c/GRAf9TMLfwt0woiMv983C5uY4zPFvEDFbKsnY8oFEbTsv+Jc0KtpdSd82WmdZfRpFvW+5vlqOvuOw3BdgDq4blxKZrZm33yRk+WCd11R9Nq0zV66iOs7uQYuTgv0gRu9bLfJC33Gm512BClJs3WtJ06VIHiL4WEaApb+SEoXh76Y6Rtpwkmzs/onWTmB0ITzROXwFt7jaLIRYjbVbpOGG4OdUDVXtXIHime6qBs8OBwQkFdfb1p9LmNkmudpig4v4kbpolt4HM3btB9YnQ0RY0tTWbrpVkP5h3t0AGjGfQxTSfdNsFuUiHwPT01+lcz6oMJSP8/gdyLa6Ej9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793873324; c=relaxed/relaxed;
	bh=Z2qCIfu1coqF5CKQo/xHkFXbKW7Y+rLlNCa31RZmxiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5NSCyKOgroXyAQ3v8hGtoWFfq9WcDQyHyuKsZk2bZtap352WVPhU+VcfFgAzxgrM3P54D+1ixDHubF5jyWNWiTNVAZdz56DsLB3M7CuH4WxNd+5tSGRnF2wdinRY01maXh6HUc4sYGv51Zj4CMroFUkBHiMVq4njt8zrRDzH3uBXPw8MNyeZktXlFmfvgmLOj+sSAefSoWM/VOZ4nAPz9EIQhwGnUNnjO+n3/k7FADx6/cRwvPWvY8liKWLwrALCBNNB2ZMVJnzZCdSyFj4CYjUivaF11LTXmhHrpC32fKbgul3B7NTjh+u8FoOf4m7IUxybudVj5PZemjkTyPc0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.51; helo=mail-vs1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.51; helo=mail-vs1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKygv6QJ1z2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:08:43 +1100 (AEDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc53938a8fso960692137.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873321; x=1794478121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z2qCIfu1coqF5CKQo/xHkFXbKW7Y+rLlNCa31RZmxiE=;
        b=yhbznCGns3cQRGjgtECRZ/4hB+1ymW0WJU4ZsMnsRNq1sP5hGNr2+OK/3lL3I1qfXE
         1H5wpK9sU6tftChWfKr5YSyCt3EFC5Yv5Oj8vGBUtXKNwI1a2IuTLVsu54nHaT3GR1JX
         tg2Ldb/qREDvxFdHo+l3RP/tI61DUswcA7EzICmrveQzjpjopS1TIKAH/SK2BaXRpdw7
         +1HkNkNFTWMH8hwqzfjF0e9rDzxvMs4bpUJpQEYLxN8caBaTo02Q1P5Wm1/nlQIiiVNM
         7nDGAcdtYY9D68N345+d2ImbZDTbZtY0a7wKQGfhmyLnlSEuBg/sgl8EmnPC+/rgiUZ3
         uaGg==
X-Forwarded-Encrypted: i=1; AKwUvBzrhzi7H5eJ1sIr8FxBZRbRPZrqWBhs4O70nWy0A+YcwtzNyQYsuNc38nNepw7HelgCuGsXNm+oK42mATU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+2mE1o7NtLRtQyFciiOGFDJtkjmCkVu5EIP7dZLPc/pbNqpzbd
	KT2ChxyQHiR1ns0WgrpG1LLeYEVy+JoBXXf2+B9WtdbdWrK7I55cE2oym6sOZvmO40k=
X-Gm-Gg: AYBFou2jiCBgENP43n8E4xLT2GL4tH81J4T3N7Hovu5JtEd7PYHilTU+jZwcA+7iERm
	8v8U09F8VGPROMzImo2sm284R3nvXSWaNcv17ZWhEBCdnAWT1MkElpsC0RM4xj/JRX9etMW/tzz
	sf8QASVl+qppGmhxqhwa66sqAwXDx1EdP7bj8TukbpO1E7VQ1Om4H4z3UzD4UlZe/gdRT3XrnE9
	DSpWNrDDrbIWb/r6w317UAS60ZoV9Q7rk/q9YbUU3H0JESZFrpGKG4MQ7FxH8VArIcq55q4vjUV
	G5K0rrjMEXQdCvaQc2ohYJMhHeh+PUmmiHxNFErGJl741KJchv/KIGZSNT1o1aibBJopBBf1THy
	Uh7SrtAmCAwn7BKRLKFUR4S/UPr7ivltnaW5P9RMQ1yCNaShvJ+HxtqRKQkBE7R9xmyf8jadyf2
	DEZAaSSp0sOnQpzKy/cl9TnEP/6vtu01KSc0IqQLqryZfLziluMopEF4KCTWnIT+fBQQz4f6Lwk
	MH4zUNUBx0k8rcCktrZs5t6p3fOznH6VXQ8lQXRlnGhTcLpSXZcV0eErOvE3MXUNBIzz5FDsrFz
	VIU1NL55M8QmEtLpSxF9jL6oMkgPAGdn8nZpdPAPlBYTt9XcFlzhAMw6e3H1Hia2oA==
X-Received: by 2002:a05:6102:f0a:b0:7cc:2cef:b330 with SMTP id ada2fe7eead31-7d072bb37d1mr9164639137.12.1793873321425;
        Thu, 05 Nov 2026 02:08:41 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b81b3sm3800288e0c.2.2026.11.05.02.08.36
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:08:38 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-998749fe872so935017241.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:08:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxsKGO3hDMqS36MTCY/HJJSoz6eJ/+Xj2Vq/M0ybU3CIGjGoJKhN4Sr/jt1u3ugGX12oZe25wY0J60qraI=@lists.ozlabs.org
X-Received: by 2002:a05:6102:5494:b0:7cb:bc5e:7d9f with SMTP id
 ada2fe7eead31-7d072bb3829mr8787869137.11.1793873316184; Thu, 05 Nov 2026
 02:08:36 -0800 (PST)
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
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-16-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-16-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:08:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAk9CwoXpak8+EQjdvJ2Ab9fo1bvj_D5GqBzXB7urEUQ@mail.gmail.com>
X-Gm-Features: AclHuK_D2R6ZzQFy7DOLUQHC3VotRoglnOuhbtIFU-Oniz4UMRG_6kQUnblEqeo
Message-ID: <CAMuHMdXAk9CwoXpak8+EQjdvJ2Ab9fo1bvj_D5GqBzXB7urEUQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 16/23] proc: let procfs copy out reads that
 don't go through seq_file
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On Wed, 4 Nov 2026 at 20:33, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_read() and proc_reg_read_iter() pin the entry and call
> ->proc_read() or ->proc_read_iter() which copy to userspace
> themselves. Like for seq_file reads and for writes, a reader can make
> a page fault in that copy take as long as it wants and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for these reads as well. An entry that implements
> ->proc_read_buf() fills a kernel buffer of at most ->proc_read_size
> bytes, a page if the entry doesn't care, and procfs copies it to
> userspace after unpinning the entry. The entry moves the position like
> it did for ->proc_read() but that only sticks if the copy to userspace
> worked, like in kernfs_file_read_iter(). If the copy fails halfway the
> read fails with -EFAULT and the position stays, where
> simple_read_from_buffer() returned what it had copied until then.
> procfs remembers ->proc_read_size in the entry like ->proc_write_size.
>
> Larger reads come up short, like with kernfs. An entry whose readers
> want all of a large file in one read asks for PROC_ENTRY_FULL_READS and
> procfs fills the read in pieces of ->proc_read_size, unpinning the entry
> in between. A piece whose copy fails ends the read with what the pieces
> before it returned. kexec-tools treats any short read of /proc/vmcore
> as fatal for example (cf. [1]).
>
> These entries are read through ->read_iter() so readv(), splice(), aio,
> the RWF flags, kernel_read() and io_uring work for them like for the
> ->proc_read_iter() ones. io_uring's nonblocking attempt gets -EAGAIN
> though, like loop_rw_iter() gave it for ->proc_read() entries. Neither
> the allocation nor the entry can honor IOCB_NOWAIT, and io_uring would
> take a short read of a record file for an unfinished one and glue the
> next record to it. So it retries from a worker like before.
>
> An entry that implements ->proc_read_buf() and also declares a seq_file
> or one of the other read methods fails to register.
>
> No users yet.
>
> [1]: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/util_lib/elf_info.c
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h

> @@ -84,6 +91,15 @@ struct proc_ops {
>          */
>         ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);
>         unsigned int proc_write_size;
> +       /*
> +        * procfs calls ->proc_read_buf() to fill a kernel buffer of at most
> +        * ->proc_read_size bytes, PAGE_SIZE if that's 0, and copies it to
> +        * userspace afterwards. Larger reads come up short unless the entry
> +        * asks for PROC_ENTRY_FULL_READS. The position the entry moves to only
> +        * sticks if the copy works.
> +        */
> +       ssize_t (*proc_read_buf)(struct file *, char *, size_t, loff_t *);

As for proc_write_buf, I think it would be good to use this conversion
as an opportunity to replace "char *" by "void *", which will probably
let you drop several casts from users.

> +       unsigned int proc_read_size;
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

