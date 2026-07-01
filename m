Return-Path: <linuxppc-dev+bounces-23273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD024C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 07:42:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqsRK0Kssz2xKh;
	Wed, 01 Jul 2026 17:42:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782891724;
	cv=none; b=m2Xv4UPL8GNtzwLf3qBEH2TC8b+YrUrLHBkfYgmqsZ8ul6SYYPNEFIJul7y3LdtCCU0hSc4dJFKwKEKBRa/1MDLwS5a6uu/oKTxN1Tf9nSbordvRWPurcKDsJR2u9Cr0DgcF0UtMcAGiBahLhfFpA0dM0b+Ctv9dYhNoZeU7Uox1VPVKSZrzl198Y7HmscLq2uGdG8TL6vmf61cEtTEVCJBxO9QWOJyzvZWhOLFZEMyZ1N3ODPyYvfZ5WXWdD5wCrfrfmmQdTzRBOVxZLjpL5uqI6J8SaAawdduCrGN+Q1ZD7Jd2BgHXsi3DTnB5ORJIBlri9ezNb/buW/glLAWIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782891724; c=relaxed/relaxed;
	bh=z/jLyEZCndM+a6hJVr7NS5QKyOjcCn/20HRIG8mNP1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBGY0fmpx6ozZlPR8679n2vhV9okbi5MV6wFASzPm7Lln4fYvNdNPjfp/P7k5ddklaWOqd8895hFiwCYhE8bRc5dxWwekZQnq/FrOggZgAINP1YxHyjSYwmrq4qhHgEod+bEqE3Cp7+7E6Cuvtb+z//VmJqSBWbcM7/J706EVNSGbYUTqk47AbK8hXaHO4bcrQ+D/EGEPrHc5w0eMgb00LUVkGVYXt5/pDvS8VzdMPeG9HeREiEmQD5kGbm/A3TE9fWz/d2EkvL1ZF0suDr2MrBVmAHVWnw4vx11mJtcdP3Vj4l2LzfxtLDOFL7LodUJZ9nOG2SaKBT3CvI0xZHlVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=E4GtCUii; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=54fB58bS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=E4GtCUii; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=54fB58bS; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=E4GtCUii;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=54fB58bS;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=E4GtCUii;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=54fB58bS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqsRH3k1Lz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 17:42:02 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EC8075FE8;
	Wed,  1 Jul 2026 07:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782891718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/jLyEZCndM+a6hJVr7NS5QKyOjcCn/20HRIG8mNP1Y=;
	b=E4GtCUiiYUpalTiWqJxl69UZ+Qd2c9Aiav4d+9DAgl8tdMxKQ9H4OHjXLFEsxkFb+wfRB4
	zXnxFB/xZipJvtTI3TLZpuXAX5evQU8Kt83V6pO6BBiT6oAGpiIKxVkFaV2Hkb9whiv2p6
	48pCb+C6e/0EFK2xYexZgmNtDyElfvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782891718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/jLyEZCndM+a6hJVr7NS5QKyOjcCn/20HRIG8mNP1Y=;
	b=54fB58bS84qf6I4e7CFbK0Pma1WyFe4UZpBMgaKoFhl5TJTpbQWFkwMRTv8Z5A7+tYy4Os
	zwM1dnVZrYTVxNCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E4GtCUii;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=54fB58bS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782891718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/jLyEZCndM+a6hJVr7NS5QKyOjcCn/20HRIG8mNP1Y=;
	b=E4GtCUiiYUpalTiWqJxl69UZ+Qd2c9Aiav4d+9DAgl8tdMxKQ9H4OHjXLFEsxkFb+wfRB4
	zXnxFB/xZipJvtTI3TLZpuXAX5evQU8Kt83V6pO6BBiT6oAGpiIKxVkFaV2Hkb9whiv2p6
	48pCb+C6e/0EFK2xYexZgmNtDyElfvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782891718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/jLyEZCndM+a6hJVr7NS5QKyOjcCn/20HRIG8mNP1Y=;
	b=54fB58bS84qf6I4e7CFbK0Pma1WyFe4UZpBMgaKoFhl5TJTpbQWFkwMRTv8Z5A7+tYy4Os
	zwM1dnVZrYTVxNCQ==
Date: Wed, 1 Jul 2026 09:41:57 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	mkchauras@linux.ibm.com, ryan.roberts@arm.com,
	ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akTExSO3ZT7iRtBa@kunlun.suse.cz>
References: <20260629182946.419552-1-mkchauras@gmail.com>
 <a58675e4-f5a6-4a21-9871-904aad33b683@linux.ibm.com>
 <akSyVOsraz9waBf4@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="V8SGfTBC2s1wfGWG"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akSyVOsraz9waBf4@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.09 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	MIME_BAD_ATTACHMENT(1.60)[c:text/x-c];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-c];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	HAS_ATTACHMENT(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,arm.com,huawei.com,lists.ozlabs.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spamd-Bar: ++++
X-Rspamd-Queue-Id: 6EC8075FE8


--V8SGfTBC2s1wfGWG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 01, 2026 at 11:57:00AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Wed, Jul 01, 2026 at 01:41:09AM +0530, Shrikanth Hegde wrote:
> > Hi Mukesh.
> > 
> > On 6/29/26 11:59 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
> > > SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
> > > (Function not implemented) instead of the expected EPERM (Operation
> > > not permitted).
> > > 
> > > The issue occurs in system_call_exception() when syscall_enter_from_user_mode()
> > > returns -1 to indicate the syscall should be skipped (e.g., blocked by seccomp).
> > > The current code treats this -1 as a syscall number and compares it against
> > > NR_syscalls. Since -1 is greater than NR_syscalls,
> > > the code incorrectly returns -ENOSYS, overwriting the errno that seccomp
> > > already set via syscall_set_return_value().
> > > 
> > > The generic entry code in syscall_trace_enter() calls __secure_computing(),
> > > which sets the appropriate errno in regs->gpr[3] and returns -1 to signal
> > > that the syscall should be skipped. However, the PowerPC syscall handler
> > > was not checking for this -1 return value before validating the syscall
> > > number.
> > > 
> > > Fix this by explicitly checking if syscall_enter_from_user_mode() returns
> > > -1 and returning the value already set in regs->gpr[3] (the errno from
> > > seccomp) before performing the syscall number validation.
> > > 
> > > Also Move the syscall_enter_from_user_mode() call and the seccomp/ptrace
> > > skip check to after the NR_syscalls bounds check.
> > > 
> > > When syscall -1 was passed, the r0 == -1L check would trigger before
> > > the NR_syscalls check, causing syscall_get_error() to return 0 instead
> > > of -ENOSYS. This resulted in a silent success (ret=0, errno=0) instead
> > > of the expected ENOSYS error.
> > > 
> > > By moving syscall_enter_from_user_mode() after the bounds check, an
> > > initial syscall number of -1 is correctly rejected with -ENOSYS first.
> > > The seccomp/ptrace skip path still works correctly for valid syscall
> > > numbers that get overridden to -1 by seccomp or ptrace.
> > > 
> > > This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
> > > and restores correct seccomp errno handling.
> > > 
> > > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > > Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
> > > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > > ---
> > > 
> > > v1 -> v2:
> > >   - Fix issues in the previous fix (Michal)
> > > v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com
> > > 
> > >   arch/powerpc/kernel/syscall.c | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > > index a9da2af6efa8..36d73933a311 100644
> > > --- a/arch/powerpc/kernel/syscall.c
> > > +++ b/arch/powerpc/kernel/syscall.c
> > > @@ -20,7 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > >   	syscall_fn f;
> > >   	add_random_kstack_offset();
> > > -	r0 = syscall_enter_from_user_mode(regs, r0);
> > >   	if (unlikely(r0 >= NR_syscalls)) {
> > >   		if (unlikely(trap_is_unsupported_scv(regs))) {
> > > @@ -31,6 +30,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > >   		return -ENOSYS;
> > >   	}
> > > +	r0 = syscall_enter_from_user_mode(regs, r0);
> > > +
> > 
> > I see many arch first do syscall_enter_from_user_mode and then check for return value.
> > take x86 for example,
> > 
> > __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> > {
> >         nr = syscall_enter_from_user_mode(regs, nr);
> > 
> >         if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
> >                 /* Invalid system call, but still a system call. */
> >                 regs->ax = __x64_sys_ni_syscall(regs);
> >         }
> > 
> > }
> > 
> > So seccomp fails silently there if initial nr was -1?
> > 
> Hey,
> 
> No the -1 syscall ignores the error silently and returns 0.
> 

There seems to be some inconsistency with the invalid syscalls.

Adapting the example from seccomp man page to ignore architecture I get
on x86_64 (presumably with GENERIC_ENTRY since long ago):

./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
ret=-1 errno=55 (No anode)

but on ppc64le (with GENEREC_ENTRY):

./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
ret=-1 errno=38 (Function not implemented)

That said, behavior of seccomp on invalid syscalls is not particularly
concerning. The tools that people typically use for constructing those
filters typically require a valid syscall number.

It would be nice to align, though.

Thanks

Michal

--V8SGfTBC2s1wfGWG
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: attachment; filename=seccomp.c

#include <linux/audit.h>
#include <linux/filter.h>
#include <linux/seccomp.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/prctl.h>
#include <sys/syscall.h>
#include <unistd.h>

	static int
install_filter(int syscall_nr, int f_errno)
{
	struct sock_filter filter[] = {
		/* [0] Load architecture from 'seccomp_data' buffer into
		   accumulator.  */
		BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
				(offsetof(struct seccomp_data, arch))),

		/* [1] Load system call number from 'seccomp_data' buffer into
		   accumulator.  */
		BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
				(offsetof(struct seccomp_data, nr))),

		/* [2] Jump forward 1 instruction if system call number
		   does not match 'syscall_nr'.  */
		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, syscall_nr, 0, 1),

		/* [3] Matching system call: don't execute
		   the system call, and return 'f_errno' in 'errno'.  */
		BPF_STMT(BPF_RET | BPF_K,
				SECCOMP_RET_ERRNO | (f_errno & SECCOMP_RET_DATA)),

		/* [4] Destination of system call number mismatch: allow other
		   system calls.  */
		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
	};

	struct sock_fprog prog = {
		.len = sizeof(filter) / sizeof(*filter),
		.filter = filter,
	};

	if (syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog)) {
		perror("seccomp");
		return 1;
	}

	return 0;
}

	int
main(int argc, char *argv[])
{
	if (argc < 4) {
		fprintf(stderr, "Usage: "
				"%s <syscall_nr> <errno> <prog> [<args>]\n"
				"\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
		perror("prctl");
		exit(EXIT_FAILURE);
	}

	if (install_filter(strtol(argv[1], NULL, 0),
				strtol(argv[2], NULL, 0)))
		exit(EXIT_FAILURE);

	execv(argv[3], &argv[3]);
	perror("execv");
	exit(EXIT_FAILURE);
}


--V8SGfTBC2s1wfGWG--

