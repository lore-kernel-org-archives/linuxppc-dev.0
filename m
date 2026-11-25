Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1C6606A6A9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EJ3ahorb;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pID2Alma
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZCwk55RPz2xlh;
	Wed, 25 Nov 2026 19:47:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.52 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795596438;
	cv=pass; b=iGLrCJGAjjq0XrE7uobFXAyiNrK5L+gjgvGBdoiyXKQoJ78QmUkAiu8mRBifA8YepMY4k4yF882R5+zAqErEv1R6V7Nu3ke+hWb9AQyfHxwGc0O0qhtafFKMIMJr8CgLxivCR3tQy92k7tKhMgd7ZUO4ohgA4YqRDFtni+csECJqAIZjQejx15OCzHgF4OqsduIB9alEe0aRxedeQNkFy3AIa2ExW4BJPvCKdxjD96zHDXhgpmNMrCOqVL7iCZ8QawIHmc7nQm8ixNiZyTJsvEYF08qvq6GJaRMlqvv0xF7e5YuhL9hhk9HTcwp/0yxvK9egNWAORKlcvefd4saWmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795596438; c=relaxed/relaxed;
	bh=y6BbzlK8NdBBNAbrElRiB7RKI8gHjkVAy6G5abVQ5oU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=oLiUaZPRw36hTgTfXl6DZKh6paAIhoSh4Cydrq7/QdpXywCAHC9oqn1LBaeZSOIVSTcKP+BvZ2qh+hJOHLKfnIyi96mNubez9DOhkh6JFb6XXcerJgzhF+W93npOQjC+f9qtQJ1AQ6mbztiRBAVoE7Xqg4L5iQ4Zhxy+EuCLpRDBoocEuSfx8V6iOEHQVU9pg2Xf5bNb7L1BONSefdxxtRxWNwN9+++QchAtJ7irnhzIp7KtMyN6t7ZI86em80p/LHlaWqLAsMuIVQNXsOJZqO/vUUa7LwHINELU4c/Nl/VHHKLUzQdcCOYLdzTBAycFBK5iyX1Hv6Jp0yDkBKtEcA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EJ3ahorb; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pID2Alma; dkim-atps=neutral; spf=pass (client-ip=85.215.255.52; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EJ3ahorb;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pID2Alma;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.52; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZCwd5xRpz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 19:47:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1795596425; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m5ssfWSEVIoE+WyH+PakpfTqHJbKYQ2zjX+hI3dokizD7o6Rflok9EWOeYd257wMUe
    JGVOO5UEKi/alZRaL/IH7fdwtK+ki5bovrrRmwmxH7sfp9l4HG0C171C2wLCwvgl6dWF
    5YJPXxJR+x0XFUfVoRqr/sxB1VbNl3tAA4mXaRauHaUImL9/OdfG11Z7shbhdlj9f0NE
    UwHjkJ/1JnYqGKpMmEjI4PNXUkEEJ95EDLkc0dbDlv2O1I6NoMXXvfEdYeG6s2AqtqST
    KNrDhuMBJXlg+vXYqbn5LeuwwMTKvFJMJNQbxbkE7rjIIY9+CubJBNWSSh6hqNJL9pN9
    6GIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795596425;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=y6BbzlK8NdBBNAbrElRiB7RKI8gHjkVAy6G5abVQ5oU=;
    b=TtLPaS+S178OwbAncT0XBYrpgam3UV8QVxH3xyGzXOZAtg2tYEJsAATBt+bEtFjITn
    SYL/oi+qwEL3qdaHR1hfwBmA47nzDe0qTprR7wm7sEeFKpIgOhnDG1A2wrjvWUxdMabU
    JyRI7fXGALlRVT7u2yZHIwD46ZnOVmuNxnMQQ8zdO6xLSk9A6y+42P1Hk3Kfoit/T2jf
    nZpS0Zpo69KraqLFFzBTXimI35fVpuLlY1r8NGt9R6km3qQLMDTjNFVt09VrjLBBjDQn
    lwYmZQ/s4+w0r11TfAIXuTXFmc2tP1E6k49HwZaN5sge1+S1qeV5VUiKcVMs5ZeKE06S
    5Rcw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795596425;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=y6BbzlK8NdBBNAbrElRiB7RKI8gHjkVAy6G5abVQ5oU=;
    b=EJ3ahorbtxLr0BmzAmdeRCcLvK/OObl9suXMA3yDIpya1bkfELnc1KSOCjMe5o+Qqq
    jwGKR0ldyi+X8rh/51Wv8zhFiM1QH0AewO/AykJ4t8t92wLSm3AKLh22tcDxQ1UtMlXh
    aOHuI7xekmzlQhtpsL+5cbdTFHGbV9+OLETxbbcB+GMTGEnnqdpfmCzU/DZM1P4lv3Al
    TJy1SSZKq9Xh3GQ0z1NHElWnZo+DqDumr7SdtyS+IOJs0fLEIs25rhLjU2Cb8/Q1jz26
    ce6PJkS+2oNWYgHsM2kSgkXStdyOQqOfvykxbbJoms4jHy6YIMzydv0X+IEaRGygsme5
    kGXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795596425;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=y6BbzlK8NdBBNAbrElRiB7RKI8gHjkVAy6G5abVQ5oU=;
    b=pID2AlmakioHFpmXvycscfLkLq3XIOg95vLkOoFhrTS81CJCmAzpdyWw8fyn2EytGT
    i3P+XFqkBrIpbpKgA+BA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5mzs3mRC3wE2YFOCcU01WtcQwPmgG2z3vC42vs="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id e825d92AP8l4eQ5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 25 Nov 2026 09:47:04 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
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
Mime-Version: 1.0 (1.0)
Subject: Re: [PREEMPT] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
Date: Wed, 25 Nov 2026 09:46:53 +0100
Message-Id: <EEB13352-2FD9-4169-B709-FF7822AA591F@xenosoft.de>
References: <D0ECD6B8-7F15-48C8-87A4-DFE5F35A42D8@xenosoft.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de,
 harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
 venkat88@linux.ibm.com, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <D0ECD6B8-7F15-48C8-87A4-DFE5F35A42D8@xenosoft.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
X-Mailer: iPhone Mail (24B156)
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	UNWANTED_DEVICE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06 November 2026 at 07:09 am, Shrikanth Hegde wrote:

Hi Christian.

We had one known issue which michal had brought up.
Do you have tracing enabled or running a bpf/bcc program?

- - -

Yes, we have BPF and Tracing activated in the kernel config.

Nemo kernel config: https://github.com/chzigotzky/kernels/blob/main/configs/=
x1000_defconfig

Edit: I have deactivated tracing

Link: https://github.com/chzigotzky/kernels/releases/tag/v7.4.0-rc4-3=


