Return-Path: <dan@embeddededge.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id 87264DDF28
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 08:19:18 +1000 (EST)
In-Reply-To: <20070327210102.22195.81287.stgit@localhost.localdomain>
References: <20070327210046.22195.772.stgit@localhost.localdomain>
	<20070327210102.22195.81287.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BAD18DB7-81D9-43D3-890B-7E79B7C80F03@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH 2/2] POWERPC: Remove global CPM mappings
Date: Tue, 27 Mar 2007 18:12:38 -0400
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 27, 2007, at 5:01 PM, Vitaly Bordug wrote:

> --- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
> @@ -52,7 +52,7 @@
>  void cpm_line_cr_cmd(int line, int cmd)
>  {
>  	ushort val;
> -	volatile cpm8xx_t *cp = cpmp;
> +	volatile cpm8xx_t *cp = (cpm8xx_t *)immr_map(im_cpm);

I'd kind of prefer you didn't place function calls
or macros up here with the variable declarations.
Do the initialization down in the code section, please.

> +#ifdef CONFIG_CPM2
>  #define cpm2_map(member)	(&cpm2_immr->member)
>  #define cpm2_map_size(member, size)	(&cpm2_immr->member)
>  #define cpm2_unmap(addr)        do {} while(0)
> +#endif
> +
> +#ifdef CONFIG_8xx
> +#define immr_map(member)	(&((immap_t *)IMAP_ADDR)->member)
> +#define immr_map_size(member, size)	(&((immap_t *)IMAP_ADDR)->member)
> +#define immr_unmap(addr)        do {} while(0)
> +#endif

Why is 8xx different?  We should be able to
devine cpm_immr and use it in both cases here,
and hopefully use the same macro names
across all drivers, too.


Thanks.

	-- Dan
