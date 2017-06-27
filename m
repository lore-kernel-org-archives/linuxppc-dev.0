Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x232.google.com (mail-qt0-x232.google.com
 [IPv6:2607:f8b0:400d:c0d::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxf9k5mGjzDr0g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 18:24:58 +1000 (AEST)
Received: by mail-qt0-x232.google.com with SMTP id 32so19018013qtv.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 01:24:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tw32cg7g.fsf@concordia.ellerman.id.au>
References: <201706251311.ys5lToYa%fengguang.wu@intel.com>
 <87tw32cg7g.fsf@concordia.ellerman.id.au>
From: Oliver <oohall@gmail.com>
Date: Tue, 27 Jun 2017 18:24:56 +1000
Message-ID: <CAOSf1CHeBJpvdc0YEH5izWjYtNqjia12-XRTnpPJS+WqW27CUA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] powerpc/mm: Add devmap support for ppc64
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kbuild test robot <lkp@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kbuild-all@01.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 27, 2017 at 12:33 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> kbuild test robot <lkp@intel.com> writes:
>
>> Hi Oliver,
>>
>> [auto build test ERROR on powerpc/next]
>> [also build test ERROR on v4.12-rc6 next-20170623]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Oliver-O-Halloran/mm-x86-Add-ARCH_HAS_ZONE_DEVICE-to-Kconfig/20170625-102522
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
>> config: powerpc-defconfig (attached as .config)
>> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=powerpc
>>
>> All errors (new ones prefixed by >>):
>>
>>    mm/gup.c: In function '__gup_device_huge_pud':
>>>> mm/gup.c:1329:14: error: implicit declaration of function 'pud_pfn' [-Werror=implicit-function-declaration]
>>      fault_pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>>                  ^~~~~~~
>>    cc1: some warnings being treated as errors
>
> The key here is that CONFIG_TRANSPARENT_HUGEPAGE=n.
>
> So this needs to be fixed before I can merge this.
>
> I think the problem is just that pud_pfn() is inside #ifdef
> CONFIG_TRANSPARENT_HUGEPAGE but shouldn't be.

I'm not 100% sold on making pud_pfn() independent of THP. pmd_pfn() is
used a few times in generic code, but the usages are always gated by a
#ifdef CONFIG_TRANSPARENT_HUGEPAGE so I think we should be doing the
same here. I sent a patch[1] yesterday to fix the usage in gup.c, but
I'll do a respin if you want.

Thanks,
Oliver

[1] http://marc.info/?l=linux-mm&m=149845912612363&w=4
