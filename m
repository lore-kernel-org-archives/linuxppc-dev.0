Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtfwF0BYFzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 18:46:36 +1000 (AEST)
Date: Mon, 25 Apr 2016 03:46:26 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Khem Raj <raj.khem@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] powerpc/ptrace: Fix out of bounds array access warning
Message-ID: <20160425084626.GA1672@gate.crashing.org>
References: <1461564006-22331-1-git-send-email-raj.khem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461564006-22331-1-git-send-email-raj.khem@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 24, 2016 at 11:00:06PM -0700, Khem Raj wrote:
> gcc-6 correctly warns about a out of bounds access
> 
> arch/powerpc/kernel/ptrace.c:407:24: warning: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Warray-bounds]
>         offsetof(struct thread_fp_state, fpr[32][0]));
>                         ^
> 
> check the end of array instead of beginning of next element to fix this

This should be fixed by doing

>         offsetof(struct thread_fp_state, fpr[32]));

instead; [31][1] is not the correct offset when TS_FPRWIDTH > 1.


Segher
