Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by ozlabs.org (Postfix) with SMTP id 3BD9CDDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 13:14:44 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/6] usb/fsl_qe_udc: Fix recursive locking bug in
	ch9getstatus()
Date: Mon, 17 Nov 2008 17:59:42 -0800
References: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
	<20081111160327.GB24699@oksana.dev.rtsoft.ru>
In-Reply-To: <20081111160327.GB24699@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811171759.42674.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Li Yang <leoli@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: dbrownell@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 11 November 2008, Anton Vorontsov wrote:
> -       spin_lock_irqsave(&udc->lock, flags);
> +       if (lock)
> +               spin_lock_irqsave(lock, flags);

Ugly ugly ugly.  Conditional locking is error prone ... don't.

Couldn't you just have the usb_ep_queue() method wrap lock calls
around a common routine called by that and the status reporting code?

Or just have the status reporting code stuff the two bytes directly
into the FIFO?  (Which is what a lot of other drivers do.)

- Dave
