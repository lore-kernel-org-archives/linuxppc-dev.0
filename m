Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845DFC6786F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BF82080A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cg9L5Jt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BF82080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kwrp1Q28zF22T
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 02:49:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cg9L5Jt6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="cg9L5Jt6"; dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42krX12Yf3zDrPw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 23:34:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TkVjTEM6kVQXzRB4RQ0hhkgzL0CICMKKvAtTiuu/UfA=; b=cg9L5Jt6jV9UAF39jA8zglY4L
 bMurzRHotS4QihR7a37Pw9LGmRKhxWGLvNQ+5Y4FHSNBSCmUcjXROWCU+Uui4+REDnNFIhDK0rGa6
 O8g2RCMwW9tm6RitL7hs6J7wE/IcPZhPu6PwTHTjEWXnFvw0OqXKXNPvKgw3XoA2cCTE4=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:48311)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gHTAx-0001gx-79; Tue, 30 Oct 2018 12:31:15 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gHTAq-0005U9-F5; Tue, 30 Oct 2018 12:31:08 +0000
Date: Tue, 30 Oct 2018 12:31:03 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep
 splats w/ kgdb
Message-ID: <20181030123103.GL30658@n2100.armlinux.org.uk>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Wed, 31 Oct 2018 02:47:32 +1100
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
Cc: nm@ti.com, linux-mips@linux-mips.org, dalias@libc.org, vigneshr@ti.com,
 linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 mhocko@suse.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 jslaby@suse.com, mingo@kernel.org, marex@denx.de, sfr@canb.auug.org.au,
 ysato@users.sourceforge.jp, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Jisheng.Zhang@synaptics.com, tony@atomide.com, mingo@redhat.com,
 joel@jms.id.au, linux-serial@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org,
 rolf.evers.fischer@aptiv.com, asierra@xes-inc.com,
 linux-snps-arc@lists.infradead.org, dan.carpenter@oracle.com,
 ying.huang@intel.com, riel@surriel.com, linux-arm-msm@vger.kernel.org,
 frederic@kernel.org, pombredanne@nexb.com, rppt@linux.vnet.ibm.com,
 bp@alien8.de, luto@kernel.org, tglx@linutronix.de,
 andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 andrew@aj.id.au, gregkh@linuxfoundation.org,
 Douglas Anderson <dianders@chromium.org>, ralf@linux-mips.org,
 rkuo@codeaurora.org, paul.burton@mips.com, vgupta@synopsys.com, jk@ozlabs.org,
 Jason Wessel <jason.wessel@windriver.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 kstewart@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 30, 2018 at 11:56:28AM +0000, Daniel Thompson wrote:
> On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> > Looking back, this is pretty much two series squashed that could be
> > treated indepdently.  The first is a serial series and the second is a
> > kgdb series.
> 
> Indeed.
> 
> I couldn't work out the link between the first 5 patches and the last 2
> until I read this...
> 
> Is anything in the 01->05 patch set even related to kgdb? From the stack
> traces it looks to me like the lock dep warning would trigger for any
> sysrq. I think separating into two threads for v2 would be sensible.

I'm concerned about calling smp_call_function() from IRQ context with
IRQs disabled - that will block the ability of the _calling_ CPU to
process IPIs from other CPUs in the system.  If we have other CPUs
waiting on their IPIs to complete on _this_ CPU, we could end up
deadlocking while trying to grab the CSD lock.

This is the intention of warnings in smp_call_function*() - to catch
cases where deadlocks _can_ occur, but do not reliably show up.

The exceptions to the warning (disregarding oops_in_progress) are
chosen to allow IRQs-disabled calls when we're sure that the rest of
the system isn't going to be sending the calling CPU an IPI (eg,
because the CPU isn't marked online, and we only send IPIs to online
CPUs, or if we're still early in the kernel boot and hence have no
other CPUs running.)  The exception is oops_in_progress, which can
occur at any time - even with the current CPU already holding some
CSD locks (eg, oops while trying to send an IPI.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
