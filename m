Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc/cell/axon-msi: retry on missing interrupt
Date: Tue, 18 Nov 2008 21:18:40 +0100
References: <OFAA8011D7.7EC11C03-ONC2257505.00480C55-C2257505.00486E5E@il.ibm.com>
In-Reply-To: <OFAA8011D7.7EC11C03-ONC2257505.00480C55-C2257505.00486E5E@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811182118.41449.arnd@arndb.de>
Cc: paulus@samba.org, cbe-oss-dev@ozlabs.org, Giora Biran <GBIRAN@il.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 18 November 2008, Giora Biran wrote:
> 
> Arnd,
> >> However, reading that position does not flush the DMA, so that we can
> observe stale data in the buffer.
> 
> The position register is in the DCR space from which a read does not flush
> the interrupt. But it seem that reading a register mapped to the PLB5 can
> flush the interrupts if the C3PO is set to producer/consumer mode.
> 

Right, however I guess that implementing this in Linux would either
get a lot uglier than the current patch, or require an updated firmware.
The problem here is that the MSIC device node only provides a DCR
register range, and no MMIO register range, so there is no clean
way for the device driver to know about any register it can safely
read.

	Arnd <><
