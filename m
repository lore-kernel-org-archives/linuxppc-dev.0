Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAADC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 00:01:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF51821473
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 00:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls1p2rtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF51821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PK8346HVzF3Df
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 10:01:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ls1p2rtE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ls1p2rtE"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PK5Q4cJvzF39y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 09:59:37 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id b7-v6so127166pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oi8iaouQOFJrW0+Yyubhf30GwexK4gdZzz6oxpOdU4M=;
 b=Ls1p2rtELtvOk+bfgVotmOkLFSeUjvjmxsLPEuM1h8s4ggjgyDY78oKYpbOfCpb8df
 SVomdnFoU0eiq1DPLe0yjX0JU1DI0+MzhgMv8Rk/p80K8bJ6hbyUys7DwT5W3eL9jw0V
 LldNp4GuB6qDxvD6fHjJezya2fkPuqooPFLXIFv0nUmUUXVEcCl3hXdWkuW6TYaLxLPc
 o29AHxw3Q3lv0CP/WNuDPms2eQGGG7gLr0MV+sFD0+I7S00ISaqCq8HgX1LhN9n9Qfrk
 FPT7Ne/FaTOoJVAn6BUmoMxhWJseI8+ngf/e2p+1jd05ndyxmdUvd9AHXZsT7K8TSDcI
 l4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oi8iaouQOFJrW0+Yyubhf30GwexK4gdZzz6oxpOdU4M=;
 b=Sb+FpW4dCkFTpqX57gv3Pw9iB02piLhvi0wzM9Ll2SZlAV8JPMTU2upN/N6ts7fZAH
 XcgQMLOBLFH/jCYRbzHPo7eBfUh+jQZm3Z5LgVXZJZbK6p34Y02vGpVL1VyzT34uNKHN
 88MJTIOlihvark8SwQ1SN5zNU1mVkSFj1SEpSjsCukzSPOirkZ+D6pI1qCL8PFiC+Y8I
 3XmKoegpbxXFDtedOs9dWpovNMn2KJbo+vbFSSx12ZwZSLKfU4XEYsb+3BDFUVUTzjVJ
 JTg/nadOShC150bUsrYzTEtaY6OwSe/m3hH2iRe1f39IkT9npTWQwosIu8gMmYgB4Df+
 EU9A==
X-Gm-Message-State: ABuFfohyKiy1aU9uZVZFn0qVkxrdvdWSd6jLk87eKPPh3NyzgTuWQKRM
 BC2dFyXRH5AWgQnPkyLfwQI=
X-Google-Smtp-Source: ACcGV62w2NlFQ2zEGn+P+aSQ7YcYSRzppe8WPAMZ3vitex1bD2t44mjDMKXqF1Wl13K7C0/y4Ac+kA==
X-Received: by 2002:a17:902:a716:: with SMTP id
 w22-v6mr14126926plq.334.1538438376174; 
 Mon, 01 Oct 2018 16:59:36 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id e19-v6sm5685783pfb.153.2018.10.01.16.59.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 01 Oct 2018 16:59:35 -0700 (PDT)
Date: Tue, 2 Oct 2018 09:59:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit
 kernel to 512 bytes
Message-ID: <20181002095929.25253b99@roar.ozlabs.ibm.com>
In-Reply-To: <20181001085121.GB23155@gate.crashing.org>
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
 <20181001092715.0a2696bd@roar.ozlabs.ibm.com>
 <CAEUhbmUih9irf-A8E4rouvpWKjeqg78Vzg+xm5TzUVB_vLPr=g@mail.gmail.com>
 <20181001122256.7cfdf186@roar.ozlabs.ibm.com>
 <20181001085121.GB23155@gate.crashing.org>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 1 Oct 2018 03:51:21 -0500
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> Hi!
> 
> On Mon, Oct 01, 2018 at 12:22:56PM +1000, Nicholas Piggin wrote:
> > On Mon, 1 Oct 2018 09:11:04 +0800
> > Bin Meng <bmeng.cn@gmail.com> wrote:  
> > > On Mon, Oct 1, 2018 at 7:27 AM Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > > On Sat, 29 Sep 2018 23:25:20 -0700
> > > > Bin Meng <bmeng.cn@gmail.com> wrote:  
> > > > > commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
> > > > > userspace to 512 bytes") only changes stack userspace redzone size.
> > > > > We need increase the kernel one to 512 bytes too per ABIv2 spec.    
> > > >
> > > > You're right we need 512 to be compatible with ABIv2, but as the
> > > > comment says, gcc limits this to 288 bytes so that's what is used
> > > > to save stack space. We can use a compiler version test to change
> > > > this if llvm or a new version of gcc does something different.
> > > >    
> > > 
> > > I believe what the comment says is for ABIv1. At the time when commit
> > > 573ebfa6601f was submitted, kernel had not switched to ABIv2 build
> > > yet.  
> > 
> > I see, yes you are right about that. However gcc still seems to be using
> > 288 bytes.  
> 
> And that is required by the ABI!
> 
> """
> 2.2.2.4. Protected Zone
> 
> The 288 bytes below the stack pointer are available as volatile program
> storage that is not preserved across function calls. Interrupt handlers and
> any other functions that might run without an explicit call must take care
> to preserve a protected zone, also referred to as the red zone, of 512 bytes
> that consists of:
> 
>  * The 288-byte volatile program storage region that is used to hold saved
>    registers and local variables
>  * An additional 224 bytes below the volatile program storage region that is
>    set aside as a volatile system storage region for system functions
> 
> If a function does not call other functions and does not need more stack
> space than is available in the volatile program storage region (that is, 288
> bytes), it does not need to have a stack frame. The 224-byte volatile system
> storage region is not available to compilers for allocation to saved
> registers and local variables.
> """
> 
> A routine has a red zone of 288 bytes.  Below there is 224 more bytes of
> available storage, but that is not available to the routine itself: some
> (asynchronous) other code (like an interrupt) can use (i.e. clobber) it.

Thanks Segher, that explains it very well and shows we are safe with
288 in the kernel. So we can leave the code as-is, but the comment
could be updated.

What are "system functions" exactly? Can the kernel use that, or are
we talking about user mode system code like libraries? The kernel
could maybe use that for scratch space for synchronous interrupts to
avoid using a slow SPR for scratch.

Thanks,
Nick




> 
> 
> Segher

