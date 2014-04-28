Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8DD821400DA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 10:26:58 +1000 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 28 Apr 2014 01:26:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B63B1B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 01:26:58 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3S0Qonx57606268
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 00:26:51 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3S0Qnff005700
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Apr 2014 18:26:50 -0600
Message-ID: <1398644805.3046.7.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH] Fix Oops in rtas_stop_self()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Date: Mon, 28 Apr 2014 08:26:45 +0800
In-Reply-To: <20140425221833.3cc04b0c@kryten>
References: <1398418381.2805.168.camel@ThinkPad-T5421.cn.ibm.com>
 <20140425221833.3cc04b0c@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Fri, 2014-04-25 at 22:18 +1000, Anton Blanchard wrote:
> Hi,
> 
> > When trying offline cpus, I noticed following Oops in
> > rtas_stop_self(), and it seems caused by commit 41dd03a9. The Oops
> > disappears after reverting this commit.
> > 
> > After reading the code, I guess it might be caused by moving the
> > rtas_args to stack. Still need some more time to read enter_rtas to
> > understand why it happens, but the problem seems could be solved by
> > moving the rtas_args away from stack by adding static before it.
> 
> Nice catch. RTAS is 32bit and if your box has more than 4GB RAM then
> your stack could easily be outside 32bit range.

Ah, yes, the stack here is obviously at a much higher address than 4GB.

> 
> You can add:
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> And also:
> 
> Cc: stable@vger.kernel.org # 3.14+

OK, 

Thanks, Zhong
> 
> > Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/platforms/pseries/hotplug-cpu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > b/arch/powerpc/platforms/pseries/hotplug-cpu.c index 9b8e050..20d6297
> > 100644 --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > @@ -88,13 +88,14 @@ void set_default_offline_state(int cpu)
> >  
> >  static void rtas_stop_self(void)
> >  {
> > -	struct rtas_args args = {
> > -		.token = cpu_to_be32(rtas_stop_self_token),
> > +	static struct rtas_args args = {
> >  		.nargs = 0,
> >  		.nret = 1,
> >  		.rets = &args.args[0],
> >  	};
> >  
> > +	args.token = cpu_to_be32(rtas_stop_self_token);
> > +
> >  	local_irq_disable();
> >  
> >  	BUG_ON(rtas_stop_self_token == RTAS_UNKNOWN_SERVICE);
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
