Return-Path: <scop@digitel.com.br>
Received: from cosmos.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id 3E0D0DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jun 2007 14:33:29 +1000 (EST)
From: Ricardo Scop <scop@digitel.com.br>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux interrupt managing on 8xx
Date: Wed, 6 Jun 2007 01:02:07 -0300
References: <F1F6EC0C8B75034F9E3A79FC85122E8E264992@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E264992@aquib01a>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706060102.07410.scop@digitel.com.br>
Cc: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 04 June 2007 17:37, DI BACCO ANTONIO - technolabs wrote:
> I have a component named pca9555 (on the i2c bus) that is an I/O expander.
> It can generate an interrupt to the MPC8xx processor (SIU_IRQ1 pin). This
> pin will be active till I read registers of pca9555. Because I cannot
> access the i2c bus in the interrupt handler I queue a work on a work queue.
> Just at the end of the interrupt handler  should I disable the interrupt on
> the mpc8xx? I think that otherwise the interrupt will pop up again till I
> execute the work in the work queue finally reading the pca9555 and shutting
> off the source of the interrupt.

Well, why don't you simply program the interrupt to be edge-triggered in the 
SIEL register? This way it will only occur again after the pin level is 
cleared.

HTH,

Ricardo.
