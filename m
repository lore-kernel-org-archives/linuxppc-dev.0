Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 5E37E679FD
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 21:57:26 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Recently removed io accessors
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
	<1160724670.4792.195.camel@localhost.localdomain>
	<87slhstxlk.fsf@sleipner.barco.com>
	<17712.7972.493547.357685@cargo.ozlabs.ibm.com>
Date: Sat, 14 Oct 2006 13:57:03 +0200
In-Reply-To: <17712.7972.493547.357685@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sat, 14 Oct 2006 09:20:04 +1000")
Message-ID: <8764ent8j4.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "PM" == Paul Mackerras <paulus@samba.org> writes:

Hi,

>> Endian register set to little endian (default at powerup):
RedBoot> x -b 0x8e000064 -2 -l 4
>> 8E000064: 4321 8765
RedBoot> x -b 0x8e000064 -4 -l 4
>> 8E000064: 43218765

PM> Which is neither big-endian nor little-endian, but something more
PM> like vax-endian (or pdp11-endian), but not exactly that either -
PM> vax-endian would be 65872143.  What a mess.

Yes :/

PM> Clearly the "big endian" bit on the chip doesn't actually switch
PM> between little-endian and big-endian at all, but just acts to
PM> invert the 0x2 bit of the address...

Exactly.

PM> So the two hardware bogosities taken together leave you with only
PM> one combination that is anything like usable.  I suggest that you
PM> code up a loop of readw (or equivalent) in the driver with a big
PM> comment explaining why you need to do it that way.

It doesn't have to be readw (16bit accesses). Enabling the BE mode and
using _outsl/_insl (32bit access with byteswap) works fine.

Let me repeat my question:
Could I get _outsl/_insl re-added to kernel/misc.S or do I have to
reimplement it somewhere else (platform file or smc911x.h)?

-- 
Bye, Peter Korsgaard
