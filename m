Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 196751A0075
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 04:26:42 +1100 (AEDT)
Subject: [P.A. Semi] Does the ethernet interface work on your Electra, Chitra,
 Nemo, and Athena board?
To: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
References: <565AF986.9060106@xenosoft.de>
 <CAOJe8K1911vDjMe9m_1vY6DSGpOk0TmL96Qf1whuNFXxHJesGw@mail.gmail.com>
 <565C1B55.4020207@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <565C8287.7090209@xenosoft.de>
Date: Mon, 30 Nov 2015 18:08:23 +0100
MIME-Version: 1.0
In-Reply-To: <565C1B55.4020207@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I have tested the PA Semi Ethernet with the kernels 4.2.3 and 4.3.0 
today. With the kernel 4.2.3 it works but with the kernel 4.3.0 final it 
doesn't work.

After that I tested some git kernels and release candidates of 4.3.

Kernel 4.3 git from Tue Sep 01, 2015 -> PA Semi Ethernet works
Kernel 4.3 git from Wed Sep 02, 2015 -> PA Semi Ethernet works
Kernel 4.3 git from Thu Sep 03, 2015 -> PA Semi Ethernet works
Kernel 4.3 git from Fri Sep 04, 2015 -> PA Semi Ethernet doesn't work 
(Merge tag 'powerpc-4.3-1': 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff474e8ca8547d09cb82ebab56d4c96f9eea01ce)
Kernel 4.3 git from Sat Sep 05, 2015 -> PA Semi Ethernet doesn't work
Kernel 4.3 git from Mon Sep 07, 2015 -> PA Semi Ethernet doesn't work
Kernel 4.3 git from Wed Sep 09, 2015 -> PA Semi Ethernet doesn't work
Kernel 4.3 git from Fri Sep 11, 2015 -> PA Semi Ethernet doesn't work
Kernel 4.3 RC1 from Sun Sep 13, 2015 -> PA Semi Ethernet doesn't work
Kernel 4.3 RC2 from Mon Sep 21, 2015 -> PA Semi Ethernet doesn't work

The problematic commit must be between Thu Sep 03, 2015 at 09:37 AM (UTC 
+2) and Fri Sep 04, 2015 at 7:38 PM (UTC +2) in the linux git.

Linux git: Between 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?ofs=15500 
and 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?ofs=15200.

Maybe 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff474e8ca8547d09cb82ebab56d4c96f9eea01ce.

Cheers,

Christian

On 30 November 2015 at 10:48 AM, Christian Zigotzky wrote:
> Hi Denis,
>
> Thank you for your answer. Sorry because of my description.
>
> Yes, the driver probe function finds the device.
>
> With kernel 4.4-rc3:
>
> dmesg | grep -i eth0
>
> [ 2.297473] eth0: PA Semi GMAC: intf 5, hw addr 02:00:e0:0a:30:00
>
> dhclient eth0
>
> RTNETLINK answers: Cannot allocate memory
>
> With kernel 4.1.13:
>
> dmesg | grep -i eth0
>
> [ 2.328115] eth0: PA Semi GMAC: intf 5, hw addr 02:00:e0:0a:30:00
> [ 37.130466] eth0: Link is up at 100 Mbps, full duplex.
>
> Cheers,
>
> Christian
>
> On 30 November 2015 at 09:37 AM, Denis Kirjanov wrote:
>> On 11/29/15, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>> Hi All,
>>>
>>> Does the ethernet interface on your Electra, Chitra, Nemo, and Athena
>>> board work with the release candidates of the kernel 4.4? Unfortunately
>>> the P.A. Semi ethernet doesn't work on our Nemo boards with the release
>>> candidates of the kernel 4.4. We have set the following entries in the
>>> kernel config:
>>>
>>> CONFIG_NET_VENDOR_PASEMI=y
>>> CONFIG_PASEMI_MAC=y
>>>
>>> Could you please test the P.A. Semi ethernet on your P.A. Semi boards?
>> It's not clear from your descriptions what is not working. Does the
>> driver probe function find  a device? Does the interface show up in
>> the kernel? Can it send/receive packets?
>>
>> Also please CC netdev.
>>
>> Thanks.
>>
>>> Thanks in advance,
>>>
>>> Christian
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
