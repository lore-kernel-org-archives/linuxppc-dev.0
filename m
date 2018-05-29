Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wG1J6YsqzDr43
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 00:13:56 +1000 (AEST)
Subject: Re: [PATCH] powerpc/64s: Enhance the information in
 cpu_show_spectre_v1()
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180424041559.32410-1-mpe@ellerman.id.au>
 <20180528131914.32231-1-msuchanek@suse.de>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1b720765-faf1-719e-ab76-b3eafa559896@c-s.fr>
Date: Tue, 29 May 2018 16:13:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180528131914.32231-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 28/05/2018 à 15:19, Michal Suchanek a écrit :
> We now have barrier_nospec as mitigation so print it in
> cpu_show_spectre_v1 when enabled.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>   arch/powerpc/kernel/security.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> index 0239383c7e4d..a0c32d53980b 100644
> --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -120,7 +120,10 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, c
>   	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
>   		return sprintf(buf, "Not affected\n");
>   
> -	return sprintf(buf, "Vulnerable\n");
> +	if (barrier_nospec_enabled)

> +		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
> +	else
> +		return sprintf(buf, "Vulnerable\n");

Checkpatch would tell you that an else is unneeded after a return. So 
just leave it as it was before.

Christophe

>   }
>   
>   ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
> 
