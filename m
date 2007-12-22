Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 5EBBEDDE19
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 11:34:06 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so141168nfd.9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 16:34:04 -0800 (PST)
Date: Sat, 22 Dec 2007 03:23:41 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/4] [POWERPC] qe_lib and users: get rid of device_type
	and model
Message-ID: <20071222002341.GA3753@zarina>
References: <20071221201844.GA4278@localhost.localdomain>
	<20071221202054.GA4502@localhost.localdomain>
	<20071221212553.GA11910@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071221212553.GA11910@lixom.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 03:25:53PM -0600, Olof Johansson wrote:
> Hi,
> 
> On Fri, Dec 21, 2007 at 11:20:54PM +0300, Anton Vorontsov wrote:
> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > index e6c63a5..a152bf8 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > @@ -94,7 +94,8 @@ static void __init mpc85xx_mds_setup_arch(void)
> >  #endif
> >  
> >  #ifdef CONFIG_QUICC_ENGINE
> > -	if ((np = of_find_node_by_name(NULL, "qe")) != NULL) {
> > +	np = of_find_node_by_name(NULL, "fsl,qe");
> > +	if (np) {
> 
> That won't work. Did you mean of_find_compatible_node()?

Yes. :-(

> If so, you
> still need to fall back to looking up by name for older device trees
> that don't have the compatible field.

Yup.

Okay.. I'm approaching lucky v7. ;-)

Much thanks for catching this,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
