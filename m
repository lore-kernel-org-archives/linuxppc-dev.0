Return-Path: <heiko.carstens@de.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp16.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09A212C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 16:47:15 +1000 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Fri, 4 Oct 2013 07:47:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 805B517D805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 07:47:26 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r946ktW753608504
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Oct 2013 06:46:55 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r946l5Di024113
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Oct 2013 00:47:07 -0600
Date: Fri, 4 Oct 2013 08:47:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Alexei Starovoitov <ast@plumgrid.com>
Subject: Re: [PATCH v3 net-next] fix unsafe set_memory_rw from softirq
Message-ID: <20131004064705.GA4143@osiris>
References: <1380853446-30537-1-git-send-email-ast@plumgrid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380853446-30537-1-git-send-email-ast@plumgrid.com>
Cc: Eric Dumazet <edumazet@google.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Xi Wang <xi.wang@gmail.com>,
 Matt Evans <matt@ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Stelian Nirlu <steliannirlu@gmail.com>,
 Nicolas Schichan <nschichan@freebox.fr>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Mircea Gherzan <mgherzan@gmail.com>, Daniel Borkmann <dborkman@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Patrick McHardy <kaber@trash.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 03, 2013 at 07:24:06PM -0700, Alexei Starovoitov wrote:
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 7092392..a5df511 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -881,7 +881,9 @@ void bpf_jit_free(struct sk_filter *fp)
>  	struct bpf_binary_header *header = (void *)addr;
> 
>  	if (fp->bpf_func == sk_run_filter)
> -		return;
> +		goto free_filter;
>  	set_memory_rw(addr, header->pages);
>  	module_free(NULL, header);
> +free_filter:
> +	kfree(fp);
>  }

For the s390 part:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
