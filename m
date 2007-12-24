Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 74372DDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Dec 2007 06:30:58 +1100 (EST)
Date: Mon, 24 Dec 2007 13:38:00 -0600
From: Olof Johansson <olof@lixom.net>
To: ramkumarj Ramkumar <ramkumarj2000@gmail.com>
Subject: Re: Loop at starting pid 164, tty '': '/sbin/getty'
Message-ID: <20071224193800.GA3382@lixom.net>
References: <4f8c3030712220051if731af9g350af9d45a75c244@mail.gmail.com>
	<20071224040915.GA20380@lixom.net>
	<4f8c3030712240120m30d68b37g8b5f099294c6d769@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4f8c3030712240120m30d68b37g8b5f099294c6d769@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, Dec 24, 2007 at 05:20:10PM +0800, ramkumarj Ramkumar wrote:

> I would be very grateful if the following questions could be addressed,
> 
> 1. Does the inittab format changed for Linux 2.6. The old one was from
> mkrootfs (which I think is pretty old). I could see some changes in the
> "respawn" line.

Inittab isn't tied to the kernel, but to the init process. So no, it
should not have changed between 2.4 and 2.6.

> 2. Is it required to run the tty0 along with ttyS0. Is this is mandatory. I
> assumed all these days console and ttyS0 should be sufficient.

tty0 is normally one of the vga consoles. It shouldn't be needed if all
you have is serial.

> 3. A very basic question : What is the clear difference between ttyS0 ( UART
> Driver ), console and tty0. To my understanding, ttyS0 is the first port
> UART 's driver (for 16550/8250) which deals with the hardware as such by
> writing and reading the registers. tty0 is virtual console, something to do
> with telnet sessions. But I dont clearly understand why console and tty0 are
> both required or not. Please correct me if my understanding is wrong.

ttyS<x> are normally 8250-compatible uarts, yes. pts/<x> is remote
connections such as telnet or ssh-based ones. tty<x> are normally the
local vga consoles.


-Olof
