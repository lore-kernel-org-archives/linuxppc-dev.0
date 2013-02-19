Return-Path: <phileas-fogg@mail.ru>
Received: from smtp49.i.mail.ru (smtp49.i.mail.ru [94.100.177.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6D0422C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 04:40:46 +1100 (EST)
Message-ID: <5123C729.5040607@mail.ru>
Date: Tue, 19 Feb 2013 19:40:41 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Phileas Fogg <phileas-fogg@mail.ru>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru>
In-Reply-To: <1360365046.495584377@f356.mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I could finally find the commit which broke FreeBSD booting in linux-stable.git 
repository.
The Linux 3.4-rc1 seems to have this problem already.

--------------
commit 5375871d432ae9fc581014ac117b96aaee3cd0c7
Merge: b57cb72 dfbc2d7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Mar 21 18:55:10 2012 -0700

     Merge branch 'next' of 
git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc

     Pull powerpc merge from Benjamin Herrenschmidt:
      "Here's the powerpc batch for this merge window.  It is going to be a
       bit more nasty than usual as in touching things outside of
       arch/powerpc mostly due to the big iSeriesectomy :-) We finally got
       rid of the bugger (legacy iSeries support) which was a PITA to
       maintain and that nobody really used anymore.

       Here are some of the highlights:

        - Legacy iSeries is gone.  Thanks Stephen ! There's still some bits
          and pieces remaining if you do a grep -ir series arch/powerpc but
          they are harmless and will be removed in the next few weeks
          hopefully.

        - The 'fadump' functionality (Firmware Assisted Dump) replaces the
          previous (equivalent) "pHyp assisted dump"...  it's a rewrite of a
          mechanism to get the hypervisor to do crash dumps on pSeries, the
          new implementation hopefully being much more reliable.  Thanks
          Mahesh Salgaonkar.

        - The "EEH" code (pSeries PCI error handling & recovery) got a big
          spring cleaning, motivated by the need to be able to implement a
          new backend for it on top of some new different type of firwmare.

          The work isn't complete yet, but a good chunk of the cleanups is
          there.  Note that this adds a field to struct device_node which is
          not very nice and which Grant objects to.  I will have a patch soon
          that moves that to a powerpc private data structure (hopefully
          before rc1) and we'll improve things further later on (hopefully
          getting rid of the need for that pointer completely).  Thanks Gavin
          Shan.

        - I dug into our exception & interrupt handling code to improve the
          way we do lazy interrupt handling (and make it work properly with
          "edge" triggered interrupt sources), and while at it found & fixed
          a wagon of issues in those areas, including adding support for page
          fault retry & fatal signals on page faults.

        - Your usual random batch of small fixes & updates, including a bunch
          of new embedded boards, both Freescale and APM based ones, etc..."

     I fixed up some conflicts with the generalized irq-domain changes from
     Grant Likely, hopefully correctly.

     * 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc: 
(141 commits)
       powerpc/ps3: Do not adjust the wrapper load address
       powerpc: Remove the rest of the legacy iSeries include files
       powerpc: Remove the remaining CONFIG_PPC_ISERIES pieces
       init: Remove CONFIG_PPC_ISERIES
       powerpc: Remove FW_FEATURE ISERIES from arch code
       tty/hvc_vio: FW_FEATURE_ISERIES is no longer selectable
       powerpc/spufs: Fix double unlocks
       powerpc/5200: convert mpc5200 to use of_platform_populate()
       powerpc/mpc5200: add options to mpc5200_defconfig
       powerpc/mpc52xx: add a4m072 board support
       powerpc/mpc5200: update mpc5200_defconfig to fit for charon board
       Documentation/powerpc/mpc52xx.txt: Checkpatch cleanup
       powerpc/44x: Add additional device support for APM821xx SoC and Bluestone 
board
       powerpc/44x: Add support PCI-E for APM821xx SoC and Bluestone board
       MAINTAINERS: Update PowerPC 4xx tree
       powerpc/44x: The bug fixed support for APM821xx SoC and Bluestone board
       powerpc: document the FSL MPIC message register binding
       powerpc: add support for MPIC message register API
       powerpc/fsl: Added aliased MSIIR register address to MSI node in dts
       powerpc/85xx: mpc8548cds - add 36-bit dts
       ...
