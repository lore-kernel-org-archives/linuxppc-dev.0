Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1389DDEF74
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 08:00:32 +1000 (EST)
Message-ID: <4807C874.10200@freescale.com>
Date: Thu, 17 Apr 2008 17:00:20 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192846.GB28286@polina.dev.rtsoft.ru>
	<4807AB7A.90005@freescale.com> <20080417214846.GA3161@zarina>
In-Reply-To: <20080417214846.GA3161@zarina>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> static inline bool qe_clock_is_brg(enum qe_clock clk)
> {
> 	return clk < QE_CLK1;
> }

I have no problem with this function (the UART driver could use it), except that
your implementation is wrong.  You would need to do this:

static inline bool qe_clock_is_brg(enum qe_clock clk)
{
	return (clk >= QE_BRG1) && (clk <= QE_BRG16);
}

-- 
Timur Tabi
Linux kernel developer at Freescale
