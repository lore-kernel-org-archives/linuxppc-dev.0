Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ChVw0xrpzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 02:59:34 +1000 (AEST)
Subject: =?UTF-8?Q?Re:_[PATCH]_powerpc/xmon:_avoid_warnings_about_variables_?=
 =?UTF-8?Q?that_might_be_clobbered_by_=e2=80=98longjmp=e2=80=99?=
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20180622192718.24242-1-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <b41b244e-78b8-c85f-9122-427ad04cccf8@c-s.fr>
Date: Sat, 23 Jun 2018 18:59:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180622192718.24242-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/06/2018 à 21:27, Mathieu Malaterre a écrit :
> Move initialization of variables after data definitions. This silence
> warnings treated as error with W=1:
> 
>    arch/powerpc/xmon/xmon.c:3389:14: error: variable ‘name’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
>    arch/powerpc/xmon/xmon.c:3100:22: error: variable ‘tsk’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]

Is that an invalid warning ?

If so, please explain in the commit log.

Otherwise, I'd expect one to fix the warning, not just cheat on GCC.

Christophe


> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/xmon/xmon.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 47166ad2a669..982848c784ff 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -3097,10 +3097,11 @@ static void show_pte(unsigned long addr)
>   static void show_tasks(void)
>   {
>   	unsigned long tskv;
> -	struct task_struct *tsk = NULL;
> +	struct task_struct *tsk;
>   
>   	printf("     task_struct     ->thread.ksp    PID   PPID S  P CMD\n");
>   
> +	tsk = NULL;
>   	if (scanhex(&tskv))
>   		tsk = (struct task_struct *)tskv;
>   
> @@ -3386,10 +3387,11 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
>   			      const char *after)
>   {
>   	char *modname;
> -	const char *name = NULL;
> +	const char *name;
>   	unsigned long offset, size;
>   
>   	printf(REG, address);
> +	name = NULL;
>   	if (setjmp(bus_error_jmp) == 0) {
>   		catch_memory_errors = 1;
>   		sync();
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
