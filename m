Return-Path: <asamymuthupa@micron.com>
Received: from mailout.micron.com (mailout.micron.com [137.201.242.129])
 by ozlabs.org (Postfix) with ESMTP id B92072C011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 10:07:29 +1000 (EST)
Message-ID: <522E5FD5.40603@micron.com>
Date: Mon, 9 Sep 2013 16:55:01 -0700
From: Asai Thambi S P <asamymuthupa@micron.com>
MIME-Version: 1.0
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Shivaprasad G Bhat
 <sbhat@linux.vnet.ibm.com>
Subject: Re: powerpc allmodconfig build broken due to commit 15863ff3b
 (powerpc: Make chip-id information available to userspace)
References: <522D163E.80106@roeck-us.net>
In-Reply-To: <522D163E.80106@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/08/2013 5:28 PM, Guenter Roeck wrote:
> Hi all,
>
> powerpc allmodconfig build on the latest upstream kernel results in:
>
> ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!
>
> This is due to commit 15863ff3b (powerpc: Make chip-id information 
> available to userspace).
> Not surprising, as cpu_to_chip_id() is not exported.
>
Apart from the above error, I have a concern on the patch, purely based on the commit message.
(to be honest, I am not familiar with the ppc architecture)

Commit message of 15863ff3b has the following text.

******************
So far "/sys/devices/system/cpu/cpuX/topology/physical_package_id"
was always default (-1) on ppc64 architecture.

Now, some systems have an ibm,chip-id property in the cpu nodes in
the device tree. On these systems, we now use this information to
display physical_package_id
******************

Shouldn't the new definition of "topology_physical_package_id" apply only to those systems supporting ibm,chip-id property?


> Reverting this commit fixes the problem. Any good idea how to fix it 
> for real ?
>
> Guenter
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
