Return-Path: <SRS0=Luu/=QX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00783C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 10:56:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D25A222A1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 10:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTSYYkp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D25A222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441nBc4SDhzDqDK
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 21:56:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441n8l2RnTzDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 21:55:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTSYYkp1"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 441n8l0tCYz8w97
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 21:55:19 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 441n8l0LpQz9s9G; Sat, 16 Feb 2019 21:55:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTSYYkp1"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 441n8k3Sscz9s7T
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2019 21:55:17 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id s1so6251471plp.9
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2019 02:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1Ubpr1Ey/DmY/KE61Qrh0yzi4L35UYNNw5PJu00uODc=;
 b=gTSYYkp1t3MnTZM0YoT8ot7TKpB/68aT35/5SpKN4og5QIhe8orF0G0hFRBEdlhzSZ
 QUI97HjYOShyGwqv/RBr4sBgk9vJyWEO/KhEYRDTdKe6kqbIepfy1i+jNqeQgQT5i9nx
 GUT3mzRHk+JnWlSPY2PQ4JzIm2C4WlnViSb8R+UVlPdqwnIYhtEjM3wD/9jy4iHCKAmO
 d82k+tDkXgOQBBQWmicHzH0OcQPf3Q7Xzm0PhQK0a7GDmXsghgaioI8raZ1m0wk67uD8
 2i1TAfvSNY8TgWPw0OuZRv8Wh3Gf7KjwfDCTRQYBPrTOEheaKTZfu7uTA3x1GSXnyf7M
 GtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1Ubpr1Ey/DmY/KE61Qrh0yzi4L35UYNNw5PJu00uODc=;
 b=IrFksOdHYtgvHBwRCK0q1KZFMn87hZUDWnqpfgIuykSFcwaeWIyfIoWpaBhoTdY+lE
 OKco4MKyN1i1GcIe38b6r+LQkkjvzsILj7m0LYL5R4AKVAC1YriAk6RJibI1AawpHpC5
 n5o3Cl0E7WaHee5ZdiiQBO0tU2ke7jae2DH457vr1WqmlJ+Urb0wpXCyYFd62W8LlCPc
 DDukblHX6bGyviS8mrzXf2JeTpnIsI1S8oBTV0dVbpJwoDY4J2mxNWnkfZwtb5eoW2pp
 8WOnSjVSqDnboUuyUl/n2Z7/e4X03LERmtFGFfimvyUnDt0vEhpfvfsT5d6AcE/13CZu
 mATg==
X-Gm-Message-State: AHQUAuZITfcUprhBORzveb3O/5ehUkm7LAUhMMESTF5djUIe8rJGiMeV
 R33AE1pnUwpON1XDQmiyqfrRgBew
X-Google-Smtp-Source: AHgI3IaJGJ4E5JLUuz+5RAh+KUilztY5KioLABGSyqMSqji8EHYOrI10oopn/wpXsFIzfD3Hl7vpJg==
X-Received: by 2002:a17:902:2dc3:: with SMTP id
 p61mr14670803plb.166.1550314515841; 
 Sat, 16 Feb 2019 02:55:15 -0800 (PST)
Received: from localhost (123-243-232-193.tpgi.com.au. [123.243.232.193])
 by smtp.gmail.com with ESMTPSA id p12sm17159170pfj.81.2019.02.16.02.55.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 02:55:15 -0800 (PST)
Date: Sat, 16 Feb 2019 21:55:11 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due
 to pgd/pud_present()
Message-ID: <20190216105511.GA31125@350D>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214062339.7139-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: erhard_f@mailbox.org, jack@suse.cz, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
> In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
> rather than just checking that the value is non-zero, e.g.:
> 
>   static inline int pgd_present(pgd_t pgd)
>   {
>  -       return !pgd_none(pgd);
>  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>   }
> 
> Unfortunately this is broken on big endian, as the result of the
> bitwise && is truncated to int, which is always zero because

Not sure why that should happen, why is the result an int? What
causes the casting of pgd_t & be64 to be truncated to an int.

> _PAGE_PRESENT is 0x8000000000000000ul. This means pgd_present() and
> pud_present() are always false at compile time, and the compiler
> elides the subsequent code.
> 
> Remarkably with that bug present we are still able to boot and run
> with few noticeable effects. However under some work loads we are able
> to trigger a warning in the ext4 code:
> 
>   WARNING: CPU: 11 PID: 29593 at fs/ext4/inode.c:3927 .ext4_set_page_dirty+0x70/0xb0
>   CPU: 11 PID: 29593 Comm: debugedit Not tainted 4.20.0-rc1 #1
>   ...
>   NIP .ext4_set_page_dirty+0x70/0xb0
>   LR  .set_page_dirty+0xa0/0x150
>   Call Trace:
>    .set_page_dirty+0xa0/0x150
>    .unmap_page_range+0xbf0/0xe10
>    .unmap_vmas+0x84/0x130
>    .unmap_region+0xe8/0x190
>    .__do_munmap+0x2f0/0x510
>    .__vm_munmap+0x80/0x110
>    .__se_sys_munmap+0x14/0x30
>    system_call+0x5c/0x70
> 
> The fix is simple, we need to convert the result of the bitwise && to
> an int before returning it.
> 
> Thanks to Jan Kara and Aneesh for help with debugging.
> 
> Fixes: da7ad366b497 ("powerpc/mm/book3s: Update pmd_present to look at _PAGE_PRESENT bit")
> Cc: stable@vger.kernel.org # v4.20+
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index c9bfe526ca9d..d8c8d7c9df15 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -904,7 +904,7 @@ static inline int pud_none(pud_t pud)
>  
>  static inline int pud_present(pud_t pud)
>  {
> -	return (pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
> +	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
>  }
>  
>  extern struct page *pud_page(pud_t pud);
> @@ -951,7 +951,7 @@ static inline int pgd_none(pgd_t pgd)
>  
>  static inline int pgd_present(pgd_t pgd)
>  {
> -	return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> +	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>  }
>

Care to put a big FAT warning, so that we don't repeat this again
(as in authors planning on changing these bits). 

Balbir Singh.
  
