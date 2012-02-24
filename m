Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D3DFB6F98
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 08:55:49 +1100 (EST)
Received: by dady9 with SMTP id y9so3244752dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 13:55:47 -0800 (PST)
Date: Fri, 24 Feb 2012 13:50:08 -0800
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: warnings from drivers/tty/ehv_bytechan.c
Message-ID: <20120224215008.GB25330@kroah.com>
References: <20120220072352.4c8131bbcea69afc007a4297@canb.auug.org.au>
 <4F424985.2020706@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F424985.2020706@freescale.com>
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

On Mon, Feb 20, 2012 at 01:24:22PM +0000, Tabi Timur-B04825 wrote:
> Stephen Rothwell wrote:
> > console_initcall() is not defined for modules.
> 
> Hmmm... the patch you posted is a good short-term fix, but I wonder if 
> makes sense for the driver to support modules at all.  I have this in the 
> driver:
> 
> #include <linux/module.h>
> ...
> module_init(ehv_bc_init);
> module_exit(ehv_bc_exit);
> 
> although to be honest, I can't remember the last time I tried to compile 
> it as a module.
> 
> The problem stems from the fact that it's a console driver *and* a tty 
> driver.  It makes sense that a tty driver can be compiled as a module, but 
> not a console driver.
> 
> So Greg, can I do something like this:
> 
> #ifdef MODULE
> module_initcall(ehv_bc_console_init)
> #else
> console_initcall(ehv_bc_console_init);
> #endif

Sure, something like that is fine, but if the code really can't be a
module, why not just fix the Kconfig file to enforce this properly
instead?

thanks,

greg k-h
