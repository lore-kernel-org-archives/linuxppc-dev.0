Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DF471A09B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 02:45:44 +1100 (AEDT)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0EA7014008F
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 02:45:43 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: ADDR_COMPAT_LAYOUT breaks PTRACE_SEIZE
Date: Sun, 22 Mar 2015 16:39:44 +0100
Message-ID: <87pp81nirj.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On ppc64, a process running with the ADDR_COMPAT_LAYOUT personality
causes ptrace(PTRACE_SEIZE) to hang in the kernel, unkillable.

#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/personality.h>
#include <sys/ptrace.h>
#include <sys/wait.h>

int
main (void)
{
  pid_t child;

  personality (ADDR_COMPAT_LAYOUT);
  child = fork ();
  if (child == 0)
    {
      kill (getpid (), SIGSTOP);
      exit (0);
    }

  ptrace (PTRACE_SEIZE, child, NULL, NULL);
  wait (NULL);
  ptrace (PTRACE_CONT, child, NULL, NULL);
}

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
