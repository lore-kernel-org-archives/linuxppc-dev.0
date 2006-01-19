Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7362768A0A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 21:39:40 +1100 (EST)
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 09:49:16 +0000
Message-Id: <1137664156.8471.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, wim@iguana.be, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Iau, 2006-01-19 at 00:58 -0600, Kumar Gala wrote:
> Since we can only open the watchdog once having a spinlock to protect
> multiple access is pointless.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

NAK

This is a common mistake.

open is called on the open() call and is indeed in this case 'single
open', but file handles can be inherited and many users may have access
to a single file handle.

eg

	f = open("/dev/watchdog", O_RDWR);
	fork();
	while(1) {
		write(f, "Boing", 5);
	}

Alan
