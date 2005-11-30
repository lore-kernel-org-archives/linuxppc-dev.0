Return-Path: <ihornberger@sysgo.de>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 4E6386884B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 19:01:23 +1100 (EST)
From: Ingo Hornberger <ihornberger@sysgo.de>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <f3e079332f2f66cb1898b288cf66e5c9@embeddededge.com>
References: <1133275187.2664.32.camel@iho.sysgo.com>
	<f3e079332f2f66cb1898b288cf66e5c9@embeddededge.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 08:59:41 +0100
Message-Id: <1133337581.2660.29.camel@iho.sysgo.com>
Mime-Version: 1.0
Cc: linuxppc-devel list <linuxppc-dev@ozlabs.org>
Subject: Re: immap with 8xx.
Reply-To: ihornberger@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Dan for your reply!

I mainly needed the immap stuff like 'immap_rp_t' and some 'defines'.

But I just started to reorder this. I thought that 'cpm1' and 'cpm2'
devices should follow the same unique scheme, shouldn't they? Even if we
only have one cpm1 device.

Otherwise the naming is very confusing.
For example:
(8xx)     	(cpm2)
commproc.h	cpm2.h
8xx_immap.h	immap_cpm2.h
immap_t  	cpm2_map_t
iop8xx_t	iop_cpm2_t
...       	...

And because the cpm2 scheme is newer and cleaner, I think we should use
that instead.
This change would mainly rename the following files (and their symbols):
8xx_immap.h -> immap_cpm1.h
commproc.h  -> cpm1.h
(but likely affect others, too)

Then we would need three patches:
1. rename the files
2. patch only the 'include/asm' files
3. rename all "#include" directives and symbols in the rest.

Or do you see too much problems in renaming such symbols? Perhaps this
should be a topic for the development kernel, but I don't think so...

I think we should do this now, because it's only relevant for low-level
8xx code (and drivers like mine or the ide driver). The init code could
be converted by us, and as the 8xx port of 2.6 isn't such old and stable
I believe that there are not too much (if none) already ported drivers
around that are using low-level 8xx stuff.

But I'd like to here more opinions.

regards,
	Ingo

On Tue, 2005-11-29 at 13:13 -0500, Dan Malek wrote:
> On Nov 29, 2005, at 9:39 AM, Ingo Hornberger wrote:
> 
> > But it seems that there was some generalization work done, which didn't
> > reach the 8xx part. Particularly this means that some parts of
> > 'asm/commproc.h' as well as (at least) 'asm/immap_8260.h' built up a 
> > new
> > header 'asm/immap_cpm2.h'.
> 
> That's because the cpm2 is used in more parts than just the 82xx,
> so we carved up the files to make it more useful.
> 
> > Actally I miss a file like 'asm/immap_cpm1.h'.
> 
> The 8xx is the only processor to use the CPM1, so just update
> the immap or 8xx files to accommodate the differences you may
> need.  There isn't a similar requirement to create a immap_cpm1.h
> file like there was for the CPM2.  What kind of updates do you need?
> 
> Thanks.
> 
> 	-- Dan
> 
