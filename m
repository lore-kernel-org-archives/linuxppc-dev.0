Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 16DBE67C30
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 01:44:58 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: sfr@canb.auug.org.au
Subject: Recently removed io accessors
Date: Thu, 12 Oct 2006 17:44:56 +0200
Message-ID: <873b9twnbb.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Commit 661f1cdb8b3e3c2c44e97df122c1d5643c054ce8 ([POWERPC] remove
unused asm routines) removed the _insl / _outsl routines for 32bit
copies with byteswap.

I've been working on adding ppc support to drivers/net/smc911x.c, and
I was unfortunately using those routines (The ethernet controller can
be configured for big endian mode, but the contents of the internal
packet buffers is still little endian, so you need to byteswap in the
tx/rx routines).

Any chance of getting them back or should I implement a (slower) loop
myself before submitting the patch?

-- 
Bye, Peter Korsgaard
