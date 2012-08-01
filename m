Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id BAF902C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 11:37:24 +1000 (EST)
Message-ID: <5018897E.4040109@cn.fujitsu.com>
Date: Wed, 01 Aug 2012 09:42:22 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: gerald.schaefer@de.ibm.com
Subject: Re: [RFC PATCH v5 12/19] memory-hotplug: introduce new function
 arch_remove_memory()
References: <50126B83.3050201@cn.fujitsu.com>	<50126E2F.8010301@cn.fujitsu.com>	<20120730102305.GB3631@osiris.boeblingen.de.ibm.com>	<50166379.4090305@cn.fujitsu.com>
 <20120731144000.33fd4a0a@thinkpad>
In-Reply-To: <20120731144000.33fd4a0a@thinkpad>
Content-Type: text/plain; charset=UTF-8
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 07/31/2012 08:40 PM, Gerald Schaefer Wrote:
> On Mon, 30 Jul 2012 18:35:37 +0800
> Wen Congyang <wency@cn.fujitsu.com> wrote:
>=20
>> At 07/30/2012 06:23 PM, Heiko Carstens Wrote:
>>> On Fri, Jul 27, 2012 at 06:32:15PM +0800, Wen Congyang wrote:
>>>> We don't call =5F=5Fadd=5Fpages() directly in the function add=5Fmemor=
y()
>>>> because some other architecture related things need to be done
>>>> before or after calling =5F=5Fadd=5Fpages(). So we should introduce
>>>> a new function arch=5Fremove=5Fmemory() to revert the things
>>>> done in arch=5Fadd=5Fmemory().
>>>>
>>>> Note: the function for s390 is not implemented(I don't know how to
>>>> implement it for s390).
>>>
>>> There is no hardware or firmware interface which could trigger a
>>> hot memory remove on s390. So there is nothing that needs to be
>>> implemented.
>>
>> Thanks for providing this information.
>>
>> According to this, arch=5Fremove=5Fmemory() for s390 can just return
>> -EBUSY.
>=20
> Yes, but there is a prototype mismatch for arch=5Fremove=5Fmemory() on s3=
90
> and also other architectures (u64 vs. unsigned long).
>=20
> arch/s390/mm/init.c:262: error: conflicting types for
> =E2=80=98arch=5Fremove=5Fmemory=E2=80=99 include/linux/memory=5Fhotplug.h=
:88: error: previous
> declaration of =E2=80=98arch=5Fremove=5Fmemory=E2=80=99 was here
>=20
> In memory=5Fhotplug.h you have:
> extern int arch=5Fremove=5Fmemory(unsigned long start, unsigned long size=
);
>=20
> On all archs other than x86 you have:
> int arch=5Fremove=5Fmemory(u64 start, u64 size)

Thanks for pointing it out. I will fix it.

Wen Congyang

>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

=
