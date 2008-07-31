Return-Path: <timur@freescale.com>
Message-ID: <4891E06A.4070608@freescale.com>
Date: Thu, 31 Jul 2008 10:55:22 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>	
	<48899736.8020400@grandegger.com>	
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>	
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>	
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>	
	<20080727012722.GH12191@secretlab.ca>	
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
In-Reply-To: <9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> Aren't the tables in the manual there just to make it easy for a human
> to pick out the line they want? For a computer you'd program the
> formula that was used to create the tables.

Actually, the tables in the manuals are just an example of what can be
programmed.  They don't cover all cases.  The tables assume a specific value of
DFSR.

For 8xxx, you want to use AN2919 to figure out how to really program the device.

The table I generated for U-Boot is based on the calculations outlined in
AN2919.  I debated trying to implement the actual algorithm, but decided that
pre-calculating the values was better.  The algorithm is very convoluted.

> I agree that it took me half an hour to figure out the formula that
> was needed to compute the i2s clocks, but once you figure out the
> formula it solves all of the cases and no one needs to read the manual
> any more. The i2c formula may even need a small loop which compares
> different solutions looking for the smallest error term. But it's a
> small space to search.

My understanding is that the algorithm itself is different on 8xxx vs. 52xx.  It
might be possible to combine 5200A and 5200B into one table/algorithm, but I
don't think you can combine it with the 8xxx table.

-- 
Timur Tabi
Linux kernel developer at Freescale
