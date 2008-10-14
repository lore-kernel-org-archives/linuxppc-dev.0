Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D30FDDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:49:11 +1100 (EST)
Date: Tue, 14 Oct 2008 10:44:28 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 4/5] hvc_console: Add tty window resizing
Message-ID: <20081014104428.698b750b@lxorguk.ukuu.org.uk>
In-Reply-To: <20081014091413.306993844@linux.vnet.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
	<20081014091413.306993844@linux.vnet.ibm.com>
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

> +	hp = container_of(work, struct hvc_struct, tty_resize);
> +	if (!hp || !hp->tty)
> +		return;

What locks hp->tty here, it can go NULL after the test on a hangup it
seems ?

> + * hvc_resize() - Update terminal window size information.
> + * @hp:		HVC console pointer
> + * @ws:		Terminal window size structure

See tty_do_resize() for all of this stuff in the latest git. If you can't
use tty_do_resize from your work queue then please let me know why as I'd
like everyone to be using one abstraction.

We also now have a "resize" operation for devices that want to react to a
resize from TIOCSWINSZ
