Return-Path: <SRS0=xMQ5=PN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A5C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 23:07:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067C8222C0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 23:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067C8222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43XHNp6VY1zDqHX
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jan 2019 10:07:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43XHMB6xNqzDqDr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jan 2019 10:05:58 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 09123272DE;
 Sat,  5 Jan 2019 18:05:50 -0500 (EST)
Date: Sun, 6 Jan 2019 10:06:24 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 20/25] powerpc, fbdev: Use arch_nvram_ops methods
 instead of nvram_read_byte() and nvram_write_byte()
In-Reply-To: <alpine.LNX.2.21.1812301024400.215@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1901060931140.23@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <7e8eb87ea829c03941c895c968df2ebd0f80512f.1545784679.git.fthain@telegraphics.com.au>
 <20181229180236.Horde.idY3gOIzkSWywjIrqlXJMA1@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812301024400.215@nippy.intranet>
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
Cc: linux-fbdev@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 30 Dec 2018, I wrote:

> On Sat, 29 Dec 2018, LEROY Christophe wrote:
> 
> > Finn Thain <fthain@telegraphics.com.au> a ?crit?:
> > 
> > > Make use of arch_nvram_ops in device drivers so that the nvram_* function
> > > exports can be removed.
> > > 
> > > Since they are no longer global symbols, rename the PPC32 nvram_* functions
> > > appropriately.
> > > 
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > > ---
> > > arch/powerpc/kernel/setup_32.c             | 8 ++++----
> > > drivers/char/generic_nvram.c               | 4 ++--
> > > drivers/video/fbdev/controlfb.c            | 4 ++--
> > > drivers/video/fbdev/imsttfb.c              | 4 ++--
> > > drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
> > > drivers/video/fbdev/platinumfb.c           | 4 ++--
> > > drivers/video/fbdev/valkyriefb.c           | 4 ++--
> > > 7 files changed, 15 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> > > index e0d045677472..bdbe6acbef11 100644
> > > --- a/arch/powerpc/kernel/setup_32.c
> > > +++ b/arch/powerpc/kernel/setup_32.c
> > > @@ -152,20 +152,18 @@ __setup("l3cr=", ppc_setup_l3cr);
> > > 
> > > #ifdef CONFIG_GENERIC_NVRAM
> > > 
> > > -unsigned char nvram_read_byte(int addr)
> > > +static unsigned char ppc_nvram_read_byte(int addr)
> > > {
> > > 	if (ppc_md.nvram_read_val)
> > > 		return ppc_md.nvram_read_val(addr);
> > > 	return 0xff;
> > > }
> > > -EXPORT_SYMBOL(nvram_read_byte);
> > > 
> > > -void nvram_write_byte(unsigned char val, int addr)
> > > +static void ppc_nvram_write_byte(unsigned char val, int addr)
> > > {
> > > 	if (ppc_md.nvram_write_val)
> > > 		ppc_md.nvram_write_val(addr, val);
> > > }
> > > -EXPORT_SYMBOL(nvram_write_byte);
> > > 
> > > static ssize_t ppc_nvram_get_size(void)
> > > {
> > > @@ -182,6 +180,8 @@ static long ppc_nvram_sync(void)
> > > }
> > > 
> > > const struct nvram_ops arch_nvram_ops = {
> > > +	.read_byte      = ppc_nvram_read_byte,
> > > +	.write_byte     = ppc_nvram_write_byte,
> > > 	.get_size       = ppc_nvram_get_size,
> > > 	.sync           = ppc_nvram_sync,
> > > };
> > > diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
> > > index f32d5663de95..41b76bf9614e 100644
> > > --- a/drivers/char/generic_nvram.c
> > > +++ b/drivers/char/generic_nvram.c
> > > @@ -48,7 +48,7 @@ static ssize_t read_nvram(struct file *file, char __user
> > > *buf,
> > > 	if (*ppos >= nvram_len)
> > > 		return 0;
> > > 	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
> > > -		if (__put_user(nvram_read_byte(i), p))
> > > +		if (__put_user(arch_nvram_ops.read_byte(i), p))
> > 
> > Instead of modifying all drivers (in this patch and previous ones related to
> > other arches), wouldn't it be better to add helpers like the following in
> > nvram.h:
> > 
> > Static inline unsigned char nvram_read_byte(int addr)
> > {
> >        return arch_nvram_ops.read_byte(addr);
> > }
> > 
> 
> Is there some benefit, or is that just personal taste?
> 
> Avoiding changes to call sites avoids code review, but I think 1) the 
> thinkpad_acpi changes have already been reviewed and 2) the fbdev changes 
> need review anyway.
> 
> Your suggesion would add several new entities and one extra layer of 
> indirection.
> 

Contrary to what I said above, this kind of double indirection could be 
useful if it allows us to avoid the kind of double indirection which Arnd 
objected to (which arises when an arch_nvram_ops method invokes a ppc_md 
method). For example,

static inline unsigned char nvram_read_byte(int addr)
{
#ifdef CONFIG_PPC
	return ppc_md.nvram_read_byte(addr);
#else
	return arch_nvram_ops.read_byte(addr);
#endif
}

I'll try this approach for v9 if there are no objections. It may be the 
least invasive approach. Also, arch_nvram_ops can remain const.

-- 
