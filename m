Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 1CAD0B7DDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 17:22:28 +1000 (EST)
Message-ID: <4BEA5726.50806@nerdbynature.de>
Date: Wed, 12 May 2010 00:22:14 -0700
From: Christian Kujau <lists@nerdbynature.de>
MIME-Version: 1.0
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
References: <20100511174749.19309.44615.stgit@muvarov>
In-Reply-To: <20100511174749.19309.44615.stgit@muvarov>
Content-Type: text/plain; charset=UTF-8
Cc: kexec@lists.infradead.org, uvarov@dev.rtsoft.ru,
	linuxppc-dev@lists.ozlabs.org, horms@verge.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 11 May 2010 at 21:47, Maxim Uvarov wrote:
> This patch is required in case if you are using new toolchains.

After kexec-tools compiled, I actually tried it:

# kexec -l /boot/2.6/zImage --command-line="root=/dev/hda6 ro"
# echo $?
0
# kexec -e
Starting new kernel
Bye!

....but then the system just hung there, no more messages, I had to
powercycle it.

The --debug options is listed for "dol-ppc" systems (I have a PowerBook
G4, not sure if this falls into this category), when I use it the help
screen of kexec is displayed again and at the bottom:

   Cannot load /boot/2.6/zImage


This is with 2.6.34-rc7 (today's git):

# file /boot/2.6/zImage
/boot/2.6/zImage: ELF 32-bit MSB executable, PowerPC or cisco 4500,
version 1 (SYSV), statically linked, with unknown capability 0x41000000
= 0x11676e75, with unknown capability 0x10000 = 0x90402, not stripped


.config and dmesg: http://nerdbynature.de/bits/2.6.34-rc7/kexec/

Christian.
-- 
make bzImage, not war
