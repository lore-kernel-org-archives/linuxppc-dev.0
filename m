Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC08C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:05:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B8A2087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XHlgJWUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B8A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447QGk12YqzDqPC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 02:05:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=jannh@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="XHlgJWUe"; 
 dkim-atps=neutral
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447QDn1bGDzDqMn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 02:03:18 +1100 (AEDT)
Received: by mail-oi1-x243.google.com with SMTP id x187so7461386oia.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JwnbB+HBTo5JOYnPid93hiHgo2MFCSC5v/rN5mqU928=;
 b=XHlgJWUeDDx6lbpgfLUpQ5yfIUQFGfn1m5PPc7WGIHxyFHF+3HA8RToeR0IuWQTMN/
 kYElrj1fN+IeqNdYbRmwAUaB69TMayM5wuJbTEp24VE214/mWT/xDQYPvVYUSWfRQwnl
 fFIUceO+1YK3XJ2mLjULUlLksCg2bDUakUQlebnlDuQrL8KoWT/ebZaWCIN28a/ZX14f
 1k+xNyO59W4t8NvqK0KE5I1SiObcarSGLwfUlexah9T49wYpQMcpDFBnbY4Kvmw3FkUG
 rOYZg6DISvirJp/NrEBe7juXNrVkyxgfErqbej4PyY9Rhl/X1qK92yYxIAR+i25QecJ/
 n1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JwnbB+HBTo5JOYnPid93hiHgo2MFCSC5v/rN5mqU928=;
 b=stOt2HfQG10eQZsFKM1TlG9+GYBna0w/dMVJxrgnq8Py9iHlitOQvA7EcSXaCHSl7+
 1ESGyUqatGwY+hVMYEkrS3ErHS9sGwnV72H8/IT5AocHi+KvOzoeeVqsOyuu6yeWz2Lm
 I7KRdQ6JKylrBAOiNctF+2KjpU+6KyVkRnJ7Cn0gIZzp64sVL/epPUn2BKcMpNfp8sPt
 FgAFOBos7BGkeMIbMHM0SD14/q/HbZVFGAfNypo5Z8SQUQ4wTE84iQRMahzV/ZqbS3ou
 sa9VHvwo0rgaJz/PpOlcP5ydG2qQstCD99cuzzt3kc0eVNIrBl4D597kKPeW1/elH1Rq
 7L5A==
X-Gm-Message-State: AHQUAuastSBBFBYHVRB6DSlSjCt1IYWTbCpt5ctwdfmh+udCwCQDmZJZ
 5cQHNyLUjYlHsbFbCP7HMZhMfP9sj4eq2ATncPG3EQ==
X-Google-Smtp-Source: AHgI3IakbtGYqM+ewKVAew/Zusknu3ALNnxN/Nf80/TGijJe/f7sNVo+lxNRjjn8bKcLJ2BEIUj2PsijmEUfhphmvns=
X-Received: by 2002:aca:3806:: with SMTP id f6mr10857802oia.47.1551106993935; 
 Mon, 25 Feb 2019 07:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20190211163653.97742-1-jannh@google.com>
 <f89de711-d73b-96be-75b6-0e9054022708@gmail.com>
In-Reply-To: <f89de711-d73b-96be-75b6-0e9054022708@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 25 Feb 2019 16:02:48 +0100
Message-ID: <CAG48ez2h6eavM9YWXYa69OLY7mFFKn1KN=roH2dZJCi7PSSmuQ@mail.gmail.com>
Subject: Re: [PATCH] mmap.2: describe the 5level paging hack
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-man <linux-man@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Linux-MM <linux-mm@kvack.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@amacapital.net>,
 Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 25, 2019 at 3:55 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 2/11/19 5:36 PM, Jann Horn wrote:
> > The manpage is missing information about the compatibility hack for
> > 5-level paging that went in in 4.14, around commit ee00f4a32a76 ("x86/mm:
> > Allow userspace have mappings above 47-bit"). Add some information about
> > that.
> >
> > While I don't think any hardware supporting this is shipping yet (?), I
> > think it's useful to try to write a manpage for this API, partly to
> > figure out how usable that API actually is, and partly because when this
> > hardware does ship, it'd be nice if distro manpages had information about
> > how to use it.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > This patch goes on top of the patch "[PATCH] mmap.2: fix description of
> > treatment of the hint" that I just sent, but I'm not sending them in a
> > series because I want the first one to go in, and I think this one might
> > be a bit more controversial.
> >
> > It would be nice if the architecture maintainers and mm folks could have
> > a look at this and check that what I wrote is right - I only looked at
> > the source for this, I haven't tried it.
> >
> >  man2/mmap.2 | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/man2/mmap.2 b/man2/mmap.2
> > index 8556bbfeb..977782fa8 100644
> > --- a/man2/mmap.2
> > +++ b/man2/mmap.2
> > @@ -67,6 +67,8 @@ is NULL,
> >  then the kernel chooses the (page-aligned) address
> >  at which to create the mapping;
> >  this is the most portable method of creating a new mapping.
> > +On Linux, in this case, the kernel may limit the maximum address that can be
> > +used for allocations to a legacy limit for compatibility reasons.
> >  If
> >  .I addr
> >  is not NULL,
> > @@ -77,6 +79,19 @@ or equal to the value specified by
> >  and attempt to create the mapping there.
> >  If another mapping already exists there, the kernel picks a new
> >  address, independent of the hint.
> > +However, if a hint above the architecture's legacy address limit is provided
> > +(on x86-64: above 0x7ffffffff000, on arm64: above 0x1000000000000, on ppc64 with
> > +book3s: above 0x7fffffffffff or 0x3fffffffffff, depending on page size), the
> > +kernel is permitted to allocate mappings beyond the architecture's legacy
> > +address limit. The availability of such addresses is hardware-dependent.
> > +Therefore, if you want to be able to use the full virtual address space of
> > +hardware that supports addresses beyond the legacy range, you need to specify an
> > +address above that limit; however, for security reasons, you should avoid
> > +specifying a fixed valid address outside the compatibility range,
> > +since that would reduce the value of userspace address space layout
> > +randomization. Therefore, it is recommended to specify an address
> > +.I beyond
> > +the end of the userspace address space.
> >  .\" Before Linux 2.6.24, the address was rounded up to the next page
> >  .\" boundary; since 2.6.24, it is rounded down!
> >  The address of the new mapping is returned as the result of the call.
> >
>
> Hi Jann,
>
> A few comments came in on this patch. Is there anything from
> those comments that should be rolled into the text?

Hi!

Yeah, I think all the feedback on the patch were good points, and I'll
have to integrate that into my patch.
