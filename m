Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC3Ds6pVnzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 08:58:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 1/4] powerpc/mm: refactor radix physical page mapping
In-Reply-To: <20170130172802.qvv2wqksxn7bq2sr@arbab-laptop.austin.ibm.com>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-2-git-send-email-arbab@linux.vnet.ibm.com>
 <87o9ypvt6t.fsf@concordia.ellerman.id.au>
 <20170130172802.qvv2wqksxn7bq2sr@arbab-laptop.austin.ibm.com>
Date: Tue, 31 Jan 2017 08:58:36 +1100
Message-ID: <87r33kus4z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> On Mon, Jan 30, 2017 at 07:38:18PM +1100, Michael Ellerman wrote:
>>Doesn't build.
>>
>>In file included from ../include/linux/kernel.h:13:0,
>>                 from ../include/linux/sched.h:17,
>>                 from ../arch/powerpc/mm/pgtable-radix.c:11:
>>../arch/powerpc/mm/pgtable-radix.c: In function =E2=80=98create_physical_=
mapping=E2=80=99:
>>../include/linux/printk.h:299:2: error: =E2=80=98mapping_size=E2=80=99 ma=
y be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>>  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>>  ^~~~~~
>>../arch/powerpc/mm/pgtable-radix.c:123:22: note: =E2=80=98mapping_size=E2=
=80=99 was declared here
>>  unsigned long addr, mapping_size;
>
> Doh. Could you please do the following for now?
>
> -	unsigned long addr, mapping_size;
> +	unsigned long addr, mapping_size =3D 0;

Thanks.

> I'd like to delay spinning v6 with this until I see any input you might=20
> have on the rest of the set.

I don't think I have any at the moment. So I'll just fold the above into
v5.

> And for future reference, how are you ending up with=20
> -Werror=3Dmaybe-uninitialized? On powerpc/next, with pseries_le_defconfig=
,=20
> I get -Wno-maybe-uninitialized.

By default. Probably you're not getting it because your compiler is too
old. If I'm reading Makefile correctly it's enabled for GCC 4.9 or later:

  KBUILD_CFLAGS +=3D $(call cc-ifversion, -lt, 0409, \
  			$(call cc-disable-warning,maybe-uninitialized,))

I'm using GCC 6.2.0.

cheers
