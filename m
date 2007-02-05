Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 160DDDDDE4
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 09:43:39 +1100 (EST)
Date: Mon, 5 Feb 2007 23:43:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 02/10] windfarm: dont die on suspend thread signal
Message-ID: <20070205224325.GA8453@lst.de>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185835.700233000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070205185835.700233000@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2007 at 07:30:29PM +0100, Johannes Berg wrote:
> -		/* there should be no signal, but oh well */
> -		if (signal_pending(current)) {
> +		/* there should be no non-suspend signal, but oh well */
> +		if (signal_pending(current) && !try_to_freeze()) {

Given that the driver uses the kthread infrastructure and doesn't
explicitly re-enable signals there can't be any other signal.
So just remove the signal_pending check.
