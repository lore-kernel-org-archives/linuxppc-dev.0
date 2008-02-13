Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id B7AB4DE012
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 10:31:30 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [Patch 0/2] powerpc: avoid userspace poking to legacy ioports
Date: Thu, 14 Feb 2008 00:07:37 +0100
References: <20080213182800.5c6940a8@de.ibm.com>
	<20080213183506.7f3e3145@de.ibm.com>
	<1202935374.7296.44.camel@pasglop>
In-Reply-To: <1202935374.7296.44.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802140007.38407.arnd@arndb.de>
Cc: parabelboi@bopserverein.de, Christian Krafft <krafft@de.ibm.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 13 February 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-02-13 at 18:35 +0100, Christian Krafft wrote:
> > sensors_detect crashes kernel on PowerPC, as it pokes directly to memory.
> > This patch adds a check_legacy_ioports to read_port and write_port.
> > It will now return ENXIO, instead of oopsing.
> > 
> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> 
> The problem is that this prevents using /proc/ioports to access PCI
> IO space, which might be useful.
> 
> I hate that sensors_detect.. or for that matter any other userland code
> that pokes random ports like that. It should die.

What kind of Oops do you get? Is it because the ioport area is not
ioremapped at all or do you get a machine check? If there is no
mapping, we could possibly change inb and outb do deal with that.

	Arnd <><
