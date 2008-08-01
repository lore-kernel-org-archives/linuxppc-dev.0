Return-Path: <timur@freescale.com>
Message-ID: <489368F7.1040503@freescale.com>
Date: Fri, 01 Aug 2008 14:50:15 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
References: <488982B5.4070102@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891E06A.4070608@freescale.com>
	<Pine.LNX.4.58.0807311610170.10341@shell4.speakeasy.net>
	<ed82fe3e0808010617u101855f7x70d3cbd2bed31f8c@mail.gmail.com>
	<Pine.LNX.4.58.0808011246290.10341@shell4.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0808011246290.10341@shell4.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho wrote:

> All 83xx other than 832x.

Never mind, I forgot that 83xx support for i2c1_clk was already in U-Boot:

#if defined(CONFIG_MPC834X)
	i2c1_clk = tsec2_clk;
#elif defined(CONFIG_MPC8360)
	i2c1_clk = csb_clk;
#elif defined(CONFIG_MPC832X)
	i2c1_clk = enc_clk;
#elif defined(CONFIG_MPC831X)
	i2c1_clk = enc_clk;
#elif defined(CONFIG_MPC837X)
	i2c1_clk = sdhc_clk;
#endif
#if !defined(CONFIG_MPC832X)
	i2c2_clk = csb_clk; /* i2c-2 clk is equal to csb clk */
#endif

-- 
Timur Tabi
Linux kernel developer at Freescale
