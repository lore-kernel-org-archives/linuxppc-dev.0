Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EBCC433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Nov 2021 21:45:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91A461215
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Nov 2021 21:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D91A461215
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hlcd23j0Wz307x
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 08:45:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xYAjZ8zs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=korg header.b=xYAjZ8zs; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HlccL5chCz2xWx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Nov 2021 08:44:49 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E73D6120F;
 Thu,  4 Nov 2021 21:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1636062286;
 bh=j99yLbawhP8nS65VSNwoVEG61+ELDW3rr3unGR3UBCg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=xYAjZ8zs9+oJOMxv1KXwonQ+aKbWfMmO7HfIsxDFjLoqTAj3LyGtnvu5GAHO6i8F6
 tTLnvU37UqoYDFqxPz0RM33U6DPFdsgJFgmUGeovTBXOeZZ1uqUtmKClxR9BsD+2R8
 BoNWN1J1HRZWj563lpDBMFRDadPRbxs05FsdJ6oM=
Date: Thu, 4 Nov 2021 14:44:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v3 2/4] mm: Make generic arch_is_kernel_initmem_freed()
 do what it says
Message-Id: <20211104144442.7130ae4a104fca70623a2d1a@linux-foundation.org>
In-Reply-To: <87ilyhmd26.fsf@linkitivity.dja.id.au>
References: <9ecfdee7dd4d741d172cb93ff1d87f1c58127c9a.1633001016.git.christophe.leroy@csgroup.eu>
 <1d40783e676e07858be97d881f449ee7ea8adfb1.1633001016.git.christophe.leroy@csgroup.eu>
 <87ilyhmd26.fsf@linkitivity.dja.id.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>, arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 01 Oct 2021 17:14:41 +1000 Daniel Axtens <dja@axtens.net> wrote:

> >  #ifdef __KERNEL__
> > +/*
> > + * Check if an address is part of freed initmem. After initmem is freed,
> > + * memory can be allocated from it, and such allocations would then have
> > + * addresses within the range [_stext, _end].
> > + */
> > +#ifndef arch_is_kernel_initmem_freed
> > +static int arch_is_kernel_initmem_freed(unsigned long addr)
> > +{
> > +	if (system_state < SYSTEM_FREEING_INITMEM)
> > +		return 0;
> > +
> > +	return init_section_contains((void *)addr, 1);
> 
> Is init_section_contains sufficient here?
> 
> include/asm-generic/sections.h says:
>  * [__init_begin, __init_end]: contains .init.* sections, but .init.text.*
>  *                   may be out of this range on some architectures.
>  * [_sinittext, _einittext]: contains .init.text.* sections
> 
> init_section_contains only checks __init_*:
> static inline bool init_section_contains(void *virt, size_t size)
> {
> 	return memory_contains(__init_begin, __init_end, virt, size);
> }
> 
> Do we need to check against _sinittext and _einittext?
> 
> Your proposed generic code will work for powerpc and s390 because those
> archs only test against __init_* anyway. I don't know if any platform
> actually does place .init.text outside of __init_begin=>__init_end, but
> the comment seems to suggest that they could.
> 

Christophe?
