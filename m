Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMl5J6Z84zDvMJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 21:21:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc/xmon: Add support for dump in reverse
In-Reply-To: <044f9dc1-c2aa-9798-f5ca-5bfb4796ef42@gmail.com>
References: <201611181011.JmH0m3H9%fengguang.wu@intel.com>
 <044f9dc1-c2aa-9798-f5ca-5bfb4796ef42@gmail.com>
Date: Mon, 21 Nov 2016 21:21:55 +1100
Message-ID: <87eg25w2t8.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On 18/11/16 13:02, kbuild test robot wrote:
>> Hi Balbir,
>> 
>> [auto build test ERROR on powerpc/next]
>> [also build test ERROR on v4.9-rc5 next-20161117]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>> 
>> url:    https://github.com/0day-ci/linux/commits/Balbir-Singh/powerpc-xmon-Add-support-for-dump-in-reverse/20161118-081358
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
>> config: powerpc-ppc64e_defconfig (attached as .config)
>> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=powerpc 
>> 
>> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
>> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>> 
>> All errors (new ones prefixed by >>):
>> 
>>    arch/powerpc/xmon/xmon.c: In function 'prdump':
>>>> arch/powerpc/xmon/xmon.c:2431:10: error: 'idx' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>          idx -= 2;
>>          ~~~~^~~~
>>    cc1: all warnings being treated as errors
>> 
>> vim +/idx +2431 arch/powerpc/xmon/xmon.c
>> 
>>   2425				}
>>   2426	
>>   2427				if (m < nr) {
>>   2428					if (reverse) {
>>   2429						buf[idx + 1] = digithex(temp[m] % 16);
>>   2430						buf[idx] = digithex(temp[m] / 16);
>>> 2431						idx -= 2;
>>   2432					} else
>>   2433						printf("%.2x", temp[m]);
>>   2434				} else
>> 
>
> This seems like a false positive, I don't see it with gcc 5.3.1 on my system. I also tried with gcc 6.2.0
> I tried with the same config as attached with the email in the reported failure. I'll try to get the debian
> 6.1.1 compiler and see how that goes.

Actually I want you to rework the patch anyway :)

Will talk tomorrow.

cheers
