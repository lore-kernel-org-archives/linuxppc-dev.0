Return-Path: <linuxppc-dev+bounces-25740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BB4C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 12:46:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKBG55jZrz2yyJ;
	Tue, 11 Aug 2026 22:46:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786452413;
	cv=none; b=JBg1vvZhPnUOeyGPCN/NUgmEakUA0R7t5uEsNLAE+IZJKNU64hZGpPJc1bUGt/p38tmKM1I3+2qbojEPrDwtN+QPXzRvrCYH6Csw4GmXF5lsALb4wkWFeuP4Hv8l/nmf5IZjMvtLsgNno4zq8NL2lGb3Vg9TMacUliTPZkZzbCA1c/Gg7sy6lzOj8Zpq4zKcSxvpnmTYT2IoxFZZ+y9JnismRa16F+3PHrLxHfm/uTv4CYhG2CaMCPivImHspyqNaxeFhRcnvGP/dwM574r4FMX8uFTYumVAfc2YwB7IgPOR/t7MrSkHzh/VOCGI1tKXpdSV5kxQwwGJA4mvJdH5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786452413; c=relaxed/relaxed;
	bh=XPyCbULBvegiKQxqrgTXiGq19exYTrYxLlFRH0sdiJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRg6kCUjGWp9YExL/4sjtm9hLa5t4bmIK5N8VeYGN3AvjSKbZSJnYkLruu5+CIOQ5v4XZULclFDH98PwEEEN5AWBbvYis8rgllLLKEXjgy1K7Tf/LzKoSeozT+l7J/MUGXY6Faj8I9ZvihrbRoqsiwr53nz9/tt8vl6uqbB55fBK0FUiAyl0cYcIwoNkUsASK2JLvZFDPI6TU7IaxPyDFHrbe5Rn+wt94Ll6iNVxUbaz1MctabuxIU43O9w7/rhKhzHK8NSSYx/LqncWjVQkQJ6Oa/qyUzVM79epvZQ4Yjcdlsgb/t7i4rjYlGB3tHwjWax1rb79FByLvyfLVOAHVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ANjAH1Vi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ANjAH1Vi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKBG40pGcz2yvM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 22:46:51 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2d01663d816so26235585ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786452403; x=1787057203; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XPyCbULBvegiKQxqrgTXiGq19exYTrYxLlFRH0sdiJY=;
        b=ANjAH1ViX8+fWNjsIy994m2+wp8O24or/yudw+vUaZooiXzMRsxdQtwNubGx7G4wSP
         diq/JQ2qhhtCu07vsn1PG7/nYrdewo1fBQFZlFdGU0VbCfM2GJdI9TNR46FnjPzVwmV6
         10E6YJBJMHgV3ykwIkJRUTcOWGkpf4x5qIdXioVrVRUHdcagDEvcHLzFyv+6YtNNp4MZ
         j0v4ThE/HuPnHVpXeUUAbgakhejVGVqAMmhJse05+ipVWIevyD6s9RAuiIEDu2qq9bOa
         N2Wp4IPnrlY1NTh5dEa083FvC7LD+L4MeQSmAB112O6yqlpdKe5d0m2n+V9xq0lzhG4s
         Jdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452403; x=1787057203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XPyCbULBvegiKQxqrgTXiGq19exYTrYxLlFRH0sdiJY=;
        b=Nqn/PLv/iIawQzTZyEEsIxcNGupfV401QxIY3T40qdAppIngQ9VEpwY1kg5SQT/Qh1
         CTxPI6Dmw2E3p8y6hVjehG831Slna18TkNNZrQaqdVDIwW+Jnj0e9duEnUpioHbc6iiR
         To7tHnuJNbADuFeIxcR8w36hHIUPCG7A91NBpSVNWN8DyLSqai120TPkmGlx1secXCbu
         2EIU+1vG7WCOU7N5SQW/c2VnQhfauMDhuv57afc6tvcCg7tGX/oPITsuqcLti/TJNMTI
         X9lBEKouX5v/pGqu0ALUhUpBWyt6t2FlRtSzIqk4HHaLwjPA8U7RQMNBr/1BFNpfFb5Q
         p/3g==
X-Forwarded-Encrypted: i=1; AHgh+RpT4gxzizBm2xv1SqdZkbqGOA3u5rdqhSzFEfDaAOHtmUM+c0oxST5AMfkG8FM+GxaM99N/z86bMqkwXxQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyzC9lw68XPm6mJyJ7lU7NsNBuHH2IHZIINVtb9GZUGUf5CgENQ
	DVXLa86I9f5YQckcWkdz++m50Vzv/jz9HuFuuRjNBYaGVTfah8ZyMcQ8
X-Gm-Gg: AR+sD10XEBnc0rNULiiLkgvHqomE7HB7Mk6F5WluBIFRGLcgj426qvuz4TgMReKUASU
	oJ7nBktCfZscrtzDFFR2sM0rSbXzIHuVSPrdKafG5JGT+dmiw6c1JV+BBli6z9YIcQSChgBkuq3
	TIdQHFRQbbD7ckUrh9huvQXOHy8CKiLK5RWj/Zk0rfAebhm8uooARs8TLFCp/pLfK+DMxLJaEFI
	TnkpE6C3LEqr3+mtYoZ1gXELAAD8hXK7v/dEwae7ONK4VfRprg6Ujb31EY48/ae9IK1FbzmpLIC
	xjqpkiOGa+XImxTZF61j9mxKG/dvy/wuNFg8nYQOjLxT2fP/n61099wgOCDCDa7k3i6IjCLhWD+
	XfGC+YCLZW0nsvA4vze8RRyeYH5GpfximSwsWYF32mOE73yaxdkzLyBUs26EFD6L7zitRVkxf5h
	Y1A1yOGjL47yetV/4YmZ/y4U6Ef7uV1ReDGCzJ2kYGiA6jbhzoFYQEeESF8svCqqEEmjSUJi7v7
	KXr60rZIoNJ4wBIedaHtubOi6G6//sWJ+NR
X-Received: by 2002:a17:903:2a8d:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d3177cb87fmr41144825ad.10.1786452403187;
        Tue, 11 Aug 2026 05:46:43 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315d829c4sm7520985ad.0.2026.08.11.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:46:42 -0700 (PDT)
Date: Tue, 11 Aug 2026 18:16:37 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [REGRESSION] Power9 pseries boot hang in v7.2-rc6, narrowed to
 PowerPC GENERIC_ENTRY conversion window
Message-ID: <ansZjSJMWMV8DDF-@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com>
 <e27eeaf4-c2c9-4ef7-9e1c-0a5fb45755d0@linux.ibm.com>
 <6d1b5f38-f4e4-46ca-88b4-7c18dd6c6280@linux.ibm.com>
 <anq72IebDSu-wWbb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <anq72IebDSu-wWbb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Tue, Aug 11, 2026 at 11:37:45AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Mon, Aug 10, 2026 at 05:19:27PM +0530, Venkat Rao Bagalkote wrote:
> > Hi Shrikanth,
> > 
> > 
> > On 04/08/26 8:23 pm, Shrikanth Hegde wrote:
> > > Hi Venkat.
> > > 
> > > On 8/4/26 2:04 PM, Venkat Rao Bagalkote wrote:
> > > > Hi,
> > > > 
> > > > I'm seeing a boot regression on a Power9 pseries LPAR. The system
> > > > hangs very early during boot after:
> > > > 
> > > > Quiescing Open Firmware ...
> > > > Booting Linux via __start() ...
> > > > 
> > > 
> > > That is strange. not sure where to look at without any logs.
> > > Is it a specific config that fails or this specific LPAR that fails?
> > > 
> Is this a specific lpar or all power9 pseries are exhibiting same
> behaviour?
> 
> Regards,
> Mukesh
> [...]
> 

Hey Venkat,

Can you try the below fix?

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index c5adb5006361..de64389b0815 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -270,7 +270,7 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
 	}
 
 	/* irqentry_exit expects to be called with interrupts disabled */
-	local_irq_disable();
+	hard_irq_disable();
 }
 
 static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)


