Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E2F5DDFB8
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 15:18:29 +1000 (EST)
Date: Fri, 11 Apr 2008 22:18:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
Message-Id: <20080411221817.0b1eb414.akpm@linux-foundation.org>
In-Reply-To: <47FFDBFF.1030809@gmail.com>
References: <12053582234100-git-send-email-yorksun@freescale.com>
	<12053582231281-git-send-email-yorksun@freescale.com>
	<47D8572C.8090501@gmail.com> <47FFDBFF.1030809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, York Sun <yorksun@freescale.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 11 Apr 2008 23:45:35 +0200 Jiri Slaby <jirislaby@gmail.com> wrote:

> On 03/12/2008 11:20 PM, Jiri Slaby wrote:
> > On 03/12/2008 10:43 PM, York Sun wrote:
> >> +static int fsl_diu_open(struct fb_info *info, int user)
> >> +{
> >> +    struct mfb_info *mfbi = info->par;
> >> +    int res = 0;
> >> +
> >> +    spin_lock(&diu_lock);
> >> +    mfbi->count++;
> >> +    if (mfbi->count == 1) {
> >> +        DPRINTK("open plane index %d\n", mfbi->index);
> >> +        fsl_diu_check_var(&info->var, info);
> >> +        fsl_diu_set_par(info);
> > 
> > Please retest your code (at least) with sleep-inside spinlock debug 
> > option. If I see correctly you call GFP_KERNEL allocation somewhere 
> > deeper in this function, which might sleep.
> > 
>
> ...
>
> ping.
> 
> Seeing this in -mm yet. Are those comments all wrong? Are you working on it?
> 

(top-posting repaired)

Thanks.  I've made a note that this patch has outstanding issues.  Usually
this means that I'll defer merging it until they have been addressed:
either by fixing them or by successfully arguing against the objections.  
