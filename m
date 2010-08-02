Return-Path: <tmb@mandriva.org>
Received: from mail.yrkesakademin.fi (mail.yrkesakademin.fi [85.134.44.20])
	by ozlabs.org (Postfix) with ESMTP id D2CB21007DC
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 18:56:44 +1000 (EST)
Message-ID: <4C5686FF.9010803@mandriva.org>
Date: Mon, 2 Aug 2010 11:51:11 +0300
From: Thomas Backlund <tmb@mandriva.org>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: make 3.82 fails on powerpc defconfig update [was: Linux 2.6.35]
References: <AANLkTim8FALeVG+NPLNLEQChu=dPD=GHSpnxmZHYgsNx@mail.gmail.com>
In-Reply-To: <AANLkTim8FALeVG+NPLNLEQChu=dPD=GHSpnxmZHYgsNx@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@ozlabs.org, bug-make@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
(please cc me as I'm not subscribed)

updating from make 3.81 to 3.82 gets me this:

[thomas@tmb linux-2.6.35]$ cp arch/powerpc/configs/ppc64_defconfig .config
[thomas@tmb linux-2.6.35]$ LC_ALL=C make oldconfig ARCH=powerpc
/mnt/work/2.6.35/linux-2.6.35/arch/powerpc/Makefile:183: *** mixed 
implicit and normal rules.  Stop.

The lines are:

182:
183: $(BOOT_TARGETS): vmlinux
184:         $(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst 
%,$(boot)/%,$@)
185:

BOOT_TARGETS are defined on line 166 as:
BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage% treeImage.% 
cuImage.% simpleImage.%


Now it's not a regression in the kernel as the same happends with the 
2.6.34 tree too.

(btw, the host I'm syncing the defconfig with is a x86_64 machine)


Now, I dont know if this is "intended breakage" by the make update, or 
if the Makefile needs to be updated....

Any ideas how to fix ?

--
Thomas
