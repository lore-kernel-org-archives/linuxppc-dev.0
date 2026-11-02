Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD987607464B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2nlTeqX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFYx46jDz3brv;
	Tue, 03 Nov 2026 02:12:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632357;
	cv=none; b=HeT7scINAQIi8hbyL5rpTD1GCYZsA9lhJeXsOfe4jdYLI6e43jJCeq1xdTP80VatXBKu5WEQiIh/AcbxM7GEJ5kbcjcKLa0xzxBsREUiSyxEoKD1jAy6v8vVhZ43Gylm9pvo8+K+bUKquCby6SCeGfV2rnkBxebnlQ/h6DzmfF412cBRfgfyui2xc6Cm3xmnFm0TgfcTj3HuG8d428CRiAECjwLwkQam+z8jhK3p69NuJxBViqJqKw5rhfKQ0TI46wBO46o9d7iVx/Rq44TPUtD3LlPynsg+Qj1diZ6BSRe5RiXt2CHNXnAYa7O2uaDq8sPLWE82svGppPzPzDne0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632357; c=relaxed/relaxed;
	bh=2puUSp7/76IVMJdmyNoOx/+sDBWWUsstBNYgnLqWADw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HMk++t8/VoaU9h72hjZvpyUuSM7cQ5NjOP331DWehupvxiPghIsDUDjoFo1OzDRyYQlhw9GD2mJb7YaJg+9bFlRIwVLWycUCxewN1MGzXu+xyZ+6Mb1p8XcYCsBO2iAQMMRv440VhAF+0Bb5Pdz8zmDJuOzs90VM75TyraRPqt1zUuGmT2uHdORon5mjsM+M9rh1SY6JxfeJXS1pvTTXYlIFR8eZo/Y9YSLcgQLCs40Zc7MdETTVTBnN9TEbDnA/kTErsQHZMgR1IgPAghzzHmjHBrgcyMnJCdlBFD9hU6W3tjuCiWtdzegr10DFaaBnZQj79iFBfT9PGdIvMovD1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2nlTeqX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2nlTeqX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFYw3nljz3bh4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:12:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9C3E46025F;
	Mon,  2 Nov 2026 15:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BF91F00A18;
	Mon,  2 Nov 2026 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632354;
	bh=2puUSp7/76IVMJdmyNoOx/+sDBWWUsstBNYgnLqWADw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=L2nlTeqX16LDphiFhdBobWHmRhTx3MwT0KXni/7hV5TOV8Bb1iGBF0MfU/T28oZR/
	 /SuIwkJ+bVm3B2SAP0Znb5GresFtO+Es8XlzGKDMqTJcQV0Bp3f+ieUJYTno9OfXl3
	 q1a8fbQ2Je4TB9yylZoew28R96rN19ylF5xffoUOtN3tvAwU78Tz2xOZ750ZGFOCAn
	 Ibh4czCp75rOQpCxn0KHiRflcUbKFQTifBpm2+xk8Y0hf/AeeQ9QQesSLna9Ny6BTz
	 CGtK8mg8hyKzl7Pitr1bA9VTa36zdMcuCQM6lfRKQtqyKdzVALiRJ5C4DatrwnAhZz
	 e/1Npk5ZH0fPQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 78346F40069;
	Mon,  2 Nov 2026 10:12:32 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 10:12:32 -0500
X-ME-Sender: <xms:YKjoasOv3RrSExDz8qDcjU4tR13_0-05QeEGoX3KO0yVa5Q_JXv4Qg>
    <xme:YKjoatzbn5mGakKAVBtj0STq7w315IwVaiSOr1PZHyWjr-j924smg1a8vxFj4fzfB
    K48KZj80AgeA0WYHPi_tsfySNywJBS-ylsJ6nwa__tOF1VP_nbJh6E>
X-ME-Proxy-Cause: dmFkZTG3MyPc0XlAqED1F+Wk8KjBXOlJDlrqYVMEspt5uOBtma9QX/RmmeH0ol3hZ7R4Pt
    fut82mh88oF1LyQRCW33nbTrNcOEyAUw+YUk26GkfZWCIcjpom/KXDW1X6gdSU0NwNs9Bq
    gINkz2zvGlMfitRfWHXKDI6Xbw/GQquv7KUA0t5cpEv8oYMYn1JumMH2bNPyEFYi0LaaVW
    gTjD8erO7yhaZEZkFol6hjLhNbWjebLB5/6TWaEUmnBM2W6t/aMCMHdQNTL60i/brSFmlJ
    F49ErqjhZTzpCwMqPKXuvnpDLZcN6GFwse+QCZtLWlykgmsfpAVJOq0XXxE/SCWzTzMFKB
    JUaM9iWeqECb2P74jtzsncnIiXpdE66vFDRTMdrSsbc9YOSWDb7a/G9+PJYvvXP06ZeHlU
    wdJXvhXxPUh//h5dw23rQwMHeL9uK5qTRTaHnBC2dYsDFC2BB8AZen8jTr8Igxl7W0J8gc
    JBXkzMbIAHZYxFTwjFTh/bPx02ErchhPaik0sF1SyxYm3NjGsZjbnYke7SWKq7uu5k++2Z
    oqvJnoc6zt6Vy7WaQUa92MIcgZjWZnG+PRUInDn6Qgqh2mFYvj6YLofrIIKHg86v2DJVf4
    NKBNsWJ4WaOQYWJNsjjR8XWgHsQq09xTQkWrzPk39C6rB/pnIxZW8UGlovtw
X-ME-Proxy: <xmx:YKjoakzLUwu6PszVzuhRdoM8BHRr1y4l0hyIB0yfPtIg1WdznEjvDA>
    <xmx:YKjoauKWqW0tLG69qtKnFhRYfgFExDZdV_U52jDX7r0wkSY-r1mYFg>
    <xmx:YKjoaoxq5L70tsubjuyOO2gHOwQK7gqovlM-p8WnS5Bmxmdja6Ifkg>
    <xmx:YKjoajrrX1nySaQw0o0jJFW9XYunBjN4_pTDjIVXWXrtSJBHZLxp5w>
    <xmx:YKjoamWRFNPbVWqwv3QIHyU4eftWpDRXb4td_E77w__vFLI8Ej6FpTZF>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 42C93782738; Mon,  2 Nov 2026 10:12:32 -0500 (EST)
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
X-ThreadId: ARCrrC6bRUOw
Date: Mon, 02 Nov 2026 10:12:12 -0500
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
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <16f91f93-16b4-49b1-b7fa-cec69759c349@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-27-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-27-59422ed3e465@kernel.org>
Subject: Re: [PATCH RFC 27/38] sunrpc: make queue_wait a global wait queue again
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, Nov 2, 2026, at 9:21 AM, Christian Brauner wrote:
> Since commit 552d0e17ea04 ("sunrpc: convert queue_wait from global to
> per-cache-detail waitqueue") poll() and epoll queue their waiters for a
> channel file on the queue_wait head in struct cache_detail. But the
> cache_detail can be freed while its channel file is still open and
> waited on.
>
> The procfs channel files of a network namespace are removed when the
> namespace goes away. Removing a procfs file waits for the callers that
> are in one of its methods right now and then calls ->release on every
> file that is still open (cf. close_pdeo()). The waiters that poll() and
> epoll left on the head stay queued until their file is really closed.
> So:
>
>   sunrpc_exit_net()
>   -> ip_map_cache_destroy()
>      -> cache_unregister_net()
>         -> remove_cache_proc_entries()
>            -> proc_remove()      // ->release, the waiters stay queued
>      -> cache_destroy_net()      // kfree(cd)
>
> and when poll() returns remove_wait_queue() writes to the freed
> cache_detail:
>
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x4b/0xa0
>   Read of size 1 at addr ff110001131bb570 by task sunrpc-poll-uaf/242
>   Call Trace:
>    remove_wait_queue+0x22/0x1c0
>    poll_freewait+0xc2/0x230
>    do_sys_poll+0x9ba/0xd50
>    __x64_sys_poll+0x165/0x470
>   Freed by task 12:
>    kfree+0x267/0x620
>    sunrpc_exit_net+0x34/0x80
>    ops_undo_list+0x271/0x8d0
>    cleanup_net+0x3f3/0x860
>
> Closing an epoll instance that watches the file gets there through
> ep_unregister_pollwait() instead.
>
> The channel files of a network namespace belong to the root of its
> user namespace and cache_open() doesn't check for a capability. So an
> unprivileged user can open the channel file of a namespace of its own
> from the outside, poll it and let the namespace die.
>
> Go back to a single static wait queue that never goes away. A wakeup
> for one cache wakes the waiters of all caches again but cache_poll()
> reports per cache_detail so that's just a spurious wakeup. procfs
> should really own the wait queue of its files like kernfs does but
> that's nothing for stable.
>
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 552d0e17ea04 ("sunrpc: convert queue_wait from global to 
> per-cache-detail waitqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

