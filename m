Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D985606B016
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuIdEGHN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXcj0M4hz2xnQ;
	Thu, 05 Nov 2026 04:34:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793813668;
	cv=none; b=a4VsdUbcu/3xL65Z0R/9FIUZ9k/b+PO6qwLF6K7XiOS0mK7xuRX4ofcgQ2J/8jIwfbsfxUlnvyL2DwWbnk5tb535WEC5sb4Y1fiKGG6dLa4YXGuRu7QhIdwp1ogj7Qy+9TEqnlcHy+V11XzjSdZUojrOXcWr4pEp8lS5MzkXChl+Coj7uGVcYR5IA20+W1Bg1R4uuwAXcXpyWafQvmmW0pOborECgQNWbovk9Vrn60ESVCyDTWY2LaLot8tpeQOIQE28vZloPf1BkhmaTewsLPH10kuAsPNyihSdn70n9AJE6c86wmGiDmdDCvA+5NKFyoatHu3SyS7VWMAOs8enzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793813668; c=relaxed/relaxed;
	bh=AMOD33XmGyHm36xJWMnYgDFAfU9OylqTMFKngAIWEtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSvjzL3rD+2a5Skk97dG03JiscZUybKaGHAK95JkoYQvyWmC6TZKHuQGiN89xkCVj9L9C3QAzFMN9Kbb95Wo1slaw3pzuQ9h55CA1nHNrzrjVG4Ylch7C5jKdqOAP9lwHNFoMvtK+rUDi78iksRZj9H7d47jo17wuraLO+3Pgmxplw0lrxC/TPfKGrhby0/lGlrFfvY2dK/IL9GTxkjwqY6qpsxSSWFmmSIkLa4cQJpID/N19cHwC4Z+O6DDm0Qs3fYT++/nyPrcrONJN7svTcAg08T2kW5qAwMCP3vlDb3vJm0kwtexPbCBNY+LoqYY00C+nPzwgLyPo5+y3bJQfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuIdEGHN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuIdEGHN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXch1cXyz2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:34:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5573043EDA
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2026 17:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7121F000C1
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2026 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813666;
	bh=AMOD33XmGyHm36xJWMnYgDFAfU9OylqTMFKngAIWEtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TuIdEGHN+tlSpGP2tguvWW7kLlUQWLPYjJKJSOdpszP2pLOR7WrjdSkZZ/grMbqbK
	 +lTr56mLL+WOdircBkePq+AP1VJ8IkK1jD+a+/cNVkOM5lTrA3ra2sVKICfCT0wVFa
	 G7aUxkwbEYQTgmz4D8gML0l5sd+AeXfF/B+yunRHPHSfp3DhyhKMZ2MO8cmr1H2mgR
	 d2oAbezChMlOpKySp6bD7YhtrL6rY8cs9aS9v0EePA62cXO8uXedgf6WJ2JQI3RfVB
	 sVx/vx3dq4DLpiMPLoF4zMVjw7jCtMETWhYAirt1guo5pK4CX4JT893wQit46xG65K
	 Y99CMV8/O64SQ==
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eafb65e169so599081e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 09:34:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwHa8BzuJEYaa6tvqhoaWV8oQ0VqXE/a/tZ3dQQv+6fc8Ntl1WrsSj2W9jl7u3/OWvZ/FJFDvIzvph0HgE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9ghydgRoPiFPIIk63Fl+8HfF1/+DV7JFOUW9fVabcXy2w6/I7d
	1/2DeQMb2asH672fkv1obvaiVQR0cmZI68LeC9NrHD4I+buNb4omonFgRZzbAnuXylXnjxGUoJS
	EnF3ONyaTs5kQ3w+hinHHtQ0cSlfigPk=
X-Received: by 2002:a05:6122:180a:b0:5ec:5f1b:f725 with SMTP id
 71dfb90a1353d-5ec689c4d7fmr8231097e0c.23.1793813664918; Wed, 04 Nov 2026
 09:34:24 -0800 (PST)
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
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org> <20261104-work-procfs-bugfixes-v2-4-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-4-bbf7d5546809@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 18:34:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gnefKDcBnLzxxXPLJkYRHN9pbYH9WVFAoUGuCSOPcW1A@mail.gmail.com>
X-Gm-Features: AclHuK8WGpfSf3TpV-YfKcvDlenGAnmL4yQTyeV9z6QpHJtyVq4G8L84EjJ5Q2g
Message-ID: <CAJZ5v0gnefKDcBnLzxxXPLJkYRHN9pbYH9WVFAoUGuCSOPcW1A@mail.gmail.com>
Subject: Re: [PATCH v2 04/51] PNP: isapnp: don't go on when isapnp_cfg_begin() fails
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

On Wed, Nov 4, 2026 at 6:30=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> isapnp_cfg_begin() refuses a logical device number above 10 and a bad
> card number with -EINVAL before it takes isapnp_cfg_mutex. The callers
> that read and write the device's configuration, the proc file included,
> don't look at that: they go on talking to whatever device the card
> currently has selected and then unlock a mutex they never took in
> isapnp_cfg_end(). isapnp_create_device() hands out logical device
> numbers without a bound, so a card with twelve or more logical devices
> gets there. Return the error instead.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pnp/isapnp/core.c | 16 ++++++++++++----
>  drivers/pnp/isapnp/proc.c |  5 ++++-
>  sound/isa/es18xx.c        |  6 +++++-
>  3 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> index 219f96f2aaaf..3591a2791c1a 100644
> --- a/drivers/pnp/isapnp/core.c
> +++ b/drivers/pnp/isapnp/core.c
> @@ -853,7 +853,9 @@ static int isapnp_get_resources(struct pnp_dev *dev)
>
>         pnp_dbg(&dev->dev, "get resources\n");
>         pnp_init_resources(dev);
> -       isapnp_cfg_begin(dev->card->number, dev->number);
> +       ret =3D isapnp_cfg_begin(dev->card->number, dev->number);
> +       if (ret)
> +               return ret;
>         dev->active =3D isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
>         if (!dev->active)
>                 goto __end;
> @@ -887,10 +889,12 @@ __end:
>  static int isapnp_set_resources(struct pnp_dev *dev)
>  {
>         struct resource *res;
> -       int tmp;
> +       int tmp, ret;
>
>         pnp_dbg(&dev->dev, "set resources\n");
> -       isapnp_cfg_begin(dev->card->number, dev->number);
> +       ret =3D isapnp_cfg_begin(dev->card->number, dev->number);
> +       if (ret)
> +               return ret;
>         dev->active =3D 1;
>         for (tmp =3D 0; tmp < ISAPNP_MAX_PORT; tmp++) {
>                 res =3D pnp_get_resource(dev, IORESOURCE_IO, tmp);
> @@ -936,9 +940,13 @@ static int isapnp_set_resources(struct pnp_dev *dev)
>
>  static int isapnp_disable_resources(struct pnp_dev *dev)
>  {
> +       int ret;
> +
>         if (!dev->active)
>                 return -EINVAL;
> -       isapnp_cfg_begin(dev->card->number, dev->number);
> +       ret =3D isapnp_cfg_begin(dev->card->number, dev->number);
> +       if (ret)
> +               return ret;
>         isapnp_deactivate(dev->number);
>         dev->active =3D 0;
>         isapnp_cfg_end();
> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> index c1f6e6bd0eb2..b3abab24050b 100644
> --- a/drivers/pnp/isapnp/proc.c
> +++ b/drivers/pnp/isapnp/proc.c
> @@ -25,6 +25,7 @@ static ssize_t isapnp_proc_bus_read(struct file *file, =
char __user * buf,
>         struct pnp_dev *dev =3D pde_data(file_inode(file));
>         int pos =3D *ppos;
>         int cnt, size =3D 256;
> +       int ret;
>
>         if (pos >=3D size)
>                 return 0;
> @@ -37,7 +38,9 @@ static ssize_t isapnp_proc_bus_read(struct file *file, =
char __user * buf,
>         if (!access_ok(buf, cnt))
>                 return -EINVAL;
>
> -       isapnp_cfg_begin(dev->card->number, dev->number);
> +       ret =3D isapnp_cfg_begin(dev->card->number, dev->number);
> +       if (ret)
> +               return ret;
>         for (; pos < 256 && cnt > 0; pos++, buf++, cnt--) {
>                 unsigned char val;
>                 val =3D isapnp_read_byte(pos);
> diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
> index 3cadbf7cf238..de1eda5a0656 100644
> --- a/sound/isa/es18xx.c
> +++ b/sound/isa/es18xx.c
> @@ -1950,7 +1950,11 @@ static int snd_audiodrive_pnp_init_main(int dev, s=
truct pnp_dev *pdev)
>         /* ok. hack using Vendor-Defined Card-Level registers */
>         /* skip csn and logdev initialization - already done in isapnp_co=
nfigure */
>         if (pnp_device_is_isapnp(pdev)) {
> -               isapnp_cfg_begin(isapnp_card_number(pdev), isapnp_csn_num=
ber(pdev));
> +               int ret =3D isapnp_cfg_begin(isapnp_card_number(pdev),
> +                                          isapnp_csn_number(pdev));
> +
> +               if (ret)
> +                       return ret;
>                 isapnp_write_byte(0x27, pnp_irq(pdev, 0));      /* Hardwa=
re Volume IRQ Number */
>                 if (mpu_port[dev] !=3D SNDRV_AUTO_PORT)
>                         isapnp_write_byte(0x28, pnp_irq(pdev, 0)); /* MPU=
-401 IRQ Number */
>
> --
> 2.53.0
>
>

