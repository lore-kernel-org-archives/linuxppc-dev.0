Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8bjs26QvzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:12:01 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3LD9NkT077081
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:11:50 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29xxm31y0m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:11:50 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 21 Apr 2017 07:11:49 -0600
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH v4 3/7] kprobes: validate the symbol name provided during
 probe registration
References: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170421123234.6895-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
From: Paul Clarke <pc@us.ibm.com>
Date: Fri, 21 Apr 2017 08:11:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170421123234.6895-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <dc950d45-4e98-9bd7-d435-4a6005507f94@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

a nit or two, below...

On 04/21/2017 07:32 AM, Naveen N. Rao wrote:
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 6a128f3a7ed1..ff9b1ac72a38 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1383,6 +1383,34 @@ bool within_kprobe_blacklist(unsigned long addr)
>  }
> 
>  /*
> + * We mainly want to ensure that the provided string is of a reasonable length
> + * and is of the form [<mod_name>:]<sym_name>, so that this is safe to process
> + * further.
> + * We don't worry about invalid characters as those will just prevent
> + * matching existing kallsyms.
> + */
> +bool is_valid_kprobe_symbol_name(const char *name)
> +{
> +	size_t sym_len;
> +	const char *s;
> +
> +	s = strnchr(name, ':', MODULE_NAME_LEN + KSYM_NAME_LEN + 1);
> +	if (s) {
> +		sym_len = (size_t)(s - name);
> +		if (sym_len <= 0  || sym_len >= MODULE_NAME_LEN)

"sym_len <= 0" looks odd here, since sym_len is likely unsigned and would never be less than zero, anyway.

> +			return false;
> +		s++;
> +	} else
> +		s = name;
> +
> +	sym_len = strnlen(s, KSYM_NAME_LEN);
> +	if (sym_len <= 0 || sym_len >= KSYM_NAME_LEN)

here, too.

> +		return false;
> +
> +	return true;
> +}

PC
