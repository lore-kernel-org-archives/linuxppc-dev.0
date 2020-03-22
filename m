Return-Path: <SRS0=TpGY=5H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBEFC4332D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2020 01:38:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E41A20754
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2020 01:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PL1RyTyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E41A20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48lKs74WBlzDrh8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2020 12:38:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=joelfernandes.org (client-ip=2607:f8b0:4864:20::743;
 helo=mail-qk1-x743.google.com; envelope-from=joel@joelfernandes.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.a=rsa-sha256 header.s=google header.b=PL1RyTyq; 
 dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48lKqM169KzDrgK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2020 12:36:29 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id i6so2483412qke.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2020 18:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ubq/qZnX/ujKaYfjOueGLD6Nqh5QSMEUH2vduTkKjHA=;
 b=PL1RyTyq/WRZKZrEHqL4R/7W0dJU38ey6RtLKNXSwKxSkIN9TA8rk+1XHkXSB34Z3U
 +hT8qUXMqZjtKTftKJLwunclFMXbCFua88wGTvXHtsD23zMsiUUWyiPeyIJ6vgtbThHW
 gFwhM+xyJWfZ3VhmNgEQUPD4gXknbn5mHpUV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ubq/qZnX/ujKaYfjOueGLD6Nqh5QSMEUH2vduTkKjHA=;
 b=edHOSvlRSH0v4bN/+FwfsALVCIt15oy8dYqNfdjs8e8iayUGh0ibibRjFZVqBe6727
 R41SH+zIRsQo13nWP0u2IXde6633c+8HWytjzlY9bGKrKv/Ml/642p+MFfYFGuba+PUD
 4NL5WKnWmC937bVMeLL6ndCergBF4iFKzLyeX8TUx05zpCz5IBsMULq7Am7nFo/cUVkc
 vg0wSR5G63+OMylCWKydkAlFj4otu7pNV6aHBgWF96LAmgPrzNRzAgyUeVYMy2yFhDlJ
 8vFETLfgzzHDJBRhqSBmMbvqvHElIHwxKzaJ0mkqQtHDOlgzPrlLKXatx9uzW+Fxc8yj
 Y5sA==
X-Gm-Message-State: ANhLgQ1XHbFRfo/qsq73jlBDL+jB3xBchFm24rk7dYKCKmsscEM7IE8U
 13s7fAIThIFTh57+IffoTSgRFg==
X-Google-Smtp-Source: ADFU+vu+Jf1CVw4GQOx5dNoxGTymqpn5p1dmtyWCTiwwU99STlnO5FKSrpzUOQTz2PYCKmBpD/vEgA==
X-Received: by 2002:a37:db0a:: with SMTP id e10mr2637693qki.273.1584840985412; 
 Sat, 21 Mar 2020 18:36:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
 by smtp.gmail.com with ESMTPSA id w18sm7979664qkw.130.2020.03.21.18.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 18:36:24 -0700 (PDT)
Date: Sat, 21 Mar 2020 21:36:24 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 08/15] Documentation: Add lock ordering and nesting
 documentation
Message-ID: <20200322013624.GA161885@google.com>
References: <20200318204302.693307984@linutronix.de>
 <20200318204408.211530902@linutronix.de>
 <20200321212144.GA6475@google.com>
 <874kuhqsz3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kuhqsz3.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
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
Cc: Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-pci@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, Logan Gunthorpe <logang@deltatee.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Kalle Valo <kvalo@codeaurora.org>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 21, 2020 at 10:49:04PM +0100, Thomas Gleixner wrote:
[...] 
> >> +rwsems have grown interfaces which allow non owner release for special
> >> +purposes. This usage is problematic on PREEMPT_RT because PREEMPT_RT
> >> +substitutes all locking primitives except semaphores with RT-mutex based
> >> +implementations to provide priority inheritance for all lock types except
> >> +the truly spinning ones. Priority inheritance on ownerless locks is
> >> +obviously impossible.
> >> +
> >> +For now the rwsem non-owner release excludes code which utilizes it from
> >> +being used on PREEMPT_RT enabled kernels.
> >
> > I could not parse the last sentence here, but I think you meant "For now,
> > PREEMPT_RT enabled kernels disable code that perform a non-owner release of
> > an rwsem". Correct me if I'm wrong.
> 
> Right, that's what I wanted to say :)
> 
> Care to send a delta patch?

Absolutely, doing that now. :-)

thanks,

 - Joel

