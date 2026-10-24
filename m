Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE38606A31B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=F8syek8F
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBmW54CJgz2xdR;
	Sun, 25 Oct 2026 04:06:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:760:2e00:f0a1::32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792861569;
	cv=none; b=fdsJGQbJnSPsE5AgX8pDu4ObWbWXWI3d496oDf6OWp+PUc5i3b/ufOo/Gxr/fZEHtjX7i35vGEvXugKI+diFe+IDWyuKrHF7wKUiEEqhW/Jx4nDnyePl6Ypf1mm0Da8Zr9U2wKKgn0YzuOlmLoJQ/A8eNrtU491pSXqS7qe7K+2UFT06pmkV7Qp2EzrbAn6K5LjDC4NpIcHTK88N81jx+GlzknWyJPtfaIDYKDX4uOiD2t87FnfditXolyDZDbp0HSjBkh4c80mnN2INhT2kVVjNxN0+iTa0/uCJBXewfwvu3lZH1YB1Ac1LD7bpjBAMfkBoOU+ZYlfWkFYSY7MYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792861569; c=relaxed/relaxed;
	bh=ejcHXbbMJpCzIhflciAk29KX5ss42MtWupq3XSWtgN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM9A2CE8YdnbqEkselP29KJiC8A/+CNya5IuT68/40j5V3MmSa8SM0jNQXm3hlQ++ijeNeN/301od2iEM/+Fz+3Xs/NS2XZWHKMnUZ+cBfFP2eICOlfeNpDSTxZYUStgObiIYFUhFMEqwRwDc0GdWgCHxtUFyVOefDxFbIwn5OehOK1p1H7qH4WDpbYZ+eMGGCWkf72HNCwzCQ7TkvVtf2GFjoCX5e3l10KidspLyo2G1H8g1G5zKqNcHX5TVBn1aFGt4Pq2wnRiUf+33fjW8kz54BF/qJKr/uZRJIlbbnqh3nTzNoVv/rYiuZ9wg4SdxfL7HkYAONzbxxmStH093w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=F8syek8F; dkim-atps=neutral; spf=pass (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=F8syek8F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [IPv6:2001:760:2e00:f0a1::32])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBmW228HMz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 04:06:04 +1100 (AEDT)
Received: from cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id CD1DE1C006E;
	Sat, 24 Oct 2026 19:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792861557;
	bh=ZNWhMp3SkHo6YJhNGOOEGIApQhV+Rkfdv5zH7iaEACA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8syek8FAyg2mpNsahUjsU2e4w0/y1pXgpffdoHwil2Ufr6PQNhTG6hvlZNky+nfC
	 ONuMffhuWP3gfrUWLj+/Zs4GuGLfj7sNxBOUdTPaGEUh/yuUkWOWNNmhdy/D6OnG5O
	 Vm3yiOpbLLvjQ5UvOB/hIZJe0IHV/0a1NfZobC1M=
Date: Sat, 24 Oct 2026 19:05:55 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, "Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [PATCH v9 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp
 syscall skipping
Message-ID: <atzlc9tg2MTdnRtj@cs.unibo.it>
References: <20261020152945.575664-1-renzo@cs.unibo.it>
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
In-Reply-To: <20261020152945.575664-1-renzo@cs.unibo.it>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 05:29:40PM +0200, Renzo Davoli wrote:
> prerequisite-patch-id: abdd0fc0973bc3845ae7bfe84d855a7213ccd3d7

This prerequisite-patch-id is no longer valid.

The prerequisite patch "powerpc/syscall: Return the preset value of
skipped syscalls" is now at v2:
https://lore.kernel.org/lkml/20261023180735.853655-1-renzo@cs.unibo.it/

Its new patch-id is 3d8d8f9a79821bdeb7e155201b85417e9137256d.
This series still applies and builds on top of it, so no new
version is needed.

Best regards
  renzo

