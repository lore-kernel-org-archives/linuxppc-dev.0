Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BA606EE80
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3lPZ/DM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMMMj39Hvz2xrC;
	Sun, 08 Nov 2026 03:44:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794069873;
	cv=none; b=Y8eGn+WxLFQUGwpVWJypbBJqQT2OSnXreGHpy3SQnUBEesXhQx9HAoVN2zotTKRZ3rdvUTNts8kQu5bpXe7SULEKkob/cR4qguug50COwrT+N2nengAJWY1BSxiBzsT0Y3GChtD8cozIwONKxdrcz19vI6NA+4M/FqkZWpNJU/vjDdoRoWnHClnds7WKEAELHy8N1+fhU7w/fetcYSM81eb3T69gxY9XLMSCQqbehamzegbnIT3dXrq6xY56G3YIaCwdsQYemlb0hJk5gi/8x7jP0/0jdlcebcRvMR+UcWt+DnJCLLgAqIAOSY7wfC3elSBItnYstPX4aTQqFFSr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794069873; c=relaxed/relaxed;
	bh=G0TBUyhmKh6st027cPZY/A7ojV3HiUgM2XJr1Qt7yqs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SIM/1EGIORB2xn8cyhBvo7W1pwLo9S175W06Q6iE3Ob2oXprI+cfTQfe5LOt858Lsy4ygxuGhjJAhj11A8LKggz2+y8J8axNgJ48qSUzAAPIdfkOpTlpSW7MRsZqI2xbhg1SpWhbzPyZ0nj0IAESKqnQizSJD65rhuhs+APLMO3H9JZYenIZ4RPc2krJ4tQ2d+xmMRuu186V4rqoXL1r5dPPG8p6/jJGK4II/K2p6QcLMUSGhInnOMAtWb8XTIm+Fs6if2hlwQ6Nxm3dLuQXmFOoga970JJ2XlS9r5EK9mGpQHzAbvn8OvSkg6bHa9CgMmUBsSZkCRk8DKTx7LelJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3lPZ/DM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3lPZ/DM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMMMh3dkWz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 03:44:32 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DA1660D15;
	Sat,  7 Nov 2026 16:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E619B1F008A4;
	Sat,  7 Nov 2026 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794069870;
	bh=G0TBUyhmKh6st027cPZY/A7ojV3HiUgM2XJr1Qt7yqs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Q3lPZ/DM6uQ6KxKqeMit86Uw4h24/Oj4MoAMD+U42UyqHSJq4m8RqVF8SFBtqbgkl
	 uLKz7uSZCEmnbuYs91ZPRuPISbz6KSUXhqlGhYcdFXvRs+fV4tNtz+fMJYc6LC8oMR
	 oFDFo+Teg8oUBRgmiYpBQfMzAA1XArB/oe6USeIIpMwY/xLRQ+GXugleq6FMCjsnvR
	 oL0GzjIOrGJ7szvoPIr8z2eQLBvFfcxaFY5OSG8DuQTl7sLA5iAPsPb9X1GVQmFWRl
	 v9+b0K+DLHBtV/h4SwZCCLNGLR2bk/lGk8/rlnYsXPGkRtp7eujxFA2FlH7COmPBxC
	 cINjf9/GH3c6w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3FA84F40067;
	Sat,  7 Nov 2026 11:44:28 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 07 Nov 2026 11:44:28 -0500
X-ME-Sender: <xms:bFXvandvnO8fT9Ny0BCMkPPq4EFCNpni2vpykfELem4aQ_ooyMfLPQ>
    <xme:bFXvaoAzA2Ev766iXQhLHmbFgZ3OtIBo7SEoGueehftkt2V279uG4gPc-dHGVACl4
    3eUuL64evjIj3at6Odni9S14c19BTcr-N9PUxIQTqRuyqO5bQpFvwjH>
X-ME-Proxy-Cause: dmFkZTFFrV0pX7VIZHKjzx4tcEIBivmHNdZcL0Pkl1lJMTa+tHru5crcMzNJ3Ws5mFJzd2
    XoT9/tbpTRQi5ChHG+aO2WivfTQ8W/O4HZ8iiDaUhj+m1NpPL+KAn6GP/9UxfYRXNa7cOc
    joX0s1lnfj++o3vhXCB/o3bz0dxm7d2O02yAjwOawfYiOaHUVz/507CGSU2dlZJBdpa+Lz
    mT8nq07x/0R9yoox5e3apvL89qLOUo53VSUiLJOZQeHJ+y5wU8qmJSABIKtsK2dgt8sOGA
    T0DJ96+tszK/FKEJttYLQ0VT04nQzocHzMxQ4SOw7VSUIeN3vxtysUHCL040YGaqf23dGj
    ivvheSUM0dUu5CxVO2D3v9xKFwvw7gFiwnI6UZYJP+uiexSaebviQXnQh8wljTipWYfAFU
    IDtD+lRbDheFBrn7MsE10utxcQB7tzgbJi/CxporQ/0eC9ISB6TmNPCUWQW6EWtOUS1W/V
    EfIMfzoVkcdnKDH3f2go0raKAX0SZ+/rZLtKb8QoFwHn2sRk1lRwwIBewPwH60y5mUz1IA
    WNrlo2pYNCHcEWWJdaW35YV6jWZAX+iToSdrBmlEz3no1vvx1gGr28JIlz5xbU3YSZffVC
    XOYDs0bBCET+39NKG1Rl3ZxSLfa2WPKKz5qq4UxbERsnsGjG5/I8hnQr8ljA
X-ME-Proxy: <xmx:bFXvaiBZo0cONei-bs8Nn0XJuMfXZQKqSffOVJ8zNsNVaUiIUh4gog>
    <xmx:bFXvaj54dGXonsoLgi1ZS_BqxfhmI6DHm1oV66RilkelMocJVZZgbg>
    <xmx:bFXvahk0NuZcDB1AhZh9ACjM7Ufrv3Lvp0-YaZL6LBc10s6td6_Deg>
    <xmx:bFXvaqY5dGBTySVeOdGC2PKrnCR7w_fFScEZ0z0S-oALV8B19pi_ZA>
    <xmx:bFXvagqosWNpEErQ6k8RVnvtVK1EAxpNL3pHPEOnn-RYopUKyguaOx3_>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 12146782738; Sat,  7 Nov 2026 11:44:28 -0500 (EST)
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
X-ThreadId: A37rHgw9iumg
Date: Sat, 07 Nov 2026 11:44:07 -0500
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
Message-Id: <a04dde49-8373-4687-a905-10c3a3b89492@app.fastmail.com>
In-Reply-To: <20261104-work-procfs-net-v2-8-221e2437fed1@kernel.org>
References: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
 <20261104-work-procfs-net-v2-8-221e2437fed1@kernel.org>
Subject: Re: [PATCH RESEND v2 08/13] SUNRPC: let procfs copy out reads
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Wed, Nov 4, 2026, at 2:59 PM, Christian Brauner wrote:
> Implement ->proc_read_buf() for the procfs channel, flush,
> use-gss-proxy and gss_krb5_enctypes files so procfs copies what is read
> to userspace after it unpinned the entry.
>
> cache_read() takes an iov_iter now. The rpc_pipefs channel file passes
> one for the user buffer and behaves like before. The procfs one passes
> one for procfs' buffer, and a read still hands out at most one request.
> A reader of the procfs channel file whose copy out fails, a readv()
> with a bad later segment included, loses what was handed out, since the
> request moves on before procfs copies it out. If that was only part of
> a request the next read returns the rest of it. Both flush files share
> flush_time_text().
>
> The procfs files are removed when the network namespace goes away and
> that no longer waits for a reader that faults on its buffer.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

