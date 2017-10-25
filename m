Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMbNt0hF4zDqls
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 03:35:57 +1100 (AEDT)
Date: Thu, 26 Oct 2017 01:35:51 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] powerpc/kprobes: refactor kprobe_lookup_name for
 safer string operations
Message-Id: <20171026013551.b48917de3f85993b6fee70e7@kernel.org>
In-Reply-To: <88995231cc2266dd11fac018bb2027bfbf4d255b.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2a4b854c7fc11db576e3b7ff6dcfda94c64d2842.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
 <88995231cc2266dd11fac018bb2027bfbf4d255b.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 23 Oct 2017 22:07:41 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Use safer string manipulation functions when dealing with a
> user-provided string in kprobe_lookup_name().
> 

What would you mean "safer" here? using strnchr()?
Could you please show at least an example case that causes problem in original code.
And have one comment below:

> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 47 ++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index a14c61855705..bbb4795660f8 100644
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

It is odd, you can call kallsyms_lookup_name(dot_name) here.

> -	} else {
> -		dot_name[0] = '\0';
> -		strncat(dot_name, name, KSYM_NAME_LEN - 1);
>  	}
> -	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
> -	if (!addr && dot_appended) {
> -		/* Let's try the original non-dot symbol lookup	*/
> +	ret = strscpy(dot_name + len, c, KSYM_NAME_LEN);
> +	if (ret > 0)
> +		addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
> +
> +	/* Fallback to the original non-dot symbol lookup */
> +	if (!addr && dot_appended)
>  		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);

Then we can remove dot_appended.

Thank you,

> -	}
>  #else
>  	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
>  #endif
> -- 
> 2.14.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
