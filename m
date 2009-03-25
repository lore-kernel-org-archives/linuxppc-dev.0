Return-Path: <jwboyer@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id B7F3FDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 03:27:29 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so54723waf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:27:27 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 25 Mar 2009 12:27:01 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Sanitize stack pointer in signal handling code
Message-ID: <20090325162700.GB2367@yoda.jdub.homelinux.org>
References: <20090325162359.GA2367@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090325162359.GA2367@yoda.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 25, 2009 at 12:23:59PM -0400, Josh Boyer wrote:
>On powerpc64 machines running 32-bit userspace, we can get garbage bits in the
>stack pointer passed into the kernel.  Most places handle this correctly, but
>the signal handling code uses the passed value directly for allocating signal
>stack frames.
>
>This fixes the issue by introducing a get_clean_sp function that returns a
>sanitized stack pointer.  For 32-bit tasks on a 64-bit kernel, the stack
>pointer is masked correctly.  In all other cases, the stack pointer is simply
>returned.
>
>Additionally, we pass an 'is_32' parameter to get_sigframe now in order to
>get the properly sanitized stack.  The callers are know to be 32 or 64-bit
>statically.
>
>Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Ben, this should look familiar.  It's based on your current -next branch.

If you agree, I can send it to the -stable team for .27, .28 and .29.

josh
