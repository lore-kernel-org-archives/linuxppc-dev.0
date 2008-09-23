Return-Path: <benh@kernel.crashing.org>
Subject: Re: irq_disable() not working
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <48D8B214.2050706@grandegger.com>
References: <48D8B214.2050706@grandegger.com>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 19:20:34 +1000
Message-Id: <1222161634.12085.138.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-23 at 11:08 +0200, Wolfgang Grandegger wrote:
> I'm trying to understand how irq_disable() is supposed to work on
> PowerPC systems. Most PowerPC PIC do *not* implement the enable and
> disable, but just the unmask and mask methods, e.g:
> 
>   http://lxr.linux.no/linux+v2.6.26.5/arch/powerpc/sysdev/mpic.c#L867
> 
> The irq_disable() function will then call the default function
> default_disable():
> 
>   http://lxr.linux.no/linux+v2.6.26.5/kernel/irq/chip.c#L234
> 
> which does not *nothing*. I do not see how the interrupt gets disabled
> on the hardware level. Obviously I have missed something. TIA for
> clarification.

Lazy masking ? ie, look what happens if the irq happens while disabled.

Ben.
