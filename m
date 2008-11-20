Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mpic: don't reset affinity for secondary MPIC
	on boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200811191450.59361.arnd@arndb.de>
References: <200811191450.59361.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 20 Nov 2008 18:30:40 +1100
Message-Id: <1227166240.7185.207.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kexec@lists.infradead.org,
	cbe-oss-dev@ozlabs.org, Max Krasnyansky <maxk@qualcomm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-19 at 14:50 +0100, Arnd Bergmann wrote:
> This patch implements the first approach, because it can work on
> machines that have a secondary controller that needs to deliver
> interrupts to a destination other than CPU 0. The disadvantage
> is that it requires the system to set up the affinity register
> correctly on bootup.
> 
That won't fly with MPICs that get reset.

I would rather, for non primary, set it to a cpu provided as
either a new argument or an mpic struct member initially set to 1 with
an accessor to change it if necessary. Or should we define a flag to
have it read it at init time from the chip ?

Ben.
