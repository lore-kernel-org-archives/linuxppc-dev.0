Return-Path: <david-b@pacbell.net>
Received: from smtp122.sbc.mail.re3.yahoo.com (smtp122.sbc.mail.re3.yahoo.com
	[66.196.96.95]) by ozlabs.org (Postfix) with SMTP id 93B98DE029
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 02:19:23 +1000 (EST)
Date: Mon, 08 Oct 2007 09:19:27 -0700
From: David Brownell <david-b@pacbell.net>
To: vbarshak@ru.mvista.com
Subject: Re: [linux-usb-devel] [PATCH] OHCI: add PowerPC 440EP/440EPx support
References: <20071008142554.GA15175@ru.mvista.com>
	<20071008150125.26C802393C7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<470A55A2.5050606@ru.mvista.com>
In-Reply-To: <470A55A2.5050606@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20071008161927.84C601915AE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Near as I can tell, the original code is wrong ... the hcca->frame_no
> > byte offset is fully specified, so that shift should always be 16.
>
> Are you saying that it should always be #define OHCI_BE_FRAME_NO_SHIFT 
> 16 for big endian platforms?

More than that, I'm saying that shouldn't even be a #define!  The
default should be that drivers expect chips to follow the interface
specs.  Any value other than 16 violates the OHCI spec.

However, based on one other post, I suspect at least one Freescale
part will need to declare a chip quirk for this case.

- Dave
