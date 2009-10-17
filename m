Return-Path: <akinobu.mita@gmail.com>
Received: from mail-qy0-f186.google.com (mail-qy0-f186.google.com
	[209.85.221.186]) by ozlabs.org (Postfix) with ESMTP id 03EB0B7043
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 01:43:58 +1100 (EST)
Received: by qyk16 with SMTP id 16so2019682qyk.15
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 07:43:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091017224028V.fujita.tomonori@lab.ntt.co.jp>
References: <20091009164100.85a36188.akpm@linux-foundation.org>
	<20091013021818.GA3898@localhost.localdomain>
	<20091013091017.GA18431@localhost.localdomain>
	<20091017224028V.fujita.tomonori@lab.ntt.co.jp>
Date: Sat, 17 Oct 2009 23:43:56 +0900
Message-ID: <961aa3350910170743n4c9947d1ka0bd31aa1c7b9917@mail.gmail.com>
Subject: Re: [PATCH 2/8] bitmap: Introduce bitmap_set, bitmap_clear,
	bitmap_find_next_zero_area
From: Akinobu Mita <akinobu.mita@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Cc: fenghua.yu@intel.com, gregkh@suse.de, tglx@linutronix.de,
	tony.luck@intel.com, x86@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-altix@sgi.com,
	yevgenyp@mellanox.co.il, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, paulus@samba.org, hpa@zytor.com,
	sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
	akpm@linux-foundation.org, linux-usb@vger.kernel.org,
	davem@davemloft.net, LW@karo-electronics.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/10/17 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>:
> On Tue, 13 Oct 2009 18:10:17 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
>> My user space testing exposed off-by-one error find_next_zero_area
>> in iommu-helper. Some zero area cannot be found by this bug.
>>
>> Subject: [PATCH] Fix off-by-one error in find_next_zero_area
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> ---
>> =A0lib/iommu-helper.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
>> index 75dbda0..afc58bc 100644
>> --- a/lib/iommu-helper.c
>> +++ b/lib/iommu-helper.c
>> @@ -19,7 +19,7 @@ again:
>> =A0 =A0 =A0 index =3D (index + align_mask) & ~align_mask;
>>
>> =A0 =A0 =A0 end =3D index + nr;
>> - =A0 =A0 if (end >=3D size)
>> + =A0 =A0 if (end > size)
>
> I think that this is intentional; the last byte of the limit doesn't
> work.

It looks ok to me. Without above change, find_next_zero_area cannot
find a 64 bits zeroed area in next sample code.

        unsigned long offset;

        DECLARE_BITMAP(map, 64);

        bitmap_clear(map, 0, 64);
        offset =3D find_next_zero_area(map, 64, 0, 64, 0);
        if (offset >=3D 64)
                printf("not found\n");
        else
                printf("found\n");
