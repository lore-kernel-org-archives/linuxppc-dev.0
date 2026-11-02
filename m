Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA8606D839
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4XS/+Qp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJPc827qPz2xSS;
	Tue, 03 Nov 2026 08:15:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793654104;
	cv=none; b=WeYGeJejEFcBknAY8hcsUVVGHf661PmCOq6srvek02eEFhm8pvA87kd7CFSUOU++5/gQYKU39hbT6NGTo0wQKD9+i4xnx1E43FBEr2wmOkTGjARtg8dMMBCoF6ee6g8YgtnkGx/kVPUX5b1t72xrBnZOO4k8baQvtXjfR89Ck5r8dcVzSz8BSjkcVg5wKd46icOYEfxGbntr5FnLwbCKyWarNJutOCFyKUjWPk7CqmW2JiA08lPtc7crC8MT++UXqRM55/BEsNfn6+vaqDbnIkE7jAkA4aaMWFF4QHZeOeHNET58X1/4fGXOreRCuPGE+a/MCUGRM9c7ONGCDW+qAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793654104; c=relaxed/relaxed;
	bh=IboT5prE1F2zgLUjN3M8JJkwTsSKYt9w9Q1ZY5Lm5jE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UcCmB2FMK5W0v1nEaKH36yPPDkr1VDZTvrxKMCBJxCUB2faH4NFnvHxrxvZas4hu28PqClCVgPPESpZiQnBIMbvj8S5Y7TZasTZ3nlIHDaXwwnfyUH7Dd/915BK/YglKF1FaIWKk29QMcCuyHa31cx4XgYbO/ocaJtb20y37LZ9gBZK5TDPQ9EpnPTRZv/PJb+XW39/TLiXnksOfhswxG6zKLK8OFAw2J0oYLV9xFCpob7aG5YJKeYbJ4v2ljlRK+iD8AyCHm9faQNoIMdXvRvbIUL/5ZkxpMeiWmZbWO9C55TJGILa+bQE8zRCo7RMzilWn5JhI3zYbrvQiTqN6Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4XS/+Qp; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4XS/+Qp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJPc72LCsz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:15:03 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A4E0042A5F;
	Mon,  2 Nov 2026 21:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19181F00A1A;
	Mon,  2 Nov 2026 21:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654101;
	bh=IboT5prE1F2zgLUjN3M8JJkwTsSKYt9w9Q1ZY5Lm5jE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=i4XS/+Qp/XJpkpHyhLatkkxrTnb76H0AyrbluP9UrYsSjjvFvYed65zWeP+n5bDMR
	 T4jrppxwRxmsiUoLJtpEDBZOQUgSEb2I7JAqNJICoUtmRZqGDSr+AkbMY5KraB9hcp
	 LJSetra0CCoguNvIXys8kMbF38qG79C7rZIljzi9OxsucTBr2qJtAKy2hNxphivV7X
	 SqR7z4TvF6OS2jxQo3eWdNU0GD2TA876qUhcb25obxs7Qa0hq+gMR1c2AKZ0TYfXxl
	 /PRnwvUkfYbroZLwoik/xUkslivJlp+q60cSPVqp80BDXlYt0jmnPbIlU0+2JbsucT
	 rjIixFbj3/TrQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3FB84F4006B;
	Mon,  2 Nov 2026 16:14:59 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 16:14:59 -0500
X-ME-Sender: <xms:U_3oagUAPKL0KahIhejOYJwKEPfYb6twqYG_HHugM7_eLn8Er-TgPg>
    <xme:U_3oavZTuzGHMfK0qXbinG0nc7CYskrIhJQ5eHOz_Ha7XvQtwnXU_T7hJPsGo9qg4
    BhXiwA3Pdzj3QiIOE4JzHYJnc55BkwZtZcinLkFBcrDsA6sylLxQvo7>
X-ME-Proxy-Cause: dmFkZTGSCWblgfsMhzNjEIN00ph1bmXztXGhYrK6FQCSJysx8m5mqsCTJHkCuZD0tpZuBG
    pYnx6qST1krVMCyjpYhoMBo2TltjSYVP2LKGOkZnOBb4t//k/nGoJ/SIXKKJyIATQl84il
    BuXRlRV3aPeB88TAd/llIDq/9PMZ1EzorVjUV4ox06mXS/IOKUqdbOTFcr2gFtJFq3Gx7F
    Zq0nEujwlkDiPcDOX28riG6oQW7iLTgD6BaMnfnV9H0ADvTknFe8adm4EFa+o6I1mSuG3K
    LJ3epAVfTBg3DuzNRu88aZuYWYeuI7KoVJah/eioVIkx6sAoHZjqyTVRvcNhYqHYgvNdOh
    F7RoapMXPpPy7fnRDGp1EnOzRafp7mYLbQvUWevKonPpL0zVugnrni/xwOB0ZUdq15K6LL
    U4eIWAyGEDjfaCYO/Dppo1HoBBuP1Ugp4Zki+kXZHcTkA1gjEQVaV70KrwrPcut26vPd/h
    q5yJSVyn3x/Ch0xklWbVCXPbWoaIS17brwWPL/guaVzJxizQ0P/jgX0plm53NXTsLd+70V
    110yVl467ZsRMKGBWdC4JnWQHbcxAMHjeZkhkyAsfOuCVSLebxwzvInrQKLcoImyb5UwHY
    pO0Oc+d4/j2oJCRnrCOkOe51eLIclfMVgyBLq7y/6qqZiV8XA97NvuTzr1lg
X-ME-Proxy: <xmx:U_3oatxqYhX0hWpcSGJgdTO64UmbQLn1zkSvkgmn2QN3P9YNu5WJ0w>
    <xmx:U_3oav5HgW2k6KeJbHXAdQUNPTjXcBKAkESvLUwa5JME7gNZc5c0tQ>
    <xmx:U_3oasSgNqIt2BaGeBZ12VcERyFoy0lpk1cdl0eiT57vWKlvWpphXg>
    <xmx:U_3oaifZ0cTDaYHT72Jch7KjTqrgvVpyqwgckwFzCeMt7Uwl9HyKaw>
    <xmx:U_3oapwU7EvPML2sBaImLYgTk9SsDSGibfYemkcHEOBIYG1GVrkdWT-b>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 181AE78273B; Mon,  2 Nov 2026 16:14:59 -0500 (EST)
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
X-ThreadId: AlKaHQIBeldV
Date: Mon, 02 Nov 2026 16:14:38 -0500
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
Message-Id: <961e7e3d-2117-48ee-8a7e-a7a851ec8ef8@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-fs-v1-6-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
 <20261102-work-procfs-fs-v1-6-d09a996317b3@kernel.org>
Subject: Re: [PATCH RFC 06/27] nfsd: let procfs own the seq_file of
 /proc/fs/nfs/exports
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, Nov 2, 2026, at 10:07 AM, Christian Brauner wrote:
> Declare the seq_operations and let procfs open and free the seq_file.
> ->proc_open() and ->proc_release() only set up ->private and take and
> drop the reference to the network namespace now. Reading the file then
> no longer holds up its removal.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

