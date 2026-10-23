Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E21606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=hpk797rV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBB0f4ystz2y8m;
	Sat, 24 Oct 2026 05:11:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:760:2e00:f0a1::32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792779074;
	cv=none; b=Ca1qlz/nDT11iRrPFss52kG8jpgAN4H4OYVMRLZIg8t5Ai/hri4M9S8gAC823WH8G1fk1lxC+uOKT4oTeSY8B9LRZi+TZ9lGcD11sSzc+zx/kXdw5XXeRVNzan9TjTqoZergOPVhmRjXrEiwz6MksUxTUj1/LKPiMWAbkYZChCLZOrxHEMSkxM4adinBLv5SiR0ApdZLVqOl0IET6dpEyZEUgpzM+PDnx/irEugnNDeW5K/EF07pp2/JBQfioiyIZipDhNx6irKET5nko/KPe4/UjASxtb1snXYoP0qu/pof1nzeDgKohqU8j2ucw94SHLUhBOf2ZQlVgqWjdaenLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792779074; c=relaxed/relaxed;
	bh=zlEllQdCadh5nXVHVJnB7CN9QmI16Id0COUP94sX/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZau/dsd3fP6MI/3Zhy6BZhDufhdEaS4COmv9llA5BBCqGowGrQ7KV+5I6DOVZDQW0bMrUE2OX4M6UAuv1eIi7HD+jmyeBh7gghJzjsm7UsXxilXqCPGQVVh5N9LfSdfb0ogsibFXfIbpeVNFuS7zu3U/f9H/JvJ03QY+0uWAAAzxA6+H/R+lbc/L5Kt2wMeAhAhMeEjMUSXt/qz7pTH3RnSmZOrj24nBooszqm3MDn+do/RoFO2jDs7r3cyPzxsV2T1YFOHvRJD48Y23JOjsQblEodF7+gDjWoEu4zfDRxH6YmwxIFmUAfxmoT6AYX1CI87L5FpmfhpqMCxV3bb5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=hpk797rV; dkim-atps=neutral; spf=pass (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=hpk797rV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [IPv6:2001:760:2e00:f0a1::32])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBB0d5Hscz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 05:11:13 +1100 (AEDT)
Received: from cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 7C4571C006E;
	Fri, 23 Oct 2026 20:11:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792779066;
	bh=JfVJ1oL2SMfCGS/dFNT2nuayN9wuQODynfmtelBWhQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpk797rVa3EWeiVAfgkCmEPotFp0QqRfyurHxPhScpC5kuYSR++oxf3VkSF/slYhL
	 HaCacal9U9YQkL92aqbNuvl+I2LnpPBBvMB/XFL8JY1pRvcK7C/fN7Ub/6rDDAKmd/
	 L/m07oDHuUmoTINS+ztraCMj9juXUBaSr7qgnrxM=
Date: Fri, 23 Oct 2026 20:11:05 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
To: samir <samir@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Davide Berardi <berardi.dav@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] powerpc/syscall: Return the preset value of skipped
 syscalls
Message-ID: <atujOWJNfMZPVD0q@cs.unibo.it>
References: <20261018151539.440213-1-renzo@cs.unibo.it>
 <49f43f66-f516-413a-9842-bf6d8cef5fb1@linux.ibm.com>
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
In-Reply-To: <49f43f66-f516-413a-9842-bf6d8cef5fb1@linux.ibm.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 02:28:09PM +0530, samir wrote:
> Hi Renzo,
> 
> 
> I tried applying the patches to the latest upstream kernel (master branch),
> but the patch fails to apply with the following errors:
> 
> error: patch failed: arch/powerpc/include/asm/syscall.h:98
> error: arch/powerpc/include/asm/syscall.h: patch does not apply
> error: patch failed: arch/powerpc/kernel/syscall.c:18
> error: arch/powerpc/kernel/syscall.c: patch does not apply
> 
> The latest commit on the master branch:
> commit 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> (HEAD -> master, origin/master, origin/HEAD)
> 
> 
> Could you please take a look and suggest how to resolve these conflicts?
> Does the patch need to be rebased against the latest upstream kernel?
> 
> Thanks for your help.
> 
> Best regards,
> Samir

fixed in v2:
https://lore.kernel.org/lkml/20261023180735.853655-1-renzo@cs.unibo.it/

Best Regards,
		 renzo

