Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJdfY0yljzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 01:07:00 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44F3tAP143313
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 11:06:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7ux5dr74-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 11:06:54 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Thu, 4 May 2017 09:06:53 -0600
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH v2] powerpc/kprobes: refactor kprobe_lookup_name for safer
 string operations
References: <20170504102452.9701-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>
From: Paul Clarke <pc@us.ibm.com>
Date: Thu, 4 May 2017 10:06:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170504102452.9701-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <0895bcf8-f06b-98b8-265c-bc5bcc2057f1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2017 05:24 AM, Naveen N. Rao wrote:
> Use safer string manipulation functions when dealing with a
> user-provided string in kprobe_lookup_name().
> 
> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changed to ignore return value of 0 from strscpy(), as suggested by
> Masami.
> 
> - Naveen
> 
>  arch/powerpc/kernel/kprobes.c | 47 ++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 160ae0fa7d0d..255d28d31ca1 100644
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

Shouldn't this be MODULE_NAME_LEN + 1, since the ':' can come after a module name of length MODULE_NAME_LEN?

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

PC
