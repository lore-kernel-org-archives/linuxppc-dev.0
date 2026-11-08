Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C731606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0m+246eg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jN2Kg5GbDz2xwZ;
	Mon, 09 Nov 2026 06:00:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794164407;
	cv=none; b=Vex9D/tPrjKzwN5d4aAOAkp/4yqdzBWNqAJ5oxTJrHyn1zLo8O85Gf86KSNnNEOPe0wkXYnagxHfOAX+vwjiAmwiCsebw8kyAkb6HET2cUWCVWj5VqA4pFrWCnBVE5zUA7uxlOe8C3TeX8M6xl4oLo1YAu+MClJ5cbHobMbneaJHdpPGrPH8aTNNPcdHPtPJ4Vf728Rrn3lLcxqCYX7omk9EyA9gDoEA+up0TEIWrL7HcZ6TBihzEmRiNWW0fN4KYMXu3DNCTqrd8E5GQL6SJ5yGgPbkO4LPOscWMli5KgevMtVinuE6j/Ke3VHNFKL51DflgFDxu8JntmnZ9t0ODw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794164407; c=relaxed/relaxed;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKdfyHaiUCpHhquff4jTEQsvVzCvUOs+VivHyP/4uHXx8V1/ENzLCUhkmQ4vs7wWgGdS4HRJZvx8cpTiyBESYxo2kA6b/iErgx7TkDEXfS1bGe+TU5LQYQXQWhkPtm6/nc01DeT4XMzrhP1CPWl+V2+wOLs9oobLMvfkQeWQbNuNJEoM4AAn6mmp9KFtq96w6NWK3TWd4eveLv34OdrC4PQbrfyMFFzlCFXnmAsGxz3Ylc+7KUHj7U80hqFEke2ebpgoTI5vn+jGxCzCdlFhSSVivM/rxbIbEvjRnsqrwSuuslYZlKpVR1T6T+p0aQICQwSzQKhSsxTlFml5qQH7sA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0m+246eg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0m+246eg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jN2Kf0gDkz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 06:00:05 +1100 (AEDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso1791435e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=0m+246egrhJKt/CpHMXc124ZOewoj/sNV/rfIh0gaGkB9IoKW5lLYNxTqcPz5luYkK
         vU1z91gDgwQnw9/jGz46CRSgwcBHpA88vYGXLCsbI4IgTRvEs13epedPFRW3PBhqL+jl
         9J8jAhluUNbylrfm7rFxoQFxrkYGA6LsS/svQsFHcI3BpJcAbqdHwAcBaJo/1AbQFopN
         kBUOFmqxi3/Ys4nT/RRLv9gPs2RKihBDplgNSAyf7dh3oPYAWzywGsFXI4MFBPoAj7+8
         JzOHpydxx/or1bHYPdEyY6fVIBgHNL/bRON8lSVcMFZDznIKyMr3PkoIZqPxlQmCQwzE
         OkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=BMQXTV4LseUFjXaFi/6n/9YT87EnZZiO9W069sfqoCMeLZheSzwv4J6Rp9RnzGZlgY
         Vfiy5hqoHBmVCJ3kUi+pzQPsVJvHeTdWJxJnN1V87KOOD1Xw5D6jzyiCzsF9LOtK26OE
         hQtWErIffh9B3eIDjHwKNO6kOc/t/isGtgT7ZpZuol0US7WahROcPZnhimcSEC/7cG3u
         jqQMvfnslQ4M7LY/2zjEmonF0rAO4zqjQJWWEoh1SjQC/8FjYXIbJoIubhIeTVlhv3aG
         U+WAT+1S+gXa8/6HXGLhlJiiLd1VzLtMnhL+P3wQtanj8zra1uYG8mSDgYVLcJhGyhSr
         QFjw==
X-Forwarded-Encrypted: i=1; AL+hErFZceHyH+YRp0SySMt8EKHV0EN0oUN21ByhMdW0KCP9X0ZlfLCLap3vYol4ZlHRCaIal6FdU1HEbl2Nr1s=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/5iQ6QYIpJRGNanbYhwYwgMhP8VVQt8WobzehNVPvaFQC7ase/
	N9lWM1GRox97PJFsNSHrOtTGfaRIq72axrckC70sEoBJr66wf+AW/11x
X-Gm-Gg: AYBFou1tWsIKi8hDRa9fpXc9XrE6164Dwef1CqRocgc8xpIWl863J7QKmjoSPdBgq0t
	lZZyzJgmZGdgYTJgVRdS3sgpI7uXfd5eH7Gul6kEJy5/3jDPulvkCiDRLY1nysy/jEYvyTm8PRL
	MUSx45QV9AONsNXo+f5DO3uG7oCKuQ4epA/IkT5//YnhGBz5+L7skH9I4ThZl1nj4zti5keAjRC
	jeEP73c3jY0yLAizK0RmQ0Iqiav9Myxt+z76+hZd6HKlC0H3P5239KwpEsUYUM7FF/oWzl9W51P
	Tpjm42zmjRO7sZl8d8vnPrdq7k3X93NBuUmvmcqmTBVpmsZlpKcwiija6AIHVnLvaJog3lPR8yD
	bXl4BHTymBh0u7tzaJTlULYxuLehNWrLSMBfmEcxkXW5Ty5LXwnW4byZngt7Q0rmEge+NRdoHie
	WXaffOQXKtYmOopP4nN2119t0SlBvB5TfjXeRqXqVg9qOJSg2Bkao1nt+dpfWdLi3G+t2iA41kN
	8E9fFWUtjh9zOICmXR1/ylb32sCn4h5oO1T+qWuwZmapqH8RaOGhVp4OodXYM7BCFJLcL4NKp9H
	EASCArTxUcYbhpFlbg8Q4WgrUncgzTaia42+kJCt3Jxef4ahr/WM1Oe6MS+WccRk
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David

