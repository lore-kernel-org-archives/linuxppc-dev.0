Return-Path: <palves@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 93CE71400AD
 for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2014 09:42:58 +1000 (EST)
Message-ID: <535AF2E9.1000005@redhat.com>
Date: Sat, 26 Apr 2014 00:42:33 +0100
From: Pedro Alves <palves@redhat.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] powerpc, ptrace: Add new ptrace request macros for
 transactional memory
References: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1396422144-11032-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1396422144-11032-3-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, avagin@openvz.org, oleg@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2014 08:02 AM, Anshuman Khandual wrote:
> This patch adds following new sets of ptrace request macros for transactional
> memory expanding the existing ptrace ABI on PowerPC.
> 
> 	/* TM special purpose registers */
> 	PTRACE_GETTM_SPRREGS
> 	PTRACE_SETTM_SPRREGS
> 
> 	/* TM checkpointed GPR registers */
> 	PTRACE_GETTM_CGPRREGS
> 	PTRACE_SETTM_CGPRREGS
> 
> 	/* TM checkpointed FPR registers */
> 	PTRACE_GETTM_CFPRREGS
> 	PTRACE_SETTM_CFPRREGS
> 
> 	/* TM checkpointed VMX registers */
> 	PTRACE_GETTM_CVMXREGS
> 	PTRACE_SETTM_CVMXREGS

Urgh, we're _still_ adding specialized register specific calls?
Why aren't these exported as new register sets, accessible through
PTRACE_GETREGSET /  PTRACE_SETREGSET?  That's supposed to be the
Modern Way to do things.

-- 
Pedro Alves
