Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D84F82C0093
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 20:01:53 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Fri, 7 Sep 2012 15:31:48 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q87A1jIc37814402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 15:31:46 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q87A1iDk010905
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 20:01:45 +1000
Message-ID: <5049C5F1.3050301@in.ibm.com>
Date: Fri, 07 Sep 2012 15:31:21 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] [powerpc] Change memory_limit from phys_addr_t
 to unsigned long long
References: <20120821113815.29282.4000.stgit@suzukikp.in.ibm.com>
 <20120821114225.29282.87841.stgit@suzukikp.in.ibm.com>
 <1346981712.2385.30.camel@pasglop>
In-Reply-To: <1346981712.2385.30.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/07/2012 07:05 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-08-21 at 17:12 +0530, Suzuki K. Poulose wrote:
>> There are some device-tree nodes, whose values are of type phys_addr_t.
>> The phys_addr_t is variable sized based on the CONFIG_PHSY_T_64BIT.
>>
>> Change these to a fixed unsigned long long for consistency.
>>
>> This patch does the change only for memory_limit.
>>
>> The following is a list of such variables which need the change:
>>
>>   1) kernel_end, crashk_size - in arch/powerpc/kernel/machine_kexec.c
>>
>>   2) (struct resource *)crashk_res.start - We could export a local static
>>      variable from machine_kexec.c.
>>
>> Changing the above values might break the kexec-tools. So, I will
>> fix kexec-tools first to handle the different sized values and then change
>>   the above.
>>
>> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
>> ---
>
> Breaks the build on some configs (with 32-bit phys_addr_t):

Sorry for that.
>
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/prom.c: In function
> 'early_init_devtree':
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/prom.c:664:25: error:
> comparison of distinct pointer types lacks a cast
>
> I'm fixing that myself this time but please be more careful.
Sure. Thanks Ben for fixing that.

Suzuki
