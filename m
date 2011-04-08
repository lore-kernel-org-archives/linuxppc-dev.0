Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43A3BB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Apr 2011 09:48:34 +1000 (EST)
Subject: Re: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tmarri@apm.com
In-Reply-To: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 09 Apr 2011 09:48:04 +1000
Message-ID: <1302306484.2458.64.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Ayman El-Khashab <ayman@elkhashab.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-04-08 at 13:22 -0500, Ayman El-Khashab wrote:
> From: Ayman El-Khashab <ayman@elkhashab.com>
> 
> This patch is to fix the PCIe on the 460SX CPU.  As far as I can tell,
> the 460SX must be using a different core than the previous 4xx SOCs.
> The registers aren't the same and it appears DCRs that existed on 
> previous parts don't exist on this one.  Perhaps somebody from AMCC 
> can chime in.  In any case, the main problem was that the TX and RX
> weren't enabled so nothing downstream from the RP was ever found.
> And the check to set "port->link" would never work (as far as I could
> tell).  I could not find any DCRs in this part to indicate when the
> link was up and there isn't an obvious loopback, so the following
> call would fail and result in no devices found.
> 
> ppc4xx_pciex_wait_on_sdr(port, PESDRn_LOOP, 1 << 28, 1 << 28, 100)
> 
> It would be better to detect the link status, but I don't see an
> obvious way to do that from the data sheet.  U-boot just skips the
> link check as well for this part.

Hi Tirumala !

You originally submitted the support for 460ex. Can you chime in (and
review Ayman patch) please ?

Cheers,
Ben.

> 
> Ayman El-Khashab (1):
>   ppc4xx: Fix PCIe scanning for the 460SX
> 
>  arch/powerpc/sysdev/ppc4xx_pci.c |   35 +++++++++++++++++++++++++++++++----
>  1 files changed, 31 insertions(+), 4 deletions(-)
> 
