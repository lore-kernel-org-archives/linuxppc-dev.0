Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5FAC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 12:31:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C12520895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 12:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLzz/Zom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C12520895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XPFg6FGqzF3Hs
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 23:31:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLzz/Zom";
	dkim-atps=neutral
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XP9y72lbzF3Cm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 23:28:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLzz/Zom"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42XP9x6mlCz8sfw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 23:28:05 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42XP9x4clpz9s9J; Sat, 13 Oct 2018 23:28:05 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLzz/Zom"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42XP9w3Zzjz9s3Z
 for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2018 23:28:04 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id 78-v6so5112145pfq.0
 for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2018 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VfSR2/+Ae5sJTPDTUv7XaAeRZfCY5JMtwndKAnigq1M=;
 b=LLzz/ZomzW6O3KsRx9CdjG2+YW81K3kzM+aVFf4Yr8n5qIHO0DwYuMn9E+u/ATrlmC
 BqnyxqltCUP5G0TsefE3GqsZSqdlVCYlyKngGOtnXZudSIrzM5/m4q00F9DsZ9vpPqxs
 3pRcBp5DtpZ2E9vWt1FtPJLRdgA4YOl6qGZyN3r5QjLjVp/L+b2hMlrt2yB8Y24PCguG
 w4wVInk16q2ZmPpFr3fb2NnMu2I+BTtUwlcKq++P5riOy5Rc5lpajKW0mBAUkxlZ5cwp
 om0qKYVXGGpGCQpCFCEhACofjMJxORSizS68jp2FBsZGlYqPCVjMr/WHo67EOrfGdrvo
 vZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VfSR2/+Ae5sJTPDTUv7XaAeRZfCY5JMtwndKAnigq1M=;
 b=WIXShEbt/bKs+5OQRc/fwHjLNIIZAR+CuTinreG6mH5QMQgdxLyT7/vVFz6pyDHnU5
 NOG8K83qXKk7sc9eQW4fJY/d1ybryfbAnPaMAussRVSq7+BhzeGljIqS7gpDFbEyFJ8E
 2HLX7r0I51jp4ePiaJAyB5yJMrur9qe0h681L/33py7GRFEbQU3CniYnMPBshhlYZjBq
 FyTU8d3+nrh9Fp6Y+kJxgaM2vITm1282NbSNCBEz8Cvr8uYlqOUAPQD+j34dLX/H2xhi
 Yv14j9RIT1PGbHrWe2Mi+UFcY0UhlrESEUmX9cN5SBD3cRY2jUF4XpjcAsn8LYASIpjH
 Tufw==
X-Gm-Message-State: ABuFfojkMMdQ0KMZ74D4kTZofBzVdrDcotTajtsND7CTkxt/NcX9pfpV
 vEwLdMRPeOw+l6wX0jjXf7A=
X-Google-Smtp-Source: ACcGV63E+8gdEHoL09dTIR4ZHDwxdpUEMx7zqpvu3/5L8+JVQ8w1jHaA+eVoa+qxMTH6nrse908WMg==
X-Received: by 2002:a63:4cb:: with SMTP id
 194-v6mr9173155pge.183.1539433682537; 
 Sat, 13 Oct 2018 05:28:02 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (61-68-185-28.tpgi.com.au. [61.68.185.28])
 by smtp.gmail.com with ESMTPSA id
 3-v6sm5565495pga.12.2018.10.13.05.28.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 13 Oct 2018 05:28:01 -0700 (PDT)
Date: Sat, 13 Oct 2018 22:27:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc: Split user/kernel definitions of struct
 pt_regs
Message-ID: <20181013222756.2e9ca459@roar.ozlabs.ibm.com>
In-Reply-To: <20181013105646.5147-1-mpe@ellerman.id.au>
References: <20181013105646.5147-1-mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 13 Oct 2018 21:56:44 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> We use a shared definition for struct pt_regs in uapi/asm/ptrace.h.
> That means the layout of the structure is ABI, ie. we can't change it.
> 
> That would be fine if it was only used to describe the user-visible
> register state of a process, but it's also the struct we use in the
> kernel to describe the registers saved in an interrupt frame.
> 
> We'd like more flexibility in the content (and possibly layout) of the
> kernel version of the struct, but currently that's not possible.
> 
> So split the definition into a user-visible definition which remains
> unchanged, and a kernel internal one.
> 
> At the moment they're still identical, and we check that at build
> time. That's because we have code (in ptrace etc.) that assumes that
> they are the same. We will fix that code in future patches, and then
> we can break the strict symmetry between the two structs.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Yeah this looks much better than my int_frame thing, thanks.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
