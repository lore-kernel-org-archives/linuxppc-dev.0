Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::5])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A8E35140079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 22:30:18 +1000 (EST)
Message-ID: <53720AAC.1000100@xenosoft.de>
Date: Tue, 13 May 2014 14:06:04 +0200
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Boot problems with a PA6T board
References: <5366649E.4030102@xenosoft.de> <1399268891.4600.3.camel@concordia>
In-Reply-To: <1399268891.4600.3.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05.05.2014 07:48, Michael Ellerman wrote:
> On Sun, 2014-05-04 at 18:02 +0200, Christian Zigotzky wrote:
>> Hi All,
>>
>> The RC 1, 2, and 3 of the kernel 3.15 don't boot on my PA6T board with a
>> Radeon HD 6870 graphics card.
>>
>> Screenshot:
>> http://forum.hyperion-entertainment.biz/download/file.php?id=1060&mode=view
>>
>> The kernel 3.14 starts without any problems. Has anyone a tip for me,
>> please?
> The line that says "starting cpu hw idx 0... failed" looks a little worrying.
> Do you see that on 3.14 as well?
>
> Otherwise bisection is probably your best bet.
>
> cheers
Hi All,

I have found out which patch is responsible for the boot problems. It's 
patch 9000c17dc0f9c910267d2661225c9d33a227b27e. Link: 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9000c17dc0f9c910267d2661225c9d33a227b27e

Experimental protocol:

git checkout -f 01d8885785a60ae8f4c37b0ed75bdc96d0fc6a44; git clean -fdx 
(from 02/04/14) -> Kernel boots
git checkout -f f1553174a207f68a4ec19d436003097e0a4dc405; git clean -fdx 
(from 03/04/14) -> Kernel boots
git checkout -f d40326f4b9f9617cdfd30f83a2db57d47e9c5bac; git clean -fdx 
(from 04/04/14) -> Kernel boots
git checkout -f 930b440cd8256f3861bdb0a59d26efaadac7941a; git clean -fdx 
(from 05/04/14) -> doesn't boot (rtc error)
git checkout -f 2b3a8fd735f86ebeb2b9d061054003000c36b654; git clean -fdx 
(from 06/04/14) -> doesn't boot (rtc error)
git checkout -f 26c12d93348f0bda0756aff83f4867d9ae58a5a6; git clean -fdx 
(from 07/04/14) -> doesn't boot (rtc error)
git checkout -f a6c8aff022d4d06e4b41455ae9b2a5d3d503bf76; git clean -fdx 
(from 08/04/14) -> Kernel boots
git checkout -f 035328c202d26a824b8632fd3b00635db5aee5a2; git clean -fdx 
(from 08/04/14) -> Kernel boots
git checkout -f 9000c17dc0f9c910267d2661225c9d33a227b27e; git clean -fdx 
(from 08/04/14) powerpc/powernv: Fix endian issues with sensor code
One OPAL call and one device tree property needed byte swapping. -> 
doesn't boot (prom_init)
git checkout -f d3d35d957a9d0733dc51f14b5abc0bff5d3c5f3a; git clean -fdx 
(from 08/04/14) -> doesn't boot (prom_init)
git checkout -f c4586256f0c440bc2bdb29d2cbb915f0ca785d26; git clean -fdx 
(from 09/04/14) -> doesn't boot (prom_init)

I'm not a programmer but what can I do to solve this boot problem?

Cheers,

Christian
