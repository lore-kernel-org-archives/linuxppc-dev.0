Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A60C2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 12:54:18 +1000 (EST)
Message-ID: <1346813643.2257.24.camel@pasglop>
Subject: Re: [PATCH v2] powerpc: fix personality handling in
 ppc64_personality()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jiri Kosina <jkosina@suse.cz>
Date: Wed, 05 Sep 2012 12:54:03 +1000
In-Reply-To: <alpine.LNX.2.00.1208020907490.14910@pobox.suse.cz>
References: <alpine.LNX.2.00.1208012201520.14910@pobox.suse.cz>
 <m27gtitfv4.fsf@igel.home>
 <alpine.LNX.2.00.1208020907490.14910@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-08-02 at 09:10 +0200, Jiri Kosina wrote:
> Directly comparing current->personality against PER_LINUX32 doesn't work
> in cases when any of the personality flags stored in the top three bytes
> are used.
> 
> Directly forcefully setting personality to PER_LINUX32 or PER_LINUX
> discards any flags stored in the top three bytes
> 
> Use personality() macro to compare only PER_MASK bytes and make sure that
> we are setting only the bits that should be set, instead of
> overwriting the whole value.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> 
> changed since v1: fix the bit ops to reflect the fact that PER_LINUX is 
> actually 0

Had already merged v1 (oops.. didn't spot the issue with PER_LINUX being
0). Can you send an incremental fixup ?

Cheers,
Ben.

>  arch/powerpc/kernel/syscalls.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index f2496f2..dc1558e 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -107,11 +107,11 @@ long ppc64_personality(unsigned long personality)
>  	long ret;
>  
>  	if (personality(current->personality) == PER_LINUX32
> -	    && personality == PER_LINUX)
> -		personality = PER_LINUX32;
> +	    && personality(personality) == PER_LINUX)
> +		personality |= PER_LINUX32;
>  	ret = sys_personality(personality);
> -	if (ret == PER_LINUX32)
> -		ret = PER_LINUX;
> +	if (personality(ret) == PER_LINUX32)
> +		ret &= ~PER_LINUX32;
>  	return ret;
>  }
>  #endif
> -- 
> 1.7.3.1
> 
