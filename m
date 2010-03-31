Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 5E1A4B7CEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Mar 2010 23:18:26 +1100 (EST)
Date: Wed, 31 Mar 2010 05:18:18 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: kexec for powerpc32
Message-ID: <alpine.DEB.2.01.1003310430570.5493@bogon.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: horms@verge.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[please CC me as I am not subscribed]

Hi,

when building a kernel for powerpc32 (PowerBook6,8 / 7447A) I can select
CONFIG_KEXEC. However, after booting I can't convince kexec (from 
kexec-tools, latest git checkout) to load the kernel:

# /opt/kexec-tools/sbin/kexec -l /boot/2.6/zImage --append="root=/dev/hda6" 
get_memory_ranges(): Unsupported platform
Could not get memory layout

Can anybody comment on wether or not kexec is supported on this platform? 
If not, is this a limitation of kexec-tools or the kernel? If it's the 
latter, can't the option be hidden/disabled in Kconfig for this platform?

Then again, from looking at the Kconfig files, I see that the "74xx" CPU 
is among quite a few CPU types and so PPC_BOOK3S_32 is selected, and then
ALTIVEC selects 6xx which in turn selects PPC_BOOK3S - so, I guess 
!PPC_BOOK3S for KEXEC is not an option here?

Thanks,
Christian.
-- 
BOFH excuse #69:

knot in cables caused data stream to become twisted and kinked
