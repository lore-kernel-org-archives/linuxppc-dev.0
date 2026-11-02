Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530E606D83B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2OLFE46
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJPbh0csvz2xRm;
	Tue, 03 Nov 2026 08:14:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793654080;
	cv=none; b=A8ALxl62idmNW6eM5KsHVNOM1XEYlGsjKUlwTJ2g/vv693teDX7ut3BgRRHwfsPxqHbJJCFZB4gwWyc6o6ub+hhwy0zG2j0V7dCO8ZEH66gCTI+cVmUJ2xTTQDAKqTi/DenHOK2NT3fGWj+kcifneAPduhMcuTciP5qxng/wkT+7HIxt9dT4mJhgjkadyHii4Ylufq7jO7t1EhxyYattcyR9R5BDAZdjP4lB4gwmpfG1h2BZVCDGXtAW2nlHwtzJmJzzkH6lWXBvJzMxFeH7LrIBrQb4B8RGx1Yq4wJTx5wuWF88Pi9+PHVxzuBBY934lVh1E7ouBfXo6T26hQZm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793654080; c=relaxed/relaxed;
	bh=e/MGsEabL/7GG396Jx8SjaCfwMIwyJ2tMCUpq+3DLDI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IGKHfdF7OVTr4A4U/cCNn5jm5EISJP7YX82Kjr+6R+65WMxDq8oXYDQzXqSdPwWdmuKsXBvXaFJfwyOUiE3r/x0vkbQcoz9UeP5TyCGa+hfDMtGFhuXcgcuvvg3eb254S68V5klMlE1VF7m5YQYNi3/68qdGfg9RCGd/pbb/i+vVDZjbm+C5FHG871zbmYqPEzjxKVuswPjcz9EJ7/MJPDXvHlCIt85oDMYhaQxcqETrIdXvNPjsNzm6rl4WsSMhOa4Tcu4ZSvY0lDDNRXgGbQpWrSEqnOySI2rPE4LUkCPHFus9tov6NCXRsXQjbgzWJffKKgs5BaXoJF/GNsjOfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2OLFE46; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2OLFE46;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJPbf5kvRz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:14:38 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 07BF4601FA;
	Mon,  2 Nov 2026 21:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FFF1F00A1F;
	Mon,  2 Nov 2026 21:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654075;
	bh=e/MGsEabL/7GG396Jx8SjaCfwMIwyJ2tMCUpq+3DLDI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=e2OLFE46TWKu5xklyz12ylfAApWKZbuHBOHbJd4znhtERP8z6pMgTnOEkR0yCqqrf
	 X0ZpIxeRlmWvAmyQE1zfgNegRkiz/UubbxC458xD4vJxAxkhweyZ+HBxeRFiQik0hK
	 +wEkAFlMdFp9HsCjiJFPZbKeeOwmN0SnZ5aHmLjB22Z3BdJ0oGBndBu3mtUx6S5oE/
	 tIdpACOgd6ZR4AXos/A2m04KYmJFV8XvlO+eyAdHJnBloO1fr3KqE20ddvUwAJAsQ0
	 ou2kTaLAFJf8XG/NKph8fFPzcavx2664UTYz2c3HH020DXXlEBK2jAFQFfsL593flq
	 hlsd3atef5CFA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 26958F4006B;
	Mon,  2 Nov 2026 16:14:34 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 16:14:34 -0500
X-ME-Sender: <xms:Ov3oaudaRP85NzNgvo9gkP-MXfbogSw56-7TMRTbPKxIonQDu3IxHQ>
    <xme:Ov3oajASSRT1bTVfE6Yfylz-Q2cb5WzhItUIpzyOnYi4Ho9AOkdZT6HjOaX20rb4D
    9taQ97lq5DfA_nhyUWeMZ_W1taGbwO-fS7RiMfZ9u2zRLst3-ycp9NX>
X-ME-Proxy-Cause: dmFkZTEwFlNdOZMJt/6ERsMJpfliFwApaNUQtGyzrNgUVhL+xr6t4hflHpnCpvlDcd34OL
    tsnnvmlp46QcBNUANprPsj0jIeIkFlAHqmtQZLa2Sf8hNpQ9wBRFf1oo7j5UmVKMmxUPoD
    CAYsZ+irDyVCdEsc2qGBd+J6vgHB5jfhOit/H7yfEU9O3BgxuDkP6BIpzFQICmtidThPiQ
    wQ5iTjbCuW/m/r0nOijWyl7wYDNa5di+BmhLTsIvAVvDZmQjQEiKQbgS7OaGcQ8IrAe2iJ
    dzOrAPUicjvABQdhm6+s8X7yR3H/OnFcIOzSI3sa7nr++6wlo9Nr7XGUu9npauH3EjdnZB
    d8SiICjs57Bl5kCrWEBHfpiNyDf0VcOFdp1B4zP1lS/QTex+fDbly0ZmI6Oy2ConL4lGxh
    /glhXDiohYMGBeqhE1OFWto0WwZtKmCLBCeSZfL9MCPfURDGaHHisnCZY6kvsOFDvhaCor
    VZqgtiO/SBK/Y5QgrCdW3HFV3LwJ8YmbXP/DugUPUadgGyQm7Xhur0+oUAzHb6By+3knGi
    7OFiG2suqU+MsawnGTt3KtMcmomuas+uDRlvRDytGDwdPSUnJzYsk2KECbsMV0y2fBTHk5
    K+qTiHGAHJZkj+8vu51m+NPaw7fmZCNvqOYyO7NAnNI1SzeRX6rDMtnriOEQ
X-ME-Proxy: <xmx:Ov3oajAjXaAo0MCg-5mOh1kpmlpYdD2YfnidScMjdG05laxXGCBcug>
    <xmx:Ov3oavbaygWZIZ9DvVH6jb71mOGY1Ado5jGzZJVcQaL4VUVNzfnyLQ>
    <xmx:Ov3oahBfqIJHdV5qBhjnVnio35nQ6hlhJrYFiJZOCEftQWgDSSVQhQ>
    <xmx:Ov3oam6fLaNBtJqW2gtTD_ISnxMIg_eBjR3o4IKYsrM5dijacJsK8g>
    <xmx:Ov3oaokDgUdqdaNtT5fJJp84D48qBuDsZWPWAns4MbOuSRRfIzDAfjj->
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E5D1F78273B; Mon,  2 Nov 2026 16:14:33 -0500 (EST)
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
X-ThreadId: AnCeav_jaY2o
Date: Mon, 02 Nov 2026 16:14:13 -0500
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
Message-Id: <f29a6aca-edda-465d-b6ab-9c7a5d7cddad@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-fs-v1-5-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
 <20261102-work-procfs-fs-v1-5-d09a996317b3@kernel.org>
Subject: Re: [PATCH RFC 05/27] nfsd: factor out setting up the exports seq_file
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, Nov 2, 2026, at 10:07 AM, Christian Brauner wrote:
> Move setting up ->private and taking the reference to the network
> namespace into exports_net_init() and dropping it into
> exports_net_put(). The procfs file needs them without the seq_open()
> and seq_release() around them.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>

-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

