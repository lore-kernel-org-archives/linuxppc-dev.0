Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D57C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 09:43:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB95F20821
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 09:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="oz4fqcyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB95F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zHln3xZYzDqPP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:43:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="oz4fqcyB"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zHk00l5FzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 20:41:56 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id s1so1032049plp.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 01:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ULKJGWPq0No+6GC/bcxSVWYWrbcjwzSVvmdDBR8FNpg=;
 b=oz4fqcyBSi9ismZ7bytPCCn4QB2ehAPOo+jJuLzFVX2NYQ2azlwSYNQBmERfG1ZuVw
 eGQZGM7lEK7RcBM76vfU85SEtWwdtfVlExo96dNE435NP4TRW+crgtzDnNLH2uiShe2D
 CwsP6ZtNLwtB1FlDIIQbLv9+FEtcXyO4hy+6FZNg87BGUV0zDhttBb5qxe4RGMjCgAuE
 lEQH00osnCynrZmPPIePFjLqDylh8H7cpz8tzII/yALTiUwRjYgKyvDa5VgsfPyedIw0
 IVDExWw/9JzIlSmvGEQ8UnoP8VqC513UTVg+F0p3R9/36fwKNNdRIFjXXWxuZfv3840I
 ulyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ULKJGWPq0No+6GC/bcxSVWYWrbcjwzSVvmdDBR8FNpg=;
 b=hXzdlb8gzd4TU6Fg+YjR5rwg/f2gxx4E9Yh5HXT2cBLu41ts/BskAyhvQBUQTEwEbR
 td1wdnrESG9RVqlbuwr864K4JMuHBbdF5F5a6GkzvCJ9VGtraISNOX7BFFycetUaoVzP
 CkskGP7Wrb5EeMhRLDNQI5nHrv9rTXfJTvLfowlzAHk/fGBjzthl5MOzTmXIBFm9Sn9L
 KfFRre7KldlZ0AQjJBKIVvHP30Vt+qfYzeB4FQv5hRwxlm0Jc4MkeRfcFInT4MDiEbMS
 zPd0XoiO+p5qjFPVL4HzHAcnNX7wcItso0LsmcMvzBTIi/tUHxO4YqUKEAtZu3iNL66R
 BHSQ==
X-Gm-Message-State: AHQUAua2RX/Pw8uJ2VAJbs3ATBo+XOVCuCRd8xqldBQTsjeQem31dl5t
 /gEqXBSvTWp34e+Ow9AlwzKpLw==
X-Google-Smtp-Source: AHgI3IZbSkcUnItYKRqYqpDbDeAVRnQeTmuDwZZXQAMV8eQDd3Fni7xJYWoe03xeFvKMmhVcwLOcvA==
X-Received: by 2002:a17:902:bd0b:: with SMTP id
 p11mr3085458pls.259.1549964512626; 
 Tue, 12 Feb 2019 01:41:52 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
 by smtp.gmail.com with ESMTPSA id y21sm17816378pfi.150.2019.02.12.01.41.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 01:41:52 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 84BA1300100; Tue, 12 Feb 2019 12:41:48 +0300 (+03)
Date: Tue, 12 Feb 2019 12:41:48 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mmap.2: describe the 5level paging hack
Message-ID: <20190212094148.qpd6wudyry5vzw3v@kshutemo-mobl1>
References: <20190211163653.97742-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211163653.97742-1-jannh@google.com>
User-Agent: NeoMutt/20180716
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
Cc: linux-arch@vger.kernel.org, linux-man@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@amacapital.net>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, mtk.manpages@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 05:36:53PM +0100, Jann Horn wrote:
> The manpage is missing information about the compatibility hack for
> 5-level paging that went in in 4.14, around commit ee00f4a32a76 ("x86/mm:
> Allow userspace have mappings above 47-bit"). Add some information about
> that.
> 
> While I don't think any hardware supporting this is shipping yet (?), I
> think it's useful to try to write a manpage for this API, partly to
> figure out how usable that API actually is, and partly because when this
> hardware does ship, it'd be nice if distro manpages had information about
> how to use it.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks for doing this.

> ---
> This patch goes on top of the patch "[PATCH] mmap.2: fix description of
> treatment of the hint" that I just sent, but I'm not sending them in a
> series because I want the first one to go in, and I think this one might
> be a bit more controversial.
> 
> It would be nice if the architecture maintainers and mm folks could have
> a look at this and check that what I wrote is right - I only looked at
> the source for this, I haven't tried it.
> 
>  man2/mmap.2 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/man2/mmap.2 b/man2/mmap.2
> index 8556bbfeb..977782fa8 100644
> --- a/man2/mmap.2
> +++ b/man2/mmap.2
> @@ -67,6 +67,8 @@ is NULL,
>  then the kernel chooses the (page-aligned) address
>  at which to create the mapping;
>  this is the most portable method of creating a new mapping.
> +On Linux, in this case, the kernel may limit the maximum address that can be
> +used for allocations to a legacy limit for compatibility reasons.
>  If
>  .I addr
>  is not NULL,
> @@ -77,6 +79,19 @@ or equal to the value specified by
>  and attempt to create the mapping there.
>  If another mapping already exists there, the kernel picks a new
>  address, independent of the hint.
> +However, if a hint above the architecture's legacy address limit is provided
> +(on x86-64: above 0x7ffffffff000, on arm64: above 0x1000000000000, on ppc64 with
> +book3s: above 0x7fffffffffff or 0x3fffffffffff, depending on page size), the
> +kernel is permitted to allocate mappings beyond the architecture's legacy
> +address limit. The availability of such addresses is hardware-dependent.
> +Therefore, if you want to be able to use the full virtual address space of
> +hardware that supports addresses beyond the legacy range, you need to specify an
> +address above that limit; however, for security reasons, you should avoid
> +specifying a fixed valid address outside the compatibility range,
> +since that would reduce the value of userspace address space layout
> +randomization. Therefore, it is recommended to specify an address
> +.I beyond
> +the end of the userspace address space.

It probably worth recommending (void *) -1 as such address.

>  .\" Before Linux 2.6.24, the address was rounded up to the next page
>  .\" boundary; since 2.6.24, it is rounded down!
>  The address of the new mapping is returned as the result of the call.
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 

-- 
 Kirill A. Shutemov
