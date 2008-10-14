Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D807DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:43:09 +1100 (EST)
Date: Tue, 14 Oct 2008 10:40:25 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/5] hvc_console: Add tty driver flag
	TTY_DRIVER_RESET_TERMIOS
Message-ID: <20081014104025.517ae734@lxorguk.ukuu.org.uk>
In-Reply-To: <20081014091413.003841094@linux.vnet.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
	<20081014091413.003841094@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Russell <rusty@rustcorp.com.au>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>, Rusty,
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

On Tue, 14 Oct 2008 11:12:49 +0200
Hendrik Brueckner <brueckner@linux.vnet.ibm.com> wrote:

> From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> 
> After a tty hangup() or close() operation, processes might not reset the
> termio settings to a sane state.

That is the job of the getty task normally. pty is special as the reissue
of the same pty is done as a new device (with new state).

Setting this on the hvc would parallel the PC vt console behaviour but
differ from most other ports.

Anyway its a policy question for PPC64 so if thats how you want it to work

Acked-by: Alan Cox <alan@redhat.com>
