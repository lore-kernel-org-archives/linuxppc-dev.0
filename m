Return-Path: <linuxppc-dev+bounces-23955-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C01CC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:41:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx3hR6xkDz2y8p;
	Fri, 10 Jul 2026 04:41:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783622487;
	cv=none; b=nIVIboMrE2Y8zPb11EHv9Y/M01iwFNEXrdxH0fePXYF2T1MKc7Br8sfZVv4L8leC9oqCjN52Ullhr/gk1DfdBSmzjjXiMzn9m4416TT6ETeSn+PV3rzE9tCZvY9avqONkcg3T4GHVsS6zyEQRAG7tFQ9Eg60vZwsIU5duCX+6RQ5nROh7GsY0KpZuG2Fsgs/BQGzPJ4ZcCcVYCCsRKRhGU8UFaXOeLt9TEDrPd/swELT9iMrf+ln3GvPlHv6xAQpqO3YY1ES+2Tiqpr5fkvKhDljw9vdwoCei1y1K/jNwOnaujABmRMOGx2hM9CPAkg/7WQbB3gH2d+tDOqk9Dr71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783622487; c=relaxed/relaxed;
	bh=aq4oHRjffhbqNLpraCJHXQbfXmiONMD/vVc6qcgWJtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6HAPZ4Sqzuy4tzcLlYQMBO0GKYZdm4kVRW/3vkkoHGC7G7BRyWuxz64yt1nj5RtzTBRhD+IbvZleZ7IMkQ5cRnLABmfnVz/nTbAvORDZH9tW0Q+r1e7B6eMwAT2UAwlQKHadi6bsQXUzkgJJj007er19fRQ6rmQCf/Cg9CVcHv/5d1C3Bs4qxE2hzvVuryUi9xacrLSMogxD7SESQMWdofdiv/99c5lcHqXIBRS8hrrs9s7NAjpEXbmn7ZrcPaFsR3EqY2oOaEuqYZdhIDM8oUOX72tyO3khF0YKZRTY46rf63Ch7iYK/iFr1gQh7Qrv4eVkzmssA0v9YWmXuPo8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VCRgMPwo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VCRgMPwo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx3hR2Nzcz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:41:27 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-84861fc51a5so92778b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622485; x=1784227285; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aq4oHRjffhbqNLpraCJHXQbfXmiONMD/vVc6qcgWJtk=;
        b=VCRgMPwomfDVcJqs9b9HwE57ydYcXef70hcY8VVF9vA16LzJ/L/LbZ8ybGcJZ4tMMl
         MZDUYNvhaxP9okELBOEpzb6k0p0Hzk73SCei2Pqu4ctBKEQtgjl01oFbX1VKYG8gf1Sj
         yFJ4VWABg5l4Qn+wl9szfW+qAv30YZ4H+rSF95sIT9sF9GxOzP4R/pyCK9xQnANZzvHQ
         CKZ/E7QTCsttn3SIUfgESbsYALd/BQubebyqFjUIKL7KYe1DcEnJY+NyS84FuGMHG0mD
         kTYB8QXG4jZGFDoxjA2rpPjn3IxRdyC9aYmHxXJiZhx+W20lrRZezfwC7hKKyhPBn+13
         +vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622485; x=1784227285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aq4oHRjffhbqNLpraCJHXQbfXmiONMD/vVc6qcgWJtk=;
        b=HyvqTB3pwB6sb1NefOEQIpWDbBOvAmPFzxubCrAY/QTmTPiUlraSYWamgtkUmyEu8l
         wZjT8mmGUjSAZM4+pUVvD8Ifc7H/jpwzZ+yzNNuirefom+5IS/Y5t+SEYXKCVM0oDqfz
         H+ndn5yifh55jYFEbimAIquEOykXVEaD8b4rQPyqlmo0lmNEMhGsIuPuUPseghTHoTrJ
         JJhr/CL/sh4shYk5AIF/20l6pP+QBkmNkfqnzaSUSP606xYtbAQAniJ5Z7TbepCetzEI
         y4Xj4HSJYSCT2ICJ8BXz+/5RcimXOk/UTgyMH4y/lH8PNwrwbvVwyg4lMsMKB83++Nvd
         EJMg==
X-Forwarded-Encrypted: i=1; AHgh+Rp52QfwUp/58LEMFB7qRcBGcpgxnMc0OuzvsuSviZkFZxs116r5MHSJ1c2/PoXyVJvGYnPVWu8xJNVRPcs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwSDI3LE7QkUGIcfF9Z1D8lYv/WRQQpij4FzXl7jYW1IHGWl5AY
	BDnlAemqhjcogbeXACmDzFX2N7BCVvcfoRs4cA+ighzqG/EpCjyD/mTE
X-Gm-Gg: AfdE7cmabtcmDPYE4WFxmlXcVAT8BgvWGGeBeXXa0JQqbolL0mygFYaw7F1UW+VmeBC
	FnBSST1BCo2NZS/WfdqR4Amjaol7Vene0/lk2V4q83jxbYTRqKfXnb9xp6X1JYs9HQd6x+UY+AP
	v0YN6zTGaREkirRnNUuzB8YuZadbGRpU9gpAhr49pweSk0PXwlPytgVvMG/SXtqE/jRatDJbfPs
	dngJW4Pm2R2vRRi7C2Oo5DpuSWhda+SOY6L5u7pnQOSy2vkWqvU+RIwlWfIZ6TXLfL70BlajZqe
	8bFjr+HeBjJpfQTLG8XWF4/TPE6zzEpFyUECi7doMAO+HOss2f3te3yawXkKjoRwBSxk0M4iG+x
	D7RFKI7DLuzkNClWue/7Az7En6U1kcfjES4A73OGKsiriijwp/kFSRv7z8j1EBPWB5KyzAnOL/f
	eoKikDx1gVp0/KVeJ3FaA3hKdwICdhaV6RbOuTorfRT2bqgjoI/FhxFYKhUblg
X-Received: by 2002:a05:6a20:3d0c:b0:3bf:80b8:9c8a with SMTP id adf61e73a8af0-3c0bcead1e2mr9967332637.6.1783622485265;
        Thu, 09 Jul 2026 11:41:25 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm35321002c88.12.2026.07.09.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:41:24 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:11:04 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 05/18] powerpc/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Message-ID: <ak_rL1RfdQVJ6zeq@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.918861529@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.918861529@kernel.org>

On Tue, Jul 07, 2026 at 09:06:15PM +0200, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/syscall.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -2,7 +2,6 @@
>  
>  #include <linux/compat.h>
>  #include <linux/context_tracking.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/entry-common.h>
>  
>  #include <asm/interrupt.h>
> @@ -19,8 +18,7 @@ notrace long system_call_exception(struc
>  	long ret;
>  	syscall_fn f;
>  
> -	r0 = syscall_enter_from_user_mode(regs, r0);
> -	add_random_kstack_offset();
> +	r0 = syscall_enter_from_user_mode_randomize_stack(regs, r0);
>  
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

