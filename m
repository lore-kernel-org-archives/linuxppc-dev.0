Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B1C51A05A9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jun 2014 08:34:02 +1000 (EST)
Message-ID: <538A58D4.5090602@xenosoft.de>
Date: Sun, 01 Jun 2014 00:33:56 +0200
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Kernel 3.15: Boot problems with a PA6T board
References: <5366649E.4030102@xenosoft.de>			
 <1399268891.4600.3.camel@concordia> <53720AAC.1000100@xenosoft.de>		
 <1401107166.23096.1.camel@concordia> <53851AFA.5040504@xenosoft.de>	
 <1401251015.5468.5.camel@concordia> <5385A3F4.8070004@xenosoft.de>	
 <5385C7A3.1080508@xenosoft.de> <1401331711.4930.7.camel@concordia>
 <5389AEB6.4030500@xenosoft.de> <5389B686.7070305@xenosoft.de>
In-Reply-To: <5389B686.7070305@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31.05.2014 13:01, Christian Zigotzky wrote:
> On 31.05.2014 12:28, Christian Zigotzky wrote:
>> On 29.05.2014 04:48, Michael Ellerman wrote:
>>> On Wed, 2014-05-28 at 13:25 +0200, Christian Zigotzky wrote:
>>>> On 28.05.2014 10:53, Christian Zigotzky wrote:
>>>>> Hi Michael,
>>>>>
>>>>> Thank you for your answer and thank you for your help. :-)
>>>>>
>>>>> On 28.05.2014 06:23, Michael Ellerman wrote:
>>>>>> On Wed, 2014-05-28 at 01:08 +0200, Christian Zigotzky wrote:
>>>>>>
>>>>>> I'm going to guess that cd427485357c0c4b99f69719251baacf25946e11 is
>>>>>> BAD. Can
>>>>>> you please confirm or deny that?
>>>>> It's not BAD. It boots.
>>> Hmm, interesting.
>>>
>>>>>> If cd42748 is *good*, then you'll need to do a bigger bisect from
>>>>>> d8ff9cd to
>>>>>> 18a1a7a.
>>>> OK :-)
>>>>
>>>> -> git clone
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>>>> linux2-git
>>>> -> git bisect start
>>>> -> git bisect good d8ff9cdf68fd119d491f3de90e1a612afc2f3b2b
>>>> -> git bisect bad 18a1a7a1d862ae0794a0179473d08a414dd49234
>>>>
>>>> Output:
>>>> Bisecting: 5900 revisions left to test after this (roughly 13 steps)
>>>> [cb1595563880a81dab6eab9a5ecb4520d2e76077] Merge tag 'tty-3.15-rc1' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
>>>>
>>>> Unfortunately it doesn't boot. :-(
>>> OK. So you do:
>>>
>>> $ git bisect bad
>>>
>>> And it will pick a new commit for you to test. Repeat that ~13 times 
>>> and you
>>> should have identified the bad commit.
>> OK :-)
>>
>> git bisect bad
>> Bisecting: 2902 revisions left to test after this (roughly 12 steps)
>> [b22f136071b1a797e96b3ee6fb0dc32625bd152e] staging: rtl8821ae: Fix 
>> quoted string split across lines <- Kernel boots :-)
>>
>> What shall I do next?
> OK, I know it: git bisect good
>
> -- Christian
>
git bisect good
Bisecting: 1494 revisions left to test after this (roughly 11 steps)
[3786075b5ebc8c4eaefd9e3ebf72883934fb64b3] Merge tag 'regulator-v3.15' 
of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator <- 
Kernel boots

git bisect good
Bisecting: 797 revisions left to test after this (roughly 10 steps)
[69dd89fd2b9406603d218cab8996cfb232d5b8b9] Merge tag 'asoc-v3.15-4' of 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into 
for-linus <- Kernel boots

git bisect good
Bisecting: 372 revisions left to test after this (roughly 9 steps)
[4b1779c2cf030c68aefe939d946475e4136c1895] Merge tag 'pci-v3.15-changes' 
of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci <- Doesn't boot

git bisect bad
Bisecting: 212 revisions left to test after this (roughly 8 steps)
[45b15d98a96ffdb3c608bdad952f51930c151420] Merge remote-tracking 
branches 'spi/topic/xilinx' and 'spi/topic/xtfpga' into spi-next <- 
Kernel boots

git bisect good
Bisecting: 118 revisions left to test after this (roughly 7 steps)
[91b4adc983d8e9975bc677c2b8395631edf7b92d] Merge branch 'pci/misc' into 
next <- Kernel boots

git bisect good
Bisecting: 41 revisions left to test after this (roughly 6 steps)
[26f31fb936042459d481557a83bda7a3f4d61906] Merge tag 'hwmon-for-linus' 
of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging <- 
Kernel boots

git bisect good
Bisecting: 20 revisions left to test after this (roughly 4 steps)
[e20fa6609a0076def469aeb799b1c25558e70042] PCI: Don't check 
resource_size() in pci_bus_alloc_resource() <- Doesn't boot

git bisect bad
Bisecting: 10 revisions left to test after this (roughly 3 steps)
[cd8a4d3657c3f2cf9ce3780707be1debb8fea6e2] PCI: Check IORESOURCE_UNSET 
before updating BAR <- Doesn't boot

git bisect bad
Bisecting: 4 revisions left to test after this (roughly 2 steps)
[5edb93b89f6cc3089ee283656555e7a9ad36a8a0] resource: Add 
resource_contains() <- Kernel boots

git bisect good
Bisecting: 2 revisions left to test after this (roughly 1 step)
[f44116ae881868ab72274df1eff48fdbde9898af] PCI: Remove 
pci_find_parent_resource() use for allocation <- Doesn't boot

git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[d19cb803a2ff85d1b64b9628e1aec2aa76a9260b] vsprintf: Add support for 
IORESOURCE_UNSET in %pR <- Kernel boots

git bisect good
f44116ae881868ab72274df1eff48fdbde9898af is the first bad commit
commit f44116ae881868ab72274df1eff48fdbde9898af
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Feb 26 11:25:58 2014 -0700

     PCI: Remove pci_find_parent_resource() use for allocation

     If the resource hasn't been allocated yet, 
pci_find_parent_resource() is
     documented as returning the region "where it should be allocated from."
     This is impossible in general because there may be several 
candidates: a
     prefetchable BAR can be put in either a prefetchable or 
non-prefetchable
     window, a transparent bridge may have overlapping positively- and
     subtractively-decoded windows, and a root bus may have several 
windows of
     the same type.

     Allocation should be done by pci_bus_alloc_resource(), which iterates
     through all bus resources and looks for the best match, e.g., one 
with the
     desired prefetchability attributes, and falls back to less-desired
     possibilities.

     The only valid use of pci_find_parent_resource() is to find the 
parent of
     an already-allocated resource so we can claim it via 
request_resource(),
     and all we need for that is a bus region of the correct type that 
contains
     the resource.

     Note that like 8c8def26bfaa ("PCI: allow matching of prefetchable 
resources
     to non-prefetchable windows"), this depends on 
pci_bus_for_each_resource()
     iterating through positively-decoded regions before 
subtractively-decoded
     ones.  We prefer not to return a subtractively-decoded region because
     requesting from it will likely conflict with the overlapping 
positively-
     decoded window (see Launchpad report below).

     Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/424142
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
     CC: Linus Torvalds <torvalds@linux-foundation.org>

:040000 040000 d9f2e04d3a635126a3c42406400b156aea3d2e30 
43278454117307fa7e155fb241b16b1863ea45d0 M    drivers
