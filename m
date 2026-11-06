Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F25606A31B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TMCZgtiL;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=cyvhFazL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLRxj4qNYz2xH7;
	Fri, 06 Nov 2026 16:07:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.50 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793941641;
	cv=pass; b=bFcT3Sgt7qia6RfmtBk/oPZT+HblmOCkIZT+DZv37aVzktUrbuQkUIVXmpRSqDnuniQW4dNUjVPOV4kpLfL2NEg9k52cm+sbUYpaYT/GCx/BdE1v59/S7+t+zqLa/cBRbKsqvoqBqjY2h5yRbKuwUgHGRLF6s8yC8eOhbqTVmjYew85Unk1011xCQVOOM6OVN+Tr6WaHxiXcjaJ8vVrRTmBkf4+EBNAHfQp0P/LtYzeB+nINVMJqEynPL6ygBXmHGZesLuuGOchTbc0ATTel8AdLHuEwR5a5LbyF2omPR7dQRLJ96aNK/oNtR+3xRzCv59ZaaghsH251sy6lKkcVng==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793941641; c=relaxed/relaxed;
	bh=VnDGrZnHXIuQPWIALbC30xntBi0NQEFposS5CBnrUiU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ggCJEv+3mWhPcTUJYCTqstrfwaKi/A1w2mHJycL6tur+l5gAK1vXXAzOyW4P7Laer0mm/0F1faqUvoay80dHRpTwov9p1ANk7IPvEM2+0f9iheNQc+pkScm+v7z7pL7Mac21yrrCzVkYdy+05XhfrsMzZRtr6T10rjg/VX/iQz4DR6H61XSEJl0lKjWUVkojm30ulUMmcmBjB3ikYqKk1FZgzXG9IseDvYengq7Ru6c5BGl4KpGyEvYDwwIA+M7JWvPvu2QfKMGgXhSk5y4ufksE0lzQST5CqJD8rMGM982DHu3J88Il8BHzfgGrwp0HCypWSBxwJnyesLfR98ppHA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TMCZgtiL; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=cyvhFazL; dkim-atps=neutral; spf=pass (client-ip=85.215.255.50; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TMCZgtiL;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=cyvhFazL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.50; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLRxc6xGkz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 16:07:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793941628; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HbeAG6ZURijBmu5YkINeO4Wvrp/9hQTan0BuL2Br5z4JmazBX3XLtsVfGcEd3hRyAf
    5hZfDUSRZNSewRPPn8N8TNXe3DPQdv07o62A8DfGGbB45MObaIV5EO8a4ou9aVihAh85
    deBw3QhMZChWyUCg8mjGxX0gW8wvOALKK2ZSEqo7YB7U0fxiDFkVTObjEZwrDzA2oh6n
    L13zBHUMOq1R15GBZNY5Wi72TOmIYP/qE+HtpcNP+ic4cTAcPHrjumJDlHa/0ta6M8Be
    kAGqYojwG0k77p7AmaU6YY71jFpV2R7sGfcvCFZ5o0bHRYUHQ7NfcWrP3Vk9tx63kxRN
    OWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793941628;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=VnDGrZnHXIuQPWIALbC30xntBi0NQEFposS5CBnrUiU=;
    b=XFlhKXnZORZoo8lEn5NdfK8WqopFMfp1o+VB4zKl+5oeDCZmubSdWKHS8Kp/D+dAx5
    p4S4VD1Fqde4lJbniG2095JuTcVG+Nok73j8MeKfJrS/pyrIyjmhKQp63m0Pg+eXZaCP
    Jhp+fhVUj6OXlJvPzttmy9QPNxwTZsTsM3hemJdYP8yL2wKD6ysxOk1LqjzYGTj/kaG1
    xuIhXs1h6xZH3DtFq4rVldWyc6F5dZRgP2BCqQWwfr1urePlp0pV4LWt/roGstki4O2S
    dpPOg6Tgj7ryzNrPSJK5pk9fBERLlGYEAHrgjynf6PF6RF3vaSaZ5jqN7i9IC+UVbmke
    1Lzw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793941628;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=VnDGrZnHXIuQPWIALbC30xntBi0NQEFposS5CBnrUiU=;
    b=TMCZgtiL6Kji0bq1zCy4bwcISonR3O48aqaqeWcyOu5CHC2uuCoHRQMJeAfHch19mA
    aRqnFtJ8m/nmRGBvMS/PT/amemUrzBZELf3qiIKy2mwHZuj6018rx4ja5qZufM/1M4BI
    kXzoiYoirWxHV89gpFB5kLRgWsLtvZWRHK3+OfnzsuMEczJFQrt20OujjtQ1mol76KMx
    pVT68A4LlIe9p6QarbeLQUihzbw6+6l4hsBmZupMes7SYx2KAHLplHXwBr35Fe1WQj+D
    C0FxImIGFL2Y9deFmDcrHpS/mAbqBMDA5umBEpsm47KFyHHlX3KbIzSETv3Mo/3Z+6NC
    c9XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793941628;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=VnDGrZnHXIuQPWIALbC30xntBi0NQEFposS5CBnrUiU=;
    b=cyvhFazLK15eG1ann/+L2rmmxYQOrzmW1kWiAYtVbsN3LIwILkUY1jlH9Nn97xc3S4
    YXUZN3/gKEWm2nh4oxCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+m73c="
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id e825d92A6576S88
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 6 Nov 2026 06:07:06 +0100 (CET)
Subject: [PREEMPT] Kernel panic - not syncing: stack-protector: Kernel stack
 is corrupted
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
 msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com,
 amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>
References: <c485c31c-1330-4be2-bb95-447cefa82c1e@linux.ibm.com>
 <4FED0F6E-890F-4482-99F3-39D7520C48FE@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <00f8e9aa-c3ec-1911-d81f-291d3c6ae8f0@xenosoft.de>
Date: Fri, 6 Nov 2026 06:07:06 +0100
X-Mailer: BrassMonkey/35.0.2
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
In-Reply-To: <4FED0F6E-890F-4482-99F3-39D7520C48FE@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Ever since we enabled PREEMPT on our Nemo boards [1], we have been 
experiencing occasional problems with the kernel stack.

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted 
in: srcu_gp_start_if_needed+0x534/0x538
Rebooting in 180 seconds..

We are using the following patches: [2] [3]

We have disabled PREEMPT with a patch [4] again, and since then our Nemo 
boards have been running perfectly once more.

As the problem with the kernel stack only occurs sporadically, bisection 
is impossible.

I hope you can fix the kernel stack issue.

Thanks,
Christian

[1] https://en.wikipedia.org/wiki/AmigaOne_X1000

[2] 
https://raw.githubusercontent.com/chzigotzky/kernels/refs/heads/main/patches/X1000/preempt_v1.patch

[3] 
https://raw.githubusercontent.com/chzigotzky/kernels/refs/heads/main/patches/X1000/kvm_powerpc.patch

[4] 
https://raw.githubusercontent.com/chzigotzky/kernels/refs/heads/main/patches/X1000/Kconfig.preempt.patch

[5] Kernel config: 
https://raw.githubusercontent.com/chzigotzky/kernels/31c064092e3aab0875c47d44838443c9515b2970/configs/x1000_defconfig

-- 
Sent with BrassMonkey 35.0.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_35.0.2)


