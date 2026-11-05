Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD0606A329
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:02:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKyXm4nqkz2xN4;
	Thu, 05 Nov 2026 21:02:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793872952;
	cv=none; b=oeTfiYe6eYmq5CGBkbDjcD6IYLi2AsYAAil7l6J1fLhv5vzbtnYJbazinDS3U2FI+dF6Z9Uqwd1byv3fTgeA7Uq6PH7HgBmzG7+jI93/7ie5zW0RuWmpzltudQ7du8nUc90NDDEB3//qPtadZXS9rxCLqg4ttzkZo03mp+7u16b1/CYHNn9fSL7t2RGd7/X029EXSoFyk6xGXpomnpVYAMjVIbIvKWE6YvqqtKV9CAIFvY6G8BuE78afW09qx4pNI9naueCz+qQ/5DnCe+N9mHZ5ONhQnsmbzlHU01Ovvhnn834+hAlei+/QopnJSHfZoovR3xfwrLinrfrogO3nvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793872952; c=relaxed/relaxed;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgPM5wunwi/PxtwRhHQjzJycaTL+xlT7/zoyPowiI28cDw70tOmV79W5DSWL1ETCNqr8OYHh3JroMAX9b+cMl6D5uMvqlYO2cXTzWp+1Mf/M5afD3cb+HR10LmfkQvRsvhg3Vj6+yoID+dgeQywg7DS3U+GVEMUpOYZ5VIVShb9Tky0Uu0xg4M7U6ZvndJF6GFgxFsF1GiZGJFLJD9YizFeawq8Dpfrv7qNky4Kgjo6n4wpqGbkLM5nllV59+ixXzSJf1cWtwP7etg99QVhRnJebwcsNJRaiU3aFS22rIFhLjPrpWhFQfKdvWDMC/xd8EoupQVaY/1PhA6Sjktfq9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.219.41; helo=mail-qv1-f41.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.219.41; helo=mail-qv1-f41.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKyXl6Kj4z2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:02:31 +1100 (AEDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c5e31bea9so23091176d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872949; x=1794477749;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=1KM1Hpw4Xgy7mUNvSAHHTeZbVQRHF9ZQnn67GClbXDCuAHyvtq039mCQoXAhfNFv0F
         BvJVziiOUqrHH+yEgv8KWfwmNchNJaUVqv35LpATXoDU8j+BpfA/MjwVpt9Y1RdA/xzR
         AFqnh1/l4fs7lAJOSGK66NVi6ij5DgQcKT4fIwq63Z534xEw9cDtkN9H3ywi1paBwr36
         hpOUdUUjX+gs4FJG0/jP3aJCs8X22gv+jv/O45M+ZipllNlcMbspdmfqkU+YIqYLd9G9
         FhWvp/O1dj1xyML+KYhGOVmhTy8F98NDt9VxQmST0BCfRSC5SHfLrDdEFxlVsM28yHj8
         sHhQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/CjiBJUCHIaMcBT5lMRg41AMPSp57p5/jqSzlnKN7N/OY8dTa/XtdMYLudNxyz+SSzAcThU5btzVBYMI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z91yM8rvc7QzY1QMIGC+kQW+MoT7t4hmp3N2IwSsKG6nLqrhWqd
	brMiJHsc7TnbgswOUTMl+YkoQlonws03lhmiAva+XWNCYKDzCaiRzfUgq4i4Cz1h0uA=
X-Gm-Gg: AYBFou1H8KU18h4D9+Aqi/bNLJfgKp19H7L+QjH/XwOEwFysFVUfaHO/G5j3uOEchzM
	Md+Yr9JOt0SMXOA+oQEZ2N/zKZqq+z4KpjswLNoUIfRXU5GxEZ1IM+65WwemKZuUmye2vHdtSYm
	kt5vh7Ucvuygbq+00+37agIT+tU/Gba0r0FSLmmJ5g3O5gJZJIdEthyUj2bjHP3H/c4zFpsgzqs
	kW25hMua++CSBwb7eOap7XKOpY0gYaVKb+VrMM6X/GzIQKIxsOFsHUP74i2t4PeF68gykFhiqY3
	5v36tlI0UgomewpY+Ds4UrSch3kYQ+qM4EMP+Z5s3Txzoh+aArBB3wIV4Pi/XnLBEFeRqI/1lrI
	CxB9Jwbi91XxD3s4icpks39wS2YjK/td/V3GhbkH63+lexAFY1Qpuw7YfXsTbouZP9L8isfg8cE
	IAhJDSZKCpUNU2o7LHMFjCbIvdl/2VrToSPhhYAJe5Z4Lz/SX9/vtnABVRBSh/10RIQRXd49ovR
	/JTWML5dJFyetCvfLhcbrKSr/2S/sIwldtANb0WJ+M7PVy9UKcHuPd3mKevFS1O+ViSAKMrv9/2
	rpOe+VB/Z9aANDZXUfoBd2dU+zrQ3ivPCy9j8AajT5iW131o5rs4CJEZkFmH8wv25eoP+Q==
X-Received: by 2002:a05:6214:2028:b0:917:aa2e:d007 with SMTP id 6a1803df08f44-91ca4b32e96mr308962526d6.12.1793872948846;
        Thu, 05 Nov 2026 02:02:28 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dacef6csm43353666d6.5.2026.11.05.02.02.27
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:28 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5364042eecfso22735431cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:02:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx2/Dsd9CX74UVHOjKW0hk0ElS8r3D2JQDGCvXD/WMhchFIQOHjyvglwnUVh8CXxMBUOTmJ3flyT3yMBhA=@lists.ozlabs.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
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
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
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

