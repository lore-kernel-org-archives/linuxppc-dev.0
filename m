Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17712.7972.493547.357685@cargo.ozlabs.ibm.com>
Date: Sat, 14 Oct 2006 09:20:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Recently removed io accessors
In-Reply-To: <87slhstxlk.fsf@sleipner.barco.com>
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
	<1160724670.4792.195.camel@localhost.localdomain>
	<87slhstxlk.fsf@sleipner.barco.com>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Peter Korsgaard writes:

> We're using the smsc9117
> (http://www.smsc.com/main/datasheets/9117.pdf) connected over a 16bit
> EMC bus (together with a spansion 29PL127 flash) to a Xilinx V4FX FPGA
> with a 405 core in it.
> 
> LSB of the processor is connected to LSB of of the 9117 (and same for
> the flash) and so on.
> 
> Reading the byte test register of the 9117 (supposed to contain
> 0x87654321) gives:
> 
> Endian register set to little endian (default at powerup):
> RedBoot> x -b 0x8e000064 -2 -l 4
> 8E000064: 4321 8765
> RedBoot> x -b 0x8e000064 -4 -l 4
> 8E000064: 43218765

Which is neither big-endian nor little-endian, but something more like
vax-endian (or pdp11-endian), but not exactly that either - vax-endian
would be 65872143.  What a mess.

> And with it set to big endian:
> RedBoot> x -b 0x8e000064 -2 -l 4
> 8E000064: 8765 4321
> RedBoot> x -b 0x8e000064 -4 -l 4
> 8E000064: 87654321

Clearly the "big endian" bit on the chip doesn't actually switch
between little-endian and big-endian at all, but just acts to invert
the 0x2 bit of the address...

So the two hardware bogosities taken together leave you with only one
combination that is anything like usable.  I suggest that you code up
a loop of readw (or equivalent) in the driver with a big comment
explaining why you need to do it that way.

Paul.
