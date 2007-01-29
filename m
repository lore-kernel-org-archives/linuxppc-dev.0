Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1652FDE2B9
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:56:29 +1100 (EST)
Date: Sun, 28 Jan 2007 21:02:38 -0600
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] [3/4] PMC-related cleanups
Message-ID: <20070129030238.GB6412@lixom.net>
References: <20070125082002.GD10716@lixom.net> <20070126223204.GE11008@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070126223204.GE11008@suse.de>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 26, 2007 at 02:32:04PM -0800, Greg KH wrote:
> On Thu, Jan 25, 2007 at 02:20:02AM -0600, Olof Johansson wrote:
> > Introduce _SYSDEV_ATTR(), to be used to just define the struct, and not a
> > named variable with the attribute. Useful for arrays of sysdev_attributes.
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > 
> > 
> > Index: powerpc/include/linux/sysdev.h
> > ===================================================================
> > --- powerpc.orig/include/linux/sysdev.h
> > +++ powerpc/include/linux/sysdev.h
> > @@ -98,12 +98,15 @@ struct sysdev_attribute { 
> >  };
> >  
> >  
> > -#define SYSDEV_ATTR(_name,_mode,_show,_store) 		\
> > -struct sysdev_attribute attr_##_name = { 			\
> > +#define _SYSDEV_ATTR(_name,_mode,_show,_store)			\
> > +{								\
> >  	.attr = {.name = __stringify(_name), .mode = _mode },	\
> >  	.show	= _show,					\
> >  	.store	= _store,					\
> > -};
> > +}
> 
> Oops, you need to add '.owner' to that attribute structure.  In all
> fairness, it's a bug, not caused by anything that you did.

Got it, see repost.

> If you add that, feel free to add my:
> 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> to the patch and send it through Paul.

Thanks!


-Olof
