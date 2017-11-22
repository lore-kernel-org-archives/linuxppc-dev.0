Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhgt11sY6zDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 22:56:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Josh Boyer <jwboyer@fedoraproject.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, hbabu@us.ibm.com,
 nicholas.piggin@gmail.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 "Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 "kernel-team\@fedoraproject.org" <kernel-team@fedoraproject.org>
Subject: Re: [PATCH v3 10/18] powerpc/vas,
 nx-842: Define and use chip_to_vas_id()
In-Reply-To: <CA+5PVA7k+6kWoD2moFVjM9X=B3fZJxGrM=C6EVw9UtjEYrk6fQ@mail.gmail.com>
References: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1510107838-15181-11-git-send-email-sukadev@linux.vnet.ibm.com>
 <CA+5PVA7k+6kWoD2moFVjM9X=B3fZJxGrM=C6EVw9UtjEYrk6fQ@mail.gmail.com>
Date: Wed, 22 Nov 2017 22:56:56 +1100
Message-ID: <87d14a34s7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh Boyer <jwboyer@fedoraproject.org> writes:

> On Tue, Nov 7, 2017 at 9:23 PM, Sukadev Bhattiprolu
> <sukadev@linux.vnet.ibm.com> wrote:
...
>> diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
>> index abb7090..cd9a733 100644
>> --- a/arch/powerpc/platforms/powernv/vas.c
>> +++ b/arch/powerpc/platforms/powernv/vas.c
>> @@ -123,6 +123,17 @@ struct vas_instance *find_vas_instance(int vasid)
>>         return NULL;
>>  }
>>
>> +int chip_to_vas_id(int chipid)
>> +{
>> +       int cpu;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               if (cpu_to_chip_id(cpu) == chipid)
>> +                       return per_cpu(cpu_vas_id, cpu);
>> +       }
>> +       return -1;
>> +}
>> +
>
> Likely need an EXPORT_SYMBOL here?

Yep.

>> diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
>> index 874ddf5..eb221ed 100644
>> --- a/drivers/crypto/nx/nx-842-powernv.c
>> +++ b/drivers/crypto/nx/nx-842-powernv.c
>
> Did anyone test this driver built as a module with this commit included?

Clearly not.

I build allmodconfig:

  http://kisskb.ellerman.id.au/kisskb/buildresult/13207275/

Which was green.

But that doesn't enable this driver because it depends on PPC_VAS, which
depends on PPC_64K_PAGES, and allmodconfig chooses 4K pages because
that's the default in Kconfig.

I've added a config with allmodconfig + 64K pages to catch this in
future:

  http://kisskb.ellerman.id.au/kisskb/buildresult/13213014/

And we should probably flip 64K pages to be the default for 64-bit
Book3S as well, all contemporary CPUs are designed for it.

cheers
