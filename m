Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F360CA5C7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2tiXcRL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFqn14CPz3dVJ;
	Tue, 03 Nov 2026 02:24:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633077;
	cv=none; b=F0WUxJ7xxDBqp+jOLffZ68aOpHA/KQ7ZLvf1Sg1r2ezMKrKqY2YjLRL63qM52f/efp+TgAxGiHkExl7ROmzHyuXQ40eu04jjOELM/vfODUGl7RvMNMtT8s7N363d5sDBjCfwVfJ8eTPN8Yw3CjoEZrD0YG8s8R2zM1Uk5eLNZ9hkMqeSSu5Ki7IsMMcboE2I9DyPHFGmNaeYTmYrWeBNTlFeHVh1i4Ok+ljbutUpiDpnCDeE8AQ4xlH5C+6GaHejIsTHMyo32f/6JKQ4qmjvpyBMnS7ZuGXumSLuqxC97BbZOj7xPvUImc/8dgvaNE1UGiOVCIqZpUvCCzH2FXJZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633077; c=relaxed/relaxed;
	bh=hWdxbpN4QmmVdM7UmPZX8KG1qjYZ0FQqqjiDA/VJnOE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NP/e9ywI69KxqEmAlfRfP2zEEvPVWHtGGvNDEJBM0+Xj5uOyJvqJyUhqu1Mel69wj7oL/WvdZd2j44+GbdEwiCa+K/Yy1rGRADpedtuoLZjERZp3k87CvUK+py4OrgLBxJ60ineAIl9PWaqqdF7JzK4cNfVoIHTRu5WneHjj3mrzzetDEpuPYT6Jon+J37+ICqNNoC5hLIC39v+uibgYEAVW07V+Qfb6dlN5wsD3Ox1ygmdr50DlW+ULZ2619lyGe8mLWHJt3IE9kolGq66QTaIbAm2Exu55LY4xiisly6GCWdNpz0S7fPvbg+yxd1TEWEcytpbbCYMjWnsp0yt94Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2tiXcRL; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2tiXcRL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFqm2ybJz3dTw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:24:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D83E443932;
	Mon,  2 Nov 2026 15:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885341F00A1C;
	Mon,  2 Nov 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633074;
	bh=hWdxbpN4QmmVdM7UmPZX8KG1qjYZ0FQqqjiDA/VJnOE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Q2tiXcRLjLxp0Sfv6TzxDOmLL749D8GFuBHdfpwBAeD34WSvlzVQOB66VPbtBDtEP
	 tLUMLSHppp9BGtNkx+iY6knlxASDjOHhObUbD20+r4M0FYR3O/t15nxWT7pSikrSQm
	 l80se6jfpCXXfVSnxGTpz5QshYCbpTErxlP3n0HKQQkJOPoxQWfQETJzTk1O0FgEqa
	 NmFdXlbeNn2BqDteoBNofMcN77X42d6NxWhrIvHLottL9yHP484r9SqFFyzAriZyEL
	 lYmT6OSXrQToiPByeQlZYEnbo1BZqOcbgqlCBnqZcBLQRcB8vex3ik09oALFFv4tw/
	 P9LF12YhVou9A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DF743F4006D;
	Mon,  2 Nov 2026 10:24:32 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 10:24:32 -0500
X-ME-Sender: <xms:MKvoamktWPzVHfGfqMnfBUnX12mAfqCNpYg1mnZpsjjQlytnP_GDFQ>
    <xme:MKvoaop_snACaCPsp8UbIkrX0VuTUqCS69NZfmyEg5VuQEMOwP74tDssm1mbMC7Na
    L4psiUcO7zb92ZqJJXrSnVU02K155UK_Jvir1-pnBpDMj8LrjlTIfw>
X-ME-Proxy-Cause: dmFkZTF7ntWmEwgGBlbXwlipOb1DEBDQAhhX0OL7W3ESE1c4Y58F5UnDJyEt8dnhIEkW49
    bSUNjezLoMpeptFAstes/dup+GOJHwOWVb/CWlJyXGn193f8h3l5hsZNShVjOQjsTRohCX
    A7NtHx/zL2ejOFY7nM9kfOFgoikYlrAckYOu8f7hASCDsja6Hrk1rI2T70O3iMDfg2SxYY
    Zur9L5i46jczvGC4EKxzEWA1pfFm+yB6AEfDhOzVlEFraYBZk0g/TI7U6Rq0NVJniUPAx0
    Ms7uiqAKvKWNclTSyqDyA2iZMVN/pSNwwcfh4DKH9umqsend9fzIPoI/wbZ2BY53mtMFZy
    zDHyo9usdkoEZaEpmTNoGa94y6UWs06X2+Vvayf+hT5Q00wB62DyIvXiaKtIAqQyvgezJX
    gMQyOIOZt2s0Ka06QtKc3yinHtSyP17AYeV498V+x9QPrcYPy/IjcANtd5PFTt0p4ZP/mb
    BYBzvQSBaIjqqrl6pc9hfHnF5W5BzvpNOjFH5WhHliptZEM76ApxkAEWqTQikHqy9MLimT
    SOmvYcd4EnPUd4aMEDJn0RYBZW3qZ11uB8PJIkz4XPQ45DzjQhNh88B7wEg8tgVl/zJsOZ
    8EVVdmAwwXqghCDy2L29cKu7oFIfpgdJuXdxVYsukJyDY7oGAc97hUYTlUrg
X-ME-Proxy: <xmx:MKvoahKh4Qxz2XET1vMc0TgeYLzxxsBqS_5-gXCDYyuzFKNMCpL9Gg>
    <xmx:MKvoajCApUsLjsSQE9T0YLW3NG1H8MteSFyAcNeQhGG7lN4po_K-oQ>
    <xmx:MKvoasLUqk4CAxihafDuvBm16uXYM-rD8PxB1Cn0GLv2DlrRcrPt0A>
    <xmx:MKvoajioD5IUkBoHBGTIovYDFn5dB2KnImSD1Ef9OftQO8lfEDDkGg>
    <xmx:MKvoaos93Fcbt_R095IT3GL8KWMxtU_fU-6c7khNrkI4NMTo4hEWeMfk>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AE2CD782738; Mon,  2 Nov 2026 10:24:32 -0500 (EST)
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
X-ThreadId: AG7Lg66T4xgg
Date: Mon, 02 Nov 2026 10:24:12 -0500
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
Message-Id: <097f592a-d943-4740-b99b-8983527095eb@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-fs-v1-4-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
 <20261102-work-procfs-fs-v1-4-d09a996317b3@kernel.org>
Subject: Re: [PATCH RFC 04/27] lockd: let procfs copy out reads of nlm_end_grace
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, Nov 2, 2026, at 10:07 AM, Christian Brauner wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

