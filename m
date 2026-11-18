Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAB606A325
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 15:47:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV5ZV5lw3z2xSl;
	Thu, 19 Nov 2026 02:47:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795016834;
	cv=none; b=kxIyeHqI40GPkqsPr37sm8dMEyuEG52KT2Muz+0yBWseWYory8E1H/F6EHu12IWZDznrHWIXlu4xkrz+XGjaZ9uD0w8qxxpEEGg/kOykE6lyu5KKUYGG0iRC151sSJ1svEoXJhOGRl0j9Ss/iLY20YsI7Biqjkbzw5OKvTN4MBS0eFmPKehiwuX5xqc1qcYN86yU90PxVwYLoultQW4tnc3PALHeLanQR9ZBgBXHLuX77BCxqa7ZC2nBHCz/T4/RTEaotwMXvhH6TZCz8Y79IyfGPakJksmQBM44b1p8Um72PCrLvkfx1HewGTv/5kYBY4AEnPQX0ltnNuw6Nh5srg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795016834; c=relaxed/relaxed;
	bh=flMGPLDMTpq68z1lJ74ODL+EiAGhlUNC3nFdUWIDwBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOSyz5kGHOeZ2/diuaIFqTInzxsn80AbwhXZoMTpzApWIHtUoliPdpFteZxmbf5iWJ9FgJqdu47FSMVMZN4iwvq4/MpKsBOYRrXaSESYg3rkbDWdZooooYdgq8DEnilAt5IWm7iWcvtiQZ4TFFkyf1J3XLnDM1s4MjcmpFJ3JmOmxeyi2EQx4nJvL2xwS3HVMSIsOh87yrCP42A1lVGGv78jrp3kqRu4jB7mBLtEGlx9Q9EyL2y2vPrsLvQ27abJt958hnyZSh3UKfzsYxm9kOzzZMkEjNuzsEmZVPxoIRSM/thx3BBdgDr7VT3XWYzziHF0MrABUosD3ieiYGQQYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV5ZV11S5z2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 02:47:13 +1100 (AEDT)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A73A1F798;
	Wed, 18 Nov 2026 15:47:10 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Wed, 18 Nov 2026 16:47:09 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Renzo Davoli <renzo@cs.unibo.it>
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
Message-ID: <av3Ifd4saO2_6Slq@kunlun.suse.cz>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <av2PKIf8YsEPro8O@kunlun.suse.cz>
 <av2i9kbZyMRJE9D6@cs.unibo.it>
 <av2pRG1JT9te8IiM@kunlun.suse.cz>
 <av2yDgdBWfTxvZca@cs.unibo.it>
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
In-Reply-To: <av2yDgdBWfTxvZca@cs.unibo.it>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 5A73A1F798
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 03:11:26PM +0100, Renzo Davoli wrote:
> On Wed, Nov 18, 2026 at 02:33:56PM +0100, Michal Suchánek wrote:
> > As I understand it the new s390 code resolves the problem by storing the
> > syscall number outside of the registers. Then the return value can be
> > set directly. It does not depend on using the generic entry but on the
> > architecture adding storage for the syscall number in struct pt_regs,
> > and implementing the code to determine where to get/set the syscall
> > value depending on the syscall stage.
> 
> Right, thanks for the correction: what matters is a separate storage
> for the syscall number on the architectures where it shares a register
> with the return value, not the generic entry code.
> 
> > However, it seems that extending struct pt_regs breaks userspace ABI
> > (probably because kernel refuses to transfer partial pt_regs to/fom
> > userspace) which makes it unclear how the int_code that is used by this
> > new code could be added to the s390 struct pt_regs in the first place.
> 
> On s390 int_code is not new: it has been in the kernel-only part of
> struct pt_regs, after user_pt_regs, since aa33c8cbbae2 ("[S390] cleanup
> trap handling"), and the user ABI (s390_regs, user_regs_struct) does
> not include it. Heiko's patch only redirects the ptrace accesses to
> gpr2.
> 
> On architectures where struct pt_regs is itself the user ABI (e.g.
> alpha), the storage does not need to be in pt_regs: MIPS already keeps
> the syscall number in thread_info.
> 
> This is also why this series uses a per-task flag at the seccomp stop:
> it does not depend on where the architecture stores the syscall
> number.

It does not have to know where the architecture stores the syscall
number when using syscall_get_nr and syscall_set_nr. However, the
storage for the syscall number has to be somewhere, and for powerpc
there is AFAIK no such storage.

Thanks

Michal

