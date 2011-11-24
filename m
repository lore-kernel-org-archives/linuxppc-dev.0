Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9181A1007D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 19:14:08 +1100 (EST)
Subject: Re: [PATCH] 8250: add workaround for MPC8[356]xx UART break IRQ storm
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
Date: Thu, 24 Nov 2011 02:14:03 -0600
Message-Id: <82B7F47D-C7BF-4BD1-9982-7E7AEDC23530@kernel.crashing.org>
References: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 26, 2010, at 1:25 PM, Paul Gortmaker wrote:

> Sending a break on the SOC UARTs found in some MPC83xx/85xx/86xx
> chips seems to cause a short lived IRQ storm (/proc/interrupts
> typically shows somewhere between 300 and 1500 events).  Unfortunately
> this renders SysRQ over the serial console completely inoperable.
> Testing with obvious things like ACKing the event doesn't seem to
> change anything vs. a completely dumb approach of just ignoring
> it and waiting for it to stop, so that is what is implemented here.
>=20
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>=20
> This is a refresh of a patch I'd done earlier -- I've tried to make
> the bug support as generic as possible to minimize having board
> specific ifdef crap in 8250.c -- any suggestions on how to further
> improve it are welcome.
>=20
> drivers/serial/8250.c      |    6 ++++++
> drivers/serial/8250.h      |   20 ++++++++++++++++++++
> drivers/serial/Kconfig     |   14 ++++++++++++++
> include/linux/serial_reg.h |    2 ++
> 4 files changed, 42 insertions(+), 0 deletions(-)

Did we ever decide what to do with this or trying to get it accepted =
upstream?

- k=
