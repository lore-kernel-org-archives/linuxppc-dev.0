Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB5606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=iihKc7CS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFHF3mSCz2xwL;
	Fri, 30 Oct 2026 19:52:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793350377;
	cv=none; b=W+6xlSujyLJpfLlqqOIPqpXRrg9ccM10zsa36VUnOyi1pH36BGNN+YuvBOdh5mTd5xL26DQk0/ohZy6I08oJkYagrxEKk/qCxBn+6do6oia0+C50hAaNYMG1iKUaYUkFb9Ipn1aClsPeqpjBQO6dHPE/4k2G6vdu83FIfmkmLEz00hDwZdwosLHAcizQ6MK3kbeQh8tWCP2gDZa2oQwchvorGU/6nLNWBhiEegMJT4ZMS3LQRATyme4zl/efE6/WC+4Mqo6fy4VhiMcx6bfAOyKCrl6ma4i0KWjzueuayXo7OgRJ2iVEP3lj4Mzo/hRrTjt0gwIKHRJ8CO8XomCKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793350377; c=relaxed/relaxed;
	bh=FYw+R4tThY9ijxrPMeJ6bkKz9WbQem7Wim2y25tODDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y++2h2DJhzM9rEinON63GlanUECYlApDTR835p019KP014DrV0Z/vyEmvKc8hLehjn/t+Bj8/Hy9RLq1n6vT3oDKGVtNYmdV6rtFZRMQ5MTxbFaRz9Rv7StVxdGzHlu8g+GPcIMKboOxLXVwCJXpl3BPJyjNgr3IwLnvvrefvbudvKun79ZuGG4e5dNnXxiZ/mzzkpkzhSSAiIaU4+ghqw4A8JB16AOcvROIgRbkPqIxsZ+fPXcmXHVudAMZpST6bKNQMMjBAXXhFonxkw/Y/P2dNS4cRexhUZSVegQB/CmwX4/PJyre9PpkqcmSvYNmabIaNBrAC/eCLkyBVTqZ3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=iihKc7CS; dkim-atps=neutral; spf=pass (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=iihKc7CS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFHD4WjJz2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 19:52:56 +1100 (AEDT)
Received: from cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id A0A651C0043;
	Fri, 30 Oct 2026 09:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1793350373;
	bh=q6juWM5f7jikhcMl2i3ywbPNpOJBMHXqoBewrCHl84A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iihKc7CSYD8TVRUP8Uhtr8sZX7SdlWSRlQOevVC+Mm3tmKF/xYwKffgrKG6tvTmgm
	 u9khgsUeHwN+rB5poSBzmqpI2iF2yG6pwXbM18msSILhIOAc8AWl/knEapyijB0XPR
	 o72K1nUEJtO+Og3bI6IoxGZ8Ft/DZTHHQirNKbJI=
Date: Fri, 30 Oct 2026 09:52:51 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] powerpc/syscall: Return the preset value of
 skipped syscalls
Message-ID: <auRa4xcZpLSQD78V@cs.unibo.it>
References: <20261023180735.853655-1-renzo@cs.unibo.it>
 <auB6vjNg3w5LPVwb@kunlun.suse.cz>
 <auLyYd9-6WwwzPgz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <auNZiOi_tj6ssGZr@cs.unibo.it>
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
In-Reply-To: <auNZiOi_tj6ssGZr@cs.unibo.it>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 03:34:48PM +0100, Renzo Davoli wrote:
> I will send a v3 rebased on current mainline, split in two:
>  1/2 remove TIF_SYSCALL_RET (Fixes: 69cb2be898be), as suggested by
>      Michal
>  2/2 return the preset value of a skipped syscall (Fixes: 05c033db7e9a)
>      using your expression.

v3 here:
https://lore.kernel.org/lkml/20261030084926.1068384-1-renzo@cs.unibo.it/

renzo

