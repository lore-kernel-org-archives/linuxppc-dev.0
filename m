Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 40B8DDEDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 02:49:16 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1083941anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jul 2008 09:49:14 -0700 (PDT)
Message-ID: <fa686aa40807090949s59af76c7h13ef37bbc5ce125f@mail.gmail.com>
Date: Wed, 9 Jul 2008 10:49:12 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: Please pull linux-2.6-virtex.git
In-Reply-To: <fa686aa40807090857x2d2a3086xe2c1bd81fb23bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080704172240.GE17062@secretlab.ca>
	<1215612904.13186.4.camel@weaponx>
	<fa686aa40807090857x2d2a3086xe2c1bd81fb23bb@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops, missed a fix for the virtex440-ml507.dts file.  Here's a new pull request

The following changes since commit f3e909c2750eb20536bacacc867dc9047b70546a:
  Michael Neuling (1):
        powerpc: Update for VSX core file and ptrace

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-virtex virtex-for-2.6.27

Grant Likely (5):
      powerpc/bootwrapper: Add documentation of boot wrapper targets
      powerpc/bootwrapper: add missing bit of simpleImage target
      powerpc/bootwrapper: Allow user to specify additional default targets
      powerpc/440: Convert Virtex ML507 device tree to dts-v1
      powerpc/440: frequency property should be a cell, not a string

John Linn (5):
      powerpc/virtex: add dts file for ML507 reference design
      powerpc/virtex: Fix booting of Xilinx FPGAs with 16550 for 405 and 440
      powerpc/virtex: add Xilinx Virtex 5 ppc440 platform support
      powerpc/virtex: add Xilinx 440 cpu to the cputable
      powerpc/virtex: add defconfig for virtex 5 platforms

 Documentation/powerpc/bootwrapper.txt      |  141 ++++
 arch/powerpc/Kconfig                       |   13 +
 arch/powerpc/Makefile                      |   15 +-
 arch/powerpc/boot/Makefile                 |    5 +-
 arch/powerpc/boot/dts/virtex440-ml507.dts  |  296 ++++++++
 arch/powerpc/boot/simpleboot.c             |    6 +
 arch/powerpc/boot/virtex.c                 |  100 +++
 arch/powerpc/boot/wrapper                  |   10 +-
 arch/powerpc/configs/44x/virtex5_defconfig | 1107 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c             |   10 +
 arch/powerpc/platforms/44x/Kconfig         |   26 +
 arch/powerpc/platforms/44x/Makefile        |    1 +
 arch/powerpc/platforms/44x/virtex.c        |   60 ++
 13 files changed, 1787 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/powerpc/bootwrapper.txt
 create mode 100644 arch/powerpc/boot/dts/virtex440-ml507.dts
 create mode 100644 arch/powerpc/boot/virtex.c
 create mode 100644 arch/powerpc/configs/44x/virtex5_defconfig
 create mode 100644 arch/powerpc/platforms/44x/virtex.c


On Wed, Jul 9, 2008 at 9:57 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Hey Josh, here is the new pull request:
>
> The following changes since commit f3e909c2750eb20536bacacc867dc9047b70546a:
>  Michael Neuling (1):
>        powerpc: Update for VSX core file and ptrace
>
> are available in the git repository at:
>
>  git://git.secretlab.ca/git/linux-2.6-virtex virtex-for-2.6.27
>
> Grant Likely (4):
>      powerpc/bootwrapper: Add documentation of boot wrapper targets
>      powerpc/bootwrapper: add missing bit of simpleImage target
>      powerpc/bootwrapper: Allow user to specify additional default targets
>      powerpc/440: Convert Virtex ML507 device tree to dts-v1
>
> John Linn (5):
>      powerpc/virtex: add dts file for ML507 reference design
>      powerpc/virtex: Fix booting of Xilinx FPGAs with 16550 for 405 and 440
>      powerpc/virtex: add Xilinx Virtex 5 ppc440 platform support
>      powerpc/virtex: add Xilinx 440 cpu to the cputable
>      powerpc/virtex: add defconfig for virtex 5 platforms
>
>  Documentation/powerpc/bootwrapper.txt      |  141 ++++
>  arch/powerpc/Kconfig                       |   13 +
>  arch/powerpc/Makefile                      |   15 +-
>  arch/powerpc/boot/Makefile                 |    5 +-
>  arch/powerpc/boot/dts/virtex440-ml507.dts  |  296 ++++++++
>  arch/powerpc/boot/simpleboot.c             |    6 +
>  arch/powerpc/boot/virtex.c                 |  100 +++
>  arch/powerpc/boot/wrapper                  |   10 +-
>  arch/powerpc/configs/44x/virtex5_defconfig | 1107 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/cputable.c             |   10 +
>  arch/powerpc/platforms/44x/Kconfig         |   26 +
>  arch/powerpc/platforms/44x/Makefile        |    1 +
>  arch/powerpc/platforms/44x/virtex.c        |   60 ++
>  13 files changed, 1787 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/powerpc/bootwrapper.txt
>  create mode 100644 arch/powerpc/boot/dts/virtex440-ml507.dts
>  create mode 100644 arch/powerpc/boot/virtex.c
>  create mode 100644 arch/powerpc/configs/44x/virtex5_defconfig
>  create mode 100644 arch/powerpc/platforms/44x/virtex.c
>
>
> On Wed, Jul 9, 2008 at 8:15 AM, Josh Boyer <jwboyer@gmail.com> wrote:
>> On Fri, 2008-07-04 at 11:22 -0600, Grant Likely wrote:
>>> Hi Josh,
>>>
>>> Here are the bulk of the Xilinx 440 support patches.  Please pull
>>> into your next branch.
>>>
>>> Thanks,
>>> g.
>>>
>>> The following changes since commit f3e909c2750eb20536bacacc867dc9047b70546a:
>>>   Michael Neuling (1):
>>>         powerpc: Update for VSX core file and ptrace
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.secretlab.ca/git/linux-2.6-virtex virtex-for-2.6.27
>>
>> Any chance to get that updated with the latest fixes before I pull it
>> in?  Namely the DTS file for virtex5, but there might have been others.
>>
>> josh
>>
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
