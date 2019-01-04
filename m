Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FBDC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 22:06:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FAF2087F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 22:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FAF2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Wf5X1Qv2zDqML
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 09:06:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Wf3Y5rCRzDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 09:05:13 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 3770929D56;
 Fri,  4 Jan 2019 17:05:09 -0500 (EST)
Date: Sat, 5 Jan 2019 09:05:33 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v8 05/25] char/nvram: Adopt arch_nvram_ops
In-Reply-To: <20190104175639.GA6347@infradead.org>
Message-ID: <alpine.LNX.2.21.1901050855340.11@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <66ed571883695314ace53080df8f6dfb132a8b4d.1545784679.git.fthain@telegraphics.com.au>
 <20190103080229.GB11147@infradead.org>
 <alpine.LNX.2.21.1901040844380.658@nippy.intranet>
 <20190104175639.GA6347@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 4 Jan 2019, Christoph Hellwig wrote:

> On Fri, Jan 04, 2019 at 09:08:13AM +1100, Finn Thain wrote:
> > On Thu, 3 Jan 2019, Christoph Hellwig wrote:
> > 
> > > > +
> > > > +const struct nvram_ops arch_nvram_ops = {
> > > > +	.read_byte      = nvram_read_byte,
> > > > +	.write_byte     = nvram_write_byte,
> > > > +	.get_size       = nvram_get_size,
> > > > +};
> > > > +EXPORT_SYMBOL(arch_nvram_ops);
> > > 
> > > I think something this internal should always be EXPORT_SYMBOL_GPL.
> > > 
> > 
> > By "internal" do you mean "not involving interests outside of the Linux 
> > Foundation"? TBH, I don't know who's affected.
> 
> Linux Foundation doesn't matter.
> 
> But as far as I can see you export the struct from arch code
> for nvram.ko to use them and no one else, which is clearly internal.
> 

No, arch_nvram_ops is not "internal" in that sense. The struct is used 
whereever the nvram_* exports are presently used:

$ git grep -e "EXPORT_SYMBOL.*nvram" v4.20
...
v4.20:arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_read_byte);
v4.20:arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_write_byte);
v4.20:arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_get_size);
v4.20:arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_sync);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_read_byte);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(nvram_read_byte);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_write_byte);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(nvram_write_byte);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_check_checksum);
v4.20:drivers/char/nvram.c:EXPORT_SYMBOL(nvram_check_checksum);
...
$ git grep -wle "nvram_read_byte|nvram_write_byte|nvram_get_size|nvram_sync|__nvram_read_byte|__nvram_write_byte|__nvram_check_checksum"
arch/powerpc/include/asm/machdep.h
arch/powerpc/include/asm/nvram.h
arch/powerpc/kernel/setup_32.c
arch/powerpc/platforms/powermac/nvram.c
drivers/char/generic_nvram.c
drivers/char/nvram.c
drivers/platform/x86/thinkpad_acpi.c
drivers/scsi/atari_scsi.c
drivers/video/fbdev/controlfb.c
drivers/video/fbdev/imsttfb.c
drivers/video/fbdev/matrox/matroxfb_base.c
drivers/video/fbdev/platinumfb.c
drivers/video/fbdev/valkyriefb.c
include/linux/nvram.h
sound/ppc/awacs.c
$ 

-- 
