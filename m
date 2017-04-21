Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8cBw2PZgzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:33:44 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3LDUlh8033615
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:33:33 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29y27xffvn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:33:32 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 21 Apr 2017 07:33:31 -0600
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH v4 4/7] powerpc/kprobes: Use safer string functions in
 kprobe_lookup_name()
References: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170421123320.7344-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
From: Paul Clarke <pc@us.ibm.com>
Date: Fri, 21 Apr 2017 08:33:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170421123320.7344-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5393535f-4469-d6b7-f7ce-256a5612999f@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2017 07:33 AM, Naveen N. Rao wrote:
> Convert usage of strchr()/strncpy()/strncat() to
> strnchr()/memcpy()/strlcat() for simpler and safer string manipulation.
> 
> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changes: Additionally convert the strchr().
> 
> 
>  arch/powerpc/kernel/kprobes.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 97b5eed1f76d..c73fb6e3b43f 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -65,28 +65,27 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
>  	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
>  	const char *modsym;
>  	bool dot_appended = false;
> -	if ((modsym = strchr(name, ':')) != NULL) {
> +	if ((modsym = strnchr(name, ':', MODULE_NAME_LEN)) != NULL) {
>  		modsym++;
>  		if (*modsym != '\0' && *modsym != '.') {
>  			/* Convert to <module:.symbol> */
> -			strncpy(dot_name, name, modsym - name);
> +			memcpy(dot_name, name, modsym - name);
>  			dot_name[modsym - name] = '.';
>  			dot_name[modsym - name + 1] = '\0';
> -			strncat(dot_name, modsym,
> -				sizeof(dot_name) - (modsym - name) - 2);
> +			strlcat(dot_name, modsym, sizeof(dot_name));

Would it be more efficient here to replace this:
--
dot_name[modsym - name + 1] = '\0';
strlcat(dot_name, modsym, sizeof(dot_name));
--

with this:
strncpy(&dot_name[modsym - name + 1], modsym, KSYM_NAME_LEN);

(So you aren't rescanning dot_name to find the end, when you already know the end position?)

>  			dot_appended = true;
>  		} else {
>  			dot_name[0] = '\0';
> -			strncat(dot_name, name, sizeof(dot_name) - 1);
> +			strlcat(dot_name, name, sizeof(dot_name));

and here do:
strncpy(dot_name, name, sizeof(dot_name));

(and remove the null termination immediately above)

>  		}
>  	} else if (name[0] != '.') {
>  		dot_name[0] = '.';
>  		dot_name[1] = '\0';
> -		strncat(dot_name, name, KSYM_NAME_LEN - 2);
> +		strlcat(dot_name, name, sizeof(dot_name));

and here do:
strncpy(&dot_name[1], name, sizeof(dot_name));

(and remove the null termination immediately above)

>  		dot_appended = true;
>  	} else {
>  		dot_name[0] = '\0';
> -		strncat(dot_name, name, KSYM_NAME_LEN - 1);
> +		strlcat(dot_name, name, sizeof(dot_name));

and here do:
strncpy(dot_name, name, sizeof(dot_name));

(and remove the null termination immediately above)

>  	}

PC
