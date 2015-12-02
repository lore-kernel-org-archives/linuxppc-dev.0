Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x22b.google.com (mail-yk0-x22b.google.com
 [IPv6:2607:f8b0:4002:c07::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D99A1A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 19:54:06 +1100 (AEDT)
Received: by ykdr82 with SMTP id r82so38871118ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Dec 2015 00:54:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <565C8287.7090209@xenosoft.de>
References: <565AF986.9060106@xenosoft.de>
 <CAOJe8K1911vDjMe9m_1vY6DSGpOk0TmL96Qf1whuNFXxHJesGw@mail.gmail.com>
 <565C1B55.4020207@xenosoft.de> <565C8287.7090209@xenosoft.de>
Date: Wed, 2 Dec 2015 11:54:01 +0300
Message-ID: <CAOJe8K1RHDfqSX9v2ksSHUG8H9+CMyo9WFWw-ufimEmdU+mdpA@mail.gmail.com>
Subject: Re: [P.A. Semi] Does the ethernet interface work on your Electra,
 Chitra, Nemo, and Athena board?
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/30/15, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> Hi All,
>
> I have tested the PA Semi Ethernet with the kernels 4.2.3 and 4.3.0
> today. With the kernel 4.2.3 it works but with the kernel 4.3.0 final it
> doesn't work.

Looking at the changes in pasemi I don't see any significant
changes to the driver so the best thing you can try is to bisect the
bad commit.

>
> After that I tested some git kernels and release candidates of 4.3.
>
> Kernel 4.3 git from Tue Sep 01, 2015 -> PA Semi Ethernet works
> Kernel 4.3 git from Wed Sep 02, 2015 -> PA Semi Ethernet works
> Kernel 4.3 git from Thu Sep 03, 2015 -> PA Semi Ethernet works
> Kernel 4.3 git from Fri Sep 04, 2015 -> PA Semi Ethernet doesn't work
> (Merge tag 'powerpc-4.3-1':
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff474e8ca8547d09cb82ebab56d4c96f9eea01ce)
> Kernel 4.3 git from Sat Sep 05, 2015 -> PA Semi Ethernet doesn't work
> Kernel 4.3 git from Mon Sep 07, 2015 -> PA Semi Ethernet doesn't work
> Kernel 4.3 git from Wed Sep 09, 2015 -> PA Semi Ethernet doesn't work
> Kernel 4.3 git from Fri Sep 11, 2015 -> PA Semi Ethernet doesn't work
> Kernel 4.3 RC1 from Sun Sep 13, 2015 -> PA Semi Ethernet doesn't work
> Kernel 4.3 RC2 from Mon Sep 21, 2015 -> PA Semi Ethernet doesn't work
>
> The problematic commit must be between Thu Sep 03, 2015 at 09:37 AM (UTC
> +2) and Fri Sep 04, 2015 at 7:38 PM (UTC +2) in the linux git.
>
> Linux git: Between
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?ofs=15500
>
> and
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?ofs=15200.
>
> Maybe
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff474e8ca8547d09cb82ebab56d4c96f9eea01ce.
>
> Cheers,
>
> Christian
>
> On 30 November 2015 at 10:48 AM, Christian Zigotzky wrote:
>> Hi Denis,
>>
>> Thank you for your answer. Sorry because of my description.
>>
>> Yes, the driver probe function finds the device.
>>
>> With kernel 4.4-rc3:
>>
>> dmesg | grep -i eth0
>>
>> [ 2.297473] eth0: PA Semi GMAC: intf 5, hw addr 02:00:e0:0a:30:00
>>
>> dhclient eth0
>>
>> RTNETLINK answers: Cannot allocate memory
>>
>> With kernel 4.1.13:
>>
>> dmesg | grep -i eth0
>>
>> [ 2.328115] eth0: PA Semi GMAC: intf 5, hw addr 02:00:e0:0a:30:00
>> [ 37.130466] eth0: Link is up at 100 Mbps, full duplex.
>>
>> Cheers,
>>
>> Christian
>>
>> On 30 November 2015 at 09:37 AM, Denis Kirjanov wrote:
>>> On 11/29/15, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>> Hi All,
>>>>
>>>> Does the ethernet interface on your Electra, Chitra, Nemo, and Athena
>>>> board work with the release candidates of the kernel 4.4? Unfortunately
>>>> the P.A. Semi ethernet doesn't work on our Nemo boards with the release
>>>> candidates of the kernel 4.4. We have set the following entries in the
>>>> kernel config:
>>>>
>>>> CONFIG_NET_VENDOR_PASEMI=y
>>>> CONFIG_PASEMI_MAC=y
>>>>
>>>> Could you please test the P.A. Semi ethernet on your P.A. Semi boards?
>>> It's not clear from your descriptions what is not working. Does the
>>> driver probe function find  a device? Does the interface show up in
>>> the kernel? Can it send/receive packets?
>>>
>>> Also please CC netdev.
>>>
>>> Thanks.
>>>
>>>> Thanks in advance,
>>>>
>>>> Christian
>>>> _______________________________________________
>>>> Linuxppc-dev mailing list
>>>> Linuxppc-dev@lists.ozlabs.org
>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>
>
