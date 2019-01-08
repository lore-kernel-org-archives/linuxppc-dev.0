Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3494C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 17:22:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308C7206A3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 17:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK3dd9W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308C7206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Yzby0B0RzDqXK
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 04:22:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YzZK6j9MzDqXM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 04:21:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oK3dd9W2"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43YzZK4jy8z8tRf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 04:21:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43YzZK4JLRz9sMp; Wed,  9 Jan 2019 04:21:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oK3dd9W2"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43YzZK0fBpz9sMM
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2019 04:21:28 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id u4so4873939wrp.3
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2019 09:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=53iTP2Ae9hwsS81tE3dajsTjlS6sREQ6puuxORj1Cao=;
 b=oK3dd9W2anwp6OGp8KiO+XDTUyVLxDKTKR9at9fMGviUmZWoHOwmL61d/l9E8EZDbp
 oreykvDoNrj9TUn5l70bVhC/Hu6m+xBW7TIEd2c6Swt0u4drU0FVfiOSzZmQ+P8eNmt3
 QjmOUhIOFsv3kH1mDguYusszvfYF80PPBbnXwkDGVFGKSVtYEuxtFJDtlY2vc3Ah0EMe
 6tfnH5IOFYtxoFwyxz9VC9f5Qk6tjbtHgHfDv03UUHPh0n13RiZJamuAlU96JRLOL4K8
 lQJI8VtflN3yXVTMpJmVYilSfDue9fNWdsPHexWEGWHtLbwE+h+H18cv0FrERNvc8/4T
 exkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=53iTP2Ae9hwsS81tE3dajsTjlS6sREQ6puuxORj1Cao=;
 b=tCWDKcaqe4dnizvZhb2YUr4B5ZGPwYhSSKZcDrcsWOTdokud6756unzh2qwIIxGMMQ
 vzEB81sfg9pQx4+T7JqKfT1ECDLKYW6oBiFAHvzTI9KTJqDH2NDtrF7VlvsqGo4sN22R
 My77IYb0tZolNkrrTv7YcId7cV+vym1W7iL9rFI9feenmDCFSS7grXtOs10YZqXJnbby
 RbtW3Qv4qbcwZ8PK3VuduP/GU8EBgRRLKOcYtEvCY2hD1DagSfwd9VsoBVaJgELgBb5F
 J9wJmcpTtB2l315bRYzD0yrFheDT0tS7X/07uowo1bSH7kgWoLQHDQizOFmJ0UdXyVmG
 90VQ==
X-Gm-Message-State: AJcUukfmOD6g/0QVT0VYf5Nx0khhGFhFG0Ly/E2pM08Ge8nvHDnge3uD
 JluIiGGzCg6qZmtxEqYSePo=
X-Google-Smtp-Source: ALg8bN4unTUugaVsyjf1XS2XU+HqZvl1xI7Wq5bl6Oz+0E/6MvBGM2+FORo7/Ki9azqpBwtf3y8MgQ==
X-Received: by 2002:adf:ab51:: with SMTP id r17mr2117479wrc.62.1546968085642; 
 Tue, 08 Jan 2019 09:21:25 -0800 (PST)
Received: from debian64.daheim (p4FD0970A.dip0.t-ipconnect.de. [79.208.151.10])
 by smtp.gmail.com with ESMTPSA id v8sm76661738wrq.53.2019.01.08.09.21.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 08 Jan 2019 09:21:24 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
 by debian64.daheim with esmtp (Exim 4.92-RC4)
 (envelope-from <chunkeey@gmail.com>)
 id 1ggv48-0001ZO-8K; Tue, 08 Jan 2019 18:21:24 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/2] powerpc/4xx/ocm: Fix phys_addr_t printf warnings
Date: Tue, 08 Jan 2019 18:21:23 +0100
Message-ID: <1833028.0eqVQs4dtG@debian64>
In-Reply-To: <87ef9ntqy3.fsf@concordia.ellerman.id.au>
References: <43V85g033hz9sCX@ozlabs.org> <3480116.KzcvcCly6l@debian64>
 <87ef9ntqy3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Tuesday, January 8, 2019 10:54:28 AM CET Michael Ellerman wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
> > On Wednesday, January 2, 2019 12:31:50 PM CET Michael Ellerman wrote:
> >> On Tue, 2019-01-01 at 03:56:00 UTC, Michael Ellerman wrote:
> >> > Currently the code produces several warnings, eg:
> >> > 
> >> >   arch/powerpc/platforms/4xx/ocm.c:240:38: error: format '%llx'
> >> >   expects argument of type 'long long unsigned int', but argument 3
> >> >   has type 'phys_addr_t {aka unsigned int}'
> >> >      seq_printf(m, "PhysAddr     : 0x%llx\n", ocm->phys);
> >> >                                    ~~~^     ~~~~~~~~~
> >> > 
> >> > Fix it by using the special %pa[p] format for printing phys_addr_t.
> >> > Note we need to pass the value by reference for the special specifier
> >> > to work.
> >> > 
> >> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> >> 
> >> Series applied to powerpc fixes.
> >> 
> >> https://git.kernel.org/powerpc/c/52b88fa1e8c7bae03bb691178a9f8b
> >
> > Well, I guess I'm a late. I had issues with the getting 4.20+
> > crosscompiled on debian with make-kpkg. 
> >
> > Nevertheless, I finally got a working kernel and 
> > on the MyBook Live APM82181:
> >
> > ---
> > root@mbl:/sys/kernel/debug# cat ppc4xx_ocm/info 
> > PPC4XX OCM   : 1
> > PhysAddr     : 0x0000000400040000[p]
> > MemTotal     : 32768 Bytes
> > MemTotal(NC) : 32768 Bytes
> > MemTotal(C)  : 0 Bytes
> >
> > NC.PhysAddr  : 0x0000000400040000[p]
> > NC.VirtAddr  : 0x6bc84b36
> > NC.MemTotal  : 32768 Bytes
> > NC.MemFree   : 32768 Bytes
> >
> > C.PhysAddr   : 0x0000000000000000[p]
> > C.VirtAddr   : 0x  (null)
> > C.MemTotal   : 0 Bytes
> > C.MemFree    : 0 Bytes
> 
> Oh right, I'm an idiot :)
> 
> The docs say:
> 
> Physical address types phys_addr_t
> ----------------------------------
> 
> 	%pa[p]	0x01234567 or 0x0123456789abcdef
> 
> 
> And if you grep for that there's eg:
> 
>   drivers/ntb/test/ntb_tool.c:                     "Window Size    \t%pa[p]\n",
> 
> So I just literally copied that.
> 
> But it's trying to indicate that the p is optional.
> 
> This should fix it, I won't merge it until you've tested it this time :)
> 
> cheers
> 
> 
> diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
> index a1aaa1569d7c..f0e488d97567 100644
> --- a/arch/powerpc/platforms/4xx/ocm.c
> +++ b/arch/powerpc/platforms/4xx/ocm.c
> @@ -237,12 +237,12 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
>  			continue;
>  
>  		seq_printf(m, "PPC4XX OCM   : %d\n", ocm->index);
> -		seq_printf(m, "PhysAddr     : %pa[p]\n", &(ocm->phys));
> +		seq_printf(m, "PhysAddr     : %pa\n", &(ocm->phys));
>  		seq_printf(m, "MemTotal     : %d Bytes\n", ocm->memtotal);
>  		seq_printf(m, "MemTotal(NC) : %d Bytes\n", ocm->nc.memtotal);
>  		seq_printf(m, "MemTotal(C)  : %d Bytes\n\n", ocm->c.memtotal);
>  
> -		seq_printf(m, "NC.PhysAddr  : %pa[p]\n", &(ocm->nc.phys));
> +		seq_printf(m, "NC.PhysAddr  : %pa\n", &(ocm->nc.phys));
>  		seq_printf(m, "NC.VirtAddr  : 0x%p\n", ocm->nc.virt);
>  		seq_printf(m, "NC.MemTotal  : %d Bytes\n", ocm->nc.memtotal);
>  		seq_printf(m, "NC.MemFree   : %d Bytes\n", ocm->nc.memfree);
> @@ -252,7 +252,7 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
>  							blk->size, blk->owner);
>  		}
>  
> -		seq_printf(m, "\nC.PhysAddr   : %pa[p]\n", &(ocm->c.phys));
> +		seq_printf(m, "\nC.PhysAddr   : %pa\n", &(ocm->c.phys));
>  		seq_printf(m, "C.VirtAddr   : 0x%p\n", ocm->c.virt);
>  		seq_printf(m, "C.MemTotal   : %d Bytes\n", ocm->c.memtotal);
>  		seq_printf(m, "C.MemFree    : %d Bytes\n", ocm->c.memfree);

Ok, with the patch applied it now looks like:

|root@mbl:/sys/kernel/debug/ppc4xx_ocm# cat info 
|PPC4XX OCM   : 1
|PhysAddr     : 0x0000000400040000
|MemTotal     : 32768 Bytes
|MemTotal(NC) : 32768 Bytes
|MemTotal(C)  : 0 Bytes
|
|NC.PhysAddr  : 0x0000000400040000
|NC.VirtAddr  : 0x54f5bce2
|NC.MemTotal  : 32768 Bytes
|NC.MemFree   : 32768 Bytes
|
|C.PhysAddr   : 0x0000000000000000
|C.VirtAddr   : 0x  (null)
|C.MemTotal   : 0 Bytes
|C.MemFree    : 0 Bytes

... just as expected. ;)

Thanks,
Christian


