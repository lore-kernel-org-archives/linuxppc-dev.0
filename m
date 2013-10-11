Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp16.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 317F62C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 23:47:18 +1100 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brueckner@linux.vnet.ibm.com>;
 Fri, 11 Oct 2013 13:47:12 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id E502917D8059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 13:47:31 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9BCku1n62849154
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 12:46:57 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9BCl8Kl008771
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 06:47:09 -0600
Date: Fri, 11 Oct 2013 14:47:07 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] tty/hvc_console: Add DTR/RTS callback to handle
 HUPCL control
Message-ID: <20131011124707.GA6082@linux.vnet.ibm.com>
References: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1372777635-10423-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <1381475711.5630.67.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381475711.5630.67.camel@pasglop>
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

Hi Benjamin,

On Fri, Oct 11, 2013 at 06:15:11PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2013-07-02 at 17:07 +0200, Hendrik Brueckner wrote:
> > Introduce a new callback to explicitly handle the HUPCL termios control flag.
> > This prepares for a follow-up commit for the hvc_iucv device driver to
> > improve handling when to drop an established network connection.
> > 
> > The callback naming is based on the recently added tty_port interface to
> > facilitate a potential refactoring of the hvc_console to use tty_port
> > functions.
> 
> I only just noticed that ... oops. Why add those dtr_rts() calls ? We
> already have tiocmset in there which is used to set DTR on HVSI consoles
> such as hvc_opal when using hvsi_lib...
> 
> Any reason why a separate callback was needed ?

The tiocmget/tiocmset callbacks are used to set and get modem status and
triggered through an tty ioctl.

The dtr_rts() callback is different and it is used for DTS/RTS handshaking
between the hvc_console (or any other tty_port) and the tty layer.  The tty
port layer uses this callback to signal the hvc_console whether to raise or
lower the DTR/RTS lines.  This is different than the ioctl interface to
controls the modem status.

Thanks and kind regards,
  Hendrik
