Return-Path: <SRS0=LEFZ=7J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3F6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 20:25:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF36D204EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 20:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1W/ZagWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF36D204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49XMm42FPdzDqWs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 06:25:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=1W/ZagWc; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49XMjB6S08zDqWH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2020 06:23:26 +1000 (AEST)
Received: from kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net (unknown
 [163.114.132.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74B9B204EF;
 Wed, 27 May 2020 20:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590611004;
 bh=whd5ax6cW2yilyozMSk0cai8e9IPd9MC6dtkaAAIeaQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=1W/ZagWcskvMfGNeYpwXDQ0E6cw7I2krExjORRNnbCOgfUxAw4U3PrBF9MAnP34QK
 pGBpbqhl+ES8lchRtO5oY3o6gCS41OTUTqKpA/8o9HoS+BUrVVPD0eBOPbL4/f/6Pg
 SdPtw4HHGHH8bwupYLAjAdJb8eiiaX6qju2hZUPI=
Date: Wed, 27 May 2020 13:23:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: Re: [PATCH v3 0/7] Statsfs: a new ram-based file system for Linux
 kernel statistics
Message-ID: <20200527132321.54bcdf04@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <6a754b40-b148-867d-071d-8f31c5c0d172@redhat.com>
References: <20200526110318.69006-1-eesposit@redhat.com>
 <20200526153128.448bfb43@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <6a754b40-b148-867d-071d-8f31c5c0d172@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Jonathan Adams <jwadams@google.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Lunn <andrew@lunn.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Rientjes <rientjes@google.com>,
 linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 27 May 2020 15:14:41 +0200 Emanuele Giuseppe Esposito wrote:
> Regarding the config, as I said the idea is to gather multiple 
> subsystems' statistics, therefore there wouldn't be a single 
> configuration method like in netlink.
> For example in kvm there are file descriptors for configuration, and 
> creating them requires no privilege, contrary to the network interfaces.

Enumerating networking interfaces, addresses, and almost all of the
configuration requires no extra privilege. In fact I'd hope that
whatever daemon collects network stats doesn't run as root :)

I think enumerating objects is of primary importance, and statistics 
of those objects are subordinate.

Again, I have little KVM knowledge, but BPF also uses a fd-based API,
and carries stats over the same syscall interface.
