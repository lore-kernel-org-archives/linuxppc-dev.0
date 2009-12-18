Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1DFD9B6F09
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 14:45:21 +1100 (EST)
Subject: Re: [patch 1/5] powerpc: Sky CPU: redundant or incorrect tests on
	unsigned
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <1261107631.2173.10.camel@pasglop>
References: <200912180044.nBI0iTbj028399@imap1.linux-foundation.org>
	<1261107631.2173.10.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Dec 2009 14:45:10 +1100
Message-ID: <1261107910.2173.11.camel@pasglop>
Mime-Version: 1.0
Cc: gorcunov@gmail.com, linuxppc-dev@ozlabs.org, roel.kluin@gmail.com,
	waite@skycomputers.com, galak@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-12-18 at 14:40 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2009-12-17 at 16:44 -0800, akpm@linux-foundation.org wrote:
> > From: Roel Kluin <roel.kluin@gmail.com>
> > 
> > count is unsigned and cannot be less than 0.
> 
> Is this really a powerpc thing ?
> 
> This driver is only build with CONFIG_HDPU_FEATURES and a git grep
> HDPU_FEATURES returns no Kconfig that defines it :-)
> 
> I'm happy to apply such a trivial thing but it's weird isn't it ?

Ok so it looks like some old stuff that got removed a long time ago and
never made it to arch/powerpc.

I'll send a patch to just remove the whole driver, it's stale.

Cheers,
Ben.

> Cheers,
> Ben.
> 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Kumar Gala <galak@gate.crashing.org>
> > Cc: Brian Waite <waite@skycomputers.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  drivers/misc/hdpuftrs/hdpu_cpustate.c |    5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff -puN drivers/misc/hdpuftrs/hdpu_cpustate.c~powerpc-sky-cpu-redundant-or-incorrect-tests-on-unsigned drivers/misc/hdpuftrs/hdpu_cpustate.c
> > --- a/drivers/misc/hdpuftrs/hdpu_cpustate.c~powerpc-sky-cpu-redundant-or-incorrect-tests-on-unsigned
> > +++ a/drivers/misc/hdpuftrs/hdpu_cpustate.c
> > @@ -121,8 +121,6 @@ static ssize_t cpustate_read(struct file
> >  {
> >  	unsigned char data;
> >  
> > -	if (count < 0)
> > -		return -EFAULT;
> >  	if (count == 0)
> >  		return 0;
> >  
> > @@ -137,9 +135,6 @@ static ssize_t cpustate_write(struct fil
> >  {
> >  	unsigned char data;
> >  
> > -	if (count < 0)
> > -		return -EFAULT;
> > -
> >  	if (count == 0)
> >  		return 0;
> >  
> > _
> 
