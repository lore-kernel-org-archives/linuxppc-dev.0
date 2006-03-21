Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC] powerpc: cell interrupt controller updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200601180020.17301.arnd@arndb.de>
References: <200601172028.01013.arnd@arndb.de>
	<1137533707.4823.106.camel@localhost.localdomain>
	<200601180020.17301.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 17:27:22 +1100
Message-Id: <1142922442.12137.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>, stk@de.ibm.com,
	Milton Miller <miltonm@bga.com>,
	Paul Mackerras <paulus@samba.org>, hpenner@de.ibm.com,
	linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-01-18 at 00:20 +0100, Arnd Bergmann wrote:

> The interrupt-parent relationship between the spider and iic controllers
> is just an approximation, each spider pic can also send interrupts to any
> other interrupt controller in the system (all six of them, if you count
> the SMT threads as separate interrupt targets), but for best performance, it
> is usually wise to use local interrupt delivery.

We could either express that by having a new property that we could call
"multiple-parents" or something like that with a list of parents... or
we could have a "virtual" iic that is a single controller in the
device-tree (the later makes a lot of sense I think) with sub-nodes for
the actual iic's to be used maybe by the iic driver for probing... I
still need to think about that one though..

Ben.
 
