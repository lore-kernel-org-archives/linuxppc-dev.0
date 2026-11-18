Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01880606A33A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=G8JQznDc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV3S55Ghrz2y32;
	Thu, 19 Nov 2026 01:11:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795011093;
	cv=none; b=fCmWSDxbMf8tcjglRne14U0kRsNokkSXncEF0p4R2sldOFHPWSCcJOzcTRSA+DkvcPju5gtOYu8k2vXFyE9o6U4yikIQlV3UbpYxgmF8QjM/eyakrMvaRgH6vYLUPWnknaPYgDKLBiSn0cSw2vSJY6oi9XbHM40L/PNW8FZ6XreWYBhj4b0ox0a3E5nscQk4K5IQE4pocH7CsjrMxAWqu4lcvg0zwAz89R9ZjA3PvV9Buz4V+wC5DZuCwpMsWqqeEuf++uIfAedpgINPR8q/Cc+IEXOILXez3mj+jjDileZNiApWj63FRdBD/qGblmcYGmwhx5Z+PV71K64tH/Gzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795011093; c=relaxed/relaxed;
	bh=uppGZWqUpokKoo1jmO3Dq98VgoH2LDRH/n9DuWrt6hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVp5edPnjMXQf4HLgmbfRRbteTJsvAgfrVc4ttwUBNxG6nDQRekIFoQJ9T1PgB1XfgNi3N4DvRaRyD06TrSOZ79k7gPGjsxBWLFjioB34BuLxTglHzMClMHBVeEq/EZIVReBJiqztdCGpA7ZFoepxpAzdH6OjY691dyyqPURgyWr6Pcno0vVXEob9ZdIEnEWI0yexdYzrpO3R9P53vJ85rQCh9iuXQsLDf7L0DXnjm8OnP8jqrj85jspMedTa052zr4LgcUouwxMdJCfPzm5CqSpU326SdAErGpv0X6914kpyDyzFgpY/FSCEl+ikhb9BvUGLVw5Cwv89sphw1RyvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=G8JQznDc; dkim-atps=neutral; spf=pass (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=G8JQznDc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV3S44rGhz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 01:11:31 +1100 (AEDT)
Received: from cs.unibo.it (renzopb-wl.cs.unibo.it [130.136.2.252])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id A67461C024A;
	Wed, 18 Nov 2026 15:11:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1795011087;
	bh=uppGZWqUpokKoo1jmO3Dq98VgoH2LDRH/n9DuWrt6hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8JQznDcAi0F1lVC50abvb7msa0LG9JGhM+KxWxPVZ90g6TJ9alof/ZC98RbeZsjo
	 MOaJ2F3LGzkJRFRpMd9Gj8SiNPfhaAz0sjsI+9vrDg6WHqPFXuh5NGBGMGFlFC0rCy
	 NlLTKtoNFZhcJmW3BL4DgeGufyo+iZWVEoHaRHcc=
Date: Wed, 18 Nov 2026 15:11:26 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
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
Subject: Re: [PATCH v11 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp
 syscall skipping
Message-ID: <av2yDgdBWfTxvZca@cs.unibo.it>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <av2PKIf8YsEPro8O@kunlun.suse.cz>
 <av2i9kbZyMRJE9D6@cs.unibo.it>
 <av2pRG1JT9te8IiM@kunlun.suse.cz>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av2pRG1JT9te8IiM@kunlun.suse.cz>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 02:33:56PM +0100, Michal Suchánek wrote:
> As I understand it the new s390 code resolves the problem by storing the
> syscall number outside of the registers. Then the return value can be
> set directly. It does not depend on using the generic entry but on the
> architecture adding storage for the syscall number in struct pt_regs,
> and implementing the code to determine where to get/set the syscall
> value depending on the syscall stage.

Right, thanks for the correction: what matters is a separate storage
for the syscall number on the architectures where it shares a register
with the return value, not the generic entry code.

> However, it seems that extending struct pt_regs breaks userspace ABI
> (probably because kernel refuses to transfer partial pt_regs to/fom
> userspace) which makes it unclear how the int_code that is used by this
> new code could be added to the s390 struct pt_regs in the first place.

On s390 int_code is not new: it has been in the kernel-only part of
struct pt_regs, after user_pt_regs, since aa33c8cbbae2 ("[S390] cleanup
trap handling"), and the user ABI (s390_regs, user_regs_struct) does
not include it. Heiko's patch only redirects the ptrace accesses to
gpr2.

On architectures where struct pt_regs is itself the user ABI (e.g.
alpha), the storage does not need to be in pt_regs: MIPS already keeps
the syscall number in thread_info.

This is also why this series uses a per-task flag at the seccomp stop:
it does not depend on where the architecture stores the syscall
number.

Thanks,
renzo

