Return-Path: <jamie@jamieiles.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90C26B7170
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 21:01:14 +1100 (EST)
Received: by eyg24 with SMTP id 24so2024854eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 02:01:09 -0800 (PST)
Date: Mon, 14 Feb 2011 10:01:04 +0000
From: Jamie Iles <jamie@jamieiles.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
Message-ID: <20110214100104.GC4371@pulham.picochip.com>
References: <4D55A7F7.5090700@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D55A7F7.5090700@mentor.com>
Cc: openmcapi-dev@googlegroups.com, "Blanchard,
	Hollis" <Hollis_Blanchard@mentor.com>,
	Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 11, 2011 at 03:19:51PM -0600, Meador Inge wrote:
>     1. Hardware specific bits somewhere under '.../arch/*'.  Drivers
>        for the MPIC message registers on Power and OMAP4 mailboxes, for
>        example.
>     2. A higher level driver under '.../drivers/mailbox/*'.  That the
>        pieces in (1) would register with.  This piece would expose the
>        main kernel API.
>     3. Userspace interfaces for accessing the mailboxes.  A
>        '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.

How about using virtio for all of this and having the mailbox as a 
notification/message passing driver for the virtio backend?  There are 
already virtio console and network drivers that could be useful for the 
userspace part of it.  drivers/virtio/virtio_ring.c might be a good 
starting point if you thought there was some mileage in this approach.

Jamie
