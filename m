Return-Path: <gregkh@linuxfoundation.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FBE51A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 06:29:14 +1000 (EST)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 50FDA140093
 for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2014 06:29:13 +1000 (EST)
Date: Wed, 28 May 2014 13:32:48 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] tty/hvc/hvc_console: Fix wakeup of HVC thread on
 hvc_kick()
Message-ID: <20140528203248.GA14431@kroah.com>
References: <1400838066.29150.69.camel@pasglop>
 <1401235290.8262.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401235290.8262.9.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jiri Slaby <jslaby@suse.cz>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 28, 2014 at 10:01:30AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2014-05-23 at 19:41 +1000, Benjamin Herrenschmidt wrote:
> > Some backends call hvc_kick() to wakeup the HVC thread from its
> > slumber upon incoming characters. This however doesn't work
> > properly because it uses msleep_interruptible() which is mostly
> > immune to wake_up_process(). It will basically go back to sleep
> > until the timeout is expired (only signals can really wake it).
> >
> > Replace it with a simple shedule_timeout_interruptible() instead,
> > which may wakeup earlier every now and then but we really don't
> > care in this case.
> 
> Nobody commented ? :-)
> 
> Greg, do you want to take this in the tty tree or can I stick it in
> powerpc ?

I'll take it, thanks.

greg k-h
