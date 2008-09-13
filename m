Return-Path: <rdreier@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: demuxing irqs
References: <9e4733910809131206j125e7e25of07c19028ac07339@mail.gmail.com>
	<adaprn7is80.fsf@cisco.com>
	<9e4733910809131554mb0c6660r3bcc993bb2ca082d@mail.gmail.com>
Date: Sat, 13 Sep 2008 16:04:52 -0700
In-Reply-To: <9e4733910809131554mb0c6660r3bcc993bb2ca082d@mail.gmail.com> (Jon
	Smirl's message of "Sat, 13 Sep 2008 18:54:58 -0400")
Message-ID: <adaljxvir57.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > The muxed interrupts are inside a SOC CPU.  For example eight GPIOs
 > can each individually be enabled to trigger hardware interrupt 7. When
 > I get hw interrupt 7 i want to demux it into 8 virtual interrupts.
 > There are eight bit registers for individually acking, enabling, etc
 > each of the eight multiplexed interrupts. With eight virutal
 > interrupts each user can register a different handler and isn't aware
 > the muxing is going on.

I see... well, assuming all the issues around handling multiple
simultaneous (or overlapping) interrupts are OK, you could look at how
arch/powerpc/sysdev/uic.c handles the cascaded interrupt controllers for
4xx SoCs.  The idea of that code is that you get an interrupt, and look
look at interrupt cause register 0, and see interrupt X, and to handle
interrupt X you read interrupt cause register 1 to see which the real
interrupt is.  And you might see interrupt Y, which means to go onto
interrupt cause register 2.

 - R.
