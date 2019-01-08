Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC48C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:16:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CFC20883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n7ju5MIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CFC20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z4nD0m0wzDqby
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 08:16:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::e41; helo=mail-vs1-xe41.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="n7ju5MIS";
 dkim-atps=neutral
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com
 [IPv6:2607:f8b0:4864:20::e41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z4lQ1bByzDq9P
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 08:14:42 +1100 (AEDT)
Received: by mail-vs1-xe41.google.com with SMTP id v205so3420278vsc.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 13:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OWEgAtYm9ccvWmLV8AYycOen3jNVVZL7snbVRoC2Jsg=;
 b=n7ju5MISRSee7cLJdLngz1Mdb6LlSBCNk8BK8mRbvDLCmqIsKwDKgdHG/wpLbfSBDJ
 SslGEZS8PDhaSwt3lQpLhP4l0PkbnC4k65ZU+BViOEDXcmtKOLwmBcFkBtFv2VfDWijN
 PUwrTtMH0L7MMnQ5Ibrdde0Pe3QpqRMBUt234=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OWEgAtYm9ccvWmLV8AYycOen3jNVVZL7snbVRoC2Jsg=;
 b=Azkd4L6tFZA6ZL9Ap3szH8ryAxwvTyv34vTvVpq/2H2yWhckPZanewZ1DlMPRZxa3A
 FZr9uI87eXtfeF/I7JiYC4Qf/nFZPb8GL6T8oFNKJg6dez9proa6WBPx7dCNx/clRRQ7
 1y1b1UJfvnp9Dy0IF3aD9XRFIoO0kXQ/W6qvvUBnlzeS5j9FVvaM3tJOPZblfOwUNCq1
 yqcYTEXXnpVsfb1Pb0nwRA6JQRbl3SK0KLooPxG2Aw74A2813EEfTdW6s9lklxnhRhmy
 pP6Xqb4lQs3tvcRyxVdCqFVR+4Lg/BGYzEYtwrR/o3D4emFZQyig1n9Ec7UQarIrT1E1
 d00w==
X-Gm-Message-State: AJcUukf5j6rQZuQo0U+grIgXGvbj0f3OW8HIOgnH1+DtF4QHlKQxu4kq
 bDvEMURBvTzyoFDuSdccQAsGjeqjHMs=
X-Google-Smtp-Source: ALg8bN5fHO0guOx7Linrp9e30soK3OqJrHagwXSBr+CDOC2v39JoYHwdOzHZZi4ffn+x3jGQRReVbg==
X-Received: by 2002:a67:7ed8:: with SMTP id z207mr1263738vsc.159.1546982079337; 
 Tue, 08 Jan 2019 13:14:39 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com.
 [209.85.221.181])
 by smtp.gmail.com with ESMTPSA id n206sm28295139vkn.36.2019.01.08.13.14.37
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 13:14:37 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id n126so1193876vke.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 13:14:37 -0800 (PST)
X-Received: by 2002:a1f:4982:: with SMTP id w124mr1240075vka.4.1546982076925; 
 Tue, 08 Jan 2019 13:14:36 -0800 (PST)
MIME-Version: 1.0
References: <0b0db24e18063076e9d9f4e376994af83da05456.1546932949.git.christophe.leroy@c-s.fr>
 <20190108114803.583f203b86d4a368ac9796f3@linux-foundation.org>
 <19c99d33-b796-72df-4212-20255f84efa0@c-s.fr>
In-Reply-To: <19c99d33-b796-72df-4212-20255f84efa0@c-s.fr>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 8 Jan 2019 13:14:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+8XqMu596gtzRAjV=7cv2rThcE5-Wy6QTmNzdht3k66w@mail.gmail.com>
Message-ID: <CAGXu5j+8XqMu596gtzRAjV=7cv2rThcE5-Wy6QTmNzdht3k66w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: add probe_user_read()
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>,
 Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 8, 2019 at 1:11 PM Christophe Leroy <christophe.leroy@c-s.fr> w=
rote:
>
>
>
> Le 08/01/2019 =C3=A0 20:48, Andrew Morton a =C3=A9crit :
> > On Tue,  8 Jan 2019 07:37:44 +0000 (UTC) Christophe Leroy <christophe.l=
eroy@c-s.fr> wrote:
> >
> >> In powerpc code, there are several places implementing safe
> >> access to user data. This is sometimes implemented using
> >> probe_kernel_address() with additional access_ok() verification,
> >> sometimes with get_user() enclosed in a pagefault_disable()/enable()
> >> pair, etc. :
> >>      show_user_instructions()
> >>      bad_stack_expansion()
> >>      p9_hmi_special_emu()
> >>      fsl_pci_mcheck_exception()
> >>      read_user_stack_64()
> >>      read_user_stack_32() on PPC64
> >>      read_user_stack_32() on PPC32
> >>      power_pmu_bhrb_to()
> >>
> >> In the same spirit as probe_kernel_read(), this patch adds
> >> probe_user_read().
> >>
> >> probe_user_read() does the same as probe_kernel_read() but
> >> first checks that it is really a user address.
> >>
> >> ...
> >>
> >> --- a/include/linux/uaccess.h
> >> +++ b/include/linux/uaccess.h
> >> @@ -263,6 +263,40 @@ extern long strncpy_from_unsafe(char *dst, const =
void *unsafe_addr, long count);
> >>   #define probe_kernel_address(addr, retval)         \
> >>      probe_kernel_read(&retval, addr, sizeof(retval))
> >>
> >> +/**
> >> + * probe_user_read(): safely attempt to read from a user location
> >> + * @dst: pointer to the buffer that shall take the data
> >> + * @src: address to read from
> >> + * @size: size of the data chunk
> >> + *
> >> + * Returns: 0 on success, -EFAULT on error.
> >> + *
> >> + * Safely read from address @src to the buffer at @dst.  If a kernel =
fault
> >> + * happens, handle that and return -EFAULT.
> >> + *
> >> + * We ensure that the copy_from_user is executed in atomic context so=
 that
> >> + * do_page_fault() doesn't attempt to take mmap_sem.  This makes
> >> + * probe_user_read() suitable for use within regions where the caller
> >> + * already holds mmap_sem, or other locks which nest inside mmap_sem.
> >> + */
> >> +
> >> +#ifndef probe_user_read
> >> +static __always_inline long probe_user_read(void *dst, const void __u=
ser *src,
> >> +                                        size_t size)
> >> +{
> >> +    long ret;
> >> +
> >> +    if (!access_ok(src, size))
> >> +            return -EFAULT;
> >> +
> >> +    pagefault_disable();
> >> +    ret =3D __copy_from_user_inatomic(dst, src, size);
> >> +    pagefault_enable();
> >> +
> >> +    return ret ? -EFAULT : 0;
> >> +}
> >> +#endif
> >
> > Why was the __always_inline needed?
> >
> > This function is pretty large.  Why is it inlined?
> >
>
> Kees told to do that way, see https://patchwork.ozlabs.org/patch/986848/

Yeah, I'd like to make sure we can plumb the size checks down into the
user copy primitives.

--=20
Kees Cook
