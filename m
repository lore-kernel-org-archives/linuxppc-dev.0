Return-Path: <benh@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E5182C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 08:03:02 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 11 Sep 2013 07:54:10 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 86657357804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 08:02:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8ALkO5s7078284
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 07:46:24 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8AM2sNL016424
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 08:02:54 +1000
Message-ID: <1378850569.4121.28.camel@pasglop>
Subject: Re: powerpc allmodconfig build broken due to commit 15863ff3b
 (powerpc: Make chip-id information available to userspace)
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Asai Thambi S P <asamymuthupa@micron.com>
Date: Wed, 11 Sep 2013 08:02:49 +1000
In-Reply-To: <522E5FD5.40603@micron.com>
References: <522D163E.80106@roeck-us.net> <522E5FD5.40603@micron.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-09 at 16:55 -0700, Asai Thambi S P wrote:
> On 09/08/2013 5:28 PM, Guenter Roeck wrote:
> > Hi all,
> >
> > powerpc allmodconfig build on the latest upstream kernel results in:
> >
> > ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!
> >
> > This is due to commit 15863ff3b (powerpc: Make chip-id information 
> > available to userspace).
> > Not surprising, as cpu_to_chip_id() is not exported.
> >
> Apart from the above error, I have a concern on the patch, purely based on the commit message.
> (to be honest, I am not familiar with the ppc architecture)
> 
> Commit message of 15863ff3b has the following text.
> 
> ******************
> So far "/sys/devices/system/cpu/cpuX/topology/physical_package_id"
> was always default (-1) on ppc64 architecture.
> 
> Now, some systems have an ibm,chip-id property in the cpu nodes in
> the device tree. On these systems, we now use this information to
> display physical_package_id
> ******************
> 
> Shouldn't the new definition of "topology_physical_package_id" apply only to those systems supporting ibm,chip-id property?

There should be no negative side effect (appart from the missing
EXPORT_SYMBOL of course). If the property is not found in the
device-tree, the new function returns -1, so it should work fine on all
systems.

Cheers,
Ben.

> 
> > Reverting this commit fixes the problem. Any good idea how to fix it 
> > for real ?
> >
> > Guenter
> > -- 
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
