Return-Path: <anton@bilbo.ozlabs.org>
Date: Thu, 13 Aug 2009 19:39:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: The infamous ppc_spurious_interrupt
Message-ID: <20090813093900.GF4685@kryten>
References: <c2d0b6ec0908121240v60446ebdjc9dc35fe1b5b544e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c2d0b6ec0908121240v60446ebdjc9dc35fe1b5b544e@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi,

> I'm trying to understand the rationale behind "ppc_spurious_interrupts"
> without luck so far. I'm seeing the BAD interrupt counter incrementing with
> kernels of different ages (2.6.5, 2.6.16, 2.6.27) and on different hardware
> (IBM P5 and P6 64 bit, Apple PPC 32 bit). 

On IBM POWER5 and POWER6 systems there are cases where an interrupt will
be presented to the partition but the hypervisor will handle it and
return NO_IRQ.

...

> If the "bad interrupts" are harmless (I suppose they are), why are we counting
> them and displaying the counter as BAD in /proc/interrupts?

Considering these interrupts are expected (at least on IBM platforms), I
agree it is a bit dramatic to call them BAD. Unfortunately it's been that way
forever and changing /proc/interrupts will more than likely break some tools.

Anton
