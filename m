Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4C44DE032
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 03:28:06 +1100 (EST)
Date: Tue, 14 Oct 2008 17:14:08 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 4/5] hvc_console: Add tty window resizing
Message-ID: <20081014171408.228e681b@lxorguk.ukuu.org.uk>
In-Reply-To: <20081014150209.GB5318@cetus.boeblingen.de.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
	<20081014091413.306993844@linux.vnet.ibm.com>
	<20081014104428.698b750b@lxorguk.ukuu.org.uk>
	<20081014150209.GB5318@cetus.boeblingen.de.ibm.com>
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

> Since tty_do_resize() cannot be called holding the hp spinlock; the code uses
> now tty_kref_get/put to keep track of the tty object. I am not sure if the
> use of the kref's is correct here, so please let me know if there is a better
> solution.

That looks right to me, hp->tty can go NULL but the tty object itself
will still have a reference even if the asynchronous events kick off late
