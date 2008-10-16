Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0015FDDF51
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 23:29:43 +1100 (EST)
Date: Thu, 16 Oct 2008 13:18:43 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/5] hvc_console: Add tty driver flag
	TTY_DRIVER_RESET_TERMIOS
Message-ID: <20081016131843.1227da92@lxorguk.ukuu.org.uk>
In-Reply-To: <20081016110950.GA4125@cetus.boeblingen.de.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
	<20081014091413.003841094@linux.vnet.ibm.com>
	<20081014104025.517ae734@lxorguk.ukuu.org.uk>
	<20081016110950.GA4125@cetus.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> For my network-based hvc backend, a tty_hangup() is caused by a disconnect.

If it is network backed then you probably do want
TTY_DRIVER_TERMIOS_RESET. For a normal serial type port getty is supposed
to sort the terminal settings out. So in your case it sounds like
resetting it is the right thing to do.
