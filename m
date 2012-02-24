Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C926BB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 09:20:40 +1100 (EST)
Received: by pbcxa12 with SMTP id xa12so1591831pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 14:20:38 -0800 (PST)
Date: Fri, 24 Feb 2012 14:19:24 -0800
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Timur Tabi <b04825@freescale.com>
Subject: Re: warnings from drivers/tty/ehv_bytechan.c
Message-ID: <20120224221924.GA28198@kroah.com>
References: <20120220072352.4c8131bbcea69afc007a4297@canb.auug.org.au>
 <4F424985.2020706@freescale.com> <20120224215008.GB25330@kroah.com>
 <4F48086C.5010407@freescale.com> <20120224220623.GA29400@kroah.com>
 <4F480BE8.9080606@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F480BE8.9080606@freescale.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 24, 2012 at 04:15:04PM -0600, Timur Tabi wrote:
> gregkh@linuxfoundation.org wrote:
> >> > That's the simplest approach, for use.  The TTY portion of the driver can
> >> > be used as a module.  Is there any real value in loading a TTY driver as a
> >> > module?
> 
> > Depends on the hardware it supports :)
> > 
> >> > In this case, the console support for byte channels would not be
> >> > available.
> 
> > Then it doesn't make sense, right?
> 
> I guess that's my question.  Is there a real use case for having console
> output go to the serial port, and TTY go to a byte channel?  Even if you
> wanted to do that, I supposed you don't need to load the byte channel
> driver as a module to get that behavior.
> 
> Anyway, that's all academic.  A more important question is: now that the
> driver can't be compiled as a module, should I change module_init() to
> something else (like device_initcall)?
> 
> Should I remove this line?
> 
> 	#include <linux/module.h>

No, no need to, leave it as-is if it builds properly.

greg k-h
