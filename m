Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F291C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Nov 2021 14:24:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7CB610E9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Nov 2021 14:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E7CB610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hntf26wkgz3cBQ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Nov 2021 01:24:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=netrider.rowland.org (client-ip=192.131.102.5;
 helo=netrider.rowland.org; envelope-from=stern+618c59fc@netrider.rowland.org;
 receiver=<UNKNOWN>)
X-Greylist: delayed 394 seconds by postgrey-1.36 at boromir;
 Tue, 09 Nov 2021 01:23:45 AEDT
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by lists.ozlabs.org (Postfix) with SMTP id 4HntdY2sw8z2xXm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Nov 2021 01:23:45 +1100 (AEDT)
Received: (qmail 1667203 invoked by uid 1000); 8 Nov 2021 09:17:03 -0500
Date: Mon, 8 Nov 2021 09:17:03 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v0 00/42] notifiers: Return an error when callback is
 already registered
Message-ID: <20211108141703.GB1666297@rowland.harvard.edu>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101924.15759-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108101924.15759-1-bp@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: alsa-devel@alsa-project.org, x86@kernel.org, linux-sh@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
 netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>,
 sparclinux@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Rohit Maheshwari <rohitm@chelsio.com>,
 linux-staging@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com,
 xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
 linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>,
 rcu@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, intel-gvt-dev@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
 linux-parisc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 08, 2021 at 11:19:24AM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi all,
> 
> this is a huge patchset for something which is really trivial - it
> changes the notifier registration routines to return an error value
> if a notifier callback is already present on the respective list of
> callbacks. For more details scroll to the last patch.
> 
> Everything before it is converting the callers to check the return value
> of the registration routines and issue a warning, instead of the WARN()
> notifier_chain_register() does now.

What reason is there for moving the check into the callers?  It seems 
like pointless churn.  Why not add the error return code, change the 
WARN to pr_warn, and leave the callers as they are?  Wouldn't that end 
up having exactly the same effect?

For that matter, what sort of remedial action can a caller take if the 
return code is -EEXIST?  Is there any point in forcing callers to check 
the return code if they can't do anything about it?

> Before the last patch has been applied, though, that checking is a
> NOP which would make the application of those patches trivial - every
> maintainer can pick a patch at her/his discretion - only the last one
> enables the build warnings and that one will be queued only after the
> preceding patches have all been merged so that there are no build
> warnings.

Why should there be _any_ build warnings?  The real problem occurs when 
a notifier callback is added twice, not when a caller fails to check the 
return code.  Double-registration is not the sort of thing that can be 
detected at build time.

Alan Stern

> Due to the sheer volume of the patches, I have addressed the respective
> patch and the last one, which enables the warning, with addressees for
> each maintained area so as not to spam people unnecessarily.
> 
> If people prefer I carry some through tip, instead, I'll gladly do so -
> your call.
> 
> And, if you think the warning messages need to be more precise, feel
> free to adjust them before committing.
> 
> Thanks!
