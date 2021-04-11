Return-Path: <SRS0=6Fot=JI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE0EC433ED
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 22:36:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6406611AD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 22:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6406611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJRYv6Qhgz3c0C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 08:36:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ciV9TA9s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=ciV9TA9s; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJRYP15Bmz2yRY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 08:36:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lvW0/1imLWgxPdvw89GQU7hXjnk5amCWvOf6j0ZGMxs=; b=ciV9TA9sI2hcmMk+5mvn6+GMnQ
 NVm1V6dO3xEncplJkkDlPA7TgOj6ULsrH2ZS8g/+oRMVmxes2/l/PJUJomi09t748PLbrirAblFzt
 9+iYMHD4kchH5/T/s2uhJzpGrDIP0bzFwXjxq8K7Inz0QPgN16EnsQlshWENlti99ULd0pPPgC9Vj
 MRC1FJZvgC1UEgNB5/X3wMh72XySjbvejFh2JgxyYnO2+gc/910Fy1f/DUK/AnFxSRP2HkYKAi5Ay
 A1nkFFPlVvLZHDJQxw4PZDVM6/IWhLdR10szkk3VpbK2rFhz+VFvaptbayoyArEpMhzHHNLX4tSok
 49f9Ab7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lVig5-003WFx-6L; Sun, 11 Apr 2021 22:35:44 +0000
Date: Sun, 11 Apr 2021 23:35:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: Bogus struct page layout on 32-bit
Message-ID: <20210411223537.GF2531743@casper.infradead.org>
References: <20210409185105.188284-3-willy@infradead.org>
 <202104100656.N7EVvkNZ-lkp@intel.com>
 <20210410024313.GX2531743@casper.infradead.org>
 <CAK8P3a3uEGaEN-p06vFP+jwbFt3P=Bx4=aRN+kUyB4PcFPxLRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3uEGaEN-p06vFP+jwbFt3P=Bx4=aRN+kUyB4PcFPxLRg@mail.gmail.com>
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
Cc: kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Apr 10, 2021 at 09:10:47PM +0200, Arnd Bergmann wrote:
> On Sat, Apr 10, 2021 at 4:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> > +                       dma_addr_t dma_addr __packed;
> >                 };
> >                 struct {        /* slab, slob and slub */
> >                         union {
> >
> > but I don't know if GCC is smart enough to realise that dma_addr is now
> > on an 8 byte boundary and it can use a normal instruction to access it,
> > or whether it'll do something daft like use byte loads to access it.
> >
> > We could also do:
> >
> > +                       dma_addr_t dma_addr __packed __aligned(sizeof(void *));
> >
> > and I see pahole, at least sees this correctly:
> >
> >                 struct {
> >                         long unsigned int _page_pool_pad; /*     4     4 */
> >                         dma_addr_t dma_addr __attribute__((__aligned__(4))); /*     8     8 */
> >                 } __attribute__((__packed__)) __attribute__((__aligned__(4)));
> >
> > This presumably affects any 32-bit architecture with a 64-bit phys_addr_t
> > / dma_addr_t.  Advice, please?
> 
> I've tried out what gcc would make of this:  https://godbolt.org/z/aTEbxxbG3
> 
> struct page {
>     short a;
>     struct {
>         short b;
>         long long c __attribute__((packed, aligned(2)));
>     } __attribute__((packed));
> } __attribute__((aligned(8)));
> 
> In this structure, 'c' is clearly aligned to eight bytes, and gcc does
> realize that
> it is safe to use the 'ldrd' instruction for 32-bit arm, which is forbidden on
> struct members with less than 4 byte alignment. However, it also complains
> that passing a pointer to 'c' into a function that expects a 'long long' is not
> allowed because alignof(c) is only '2' here.
> 
> (I used 'short' here because I having a 64-bit member misaligned by four
> bytes wouldn't make a difference to the instructions on Arm, or any other
> 32-bit architecture I can think of, regardless of the ABI requirements).

So ... we could do this:

+++ b/include/linux/types.h
@@ -140,7 +140,7 @@ typedef u64 blkcnt_t;
  * so they don't care about the size of the actual bus addresses.
  */
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-typedef u64 dma_addr_t;
+typedef u64 __attribute__((aligned(sizeof(void *)))) dma_addr_t;
 #else
 typedef u32 dma_addr_t;
 #endif

but I'm a little scared that this might have unintended consequences.
And Jesper points out that a big-endian 64-bit dma_addr_t can impersonate
a PageTail page, and we should solve that problem while we're at it.
So I don't think we should do this, but thought I should mention it as
a possibility.
