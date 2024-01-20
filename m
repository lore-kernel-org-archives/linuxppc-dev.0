Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2587AC47258
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jan 2024 21:27:02 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=NchmfWpK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4THV1J5cqJz3bWH
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jan 2024 08:27:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=NchmfWpK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=armlinux.org.uk (client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk; envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk; receiver=lists.ozlabs.org)
X-Greylist: delayed 609 seconds by postgrey-1.37 at boromir; Sun, 21 Jan 2024 08:26:08 AEDT
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4THV0J3LXJz30Ng
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jan 2024 08:26:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1aBK0Gktyu8z+XAOtZwM9ibKmLTWPXmi9JXFn46Moag=; b=NchmfWpKV8qW4oGh0F1Qvj2C/6
	/9LiX34B1wlpHtipYkfPNQ+3G4sxN+nN75vc36dqQqjNMWNyQa5wFbXiDuuJCw81FAOfCSys3cLbS
	IooU5FuZdHsgy/cCTasUw23eGZLHi8rqM87NA8xNGA8TZZ5t8ap1so2ig5rH24oATjRzXeNBH9G8b
	ES6a95oRMX+OMy2zD9vQRKPlkHHSsMPeqUmu5H/RRAiTRt7YRBqjFrwcrblJ1oMA3AphMu0iwndBx
	qYPvgpL249fguGP08RS7rSdcLn8m1HFKMQRGIg7MzbGLKydZ2bOvJvLHRY4wKgtirPXoSsCPXUNrl
	VswDM4wg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40226)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rRIgD-0007pB-1l;
	Sat, 20 Jan 2024 21:15:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rRIg9-0007ya-3x; Sat, 20 Jan 2024 21:15:01 +0000
Date: Sat, 20 Jan 2024 21:15:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: patchwork-bot+linux-riscv@kernel.org
Subject: Re: [PATCH 1/1] arch/mm/fault: fix major fault accounting when
 retrying under per-VMA lock
Message-ID: <Zaw31DVa9q3JZASo@shell.armlinux.org.uk>
References: <20231226214610.109282-1-surenb@google.com>
 <170578498755.24348.16166096320323933297.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170578498755.24348.16166096320323933297.git-patchwork-notify@kernel.org>
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
Cc: linux-s390@vger.kernel.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, peterz@infradead.org, Suren Baghdasaryan <surenb@google.com>, dave.hansen@linux.intel.com, x86@kernel.org, willy@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, palmer@dabbelt.com, luto@kernel.org, catalin.marinas@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 20, 2024 at 09:09:47PM +0000, patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
> 
> This patch was applied to riscv/linux.git (fixes)
> by Andrew Morton <akpm@linux-foundation.org>:
> 
> On Tue, 26 Dec 2023 13:46:10 -0800 you wrote:
> > A test [1] in Android test suite started failing after [2] was merged.
> > It turns out that after handling a major fault under per-VMA lock, the
> > process major fault counter does not register that fault as major.
> > Before [2] read faults would be done under mmap_lock, in which case
> > FAULT_FLAG_TRIED flag is set before retrying. That in turn causes
> > mm_account_fault() to account the fault as major once retry completes.
> > With per-VMA locks we often retry because a fault can't be handled
> > without locking the whole mm using mmap_lock. Therefore such retries
> > do not set FAULT_FLAG_TRIED flag. This logic does not work after [2]
> > because we can now handle read major faults under per-VMA lock and
> > upon retry the fact there was a major fault gets lost. Fix this by
> > setting FAULT_FLAG_TRIED after retrying under per-VMA lock if
> > VM_FAULT_MAJOR was returned. Ideally we would use an additional
> > VM_FAULT bit to indicate the reason for the retry (could not handle
> > under per-VMA lock vs other reason) but this simpler solution seems
> > to work, so keeping it simple.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [1/1] arch/mm/fault: fix major fault accounting when retrying under per-VMA lock
>     https://git.kernel.org/riscv/c/46e714c729c8
> 
> You are awesome, thank you!

Now that 32-bit ARM has support for the per-VMA lock, does that also
need to be patched?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
