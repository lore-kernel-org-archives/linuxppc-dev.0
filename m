Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id ADC5F67BE4
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 03:26:09 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061120100144.GA27812@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 08:25:54 -0800
Message-Id: <1164039954.3028.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-20 at 11:01 +0100, Ingo Molnar wrote:

> correct. It's basically a different type of 'flow' of handling an 
> interrupt. It's a host-side genirq-level detail that should have no 
> irqchip level impact at all.
> 
> The only detail is that sometimes a threaded flow /cannot/ be 
> implemented if the irqchip lacks certain methods. (such as a 
> mask/unmask)
> 
> i.e. Sergei's patch tweaking the irqchip data structures is wrong - the 
> correct approach is what i do for i386/x86_64: install a different 
> "threaded" flow handler. I prefer this to tweaking the existing 
> 'fasteoi' handler, to make the act of supporting a threaded flow design 
> explicit. (and to allow a mixed threaded/non-threaded flow setup) I 
> didnt take Daniel's prior patch for that reason: he tried to tweak the 
> fasteoi flow handler - which is an almost good approach but not good 
> enough :-)
> 

It makes porting to powerpc for instance harder because some controllers
have ack(), and some don't.. Some have mask(), and some don't.. So you
end up with what Sergei is doing which is flat out make ack == eoi ..
Where you have multiple irq chip types each one really needs an
individual evaluation ..

I don't really agree with your method since it increase the porting
effort, and I don't see a gain from it.. In fact the changes that you
make seem like it would be more difficult to support a simple reversal
from a thread to an interrupt context handler, since your permanently
changing the "flow handler" , as you called it, no matter what the
context is. So the person using this code will have to investigate this
new flow handler, which will result is a very anti-climactic ending and
lots of useless work since it's really making ack == eoi (at least for
powerpc). 

Daniel
