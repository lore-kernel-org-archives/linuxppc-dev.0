Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CA1C43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 18:29:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C330420652
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 18:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C330420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fifo99.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Mxrs58JVzF3Dy
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 04:29:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=fifo99.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=fifo99.com
 (client-ip=34.208.57.251; helo=ip-172-31-12-36.us-west-2.compute.internal;
 envelope-from=dwalker@fifo99.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fifo99.com
X-Greylist: delayed 575 seconds by postgrey-1.36 at bilbo;
 Sun, 30 Sep 2018 04:27:08 AEST
Received: from ip-172-31-12-36.us-west-2.compute.internal
 (ec2-34-208-57-251.us-west-2.compute.amazonaws.com [34.208.57.251])
 by lists.ozlabs.org (Postfix) with ESMTP id 42Mxph0flvzF370
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 04:27:07 +1000 (AEST)
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix,
 from userid 1001)
 id 0C39F40120; Sat, 29 Sep 2018 11:17:26 -0700 (PDT)
Date: Sat, 29 Sep 2018 11:17:26 -0700
From: dwalker@fifo99.com
To: Maksym Kokhan <maksym.kokhan@globallogic.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
Message-ID: <20180929181725.GB27441@fifo99.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
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
Cc: linux-mips@linux-mips.org, linux-efi@vger.kernel.org,
 Ruslan Bilovol <rbilovol@cisco.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Frank Rowand <frowand.list@gmail.com>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Daniel Walker <danielwa@cisco.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Bordunov <aborduno@cisco.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 27, 2018 at 07:55:08PM +0300, Maksym Kokhan wrote:
> Daniel Walker (7):
>   add generic builtin command line
>   drivers: of: ifdef out cmdline section
>   x86: convert to generic builtin command line
>   arm: convert to generic builtin command line
>   arm64: convert to generic builtin command line
>   mips: convert to generic builtin command line
>   powerpc: convert to generic builtin command line
> 

When I originally submitted these I had a very good conversion with Rob Herring
on the device tree changes. It seemed fairly clear that my approach in these
changes could be done better. It effected specifically arm64, but a lot of other
platforms use the device tree integrally. With arm64 you can reduce the changes
down to only Kconfig changes, and that would likely be the case for many of the
other architecture. I made patches to do this a while back, but have not had
time to test them and push them out.

In terms of mips I think there's a fair amount of work needed to pull out their
architecture specific mangling into something generic. Part of my motivation for
these was to take the architecture specific feature and open that up for all the
architecture. So it makes sense that the mips changes should become part of
that.

The only changes which have no comments are the generic changes, x86, and
powerpc. Those patches have been used at Cisco for years with no issues.
I added those changes into my -next tree for a round of testing. Assuming there
are no issues I can work out the merging with the architecture maintainers.
As for the other changes I think they can be done in time, as long as the
generic parts of upstream the rest can be worked on by any of the architecture
developers.

Daniel
