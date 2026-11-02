Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E482606D809
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VN2aaJi0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJPXr3x7Jz2xNC;
	Tue, 03 Nov 2026 08:12:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793653932;
	cv=none; b=JT9BqZDdHPQScR+b9ue+bSNLm/gI1kLBnsY5swQUelKkETInN0JQcWItMoBi80Ha6z1Jh68OrJ4IdRYHVxO1XBu038vIaXvQ9Mo/Vgn1uMu3AGmeBRUnQk3AYr3RcKjMyBaYW5Zp15sM6wscsgrcw8cgNK2NXmycTIT0J4yyEn3C4QazS2yJvtnK8JMkmgGnCJCRHymB6k4cSzVLxKll4DQGTdN/0SiObSszKGD67+NN1wyu2mvK8+3zpF5Il9x2yKDNGgOyUM+YJcLQ2qHEHmQkHotWtc3fbW090UIPjj36LA7FJFB0Djhgbrtn9oNGQN21cscqQMjMgVTSMApGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793653932; c=relaxed/relaxed;
	bh=2GzKULsklpP+bGy2QkTiTCDYRGUHpWIftO7smBM1HBU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DzlqmkQZd6hZE0t6C2uPXXJJoch0FBqn2siJgEBFx5M4n/15qiDp5rQvz7Xhc5Ajdiq3so6HnEPofD8MU+TZz4HbL7C4Nyv4JRimqsrFBHWBgBRsKsmsChSHp9HmDMN5V9CuGMlsYY+sYfDNN0HQ3l3RDzlqZ5ZYoYghrXDfZGOM59hlI1jLiBqwN8h+Y9R4PbXXYi/fE0BNKt3bYrGYkc721JrACK9DNxml7MLKu6Zb2b3QstfuYcXbuu1rn+dXrMa7/6qOn7JBAIQ/6EuGDrnZJjmYMQCTcJ3g7j2kA6u0oEr9V0s+ZvPuTceY6R2EhyDzaK+C6aw4lwoWLQKUcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VN2aaJi0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VN2aaJi0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJPXq58qtz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:12:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 39AAF43E65;
	Mon,  2 Nov 2026 21:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920A91F00A1E;
	Mon,  2 Nov 2026 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793653930;
	bh=2GzKULsklpP+bGy2QkTiTCDYRGUHpWIftO7smBM1HBU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=VN2aaJi0Enpo/UwbibABrTO9FP8EGEVLUb/vz9vQBNp8OjC3NmVCO1mof8njQrb0N
	 8nTaojVL7vqiOuVRmq6zN/ICTYAKzSqCZH2qK1irIxxLycT71QkpcLIf16xxIK093j
	 lKKQF1fjRBAJ5OCqWniikA7NThq5OCN0EujOkX1IqIYQgV5w0Qbi3132kg3ee/7DDv
	 iZOteq29zRi36GgmLA4PQTkgMuWdxOHacxyUYs54S+gyeSe9Uj/RO7kAaIBRnQK0PC
	 yGCoolHduytEqDS8DEJewjzj3XLbooRKj+GefsCn1nFmGMsKRiZSByfrTTgdlxRhV9
	 MrUhNhz/3+a5g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BD91CF4006B;
	Mon,  2 Nov 2026 16:12:07 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 16:12:07 -0500
X-ME-Sender: <xms:p_zoar5wEOL-zlzp67mMM3x-0bNAjLemfC24U704bCdiqApcAHrL5g>
    <xme:p_zoaruIAZVbhbJzkx6BZiPT6OnY7CcZh02-zEnuIJo4UcNxLgosp2J6h-TjliEVB
    ZqPJYchFTqtRNpd3xztymrlwtOCf3UCUYjdeN78ZHthOZxdfY00mLZG>
X-ME-Proxy-Cause: dmFkZTGxQYs5bpjtdWlj8Aj0/kqiZPUFTcG+D5sN6gK6OkOpehgbLdIraoHIQBNOWiC1QO
    mSiq7CL0AgyKU65TRh9vty9eizP0QQR2Z1J75kzFRAHQ8v9pgNzRqji+qoE5q3T4Jsup+X
    lzhToSRo/U4CDB0WiseMMwJQb5pcYnSUocPTYgbfxcxlJvkIz24hVYMUVudHFBxGqfAX9y
    NRDQxVeK5x1i3Ddsg7AnpUJtaaABZOgfFKMPhhjC21xlDH5T8xynEUHv8Edi58BP4r6DL0
    tXBEiINt8Tc23nn0L1i3BHrhk7xFRR/K75qYZJEABSfJdxx23pck1s5cvRrC4mNh0d07cq
    HGqupMbxlMLGMsZjotNq8oNhgdgag6r7eoO6ewOX1TyUeE9ji0ElKsavbILPyuWY3lDPj6
    kLgEwwgkqtpl6Law0FU+iVEL+uJ3v7diWIhR0jGD6twa2ajmdS50u8Oktw1hPNF+UDlUQg
    yRIKtfDMmxM/Iq3R6DZSCzcwPA38v1HlDy+8UHl2XtcweDNG2ziQfFDzT1wklzeKBNEIzn
    ncu1wt1SWxYrYOypHpFH//wS1fzQ136rl7/PeJ5P1hx6Kup+TY4sKx8NYC5+s3heyhXAT3
    qvO+b0k172/Cyt1JkoPLBDRysBXKaKKQpHWfUnjG6Zu8N7q1Sv1Cn7PvRxMg
X-ME-Proxy: <xmx:p_zoaoHJ7xvsGvW3yFXcg2GyCfq0QOXNhFMLApvXbwcVoRvOTLpFJg>
    <xmx:p_zoaqD_fWcNQS-k0yAhxYt-R3IJf7E5eyB3ofH-w9Jcw-Ciu6FGTA>
    <xmx:p_zoaiEsVZ8oScPDYN1YcYKCJawqQx0MVy6PLKPjVBYTbZu4plkUXw>
    <xmx:p_zoamlot3YNd3N_kPvGE0BeCL_hccbMjKBcqkXjEFdndcPA6R8aDg>
    <xmx:p_zoajqn1Cb4ZRHuQPt4ntIWweEfW3VpSRM9FhhgkVteT1l-hSkXouXh>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 96E7B78273E; Mon,  2 Nov 2026 16:12:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: A5s7LfNSi9ds
Date: Mon, 02 Nov 2026 16:11:47 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "Chris Mason" <mason@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jonathan Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 "Joel Granados" <joel.granados@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 "Takashi Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org
Message-Id: <7a864852-252c-4a62-b4f7-33072e33b7dc@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-net-v1-9-982104a4f592@kernel.org>
References: <20261102-work-procfs-net-v1-0-982104a4f592@kernel.org>
 <20261102-work-procfs-net-v1-9-982104a4f592@kernel.org>
Subject: Re: [PATCH RFC 09/11] SUNRPC: drop the ioctl of the procfs channel files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, Nov 2, 2026, at 10:07 AM, Christian Brauner wrote:
> do_vfs_ioctl() answers FIONREAD for regular files with i_size - f_pos
> before it gets to the file's ->unlocked_ioctl(). The channel files are
> regular files, so cache_ioctl_procfs() has never seen FIONREAD and only
> ever failed other commands with -EINVAL. Drop it. Other commands fail
> with -ENOTTY now.
>
> The rpc_pipefs channel files are regular files as well.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

