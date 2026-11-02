Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4266076734
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlNn/SoM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJF5p4sSbz30VV;
	Tue, 03 Nov 2026 01:51:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631102;
	cv=none; b=JGMG4cKNn4BDU86yHpNgnLv5Ron0EurzVCnEl1wzAZLq4AoT2eF0qQWSa5N2Hp2184c4oOGKDdLWF5rZuhDkeuFXyEbXM2o6B9a92l7c1b+cRXfn2ibv9pIBDvQcAoz5n5OUTZhJizD4yuK2HvW4Fl72nTGts6rqsKNVjIp1I7K04NPm8gCG1JFGdJl68Sam5vxZGo9oeMT31JHx1PGhezpZFihMzKO28yVoE3S+Om2+NaTs0u7gefokPPXGX3Ntw2bDRnr+wkbu854t00qKS7iwjj0v15h2yNhAtxEvf23ruZu8NdYlm2bl3Xc1Br7ueVvzHT3169yNFg9/0GhGag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631102; c=relaxed/relaxed;
	bh=3PMBNHbf4ph/mdyR65c545+LMS26XozggfD62W0AADg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEK0fSHux1ikRjeEi1x7gOdGHDjRy78BaMUYTn3UXq+6dd8/q1hL/TiOFsSGR9cLJey+W4nwBQoth/b8pdOCbtrA/jjBFVToY4C2tB8dJTxf9inKe2bGvg6vZzU929iSsc0vgcUJZVH8u+eBEFmxnzHEXLSysavUm4mvoMAx8OEXBstHu/FKM3kb0AoVxRZM0s0N4oZgbNUI1Q+I5ZmK6EA2uOqx89UB4SeXzk+0disyqapUevMYJ977AC0IHD8nnpLOVEfa1vr65U4+sfh5S7tKsc3u4ZqUPuUc4wG5HrjvD0sJ1at4IcUHNhg0YhJz6b1fnDoQpxzi9wtitsTLQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlNn/SoM; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlNn/SoM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJF5n6bxgz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:51:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 52E0044026
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2026 14:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238E21F00A29
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2026 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631100;
	bh=3PMBNHbf4ph/mdyR65c545+LMS26XozggfD62W0AADg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GlNn/SoMWD5zqxxqX/eCuEquiTNPRgmYC+uyTlQFZ16kexqk/KmCRp3INGj7ss8oQ
	 VUu1KkbtGSGsG3pM3YZ4MDiwbG5YrkBKBiN14T/X9emJ88g5DPj3pIXVn3phJmyVow
	 KX2JEr2f7UDK3U8ijM+CbxeE6tC6vIkI/nKJYJzvIxjwONjYrUXdb0ed56rsLZ06JR
	 rdYISyB5bt/rhPIvfR1HgK23GVD6ypB685bMRxWVtqNBK0a9B3nWL37+brdRtxbv2s
	 OHz5HfLYY/uUgJVHbpI/TT4TXRUNjrxgB4dmkRp6j56kdwhka9W+cvSiBS0wLtgATL
	 65EIv4d24CLeA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so1862944e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 06:51:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwxD3KiFeIzHLiBWEJo2yas3YVQe/9BscSq5toNwr8LRKwcOHgOTJVASltNlBlqjpxFH1HmNAgE+Oha6Fk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9Q+aQzOwhmKgngqFUG9PF0aUTwKvkz+IBSMjRI4iZ0PdZhY5/h
	wnDMeV+w65KX22lNLPtUfw3zdK8UtWs8sbMEJhXqRV3sgb2BmqITHOzdXjlFcIyKyE6xsSeTXWp
	Up6hAFNbq1DKyow2YBlEPPMQtYj4gEDU=
X-Received: by 2002:a05:6512:39cf:b0:5bc:b0b9:f457 with SMTP id
 2adb3069b0e04-5bfd95827e8mr3755837e87.47.1793631098488; Mon, 02 Nov 2026
 06:51:38 -0800 (PST)
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
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-2-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-2-59422ed3e465@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 2 Nov 2026 15:51:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gw6xykAX3dvJmjhVOQudF8qKgKLViY0oXGzUWqDsWDbg@mail.gmail.com>
X-Gm-Features: AclHuK-8h3kqhIhfKB_FBrHc69T85DQwOpvSG7VveYTuGyJayTx7vBef-7fYqkY
Message-ID: <CAJZ5v0gw6xykAX3dvJmjhVOQudF8qKgKLViY0oXGzUWqDsWDbg@mail.gmail.com>
Subject: Re: [PATCH RFC 02/38] PNP: isapnp: don't read past the end of the
 buffer on a large pread()
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 3:22=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> isapnp_proc_bus_read() truncates the position to an int. A pread() at
> an offset like 0xfffffc00 turns it negative, the check against the size
> of the configuration space passes, and the loop then puts everything
> from that position up to byte 256 into the reader's buffer, no matter
> how few bytes were asked for.
>
> Keep the position as a loff_t and clamp the count against what is left
> of the configuration space.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pnp/isapnp/proc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> index c1f6e6bd0eb2..8197c7f29743 100644
> --- a/drivers/pnp/isapnp/proc.c
> +++ b/drivers/pnp/isapnp/proc.c
> @@ -23,14 +23,12 @@ static ssize_t isapnp_proc_bus_read(struct file *file=
, char __user * buf,
>                                     size_t nbytes, loff_t * ppos)
>  {
>         struct pnp_dev *dev =3D pde_data(file_inode(file));
> -       int pos =3D *ppos;
> +       loff_t pos =3D *ppos;
>         int cnt, size =3D 256;
>
>         if (pos >=3D size)
>                 return 0;
> -       if (nbytes >=3D size)
> -               nbytes =3D size;
> -       if (pos + nbytes > size)
> +       if (nbytes > size - pos)
>                 nbytes =3D size - pos;
>         cnt =3D nbytes;
>
>
> --
> 2.53.0
>
>

