Message-ID: <38340BB3.BBB218F3@iname.com>
Date: Thu, 18 Nov 1999 14:22:43 +0000
From: Jim Chapman <jim.chapman@iname.com>
MIME-Version: 1.0
To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
CC: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help on Linux for MPC860
References: <004f01bf31ab$ae8e6740$67f102de@sjzhu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shuangjun Zhu wrote:

> Hello,
>
> How to disable the I-Cache and D-Cache in the kernel for MPC860?
>
> Thanks!
> Shuangjun Zhu

I added a new config option in arch/ppc/config.in called CONFIG_NO_CACHE
and added conditional compilation to arch/ppc/mbxboot/head.S and
arch/ppc/kernel/head.S as follows

In arch/ppc/mbxboot/head.S...

/* Most 8xx boards don't boot up with the I-cache enabled.  Do that
 * now because the decompress runs much faster that way.
 */
        lis     r3, IDC_INVALL@h
        mtspr   IC_CST, r3
#ifndef CONFIG_NO_CACHE
        lis     r3, IDC_ENABLE@h
        mtspr   IC_CST, r3
#endif /* CONFIG_NO_CACHE */

and in arch/ppc/kernel/head.S....

        /* Since the cache is enabled according to the information we
         * just loaded into the TLB, invalidate and enable the caches
here.
         * We should probably check/set other modes....later.
         */
        lis     r8, IDC_INVALL@h
        mtspr   IC_CST, r8
        mtspr   DC_CST, r8
        lis     r8, IDC_ENABLE@h
#ifndef CONFIG_NO_CACHE
        mtspr   IC_CST, r8
#if 0
        mtspr   DC_CST, r8
#else
        /* For a debug option, I left this here to easily enable
         * the write through cache mode
         */
        lis     r8, DC_SFWT@h
        mtspr   DC_CST, r8
        lis     r8, IDC_ENABLE@h
        mtspr   DC_CST, r8
#endif
#endif /* CONFIG_NO_CACHE */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
