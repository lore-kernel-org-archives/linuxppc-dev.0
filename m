Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FF0C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:45:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C259120851
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C259120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438FmV61YFzDqVB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 19:44:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438Fk74cSFzDqQv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 19:42:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 438Fk6451gz9s55;
 Tue,  4 Dec 2018 19:42:54 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] mm: add probe_user_read() and probe_user_address()
In-Reply-To: <dd9ef91add7fcf5a9e369dde322b1822e90eb218.1543811917.git.christophe.leroy@c-s.fr>
References: <dd9ef91add7fcf5a9e369dde322b1822e90eb218.1543811917.git.christophe.leroy@c-s.fr>
Date: Tue, 04 Dec 2018 19:42:52 +1100
Message-ID: <874lbtisxf.fsf@concordia.ellerman.id.au>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> In the powerpc, there are several places implementing safe
                ^
                code ?

> access to user data. This is sometimes implemented using
> probe_kernel_address() with additional access_ok() verification,
> sometimes with get_user() enclosed in a pagefault_disable()/enable()
> pair, etc... :
>     show_user_instructions()
>     bad_stack_expansion()
>     p9_hmi_special_emu()
>     fsl_pci_mcheck_exception()
>     read_user_stack_64()
>     read_user_stack_32() on PPC64
>     read_user_stack_32() on PPC32
>     power_pmu_bhrb_to()
>
> In the same spirit as probe_kernel_read() and probe_kernel_address(),
> this patch adds probe_user_read() and probe_user_address().
>
> probe_user_read() does the same as probe_kernel_read() but
> first checks that it is really a user address.
>
> probe_user_address() is a shortcut to probe_user_read()

...

> +#define probe_user_address(addr, retval)		\
> +	probe_user_read(&(retval), addr, sizeof(retval))

I realise you added probe_user_address() to mirror probe_kernel_address(),
but I'd rather we just used probe_user_read() directly.

The only advantage of probe_kernel_address() is that you don't have to
mention retval twice.

But the downsides are that it's not obvious that you're writing to
retval (because the macro takes the address for you), and retval is
evaluated twice (the latter is usually not a problem but it can be).

eg, call sites like this are confusing:

static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
{
        ...

	if (!probe_user_address(ptr, *ret))
		return 0;

It's confusing because ret is a pointer, but then we dereference it
before passing it to probe_user_address(), so it looks like we're just
passing a value, but we're not.

Compare to:

	if (!probe_user_read(ret, ptr, sizeof(*ret)))
        	return 0;

Which is entirely analogous to a call to memcpy() and involves no magic.

I know there's lots of precedent here with get_user() etc. but that
doesn't mean we have to follow that precedent blindly :)

I guess perhaps we can add probe_user_address() but just not use it in
the powerpc code, if other folks want it to exist.

cheers
