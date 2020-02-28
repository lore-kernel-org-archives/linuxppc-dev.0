Return-Path: <SRS0=/+OH=4Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6985EC3F2CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 06:32:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE472468E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 06:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE472468E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TKTt2F64zDrMC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 17:32:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
X-Greylist: delayed 2008 seconds by postgrey-1.36 at bilbo;
 Fri, 28 Feb 2020 17:31:15 AEDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TKS33sXhzDr6l
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2020 17:31:15 +1100 (AEDT)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1j7YaJ-0001Y7-1g; Thu, 27 Feb 2020 23:53:15 -0600
Message-ID: <e8cd8f287934954cfa07dcf76ac73492e2d49a5b.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Jason Yan <yanaijie@huawei.com>, Daniel Axtens <dja@axtens.net>, 
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, 
 christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, 
 npiggin@gmail.com, keescook@chromium.org,
 kernel-hardening@lists.openwall.com
Date: Thu, 27 Feb 2020 23:53:13 -0600
In-Reply-To: <8171d326-5138-4f5c-cff6-ad3ee606f0c2@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
 <87tv3drf79.fsf@dja-thinkpad.axtens.net>
 <8171d326-5138-4f5c-cff6-ad3ee606f0c2@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, dja@axtens.net, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr,
 benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 keescook@chromium.org, kernel-hardening@lists.openwall.com,
 linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2020-02-26 at 16:18 +0800, Jason Yan wrote:
> Hi Daniel,
> 
> 在 2020/2/26 15:16, Daniel Axtens 写道:
> > Hi Jason,
> > 
> > > This is a try to implement KASLR for Freescale BookE64 which is based on
> > > my earlier implementation for Freescale BookE32:
> > > https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131718
> > > 
> > > The implementation for Freescale BookE64 is similar as BookE32. One
> > > difference is that Freescale BookE64 set up a TLB mapping of 1G during
> > > booting. Another difference is that ppc64 needs the kernel to be
> > > 64K-aligned. So we can randomize the kernel in this 1G mapping and make
> > > it 64K-aligned. This can save some code to creat another TLB map at
> > > early boot. The disadvantage is that we only have about 1G/64K = 16384
> > > slots to put the kernel in.
> > > 
> > >      KERNELBASE
> > > 
> > >            64K                     |--> kernel <--|
> > >             |                      |              |
> > >          +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
> > >          |  |  |  |....|  |  |  |  |  |  |  |  |  |....|  |  |
> > >          +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
> > >          |                         |                        1G
> > >          |----->   offset    <-----|
> > > 
> > >                                kernstart_virt_addr
> > > 
> > > I'm not sure if the slot numbers is enough or the design has any
> > > defects. If you have some better ideas, I would be happy to hear that.
> > > 
> > > Thank you all.
> > > 
> > 
> > Are you making any attempt to hide kernel address leaks in this series?
> 
> Yes.
> 
> > I've just been looking at the stackdump code just now, and it directly
> > prints link registers and stack pointers, which is probably enough to
> > determine the kernel base address:
> > 
> >                    SPs:               LRs:             %pS pointer
> > [    0.424506] [c0000000de403970] [c000000001fc0458] dump_stack+0xfc/0x154
> > (unreliable)
> > [    0.424593] [c0000000de4039c0] [c000000000267eec] panic+0x258/0x5ac
> > [    0.424659] [c0000000de403a60] [c0000000024d7a00]
> > mount_block_root+0x634/0x7c0
> > [    0.424734] [c0000000de403be0] [c0000000024d8100]
> > prepare_namespace+0x1ec/0x23c
> > [    0.424811] [c0000000de403c60] [c0000000024d7010]
> > kernel_init_freeable+0x804/0x880
> > 
> > git grep \\\"REG\\\" arch/powerpc shows a few other uses like this, all
> > in process.c or in xmon.
> > 
> 
> Thanks for reminding this.
> 
> > Maybe replacing the REG format string in KASLR mode would be sufficient?
> > 
> 
> Most archs have removed the address printing when dumping stack. Do we 
> really have to print this?
> 
> If we have to do this, maybe we can use "%pK" so that they will be 
> hidden from unprivileged users.

I've found the addresses to be useful, especially if I had a way to dump the
stack data itself.  Wouldn't the register dump also be likely to give away the
addresses?

I don't see any debug setting for %pK (or %p) to always print the actual
address (closest is kptr_restrict=1 but that only works in certain
contexts)... from looking at the code it seems it hashes even if kaslr is
entirely disabled?  Or am I missing something?

-Scott


