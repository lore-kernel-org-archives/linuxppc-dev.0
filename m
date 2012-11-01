Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/6] powerpc: SMT priority (PPR) save and restore
In-reply-to: <1351666171.32304.10.camel@hbabu-laptop>
References: <1351666171.32304.10.camel@hbabu-laptop>
Date: Thu, 01 Nov 2012 11:44:49 +1100
Message-ID: <25370.1351730689@neuling.org>
Cc: anton@au1.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Haren Myneni <haren@linux.vnet.ibm.com> wrote:

> [PATCH 0/6] powerpc: SMT priority (PPR) save and restore
> 
> On P7 systems, users can define SMT priority levels 2,3 and 4 for
> processes so that some can run higher priority than the other ones.
> In the current kernel, the default priority is set to 4 which prohibits
> processes for using higher priority. Also the kernel boosts the priority to
> 4 during exceptions without saving the user defined priorities when
> the task enters the kernel. So we will be loosing the process PPR value
> and can not be restored it back when the task exits the kernel.
> 
> This patchset implements saving and restore the user defined PPR value
> for all tasks.
> 
> With null_syscall testcase (http://ozlabs.org/~anton/junkcode/null_syscall.c),
> this feature takes around extra 10 CPU cycles on average for 25 samples. 

Haren,

This version doesn't do PPR save/restore over syscall, so is this above
statement still true?  null_syscall shouldn't be effected at all, right?

Mikey

> 
> Haren Myneni (6):
>   powerpc: Move branch instruction from ACCOUNT_CPU_USER_ENTRY to caller
>   powerpc: Define CPU_FTR_HAS_PPR
>   powerpc: Increase exceptions arrays in paca struct to save PPR
>   powerpc: Define ppr in thread_struct
>   powerpc: Macros for saving/restore PPR
>   powerpc: Implement PPR save/restore
> 
>  arch/powerpc/include/asm/cputable.h      |    6 ++-
>  arch/powerpc/include/asm/exception-64s.h |   45 ++++++++++++++++++++++++++----
>  arch/powerpc/include/asm/paca.h          |    6 ++--
>  arch/powerpc/include/asm/ppc_asm.h       |   27 ++++++++++++++++-
>  arch/powerpc/include/asm/processor.h     |    6 ++++
>  arch/powerpc/include/asm/reg.h           |    1 +
>  arch/powerpc/kernel/asm-offsets.c        |    1 +
>  arch/powerpc/kernel/entry_64.S           |    6 +++-
>  arch/powerpc/kernel/exceptions-64e.S     |    3 +-
>  arch/powerpc/kernel/exceptions-64s.S     |   15 +++++----
>  arch/powerpc/kernel/process.c            |    2 +
>  11 files changed, 96 insertions(+), 22 deletions(-)
> 
> 
> 
