Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0153.outbound.protection.outlook.com [207.46.163.153])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 783802C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 12:21:16 +1100 (EST)
Message-ID: <1389144063.8284.5.camel@snotra.buserror.net>
Subject: Re: drivers/tty: ehv_bytechan fails to build as a module
From: Scott Wood <scottwood@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 7 Jan 2014 19:21:03 -0600
In-Reply-To: <20140104191537.GA9051@roeck-us.net>
References: <20131209160310.7f81a1bc@kryten>
 <20140104191537.GA9051@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: gregkh@linuxfoundation.org, dvaleev@suse.com, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-01-04 at 11:15 -0800, Guenter Roeck wrote:
> On Mon, Dec 09, 2013 at 04:03:10PM +1100, Anton Blanchard wrote:
> > ehv_bytechan is marked tristate but fails to build as a module:
> > 
> > drivers/tty/ehv_bytechan.c:363:1: error: type defaults to ‘int’ in declaration of ‘console_initcall’ [-Werror=implicit-int]
> > 
> > It doesn't make much sense for a console driver to be built as
> > a module, so change it to a bool.
> > 
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> > 
> 
> Any comments on this patch ? The problem still causes powerpc:allmodconfig to
> fail.

It's fine with me...

Greg, are you going to take this via tty.git or do you want it to go via
PPC?

-Scott

> 
> Guenter
> 
> > ---
> > 
> > 
> > Index: b/drivers/tty/Kconfig
> > ===================================================================
> > --- a/drivers/tty/Kconfig
> > +++ b/drivers/tty/Kconfig
> > @@ -366,7 +366,7 @@ config TRACE_SINK
> >  	  "Trace data router for MIPI P1149.7 cJTAG standard".
> >  
> >  config PPC_EPAPR_HV_BYTECHAN
> > -	tristate "ePAPR hypervisor byte channel driver"
> > +	bool "ePAPR hypervisor byte channel driver"
> >  	depends on PPC
> >  	select EPAPR_PARAVIRT
> >  	help
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
