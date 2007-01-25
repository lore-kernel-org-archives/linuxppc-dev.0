Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id E5146DDF7F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 14:15:35 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
Date: Thu, 25 Jan 2007 04:14:15 +0100
References: <20061218163846.337fed65@localhost>
	<523FF36A-46DF-40CA-BFFE-EDE95EFA3EFE@kernel.crashing.org>
	<1169685931.24996.16.camel@localhost.localdomain>
In-Reply-To: <1169685931.24996.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701250414.16424.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net,
	Krafft <krafft@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 01:45, Benjamin Herrenschmidt wrote:
> If the underlying ipmi stuff cannot cleanup, then the driver should not
> have a module_exit() so the module cannot be removed.

It can do the cleanup, but it won't go through the driver's remove
function currently, because it also tries to deal with implementations
that don't have a 'struct device' abstraction and therefore all ipmi
interfaces get torn down by the ipmi driver.

	Arnd <><
