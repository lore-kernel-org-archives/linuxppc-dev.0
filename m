Return-Path: <randy.dunlap@oracle.com>
Message-ID: <49EFDD66.3060407@oracle.com>
Date: Wed, 22 Apr 2009 20:15:50 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH][BUILD FAILURE 03/12] Re: Next April 21 : PPC64 randconfig
	[arch/powerpc/kernel/of_platform.o]
References: <20090422161648.9231.76057.sendpatchset@subratamodak.linux.ibm.com>
	<1240447420.6689.13.camel@localhost>
In-Reply-To: <1240447420.6689.13.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>,
	Alexander Beregalov <a.beregalov@gmail.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Wed, 2009-04-22 at 21:46 +0530, Subrata Modak wrote:
>> On Wed, 2009-04-22 at 00:20 +0530, Subrata Modak wrote:
>>> Reported this earlier on 14th April 2009:
>>> http://lkml.org/lkml/2009/4/14/480,
>>>
>>> Michael,
>>>
>>> Any fix in sight ?
>>> http://lkml.org/lkml/2009/4/14/676,
>>>
>>> CC      arch/powerpc/kernel/of_platform.o
>>> arch/powerpc/kernel/of_platform.c: In function 'of_pci_phb_probe':
>>> arch/powerpc/kernel/of_platform.c:270: error: implicit declaration of
>>> function 'pci_devs_phb_init_dynamic'
>>> arch/powerpc/kernel/of_platform.c:279: error: implicit declaration of
>>> function 'scan_phb'
>>> arch/powerpc/kernel/of_platform.c:295: error: implicit declaration of
>>> function 'pci_bus_add_devices'
>>> make[1]: *** [arch/powerpc/kernel/of_platform.o] Error 1
>>> make: *** [arch/powerpc/kernel] Error 2
>>> ---
> 
> The problem above is as I said before, that the Cell Kconfig forces on
> PPC_OF_PLATFORM_PCI even if PCI is disabled. I think the proper fix is
> just to have CELL_NATIVE force on PCI.
> 
> I don't know how you got the other errors, both pci_dn.c and pci_dlpar.c
> are only built if CONFIG_PCI is enabled, see the Makefiles.


The Kconfig could be more like this:
config PPC_CELL_NATIVE
	bool
	select PPC_CELL_COMMON
-	select PPC_OF_PLATFORM_PCI
+	select PPC_OF_PLATFORM_PCI if PCI

if it would help...



-- 
~Randy
