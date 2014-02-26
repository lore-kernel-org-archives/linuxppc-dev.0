Return-Path: <ananth@in.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4124F2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 15:33:15 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 25 Feb 2014 23:33:12 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 305C66E8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 23:33:05 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1Q4XA9r8258036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 04:33:10 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1Q4X9RN022878
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 23:33:09 -0500
Date: Wed, 26 Feb 2014 10:05:53 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>
Subject: Re: [PATCH] powerpc: ftrace: bugfix for test_24bit_addr
Message-ID: <20140226043552.GA14672@in.ibm.com>
References: <1393381381-30179-1-git-send-email-pingfank@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393381381-30179-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 26, 2014 at 10:23:01AM +0800, Liu Ping Fan wrote:
> The branch target should be the func addr, not the addr of func_descr_t.
> So using ppc_function_entry() to generate the right target addr.
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
> This bug will make ftrace fail to work. It can be triggered when the kernel
> size grows up.
> ---
>  arch/powerpc/kernel/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index 9b27b29..b0ded97 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -74,6 +74,7 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
>   */
>  static int test_24bit_addr(unsigned long ip, unsigned long addr)
>  {
> +	addr = ppc_function_entry((void *)addr);

Won't this break on LE?
