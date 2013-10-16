Return-Path: <benh@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4FAF32C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 10:21:26 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 17 Oct 2013 09:21:25 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1C6F02BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 10:21:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9GNL73L10355174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 10:21:07 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9GNLInK030844
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 10:21:18 +1100
Message-ID: <1381965672.17841.71.camel@pasglop>
Subject: Re: [PATCH 1/2] tty/hvc_console: Add DTR/RTS callback to handle
 HUPCL control
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Date: Wed, 16 Oct 2013 18:21:12 -0500
In-Reply-To: <20131016090432.GA6053@linux.vnet.ibm.com>
References: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1372777635-10423-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <1381475711.5630.67.camel@pasglop>
 <20131011124707.GA6082@linux.vnet.ibm.com>
 <1381524204.5630.91.camel@pasglop>
 <20131015153626.GA6129@linux.vnet.ibm.com>
 <1381870070.17841.24.camel@pasglop>
 <20131016090432.GA6053@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-s390@vger.kernel.org, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, brueckner@linux.vnet.com, schwidefsky@de.ibm.com,
 jslaby@suse.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-16 at 11:04 +0200, Hendrik Brueckner wrote:
> Indeed, two callbacks change the DTR line.  The main difference is that
> tiocmget/tiocmset can be called from user space by ioctl.  That's not the case
> for the dtr_cts callback.  Also, tiocmget/tiocmset provide more flags that can
> be changed (ST, SR, CTS, CD, RNG, RI,  ...)
> 
> Assume we would like to unify them have a single callback to change DTR, then
> we have to take care of these differences.  So the question to you now is
> whether you plan for a) other modem flags to be changed and b) if changing the
> DTR line (or other control flags) through an ioctl?
> 
> Depending on your results, I could work on sth that helps us both and reduces
> the callbacks.

Can we not just have the users of dtr_cts just call the backend's tiocmset ?

If they need to filter or clamp bits, we could handle all that in hvc_console
by caching the user intended value and passing a cooked value down to the backend..

None of that is urgent or anything, it's just odd and would be nice to cleanup.

Cheers,
Ben.
