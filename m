Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97844C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:05:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1F22147C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1F22147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w5qG1dfczDqQT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 16:05:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w5ng6XjTzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 16:04:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43w5ng2hX4z9s6w;
 Thu,  7 Feb 2019 16:04:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 1/2] mm: add probe_user_read()
In-Reply-To: <20190205174242.GA24427@kermit.br.ibm.com>
References: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
 <20190205174242.GA24427@kermit.br.ibm.com>
Date: Thu, 07 Feb 2019 16:04:07 +1100
Message-ID: <87zhr8jik8.fsf@concordia.ellerman.id.au>
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
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>> index 37b226e8df13..ef99edd63da3 100644
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -263,6 +263,40 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
>>  #define probe_kernel_address(addr, retval)		\
>>  	probe_kernel_read(&retval, addr, sizeof(retval))
>>
>> +/**
>> + * probe_user_read(): safely attempt to read from a user location
>> + * @dst: pointer to the buffer that shall take the data
>> + * @src: address to read from
>> + * @size: size of the data chunk
>> + *
>> + * Safely read from address @src to the buffer at @dst.  If a kernel fault
>> + * happens, handle that and return -EFAULT.
>> + *
>> + * We ensure that the copy_from_user is executed in atomic context so that
>> + * do_page_fault() doesn't attempt to take mmap_sem.  This makes
>> + * probe_user_read() suitable for use within regions where the caller
>> + * already holds mmap_sem, or other locks which nest inside mmap_sem.
>> + *
>> + * Returns: 0 on success, -EFAULT on error.
>> + */
>> +
>> +#ifndef probe_user_read
>> +static __always_inline long probe_user_read(void *dst, const void __user *src,
>> +					    size_t size)
>> +{
>> +	long ret;
>> +
>> +	if (!access_ok(src, size))
>> +		return -EFAULT;
>
> Hopefully, there is still time for a minor comment.
>
> Do we need to differentiate the returned error here, e.g.: return
> -EACCES?
>
> I wonder if there will be situations where callers need to know why
> probe_user_read() failed.

It's pretty standard to return EFAULT when an access_ok() check fails,
so I think using EFAULT here is the safest option.

If we used EACCES we'd need to be more careful about converting code to
use this helper, as doing so would potentially cause the error value to
change, which in some cases is not OK.

cheers
