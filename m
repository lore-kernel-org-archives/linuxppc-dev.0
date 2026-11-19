Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FF606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g5lLu/04
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVVw157Gkz2y0B;
	Thu, 19 Nov 2026 18:48:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::59"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795074529;
	cv=none; b=aal9awQgOXzY0+DWBwA2gGA/RKyA5RZTUWygGQFJkyh6eQbzZU6jT2Lk9G80fhynq2oyk+favE7BqVOOJ88Fnk2b1JKX4CZu2fcVM+jxprL9jNz40ykIa2VjbwKdXZBPOkAqn9UnvwOdslPlyWAF5eu7q/UECE7ypoTOrImgyWQO95FCBn5Us18BMYTut+vcAO0QydAsHeUPoeStJsbBQTAAu/u3l9fv+zrHcvHjGVqPDXPqeRLpPxgSeWAWsr7ckFEg5LVH9AgFRjXL4sAqP44twI4pX/y9lQyEovIUsA+ZtQCsVauzFeoWvSkAg4wwV7RInLpQi1Zd9WlFYXMPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795074529; c=relaxed/relaxed;
	bh=hNd5MCBb+RwQDRLrwFjdA5miwBKz7JlHYmdVmb0QLqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5EiABXPFGAwFaTZupcQ5ziQay4b14Vtw6QVL/tjAE8hx3FmgaYK8nFQtq6w4nNSMce3oMpqLhoVmILwiIDQxAlWQztUKr/KFXlLVTW2C3042HgSU/cbH9wmmOEiFIBjamRB1lYPMxuIXe71LcV+4aDN7F+ojVBnms9jw4HTToh3hCUlrZXaQYCPqX1rAILCNhwNr4S5AJDdYePGCRwvnHYP8xTq3SriBDoFwNs3y2XVdlG/GNgMKWqNkIYPXWIPPLNEhqXgEHzrCCDluEQYcRvEbt/BeBaj5kKbHEp+nojg7HDqA30FcNQ7N2j2OffaYffnDH9YeZ3cc4xP9T6wbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g5lLu/04; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::59; helo=mta0.migadu.com; envelope-from=baoquan.he@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g5lLu/04;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::59; helo=mta0.migadu.com; envelope-from=baoquan.he@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 403 seconds by postgrey-1.37 at boromir; Thu, 19 Nov 2026 18:48:42 AEDT
Received: from mta0.migadu.com (out-89.mta0.migadu.com [IPv6:2001:41d0:1004:224b::59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVVvt2m83z2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 18:48:41 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=6tO+X4PnRnD+Jk0uYi9e+cJ5+jxuZiQPrphEOsBPyUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795074502; v=1; x=1795679302;
 b=g5lLu/04/T9wBgrLaiaGdvrWDSXTEFVL3yKIFO2UMnAas6oquI4r7D/44B1kGNWpoLsDtfYD
 0xoAMdcRtmiD/wcqc18goW6kE3szv/GjO1A50FUx7dzJVulVT7zby91GQe+AHz5680DbRJbw5iF
 jlzOJaS3Mk7y8Pfd/ZiCOGbY=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id f0d3d04c8dc3375f;
	Thu, 19 Nov 2026 07:41:30 +0000
X-Mizu-Trace-ID: f0d3d04c8dc3375f
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 15:41:24 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Paul Walmsley <pjw@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/2] MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
Message-ID: <av6oJBDv2fAaWSog@fedora>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 at 08:16am, Mike Rapoport (Microsoft) wrote:
> kernel/Kconfig.kexec is not matched by the KEXEC entry, so
> get_maintainer.pl does not report kexec maintainers for changes in that
> file.
> 
> Add it to the KEXEC entry.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d738990161bd0..c61a1f0ad330e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14782,6 +14782,7 @@ W:	http://kernel.org/pub/linux/utils/kernel/kexec/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>  F:	include/linux/kexec.h
>  F:	include/uapi/linux/kexec.h
> +F:	kernel/Kconfig.kexec
>  F:	kernel/kexec*
>  
>  KEXEC HANDOVER (KHO)
> 
> -- 
> 2.53.0
> 

