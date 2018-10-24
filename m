Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58158C004D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 10:15:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72B12082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 10:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="LW3rQRbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72B12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g5jx0txgzDrNT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 21:15:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="LW3rQRbs";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="LW3rQRbs"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g5g639jGzDrL7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 21:13:04 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id f10-v6so2036822plr.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jjwSE14LPfje/VjGow1mCRc4iV2H58RrCA9qPOR9BBI=;
 b=LW3rQRbs8K/P5qiShw/IjeV4JIMIBiAhuu+U9E9cikIKD48cJuEOrgryRgu/RAi5Bj
 3cLxW44W5HajhHHvJFOUhlFSBMtQdtCFyuZNB5pWXN50urWt943X7B6IlF4lnS2P8crr
 IK0a5dadeVb2twXxbnvoqBnwvaymW80gt6ONfdSTaWEEdiF5GMl7OFiNooArOjDtQJEc
 VX9+WeKOJthMSmGl1YHBxsgw6f3AbqohBwSKRHD/fHYsKKW9yvNIulEI+bhq7B56IpfI
 Yf4cEjhcH3uKS6huccQljB1CsOCeoxoVGJnLxQA4VWUlW/F/y0aI0+QL5dcA4RpObOXq
 3F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jjwSE14LPfje/VjGow1mCRc4iV2H58RrCA9qPOR9BBI=;
 b=G5O6FIA9RcantX5JePcrqs8n8+HWuzT1eOPfJMusLAGgErvBbIesn+KNBlW6Shhppk
 4vGBCcKiCUFwQwdRb9oXQvAwaAEulzzd4ZxC3eP/9O+x8zZX/H4OFkLMnhzfeHhT2ppq
 gIX//CgL6FBne5QKHQeVu6PemJSBkUxEJGlVUjPNa/KlsFUUZp97qekUkjuFDkwbCf+s
 Sv0cz1os4WkDwqfkKRoZxx7NF38YxGaeG/VUWQPVCuc0oA8XHhrw9fvCUpkUqqVokG0e
 EG/ujmzCyH35BKbcmJrQ05BR+espySDv8yCJOTPXMvbaYAqWNUrAM6Efsy4RBVwLTjz5
 4ugQ==
X-Gm-Message-State: AGRZ1gJ9IepLqaqL5An2Hl7geKskTBqAVODRLn/3ZG0+k3OjR6rR91hp
 RhiHqShykvKw813PvC520rIIkg==
X-Google-Smtp-Source: AJdET5d0UdURELlruNjEqupiPGen6jVsxoGb5+iKkDtucxAzZChLo1c7KZe84NtjlNKHALsCS+tdDQ==
X-Received: by 2002:a17:902:9344:: with SMTP id
 g4-v6mr1939843plp.159.1540375982727; 
 Wed, 24 Oct 2018 03:13:02 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
 by smtp.gmail.com with ESMTPSA id m11-v6sm6396544pgn.39.2018.10.24.03.13.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Oct 2018 03:13:01 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 594E3300225; Wed, 24 Oct 2018 13:12:56 +0300 (+03)
Date: Wed, 24 Oct 2018 13:12:56 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013013200.206928-3-joel@joelfernandes.org>
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 kvmarm@lists.cs.columbia.edu, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, linux-s390@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
 Tony Luck <tony.luck@intel.com>, Richard Weinberger <richard@nod.at>,
 linux-parisc@vger.kernel.org, pantin@google.com,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
 minchan@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 9e68a02a52b1..2fd163cff406 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>  		drop_rmap_locks(vma);
>  }
>  
> +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> +		  unsigned long new_addr, unsigned long old_end,
> +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> +{
> +	spinlock_t *old_ptl, *new_ptl;
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> +	    || old_end - old_addr < PMD_SIZE)
> +		return false;
> +
> +	/*
> +	 * The destination pmd shouldn't be established, free_pgtables()
> +	 * should have release it.
> +	 */
> +	if (WARN_ON(!pmd_none(*new_pmd)))
> +		return false;
> +
> +	/*
> +	 * We don't have to worry about the ordering of src and dst
> +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> +	 */
> +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> +	if (old_ptl) {

How can it ever be false?

> +		pmd_t pmd;
> +
> +		new_ptl = pmd_lockptr(mm, new_pmd);
> +		if (new_ptl != old_ptl)
> +			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +
> +		/* Clear the pmd */
> +		pmd = *old_pmd;
> +		pmd_clear(old_pmd);
> +
> +		VM_BUG_ON(!pmd_none(*new_pmd));
> +
> +		/* Set the new pmd */
> +		set_pmd_at(mm, new_addr, new_pmd, pmd);
> +		if (new_ptl != old_ptl)
> +			spin_unlock(new_ptl);
> +		spin_unlock(old_ptl);
> +
> +		*need_flush = true;
> +		return true;
> +	}
> +	return false;
> +}
> +
-- 
 Kirill A. Shutemov
