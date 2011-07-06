Return-Path: <anton@samba.org>
Date: Wed, 6 Jul 2011 17:55:29 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc/kdump: Fix timeout in crash_kexec_wait_realmode
Message-ID: <20110706175529.5cdacb17@kryten>
In-Reply-To: <29259.1309848010@neuling.org>
References: <20110705161202.62dc7d24@kryten>
	<29259.1309848010@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 05 Jul 2011 16:40:10 +1000
Michael Neuling <mikey@neuling.org> wrote:

> The existing code it pretty ugly.  How about we clean it up even more
> like this?

Looks good and it passed my kdump test cases.

Anton
 
> From: Anton Blanchard <anton@samba.org>
> 
> We check for timeout expiry in the outer loop, but we also need to
> check it in the inner loop or we can lock up forever waiting for a
> CPU to hit real mode.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: <stable@kernel.org>
> 
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index 4e6ee94..cc6a9d5 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -242,12 +242,8 @@ static void crash_kexec_wait_realmode(int cpu)
>  
>  		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
>  			barrier();
> -			if (!cpu_possible(i)) {
> +			if (!cpu_possible(i) || !cpu_online(i) ||
> (msecs <= 0)) break;
> -			}
> -			if (!cpu_online(i)) {
> -				break;
> -			}
>  			msecs--;
>  			mdelay(1);
>  		}
> 
