Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x22e.google.com (mail-vc0-x22e.google.com
 [IPv6:2607:f8b0:400c:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5677B1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 17:33:36 +1100 (AEDT)
Received: by mail-vc0-f174.google.com with SMTP id la4so13946395vcb.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 23:33:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55079D05.8020302@hurleysoftware.com>
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
 <1426493810.4716.0.camel@ellerman.id.au>
 <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
 <1426548151.31646.4.camel@ellerman.id.au>
 <CAJhHMCDCoo7g5WrXKPEbemoChQn6BGZOXD00z4kZqVE5boEBhA@mail.gmail.com>
 <55079859.1020205@hurleysoftware.com>
 <CAJhHMCBzFfKxubMLkrSwCwqs5q494-kD2=a_n+tGHXAp6qgXDg@mail.gmail.com>
 <55079D05.8020302@hurleysoftware.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 17 Mar 2015 02:33:03 -0400
Message-ID: <CAJhHMCDNRCUY-H_DzrDf+9LYZOiiEVLW_f7ygp6mRKx-ho7OeA@mail.gmail.com>
Subject: Re: linux panic on 4.0.0-rc4
To: Peter Hurley <peter@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 16, 2015 at 11:18 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/16/2015 11:12 PM, Pranith Kumar wrote:
>> On Mon, Mar 16, 2015 at 10:58 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>> What is your init?
>>>>
>>>> I am using systemd from debian unstable.
>>>
>>> Do you have a stdout-path property defined in your dts to a serial
>>> console you're not actually using?
>>>
>>
>> I am using tty0 as my console. From the config which I posted, it has:
>>
>> CONFIG_CMDLINE="console=ttyS0,9600 console=tty0"
>>
>> I am not using any device tree file.
>
> Ok; there was some reported breakage on PowerMac wrt to 'stdout-path'
> changes I made, so I thought I'd check if that might have affected
> your setup as well.
>

And the painful slow bisecting did lead to that commit:

Bisecting: 0 revisions left to test after this (roughly 0 steps)
[2fa645cb2703d9b3786d850db815414dfeefa51d] of: Fix premature
bootconsole disable with 'stdout-path'

$ git show 2fa645cb2703d9b3786d850db815414dfeefa51d
commit 2fa645cb2703d9b3786d850db815414dfeefa51d
Author: Peter Hurley <peter@hurleysoftware.com>
Date:   Sun Mar 1 12:21:22 2015 -0500

    of: Fix premature bootconsole disable with 'stdout-path'

    Support for devicetree serial consoles via 'stdout-path' causes
    bootconsoles to be disabled when the vt dummy console loads, since
    there is no preferred console (the preferred console is not added
    until the device is probed).

    Ensure there is at least a preferred console, even if never matched.


More info:

$ git bisect log
git bisect start
# bad: [06e5801b8cb3fc057d88cb4dc03c0b64b2744cda] Linux 4.0-rc4
git bisect bad 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda
# good: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
git bisect good bfa76d49576599a4b9f9b7a71f23d73d6dcff735
# good: [1a67e256dbd80f47f339c4a88c34deee12489aa0] ARM: mvebu:
ISL12057 rtc chip can now wake up RN102, RN102 and RN2120
git bisect good 1a67e256dbd80f47f339c4a88c34deee12489aa0
# good: [878ba61aa98cbb97a513757800e77613f856a029] Merge tag
'soc-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 878ba61aa98cbb97a513757800e77613f856a029
# good: [18a8d49973667aa016e68826eeb374788b7c63b0] Merge tag
'clk-for-linus-3.20' of
git://git.linaro.org/people/mike.turquette/linux
git bisect good 18a8d49973667aa016e68826eeb374788b7c63b0
# good: [bfda4031621b048ca634abc5f6bce1aa490ac4e5] MAINTAINERS: Add
myself as co-maintainer to the legacy support of the mvebu SoCs
git bisect good bfda4031621b048ca634abc5f6bce1aa490ac4e5
# good: [29191c7f71aa55401c83df60482417d3c511edde] Merge tag
'char-misc-4.0-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 29191c7f71aa55401c83df60482417d3c511edde
# good: [36bef88380037288d5b575ed2029de694533b1ec] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect good 36bef88380037288d5b575ed2029de694533b1ec
# bad: [3d52c5bdbe57e2b45d9cc8da930b9ab42b5198c4] Merge tag
'devicetree-fixes-for-4.0' of
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect bad 3d52c5bdbe57e2b45d9cc8da930b9ab42b5198c4
# good: [91e9134eda82b57952fdbdb0c5990a7a6609ff13] Merge tag
'pci-v4.0-fixes-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect good 91e9134eda82b57952fdbdb0c5990a7a6609ff13
# good: [c202baf017aea0c860e53131bc55bb1af7177e76] Merge branch 'akpm'
(patches from Andrew)
git bisect good c202baf017aea0c860e53131bc55bb1af7177e76
# bad: [649022e08e4798ffb6e9b11c56ee6b2c62465d11] of/unittest: Fix the
wrong expected value in of_selftest_property_string
git bisect bad 649022e08e4798ffb6e9b11c56ee6b2c62465d11
# good: [2c192699a7050ef5bdf1e2cc95fdddfbcf524509] Merge tag
'v4.0-rc3' into HEAD
git bisect good 2c192699a7050ef5bdf1e2cc95fdddfbcf524509
# bad: [d3a891652adb82e1973348c703a597cb54e41dea] of/overlay: Remove
unused variable
git bisect bad d3a891652adb82e1973348c703a597cb54e41dea
# bad: [20aa4d8ae8d2ada8f959364ebc096b8841245456] Documentation: DT:
Renamed of-serial.txt to 8250.txt
git bisect bad 20aa4d8ae8d2ada8f959364ebc096b8841245456

Thanks!
-- 
Pranith
