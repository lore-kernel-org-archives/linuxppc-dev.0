Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75414C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 21:53:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFC12175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 21:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFC12175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wJCd09NhzF3VB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 08:53:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42wJ9B6dY5zF3RM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 08:51:26 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBF4F1596;
 Wed, 14 Nov 2018 13:51:24 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48543F5A0;
 Wed, 14 Nov 2018 13:51:23 -0800 (PST)
Date: Wed, 14 Nov 2018 21:51:13 +0000
From: Will Deacon <will.deacon@arm.com>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 1/4] kgdb: Remove irq flags from roundup
Message-ID: <20181114215112.GA4044@brain-police>
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112182659.245726-2-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, kgdb-bugreport@lists.sourceforge.net,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 Huang Ying <ying.huang@intel.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>,
 Jason Wessel <jason.wessel@windriver.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 12, 2018 at 10:26:55AM -0800, Douglas Anderson wrote:
> The function kgdb_roundup_cpus() was passed a parameter that was
> documented as:
> 
> > the flags that will be used when restoring the interrupts. There is
> > local_irq_save() call before kgdb_roundup_cpus().
> 
> Nobody used those flags.  Anyone who wanted to temporarily turn on
> interrupts just did local_irq_enable() and local_irq_disable() without
> looking at them.  So we can definitely remove the flags.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

I'm hopeful that you'll keep hacking on kgdb, because it definitely needs
some love in its current state.

Will
