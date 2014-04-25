Return-Path: <anton@samba.org>
Date: Fri, 25 Apr 2014 22:18:33 +1000
From: Anton Blanchard <anton@samba.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] Fix Oops in rtas_stop_self()
Message-ID: <20140425221833.3cc04b0c@kryten>
In-Reply-To: <1398418381.2805.168.camel@ThinkPad-T5421.cn.ibm.com>
References: <1398418381.2805.168.camel@ThinkPad-T5421.cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> When trying offline cpus, I noticed following Oops in
> rtas_stop_self(), and it seems caused by commit 41dd03a9. The Oops
> disappears after reverting this commit.
> 
> After reading the code, I guess it might be caused by moving the
> rtas_args to stack. Still need some more time to read enter_rtas to
> understand why it happens, but the problem seems could be solved by
> moving the rtas_args away from stack by adding static before it.

Nice catch. RTAS is 32bit and if your box has more than 4GB RAM then
your stack could easily be outside 32bit range.

You can add:

Signed-off-by: Anton Blanchard <anton@samba.org>

And also:

Cc: stable@vger.kernel.org # 3.14+

> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> b/arch/powerpc/platforms/pseries/hotplug-cpu.c index 9b8e050..20d6297
> 100644 --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -88,13 +88,14 @@ void set_default_offline_state(int cpu)
>  
>  static void rtas_stop_self(void)
>  {
> -	struct rtas_args args = {
> -		.token = cpu_to_be32(rtas_stop_self_token),
> +	static struct rtas_args args = {
>  		.nargs = 0,
>  		.nret = 1,
>  		.rets = &args.args[0],
>  	};
>  
> +	args.token = cpu_to_be32(rtas_stop_self_token);
> +
>  	local_irq_disable();
>  
>  	BUG_ON(rtas_stop_self_token == RTAS_UNKNOWN_SERVICE);
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
