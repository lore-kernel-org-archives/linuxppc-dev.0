Return-Path: <SRS0=rwjh=CN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A2C433E2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 04:43:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E49206CA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 04:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E49206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BjQ6v39QpzDqtY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 14:43:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=ftp.linux.org.uk (client-ip=2002:c35c:fd02::1;
 helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=zeniv.linux.org.uk
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BjQ4c2sGYzDrDZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2020 14:41:52 +1000 (AEST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kE3Xe-00AAXp-Va; Fri, 04 Sep 2020 04:41:39 +0000
Date: Fri, 4 Sep 2020 05:41:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/14] x86: remove address space overrides using set_fs()
Message-ID: <20200904044138.GP1236603@ZenIV.linux.org.uk>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-13-hch@lst.de>
 <20200904025510.GO1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904025510.GO1236603@ZenIV.linux.org.uk>
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
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 04, 2020 at 03:55:10AM +0100, Al Viro wrote:
> On Thu, Sep 03, 2020 at 04:22:40PM +0200, Christoph Hellwig wrote:
> 
> > diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
> > index c8a85b512796e1..94f7be4971ed04 100644
> > --- a/arch/x86/lib/getuser.S
> > +++ b/arch/x86/lib/getuser.S
> > @@ -35,10 +35,19 @@
> >  #include <asm/smap.h>
> >  #include <asm/export.h>
> >  
> > +#ifdef CONFIG_X86_5LEVEL
> > +#define LOAD_TASK_SIZE_MINUS_N(n) \
> > +	ALTERNATIVE "mov $((1 << 47) - 4096 - (n)),%rdx", \
> > +		    "mov $((1 << 56) - 4096 - (n)),%rdx", X86_FEATURE_LA57
> > +#else
> > +#define LOAD_TASK_SIZE_MINUS_N(n) \
> > +	mov $(TASK_SIZE_MAX - (n)),%_ASM_DX
> > +#endif
> 
> Wait a sec... how is that supposed to build with X86_5LEVEL?  Do you mean
> 
> #define LOAD_TASK_SIZE_MINUS_N(n) \
> 	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
> 		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57
> 
> there?

Pushed out with the following folded in.

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 94f7be4971ed..2f052bc96866 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -37,8 +37,8 @@
 
 #ifdef CONFIG_X86_5LEVEL
 #define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE "mov $((1 << 47) - 4096 - (n)),%rdx", \
-		    "mov $((1 << 56) - 4096 - (n)),%rdx", X86_FEATURE_LA57
+	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
+		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57
 #else
 #define LOAD_TASK_SIZE_MINUS_N(n) \
 	mov $(TASK_SIZE_MAX - (n)),%_ASM_DX
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 445374885153..358239d77dff 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -33,8 +33,8 @@
 
 #ifdef CONFIG_X86_5LEVEL
 #define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE "mov $((1 << 47) - 4096 - (n)),%rbx", \
-		    "mov $((1 << 56) - 4096 - (n)),%rbx", X86_FEATURE_LA57
+	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rbx), \
+		    __stringify(mov $((1 << 56) - 4096 - (n)),%rbx), X86_FEATURE_LA57
 #else
 #define LOAD_TASK_SIZE_MINUS_N(n) \
 	mov $(TASK_SIZE_MAX - (n)),%_ASM_BX
