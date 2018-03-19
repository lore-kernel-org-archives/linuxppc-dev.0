Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404rhB6z7kzDqlx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 09:43:38 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id w15-v6so11163552plq.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 15:43:38 -0700 (PDT)
Date: Tue, 20 Mar 2018 09:43:20 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  2/2] powerpc/mm: Trace tlbia instruction
Message-ID: <20180320094320.03ae264d@balbir.ozlabs.ibm.com>
In-Reply-To: <cccc5b8516ce8cb57bedf2c51cf67f9a2ca95242.1521452718.git.christophe.leroy@c-s.fr>
References: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
 <cccc5b8516ce8cb57bedf2c51cf67f9a2ca95242.1521452718.git.christophe.leroy@c-s.fr>
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

On Mon, 19 Mar 2018 11:32:40 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Add a trace point for tlbia (Translation Lookaside Buffer Invalidate
> All) instruction.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/trace.h | 15 +++++++++++++++
>  arch/powerpc/mm/mmu_decl.h       |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
> index 33f3b479138b..d1d63b173dd7 100644
> --- a/arch/powerpc/include/asm/trace.h
> +++ b/arch/powerpc/include/asm/trace.h
> @@ -202,6 +202,21 @@ TRACE_EVENT(tlbie,
>  		__entry->r)
>  );
>  
> +TRACE_EVENT(tlbia,
> +
> +	TP_PROTO(unsigned long lpid),
> +	TP_ARGS(lpid),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, lpid)
> +		),
> +
> +	TP_fast_assign(
> +		__entry->lpid = lpid;
> +		),
> +
> +	TP_printk("lpid=%ld", __entry->lpid)
> +);


Do we want to call this lpid?

Balbir Singh.
