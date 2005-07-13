Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 34D6467A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 06:19:24 +1000 (EST)
Date: Wed, 13 Jul 2005 13:19:21 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20050713201920.GA23573@gate.ebshome.net>
References: <42D557E3.9060503@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42D557E3.9060503@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: UART problem on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2005 at 10:05:23PM +0400, Vitaly Bordug wrote:
> Hi!
> Do anyone have 2-nd UART port working on MPC8272ADS?
> 
> The target boots OK via both UARTs as console, but any attempt to 
> transmit/receive data via the other port have failed.
> A quick lookup results that ...init_scc is called only in `console` 
> case. After addition of this call to the cpm_uart_startup (just for 
> instance) transmit from the target occur, but with only half of data. I 
> tried various pin settings including working combinations from the old 
> uart driver but with the same result.
> 
> I guess that 8xx that are also handled by this driver may behave 
> likewise, so any information whether cpm_uart driver works well  (or 
> not)  on 8xx is also valuable.
> 
> Any ideas how to solve this or concerning possible reasons of such 
> behavior are greatly appreciated.

I had some problems with multiple UARTs (SMC and SCC) on 8248-based 
custom board. It was due to completely brain-damaged BRG allocation in 
cpm2_io/uart.c. I had to hack it to make SCC UART working along with 
SMC one.

-- 
Eugene
