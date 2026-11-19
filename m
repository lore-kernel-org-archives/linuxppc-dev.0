Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CD606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=E3Ie1BHW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVZbl4rf3z2xSF;
	Thu, 19 Nov 2026 21:34:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795084499;
	cv=none; b=VzEW91RVcJI8ZiuTW+ijTAj3LTWV/m1e1unNfgVYPvbajKciKMShUyFDZDGdxEQ2e7YXQ/5KUesWAytJ8xt+SfwtCw97VSx5suOhioNTHyyh9AfgYLUQcYcHO7f1qFobRSiyRML0BMlqXEEHZFMwp9TIzyUABkEC7GJXjvchy9m6irbu8ObB48jHSO2g+ZOWyyN6gqPWtU1A6rHNuTL19UtYzDrpyYdHMADUOI1T+gpdEF9I7xxN1BCjAhMUwqTZRhXlPQusaW5+oviJp3JXIPQA6RnHiZ4xnkhTVmLMzcCpLTZpPe9CKUZAHCjvQ7kKxQ7aWsLm4A6ybyigxf96hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795084499; c=relaxed/relaxed;
	bh=aCKEnKdCSy+ImZs7Fr08y3Q1G1aahqToEeebZ+fmVxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXsV+P1EAuZYjDvCJo6xFx5C5wknR6dTlstzADW4vigGC+W11uWUaBuyqGZX6BUEIPuyvll7Z7n6pKUG1WJd1cs0YIl1hALdflUG3tZToZrUwflGJvBXaK0tqSIU8ai57NhfTSRsyUF0J/zDJAAdAK80pXxUKNwsyB4oXYGejT7afSKoNPqGiq8Z3l/x/p2CfSTyI/Opivi+gPV0cpfXs3m4BTV5XMNaC2KrQvh/H1gXy607mCzpOgV+tCGz6Yd1FrXAfwD1sDzi9B46FvguCRiEmXheo60t/udSKVbGN9SoNSlCuDzKFY0+sT9iJd9BlIvq5/JQ8JxDI39dKMfQvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=E3Ie1BHW; dkim-atps=neutral; spf=pass (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=E3Ie1BHW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVZbj17vvz2xQK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 21:34:55 +1100 (AEDT)
Received: from cs.unibo.it (renzopb-wl.cs.unibo.it [130.136.2.252])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id D6B4E1C024A;
	Thu, 19 Nov 2026 11:34:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1795084487;
	bh=aCKEnKdCSy+ImZs7Fr08y3Q1G1aahqToEeebZ+fmVxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3Ie1BHWc/V6b1bgdwtc+2v71pAz+kleKjlPIEJguRI1UeOerm0esQVsBjPfxVbb2
	 3nNRPyNBUsItmS4wxnV7QW3nDFBfTMT8xhb6a0gxwRJuRsLbmfHdXhJwoMEmOJl7a0
	 lRi+0pU0z6HbeHORs+j7+1RZlPZZSUE5dLPjJ8mI=
Date: Thu, 19 Nov 2026 11:34:46 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] powerpc/syscall: Fix the return value of skipped
 syscalls
Message-ID: <av7Qxhc37BAA04mf@cs.unibo.it>
References: <20261030084926.1068384-1-renzo@cs.unibo.it>
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
In-Reply-To: <20261030084926.1068384-1-renzo@cs.unibo.it>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 09:49:23AM +0100, Renzo Davoli wrote:
> When ptrace or seccomp skip a system call on powerpc, the return value
> they set is lost or the tracer is affected:

Hi Madhavan, Michael,

gentle ping on this series.

It fixes a bug already present in mainline: on powerpc a return value
set via PTRACE_SET_SYSCALL_INFO for a skipped system call is lost, and
syscall_set_return_value() sets TIF_SYSCALL_RET on the tracer instead
of the tracee. This currently breaks the set_syscall_info selftest
and seccomp_bpf user_notification_basic on ppc64le.

The series still applies to current mainline. Please let me know if
anything needs to be changed, or if I should resend it.

Thanks,
renzo

