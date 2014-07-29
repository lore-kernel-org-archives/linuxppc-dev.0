Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BCE11A0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 11:44:18 +1000 (EST)
Message-ID: <1406598256.11977.1.camel@concordia>
Subject: Re: [PATCH] powerpc/pci: reorder pci bus/bridge unregistration
 during PHB removal
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 29 Jul 2014 11:44:16 +1000
In-Reply-To: <1406594911-7097-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1406594911-7097-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-07-28 at 20:48 -0400, Tyrel Datwyler wrote:
> Commit bcdde7e made __sysfs_remove_dir() recursive and introduced a BUG_ON
> during PHB removal while attempting to delete the power managment attribute
> group of the bus. This is a result of tearing the bridge and bus devices down
> out of order in remove_phb_dynamic. Since, the the bus resides below the bridge
> in the sysfs device tree it should be torn down first.
> 
> This patch simply moves the device_unregister call for the PHB bridge device
> after the device_unregister call for the PHB bus.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

That commit went into 3.13, so shouldn't this be CC to stable?

And also:

  Fixes: bcdde7e221a8 ("sysfs: make __sysfs_remove_dir() recursive")

cheers
