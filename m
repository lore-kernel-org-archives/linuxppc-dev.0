Return-Path: <danielwa@cisco.com>
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqVLl0QpKzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 04:11:10 +1100 (AEDT)
To: "Oliver O'Halloran" <oohall@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 xe-linux-external@cisco.com
From: Daniel Walker <danielwa@cisco.com>
Subject: Build failure -- powerpc/boot: Add OPAL console to epapr wrappers
Message-ID: <1596fddf-b6c0-02cc-cbbd-0f74606206aa@cisco.com>
Date: Fri, 24 Mar 2017 10:00:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I get this build failure,


In file included from arch/powerpc/boot/fdt.c:51:
../arch/powerpc/boot/libfdt_env.h:9: error: redefinition of typedef 
'uint32_t'
../arch/powerpc/boot/types.h:20: note: previous declaration of 
'uint32_t' was here
../arch/powerpc/boot/libfdt_env.h:10: error: redefinition of typedef 
'uint64_t'
../arch/powerpc/boot/types.h:21: note: previous declaration of 
'uint64_t' was here
make[2]: *** [arch/powerpc/boot/fdt.o] Error 1
make[1]: *** [uImage] Error 2
make[1]: Leaving directory `/nobackup/danielwa/linux/t1040'
make: *** [sub-make] Error 2


and it bisects to ,


commit 656ad58ef19e2a763fa5c938b20ae0f6b8d67242
Author: Oliver O'Halloran <oohall@gmail.com>
Date:   Fri Jul 1 00:34:37 2016 +1000

     powerpc/boot: Add OPAL console to epapr wrappers

     This patch adds an OPAL console backend to the powerpc boot wrapper so
     that decompression failures inside the wrapper can be reported to the
     user. This is important since it typically indicates data corruption in
     the firmware and other nasty things.

     Currently this only works when building a little endian kernel. When
     compiling a 64 bit BE kernel the wrapper is always build 32 bit to be
     compatible with some 32 bit firmwares. BE support will be added at a
     later date. Another limitation of this is that only the "raw" type of
     OPAL console is supported, however machines that provide a hvsi console
     also provide a raw console so this is not an issue in practice.

     Actually-written-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
     Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
     [mpe: Move #ifdef __powerpc64__ to avoid warnings on 32-bit]
     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


I can provide a config file if needed. My apologies if this was already 
reported.


Daniel
