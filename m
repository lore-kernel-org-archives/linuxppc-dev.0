Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCS8c6BQtzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 14:41:36 +1000 (AEST)
Date: Wed, 26 Apr 2017 13:41:18 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Masami Hiramatsu
 <mhiramat@kernel.org>, David Laight <David.Laight@ACULAB.COM>, Paul Clarke
 <pc@us.ibm.com>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/kprobes: refactor kprobe_lookup_name for safer
 string operations
Message-Id: <20170426134118.d1d14c5e48e65f194b56f11d@kernel.org>
In-Reply-To: <20170425160711.15332-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20170425160711.15332-1-naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 25 Apr 2017 21:37:11 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Use safer string manipulation functions when dealing with a
> user-provided string in kprobe_lookup_name().
> 
> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 47 ++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 160ae0fa7d0d..5a17e6467be9 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -53,7 +53,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
>  
>  kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
>  {
> -	kprobe_opcode_t *addr;
> +	kprobe_opcode_t *addr = NULL;
>  
>  #ifdef PPC64_ELF_ABI_v2
>  	/* PPC64 ABIv2 needs local entry point */
> @@ -85,36 +85,29 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
>  	 * Also handle <module:symbol> format.
>  	 */
>  	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
> -	const char *modsym;
>  	bool dot_appended = false;
> -	if ((modsym = strchr(name, ':')) != NULL) {
> -		modsym++;
> -		if (*modsym != '\0' && *modsym != '.') {
> -			/* Convert to <module:.symbol> */
> -			strncpy(dot_name, name, modsym - name);
> -			dot_name[modsym - name] = '.';
> -			dot_name[modsym - name + 1] = '\0';
> -			strncat(dot_name, modsym,
> -				sizeof(dot_name) - (modsym - name) - 2);
> -			dot_appended = true;
> -		} else {
> -			dot_name[0] = '\0';
> -			strncat(dot_name, name, sizeof(dot_name) - 1);
> -		}
> -	} else if (name[0] != '.') {
> -		dot_name[0] = '.';
> -		dot_name[1] = '\0';
> -		strncat(dot_name, name, KSYM_NAME_LEN - 2);
> +	const char *c;
> +	ssize_t ret = 0;
> +	int len = 0;
> +
> +	if ((c = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
> +		c++;
> +		len = c - name;
> +		memcpy(dot_name, name, len);
> +	} else
> +		c = name;
> +
> +	if (*c != '\0' && *c != '.') {
> +		dot_name[len++] = '.';
>  		dot_appended = true;
> -	} else {
> -		dot_name[0] = '\0';
> -		strncat(dot_name, name, KSYM_NAME_LEN - 1);
>  	}
> -	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
> -	if (!addr && dot_appended) {
> -		/* Let's try the original non-dot symbol lookup	*/
> +	ret = strscpy(dot_name + len, c, KSYM_NAME_LEN);
> +	if (ret >= 0)

Here, maybe you can skip the case of ret == 0. (Or, would we have
a symbol which only has "."?)

Others look good to me.

Thank you,

> +		addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
> +
> +	/* Fallback to the original non-dot symbol lookup */
> +	if (!addr && dot_appended)
>  		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> -	}
>  #else
>  	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
>  #endif
> -- 
> 2.12.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
