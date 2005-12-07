Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 3976B6884E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 20:00:57 +1100 (EST)
Message-ID: <4396A42C.4080907@compulab.co.il>
Date: Wed, 07 Dec 2005 10:58:20 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Nathael PAJANI <nathael.pajani@cpe.fr>
References: <20051206125102.1FC7F68888@ozlabs.org> <4395AA59.5030209@cpe.fr>
In-Reply-To: <4395AA59.5030209@cpe.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: no IRQ from USB on MPC8248
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Nathael PAJANI wrote:

[snip]

> which means the hub detects a device, and tries to configure it.

The root hub is virtual and implemented in SW. It detects the device any 
time there's a pull-up on one of the D+ or D- lines, no matter if 
controller is working properly or not.

>
> second: the device is happy to see a request and replies correctly.... 
> but there's no interrupt fired, whether using SUI_INT_USB (==11) or 
> the SCC3 interrupt (==42)
>
Make sure you've adopted the following functions to your board:
    static int board_configure(struct m8xxhci_private *hp)
    static int setup_usb_clock(struct m8xxhci_private *hp)
so the controller will get proper USB clock.

-- 
Sincerely yours,
Mike Rapoport
