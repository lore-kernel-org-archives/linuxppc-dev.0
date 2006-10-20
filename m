Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8F23467B8B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 11:57:05 +1000 (EST)
Date: Thu, 19 Oct 2006 20:56:20 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] powerpc: Cell timebase bug workaround
Message-ID: <20061019205620.2658cbfd@pb15>
In-Reply-To: <1161308840.10524.112.camel@localhost.localdomain>
References: <1161308840.10524.112.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Oct 2006 11:47:20 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>  static inline unsigned int get_tbu(void)
>  {
> +#ifdef CONFIG_403GCX
>  	unsigned int tbu;
> -
> -#if defined(CONFIG_403GCX)
>  	asm volatile("mfspr %0, 0x3dc" : "=r" (tbu));
> +	return tbu;
> +#elif defined(CONFIG_PPC32)
> +	return mftbu();
>  #else
> -	asm volatile("mftbu %0" : "=r" (tbu));
> +	return mftb();
>  #endif
> -	return tbu;
>  }
>  

Shouldn't the last one be mftbu(), since that's what the asm used to do?


-Olof
