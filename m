Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjdC40bmMzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 16:58:23 +1000 (AEST)
Subject: [v2,RFC] pasemi: Fix boot failure on 4.7-rc1
To: Michael Ellerman <mpe@ellerman.id.au>,
 Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
References: <3rjbjg4fyfz9sXx@ozlabs.org>
Cc: Pat Wall <pjwall@mac.com>, aperez@alexperez.com, matthew@a-eon.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <b48a3917-0fdb-0a04-51d3-5aa0e054af44@xenosoft.de>
Date: Mon, 4 Jul 2016 08:58:08 +0200
MIME-Version: 1.0
In-Reply-To: <3rjbjg4fyfz9sXx@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many thanks!

- Christian

On 04 July 2016 at 07:51 AM, Michael Ellerman wrote:
> On Wed, 2016-29-06 at 20:06:28 UTC, Darren Stevens wrote:
>> Commit:d6a9996e84ac4beb7713e9485f4563e100a9b03e (powerpc/mm:
>>      vmalloc abstraction in preparation for radix) turned kernel memory
>>      and IO addresses from #defined constants to variables initialised
>>      at runtime.
>>      
>>      On PA6T systems the setup_arch machine call initialises the onboard
>>      PCI-e root-ports, and uses pci_io_base to do this, which is now before
>>      its value has been set resulting in a panic right after 'booting
>>      linux via __start()'
>>
>>      Move the pci_io_base initialisation to the same place as vmalloc
>>      ranges are set (hash__early_init_mmu()/radix__early_init_mmu())
>>      
>>      Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>>      Signed-off-by: Darren Stevens <darren@stevens-zone.net>
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Applied to powerpc fixes, thanks.
>
> https://git.kernel.org/powerpc/c/bfa37087aa04e45f56c41142df
>
> cheers
>
