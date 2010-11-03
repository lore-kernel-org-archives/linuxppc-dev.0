Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 3792BB7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Nov 2010 01:15:55 +1100 (EST)
Date: Wed, 3 Nov 2010 10:15:48 -0400 (EDT)
From: Jiri Kosina <jkosina@suse.cz>
To: matt mooney <mfm@muteddisk.com>
Subject: Re: [PATCH 2/3 RESEND] powerpc: remove cast from void*
In-Reply-To: <f7d601da574581e9dfdc1314a969475c73491c00.1285638395.git.mfm@muteddisk.com>
Message-ID: <alpine.LNX.2.00.1011031015150.15851@pobox.suse.cz>
References: <cover.1285638395.git.mfm@muteddisk.com>
	<f7d601da574581e9dfdc1314a969475c73491c00.1285638395.git.mfm@muteddisk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 27 Sep 2010, matt mooney wrote:

> Unnecessary cast from void* in assignment.
> 
> Signed-off-by: matt mooney <mfm@muteddisk.com>
> ---
>  arch/powerpc/platforms/pseries/hvCall_inst.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
> index e19ff02..f106662 100644
> --- a/arch/powerpc/platforms/pseries/hvCall_inst.c
> +++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
> @@ -55,7 +55,7 @@ static void hc_stop(struct seq_file *m, void *p)
>  static int hc_show(struct seq_file *m, void *p)
>  {
>  	unsigned long h_num = (unsigned long)p;
> -	struct hcall_stats *hs = (struct hcall_stats *)m->private;
> +	struct hcall_stats *hs = m->private;
>  
>  	if (hs[h_num].num_calls) {
>  		if (cpu_has_feature(CPU_FTR_PURR))

This doesn't seem to be present in 37-rc1, so I am taking it to trivial 
queue. If this has been already merged to another tree, let me know.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
