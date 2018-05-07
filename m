Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fRk36Dm0zF13r
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 12:42:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/6] powerpc/syscalls: Switch trivial cases to
 SYSCALL_DEFINE
In-Reply-To: <1525446080.ih4a1c8i42.naveen@linux.ibm.com>
References: <20180502132051.28861-1-mpe@ellerman.id.au>
 <1525446080.ih4a1c8i42.naveen@linux.ibm.com>
Date: Mon, 07 May 2018 12:42:50 +1000
Message-ID: <87y3gw6v9x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Michael Ellerman wrote:
>> From: Al Viro <viro@zeniv.linux.org.uk>
>> 
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> ---
>>  arch/powerpc/kernel/pci_32.c               | 6 +++---
>>  arch/powerpc/kernel/pci_64.c               | 4 ++--
>>  arch/powerpc/mm/subpage-prot.c             | 4 +++-
>>  arch/powerpc/platforms/cell/spu_syscalls.c | 3 ++-
>>  4 files changed, 10 insertions(+), 7 deletions(-)
>> 
>
> I suppose we can also do this for switch_endian?

Yeah. It'd nice to have an automated test that every syscall is
available via FTRACE_SYSCALLS, I just haven't got around to writing one.

cheers

> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index 466216506eb2..290265f2700c 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -123,7 +123,7 @@ long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
>  				 (u64)len_high << 32 | len_low, advice);
>  }
>  
> -long sys_switch_endian(void)
> +SYSCALL_DEFINE0(switch_endian)
>  {
>  	struct thread_info *ti;
>
>
> - Naveen
