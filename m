Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA23FC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:29:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5453E20651
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5453E20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Yn59335yzDqR2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:29:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Yn3P6Q3wzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 20:27:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Yn3N4vjcz9sMQ;
 Tue,  8 Jan 2019 20:27:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
In-Reply-To: <alpine.LNX.2.21.1901071533060.30@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
 <8736q5xst1.fsf@concordia.ellerman.id.au>
 <alpine.LNX.2.21.1901071533060.30@nippy.intranet>
Date: Tue, 08 Jan 2019 20:27:27 +1100
Message-ID: <87h8ejts74.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Finn Thain <fthain@telegraphics.com.au> writes:
> On Mon, 7 Jan 2019, Michael Ellerman wrote:
>
>> Arnd Bergmann <arnd@arndb.de> writes:
>> > On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>> >
>> >> +static ssize_t ppc_nvram_get_size(void)
>> >> +{
>> >> +       if (ppc_md.nvram_size)
>> >> +               return ppc_md.nvram_size();
>> >> +       return -ENODEV;
>> >> +}
>> >
>> >> +const struct nvram_ops arch_nvram_ops = {
>> >> +       .read           = ppc_nvram_read,
>> >> +       .write          = ppc_nvram_write,
>> >> +       .get_size       = ppc_nvram_get_size,
>> >> +       .sync           = ppc_nvram_sync,
>> >> +};
>> >
>> > Coming back to this after my comment on the m68k side, I notice that
>> > there is now a double indirection through function pointers. Have you
>> > considered completely removing the operations from ppc_md instead
>> > by having multiple copies of nvram_ops?
>> >
>> > With the current method, it does seem odd to have a single
>> > per-architecture instance of the exported structure containing
>> > function pointers. This doesn't give us the flexibility of having
>> > multiple copies in the kernel the way that ppc_md does, but it adds
>> > overhead compared to simply exporting the functions directly.
>> 
>> Yeah TBH I'm not convinced the arch ops is the best solution.
>> 
>> Why can't each arch just implement the required ops functions? On ppc
>> we'd still use ppc_md but that would be a ppc detail.
>> 
>> Optional ops are fairly easy to support by providing a default
>> implementation, eg. instead of:
>> 
>> +	if (arch_nvram_ops.get_size == NULL)
>> +		return -ENODEV;
>> +
>> +	nvram_size = arch_nvram_ops.get_size();
>> +	if (nvram_size < 0)
>> +		return nvram_size;
>> 
>> 
>> We do in some header:
>> 
>> #ifndef arch_nvram_get_size
>> static inline int arch_nvram_get_size(void)
>> {
>> 	return -ENODEV;
>> }
>> #endif
>> 
>> And then:
>> 
>> 	nvram_size = arch_nvram_get_size();
>> 	if (nvram_size < 0)
>> 		return nvram_size;
>> 
>> 
>> But I haven't digested the whole series so maybe I'm missing something?
>> 
>
> The reason why that doesn't work boils down to introspection. (This was 
> mentioned elsewhere in this email thread.) For example, we presently have 
> code like this,
>
> ssize_t nvram_get_size(void)
> {
>        if (ppc_md.nvram_size)
>                return ppc_md.nvram_size();
>        return -1;
> }
> EXPORT_SYMBOL(nvram_get_size);
>
> This construction means we get to decide at run-time which of the NVRAM 
> functions should be used. (Whereas your example makes a build-time decision.)

Right, but we only need to make a runtime decision on powerpc (right?).
So it seems to me we should isolate that in the powerpc code.

> The purpose of arch_nvram_ops is much the same. That is, it does for m68k 
> and x86 what ppc_md already does for ppc32 and ppc64. (And once these 
> platforms share an API like this, they can share more driver code, and 
> reduce duplicated code.)

> The approach taken in this series was to push the arch_nvram_ops approach 
> as far as possible, because by making everything fit into that regime it 
> immediately became apparent where architectures and platforms have 
> diverged, creating weird inconsistencies like the differences in sync 
> ioctl behaviour between ppc32 and ppc64 for core99. (Early revisions of 
> this series exposed more issues like bugs and dead code that got addressed 
> elsewhere.)

I just don't see the advantage of having arch_nvram_ops which is a
structure of function pointers that are always the same on a given arch,
vs some static inlines that implement the same ops for that arch.

> Problem is, as Arnd pointed out, powerpc doesn't need both kinds of ops 
> struct. So I'm rewriting this series in such a way that powerpc doesn't 
> have to implement both. This rewrite is going to look totally different 
> for powerpc (though not for x86 or m68k) so you might want to wait for me 
> to post v9 before spending more time on code review.

OK. I know you've been working on this series for a long time and I
don't want to roadblock it, so at the end of the day I don't feel that
strongly about it as long as the code works.

I'll wait for v9 and have another look then.

cheers
