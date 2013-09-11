Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C9972C010A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:36:11 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 11 Sep 2013 16:28:33 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 506B52BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:35:54 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8B6ZhtF3736000
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:35:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8B6ZrXv017169
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:35:54 +1000
Message-ID: <52300F59.3070605@linux.vnet.ibm.com>
Date: Wed, 11 Sep 2013 12:06:09 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allmodconfig build broken due to commit 15863ff3b
 (powerpc: Make chip-id information available to userspace)
References: <522D163E.80106@roeck-us.net> <522E5FD5.40603@micron.com>
 <1378850569.4121.28.camel@pasglop> <20130910225029.GA26981@roeck-us.net>
In-Reply-To: <20130910225029.GA26981@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 Asai Thambi S P <asamymuthupa@micron.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/11/2013 04:20 AM, Guenter Roeck wrote:
> On Wed, Sep 11, 2013 at 08:02:49AM +1000, Benjamin Herrenschmidt wrote:
>> On Mon, 2013-09-09 at 16:55 -0700, Asai Thambi S P wrote:
>>> On 09/08/2013 5:28 PM, Guenter Roeck wrote:
>>>> Hi all,
>>>>

Guenter, Ben,

Sorry for the inconvenience. I never realized my patch could break somewhere :-(

Thanks you very much for identifying and fixing this issue. Other patch looks 
good to me.

-Vasant


>>>> powerpc allmodconfig build on the latest upstream kernel results in:
>>>>
>>>> ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!
>>>>
>>>> This is due to commit 15863ff3b (powerpc: Make chip-id information
>>>> available to userspace).
>>>> Not surprising, as cpu_to_chip_id() is not exported.
>>>>
>>> Apart from the above error, I have a concern on the patch, purely based on the commit message.
>>> (to be honest, I am not familiar with the ppc architecture)
>>>
>>> Commit message of 15863ff3b has the following text.
>>>
>>> ******************
>>> So far "/sys/devices/system/cpu/cpuX/topology/physical_package_id"
>>> was always default (-1) on ppc64 architecture.
>>>
>>> Now, some systems have an ibm,chip-id property in the cpu nodes in
>>> the device tree. On these systems, we now use this information to
>>> display physical_package_id
>>> ******************
>>>
>>> Shouldn't the new definition of "topology_physical_package_id" apply only to those systems supporting ibm,chip-id property?
>>
>> There should be no negative side effect (appart from the missing
>> EXPORT_SYMBOL of course). If the property is not found in the
>> device-tree, the new function returns -1, so it should work fine on all
>> systems.
>>
> Good. I submitted a patch doing just that yesterday or so.
> Hope you'll accept it ;).
>
> Thanks,
> Guenter
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
