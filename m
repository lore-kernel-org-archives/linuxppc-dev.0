Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1BADFB7D51
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 05:28:26 +1000 (EST)
Date: Tue, 4 May 2010 12:17:19 -0700
From: Greg KH <greg@kroah.com>
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH] USB: FHCI: cq_get() should check kfifo_out()'s return
	value
Message-ID: <20100504191719.GA13854@kroah.com>
References: <20100502173025.GA24086@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100502173025.GA24086@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 02, 2010 at 09:30:25PM +0400, Anton Vorontsov wrote:
> Since commit 7acd72eb85f1c7a15e8b5eb554994949241737f1 ("kfifo: rename
> kfifo_put... into kfifo_in... and kfifo_get... into kfifo_out..."),
> kfifo_out() is marked __must_check, and that causes gcc to produce
> lots of warnings like this:
> 
>   CC      drivers/usb/host/fhci-mem.o
> In file included from drivers/usb/host/fhci-hcd.c:34:
> drivers/usb/host/fhci.h: In function 'cq_get':
> drivers/usb/host/fhci.h:520: warning: ignoring return value of 'kfifo_out', declared with attribute warn_unused_result
> ...
> 
> Fix it with BUG_ON() check. We could just forcibly ignore return
> value, but it's better to check if we really got a whole pointer.

No, you don't want to crash the whole machine for something like this.

Please just handle the error normally and pass it up to the upper levels
if possible.

thanks,

greg k-h
