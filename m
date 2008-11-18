Return-Path: <david-b@pacbell.net>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by ozlabs.org (Postfix) with SMTP id 11FBEDDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 09:13:33 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/6 v2] usb/fsl_qe_udc: Fix recursive locking bug in
	ch9getstatus()
Date: Tue, 18 Nov 2008 14:13:30 -0800
References: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
	<200811171759.42674.david-b@pacbell.net>
	<20081118175127.GA29920@oksana.dev.rtsoft.ru>
In-Reply-To: <20081118175127.GA29920@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811181413.30552.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Li Yang <leoli@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 18 November 2008, Anton Vorontsov wrote:
> +       spin_lock_irqsave(&udc->lock, flags);
> +       ret = __qe_ep_queue(_ep, _req, gfp_flags);
> +       spin_unlock_irqrestore(&udc->lock, flags);

Why are you passing "gfp_flags"?  Especially without
checking ... GFP_KERNEL will be illegal, for example.
