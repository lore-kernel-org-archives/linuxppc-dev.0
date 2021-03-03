Return-Path: <SRS0=PW48=IB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EE1C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 15:34:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFB764EBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 15:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFB764EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DrJ2w02y9z3cYw
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 02:34:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=ba9WkkdY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=suse.com (client-ip=195.135.220.15; helo=mx2.suse.de;
 envelope-from=pmladek@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=susede1 header.b=ba9WkkdY; dkim-atps=neutral
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DrJ2R6lvyz30M3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 02:34:22 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614785659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l6vUEHEmOuwjOvJINqvANTs3pqAUVxWFEfsNxLOcO0g=;
 b=ba9WkkdYwntSk2Jk4/7eOyr/mGac1IGxTizYSuaSkMmIyBWh/+Whf+/fBKRTHbqnYqcObq
 YMo4v76fMNV3+mbDXS8sQOyDuKevTNHD3YjQOxhQhxDyZYp4/Or6lavqaScPzfGWDLfof4
 Bvu2S5SwUiCNZAvZwFiKSeBZbG2HpOM=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6E4AAAC24;
 Wed,  3 Mar 2021 15:34:19 +0000 (UTC)
Date: Wed, 3 Mar 2021 16:34:16 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH next v4 00/15] printk: remove logbuf_lock
Message-ID: <YD+seF3dQUoPcZP7@alley>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
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
Cc: linux-hyperv@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Douglas Anderson <dianders@chromium.org>, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Thomas Meyer <thomas@m3y3r.de>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Richard Weinberger <richard@nod.at>, Anton Vorontsov <anton@enomsg.org>,
 Jordan Niethe <jniethe5@gmail.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, Wei Li <liwei391@huawei.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Kees Cook <keescook@chromium.org>,
 Alistair Popple <alistair@popple.id.au>, Jeff Dike <jdike@addtoit.com>,
 Colin Cross <ccross@android.com>, linux-um@lists.infradead.org,
 Wei Liu <wei.liu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Nicholas Piggin <npiggin@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Sumit Garg <sumit.garg@linaro.org>,
 Tony Luck <tony.luck@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Jason Wessel <jason.wessel@windriver.com>,
 kgdb-bugreport@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed 2021-03-03 11:15:13, John Ogness wrote:
> Hello,
> 
> Here is v4 of a series to remove @logbuf_lock, exposing the
> ringbuffer locklessly to both readers and writers. v3 is
> here [0].

The series look ready. I am going to push it into printk/linux.git
the following week unless anyone speaks against it in the meantime.

Best Regards,
Petr
