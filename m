Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3526B70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Nov 2010 01:18:05 +1100 (EST)
Subject: Re: [PATCH 2/3 RESEND] powerpc: remove cast from void*
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <alpine.LNX.2.00.1011031015150.15851@pobox.suse.cz>
References: <cover.1285638395.git.mfm@muteddisk.com>
	<f7d601da574581e9dfdc1314a969475c73491c00.1285638395.git.mfm@muteddisk.com>
	<alpine.LNX.2.00.1011031015150.15851@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Nov 2010 01:18:01 +1100
Message-ID: <1288793881.2147.73.camel@pasglop>
Mime-Version: 1.0
Cc: matt mooney <mfm@muteddisk.com>, linuxppc-dev@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-11-03 at 10:15 -0400, Jiri Kosina wrote:
> On Mon, 27 Sep 2010, matt mooney wrote:
> 
> > Unnecessary cast from void* in assignment.
> > 
> > Signed-off-by: matt mooney <mfm@muteddisk.com>
> > ---
> >  arch/powerpc/platforms/pseries/hvCall_inst.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
> > index e19ff02..f106662 100644
> > --- a/arch/powerpc/platforms/pseries/hvCall_inst.c
> > +++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
> > @@ -55,7 +55,7 @@ static void hc_stop(struct seq_file *m, void *p)
> >  static int hc_show(struct seq_file *m, void *p)
> >  {
> >  	unsigned long h_num = (unsigned long)p;
> > -	struct hcall_stats *hs = (struct hcall_stats *)m->private;
> > +	struct hcall_stats *hs = m->private;
> >  
> >  	if (hs[h_num].num_calls) {
> >  		if (cpu_has_feature(CPU_FTR_PURR))
> 
> This doesn't seem to be present in 37-rc1, so I am taking it to trivial 
> queue. If this has been already merged to another tree, let me know.

Looks like I missed it, but Ack.

Cheers,
Ben.
