Return-Path: <npiggin@gmail.com>
Date: Tue, 12 Sep 2017 15:03:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <skiboot@lists.ozlabs.org>
Subject: Re: [PATCH v1 0/4] Revisit MCE handling for UE Errors
Message-ID: <20170912150344.2d6702d1@roar.ozlabs.ibm.com>
In-Reply-To: <20170912043859.32473-1-bsingharora@gmail.com>
References: <20170912043859.32473-1-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

Very cool. How are you testing it? Is it failing memory pages
and poisoning them out properly?

Looks like you have a printk in the machine_check_early path,
which you shouldn't. I guess because we don't mark that context
as an NMI. Which we could... but I think you want to put as
little as possible in that path, so avoiding the print would
be preferable. Perhaps you could mark the mce event somehow that
the failure can be reported during processing it?

Firmware logging is a good question, I could not really see
where this all gets plumbed through. If this is expected to be
a common problem for some types of attached memory, then we
really need to build up a log of these errors that can be used
to exclude the memory after a reboot too. Do we have anything
like this capability in firmware?

Thanks,
Nick

On Tue, 12 Sep 2017 14:38:55 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> This patch series is designed to hook up memory_failure on
> UE errors, this is specially helpful for user_mode UE errors.
> 
> The first patch is a cleanup patch, it removes dead code.
> I could not find any users of get_mce_fault_addr().
> The second patch walks kernel/user mode page tables in
> real mode to extract the effective address of the instruction
> that caused the UE error and the effective address it was
> trying to access (for load/store). The third patch hooks
> up the pfn for instruction UE errors (ierror).
> 
> The fourth patch hooks up memory_failure to the MCE patch.
> 
> TODO:
> Log the address in NVRAM, so that we can recover from
> bad pages at boot and keep the blacklist persistent.
> 
> Changelog v2:
> 	- address review comments from Nick and Mahesh
> 	(initialization of pfn and more comments on failure
> 	when addr_to_pfn() or anaylse_instr() fail)
> 	- Hookup ierrors to the framework as well
> 	(comments from Mahesh)
> 
> Balbir Singh (4):
>   powerpc/mce.c: Remove unused function get_mce_fault_addr()
>   powerpc/mce: Hookup derror (load/store) UE errors
>   powerpc/mce: Hookup ierror (instruction) UE errors
>   powerpc/mce: hookup memory_failure for UE errors
> 
>  arch/powerpc/include/asm/mce.h  |   4 +-
>  arch/powerpc/kernel/mce.c       | 108 ++++++++++++++++++++++++----------------
>  arch/powerpc/kernel/mce_power.c | 105 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 163 insertions(+), 54 deletions(-)
> 
