Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B48F92C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 19:16:54 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brueckner@linux.vnet.ibm.com>;
 Thu, 17 Oct 2013 09:16:49 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DFD57219005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 09:16:45 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9H8GX0x14090330
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 08:16:33 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9H8Ghu6015631
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 02:16:45 -0600
Date: Thu, 17 Oct 2013 10:16:42 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 1/2] tty/hvc_console: Add DTR/RTS callback to handle
 HUPCL control
Message-ID: <20131017081642.GA6134@linux.vnet.ibm.com>
References: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1372777635-10423-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <1381475711.5630.67.camel@pasglop>
 <20131011124707.GA6082@linux.vnet.ibm.com>
 <1381524204.5630.91.camel@pasglop>
 <20131015153626.GA6129@linux.vnet.ibm.com>
 <1381870070.17841.24.camel@pasglop>
 <20131016090432.GA6053@linux.vnet.ibm.com>
 <1381965672.17841.71.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381965672.17841.71.camel@pasglop>
Cc: linux-s390@vger.kernel.org, brueckner@linux.vnet.com,
 gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, schwidefsky@de.ibm.com,
 jslaby@suse.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 16, 2013 at 06:21:12PM -0500, Benjamin Herrenschmidt wrote:
> On Wed, 2013-10-16 at 11:04 +0200, Hendrik Brueckner wrote:
> > Indeed, two callbacks change the DTR line.  The main difference is that
> > tiocmget/tiocmset can be called from user space by ioctl.  That's not the case
> > for the dtr_cts callback.  Also, tiocmget/tiocmset provide more flags that can
> > be changed (ST, SR, CTS, CD, RNG, RI,  ...)
> > 
> > Assume we would like to unify them have a single callback to change DTR, then
> > we have to take care of these differences.  So the question to you now is
> > whether you plan for a) other modem flags to be changed and b) if changing the
> > DTR line (or other control flags) through an ioctl?
> > 
> > Depending on your results, I could work on sth that helps us both and reduces
> > the callbacks.
> 
> Can we not just have the users of dtr_cts just call the backend's tiocmset ?

That's possible.  The only concern is that the tiocmset() callback could be
triggered from within the hvc_console() layer as well as from user space via
ioctl.  For the hvc_iucv driver, I do not want to introduce this ioctl.

One option would be to add parameter to the hvc_callbacks that indicate the
origin so that a backend could filter.

> If they need to filter or clamp bits, we could handle all that in hvc_console
> by caching the user intended value and passing a cooked value down to the backend..

Sure the hvc_console layer could do as much as possible.

> 
> None of that is urgent or anything, it's just odd and would be nice to cleanup.

Thanks and kind regards,
  Hendrik
