Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E900C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 18:02:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L728y4mhBz3cCh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 May 2022 04:02:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=nodXHs2u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=nodXHs2u; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L728J2ZFxz3bZc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2022 04:01:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YXiKAUGmVFYINv0mJnNJSdrzD7hR42YPArPjBJEWS1s=; b=nodXHs2uHAJ+xtV3jwHqsqR4h+
 Ulw8NqSb/flNvmWgvXOIgyLgQbdxVT3BCr+bphPK5qE9zuv97xwKRpBfA7SFck7EGnGbz+5pOEfsP
 2CJsbUboz4z0PDBckALPoSoFLC2Oqx+ZgfH3zh02ZZ6UvgnMMMrFCQxeRTkNvsbQhb9V0QfH4nvwR
 DzdAOgLHDUWldaSrOQPCbF6okianuPJAGMYSF4tDYZ0nJnqREo+rdyDni4NiJ8MFYPkcEw2mbVSFd
 iEm8zlHPGd+50+MdKv05pw0etmjoc/qowvdbtTPypewzSjJ3kSmABieVSQAtQmuI1FtehtHDG6o7Z
 F+GFbA8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntYqi-001Oat-B5; Tue, 24 May 2022 18:01:41 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFD0A300222;
 Tue, 24 May 2022 20:01:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id DA74220775840; Tue, 24 May 2022 20:01:39 +0200 (CEST)
Date: Tue, 24 May 2022 20:01:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH v2 5/7] objtool: Enable objtool to run only on files
 with ftrace enabled
Message-ID: <Yo0dgyqAOuwU6gHq@hirez.programming.kicks-ass.net>
References: <cover.1653398233.git.christophe.leroy@csgroup.eu>
 <cf3013dfad89ad5ac7d16d56dced72d7c138a20e.1653398233.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3013dfad89ad5ac7d16d56dced72d7c138a20e.1653398233.git.christophe.leroy@csgroup.eu>
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
Cc: aik@ozlabs.ru, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, sv@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
 naveen.n.rao@linux.vnet.ibm.com, mbenes@suse.cz, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 24, 2022 at 03:17:45PM +0200, Christophe Leroy wrote:
> From: Sathvika Vasireddy <sv@linux.ibm.com>
> 
> This patch makes sure objtool runs only on the object files
> that have ftrace enabled, instead of running on all the object
> files.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  scripts/Makefile.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 2e0c3f9c1459..06ceffd92921 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -258,8 +258,8 @@ else
>  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
>  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
>  
> -$(obj)/%.o: objtool-enabled = $(if $(filter-out y%, \
> -	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
> +$(obj)/%.o: objtool-enabled = $(and $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y),        \
> +        $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),y),y)

I think this breaks x86, quite a bit of files have ftrace disabled but
very much must run objtool anyway.
