Return-Path: <dgibson@ozlabs.org>
Date: Sat, 8 Dec 2007 11:36:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [DTC][PATCH] Fix cross-compile building
Message-ID: <20071208003604.GH566@localhost.localdomain>
References: <Pine.LNX.4.64.0712071227280.1788@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0712071227280.1788@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>, stuarth@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 07, 2007 at 12:28:20PM -0600, Kumar Gala wrote:
> From: Stuart Hughes <stuarth@freescale.com>
> 
> This patch allows you to build the DTC source without making the
> tests directory.  This is necessary when cross compiling as the
> dumptest (and other) files cannot be run/used on the host system.
> To use this use: 'make TESTS='

I think this is a silly way of doing this.  Instead create a new
target which builds everything but the tests.

Say,

	all: cross tests

	cross: dtc ftdump libfdt

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
