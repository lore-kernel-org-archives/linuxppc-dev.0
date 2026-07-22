Return-Path: <linuxppc-dev+bounces-24631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D623C44512
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 07:10:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4llB69JZz2yVd;
	Wed, 22 Jul 2026 17:10:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.107.17.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784704230;
	cv=none; b=OlvL85Nle1gT1dEjrwOj7Gk1pNVt2rjGi8ll2hHq1rhkIVnxEia6ot2xjWbxKXzIF5S1lF51k5H5dK774Mx8WSHtqD3lQKpO06ioucMZHQhy9T6QVa/CH2sMJkLDDCkO5cN1XQjBOSTcsMlt8+o6yYl/rzVD2Rpl+Z77eCwXhZyVsAoKGLhNOFrjEaxZUCOrQqd83yeqo4KZyO3VxmwVW+Uw9hWxD5BTEvSegHigQsurcnwviqe1x+7JIWLv751CLGxDOkiUIVNB/kGrhqyAmFd23k5bl0NtjRuVK+D2YbE82yh1QYEpcxrv4xANXj2w8JyNK+Acx2T9j+RS4dtzew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784704230; c=relaxed/relaxed;
	bh=2IBuQ8+74HxacixMbCSzXuBWRoKTCrYoIXzz4TrhDIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGQcnXeicMFCbgA9NFi1AX21Cp19/GqPLnDpzPaqQof6/zh+/eTlJtC7Ke1bHeApffQWrxonlB2R/1iRqtnDag0MHvIAPMfCFoIWfg4zYA4Jzih/7XOFm01iFM4u1kzybSumaEimbWQcRDRqVpe6FFPZMQjaoy60/qnfvgix7i2UbHOUf5DaMHxAplAo6HDNZQBNdbvy1fPa357get+S5LbkpgDqbaLL61xqIpDHKOqxeHy3bUQIQ/fZ/x9oMUo+B56KKlc5f2OqnWybm/MFW4m2fleANmezinXFmSs0eLuRgYDioqcNbFyHk5eaeL0nN4EHcw7ts/MpHzAL9B1PEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass (client-ip=194.107.17.57; helo=vmicros1.altlinux.org; envelope-from=ldv@altlinux.org; receiver=lists.ozlabs.org) smtp.mailfrom=altlinux.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=altlinux.org (client-ip=194.107.17.57; helo=vmicros1.altlinux.org; envelope-from=ldv@altlinux.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 510 seconds by postgrey-1.37 at boromir; Wed, 22 Jul 2026 17:10:30 AEST
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4llB0jM5z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 17:10:30 +1000 (AEST)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id BCF1772C8CC;
	Wed, 22 Jul 2026 10:01:55 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id AC7427CCB3A; Wed, 22 Jul 2026 10:01:55 +0300 (IDT)
Date: Wed, 22 Jul 2026 10:01:55 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	oleg@redhat.com, kees@kernel.org, luto@amacapital.net,
	wad@chromium.org, mchauras@linux.ibm.com, thuth@redhat.com,
	ruanjinjie@huawei.com, sshegde@linux.ibm.com,
	akpm@linux-foundation.org, charlie@rivosinc.com, deller@gmx.de,
	macro@orcam.me.uk, segher@kernel.crashing.org, peterz@infradead.org,
	bigeasy@linutronix.de, namcao@linutronix.de, tglx@linutronix.de,
	mark.barnett@arm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 5/8] powerpc: add exit_flags field in pt_regs
Message-ID: <20260722070155.GA11808@strace.io>
References: <20260123073916.956498-1-mkchauras@linux.ibm.com>
 <20260123073916.956498-6-mkchauras@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123073916.956498-6-mkchauras@linux.ibm.com>

On Fri, Jan 23, 2026 at 01:09:13PM +0530, Mukesh Kumar Chaurasiya wrote:
> From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> 
> Add a new field `exit_flags` in the pt_regs structure. This field will hold
> the flags set during interrupt or syscall execution that are required during
> exit to user mode.

Apparently, this change breaks PTRACE_GETREGS as the latter has no means
to communicate the size of struct pt_regs being written to userspace.

As result, the kernel with this patch will write to userpsace 32 more
bytes than before, and unless the userspace is re-compiled with the latest
ptrace.h, 32 bytes of userspace memory after struct pt_regs will be
overwritten.

This issue was detected by strace test suite, specifically, the test that
checks whether the actual number of bytes written by
ptrace(PTRACE_GETREGS) matches sizeof(struct pt_regs), and that test failed
with runtime version v7.1 and headers version v7.2-rc1.

> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index 01e630149d48..a393b7f2760a 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -55,6 +55,8 @@ struct pt_regs
>  	unsigned long dar;		/* Fault registers */
>  	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
>  	unsigned long result;		/* Result of a system call */
> +	unsigned long exit_flags;	/* System call exit flags */
> +	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
>  };
>  
>  #endif /* __ASSEMBLER__ */

-- 
ldv

