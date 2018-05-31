Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xN9l1Sj7zDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 19:55:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/8] Remove unneccessary included headers
In-Reply-To: <cover.1527697995.git.christophe.leroy@c-s.fr>
References: <cover.1527697995.git.christophe.leroy@c-s.fr>
Date: Thu, 31 May 2018 19:55:03 +1000
Message-ID: <87bmcwywso.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to limit the number of includes to
> only the necessary ones in order to reduce the number of files
> recompiled everytime a header file is modified.
>
> This is the start of the work, please provide feedback if any so
> that I don't go in the wrong direction.

Thanks for starting on this.

There's a few build errors, summary below.

  http://kisskb.ellerman.id.au/kisskb/head/14031/

cheers

arch/powerpc/kernel/machine_kexec.c:140:26: error: 'KDUMP_KERNELBASE' undeclared (first use in this function):
  corenet32_smp_defconfig powerpc
  corenet32_smp_defconfig powerpc-5.3
  g5_defconfig powerpc
  g5_defconfig powerpc-5.3
  gamecube_defconfig powerpc
  gamecube_defconfig powerpc-5.3
  maple_defconfig powerpc
  maple_defconfig powerpc-5.3
  mpc85xx_defconfig powerpc
  mpc85xx_defconfig powerpc-5.3
  mpc85xx_smp_defconfig powerpc
  mpc85xx_smp_defconfig powerpc-5.3
  mpc86xx_defconfig powerpc
  mpc86xx_defconfig powerpc-5.3
  powernv_defconfig+NO_NUMA ppc64le
  powernv_defconfig+NO_PERF ppc64le
  powernv_defconfig+NO_RADIX ppc64le
  powernv_defconfig+STRICT_RWX ppc64le
  powernv_defconfig+THIN ppc64le
  powerpc-randconfig powerpc-5.3
  ppc64e_defconfig+KEXEC powerpc
  ppc64e_defconfig+KEXEC powerpc-5.3
  ps3_defconfig powerpc
  ps3_defconfig powerpc-5.3
  pseries_defconfig powerpc
  pseries_defconfig powerpc-5.3
  pseries_defconfig+NO_MEMORY_HOTPLUG powerpc
  pseries_defconfig+NO_MEMORY_HOTPLUG powerpc-5.3
  pseries_defconfig+NO_MEMORY_HOTREMOVE powerpc
  pseries_defconfig+NO_SPLPAR powerpc
  pseries_defconfig+NO_SPLPAR powerpc-5.3
  pseries_le_defconfig ppc64le
  pseries_le_defconfig+NO_NUMA ppc64le
  pseries_le_defconfig+NO_SPLPAR ppc64le
  skiroot_defconfig ppc64le
  wii_defconfig powerpc
  wii_defconfig powerpc-5.3

arch/powerpc/include/asm/cputable.h:146:23: error: implicit declaration of function 'ASM_CONST' [-Werror=implicit-function-declaration]:
  amigaone_defconfig powerpc-5.3
  corenet_basic_defconfig powerpc-5.3
  holly_defconfig powerpc-5.3
  mpc85xx_basic_defconfig powerpc-5.3
  pmac32_defconfig powerpc-5.3
  pmac32_defconfig+KVM powerpc-5.3
  pmac32_defconfig+kexec powerpc-5.3

arch/powerpc/include/asm/cputable.h:538:6: error: enumerator value for 'CPU_FTRS_POSSIBLE' is not an integer constant:
  44x/akebono_defconfig powerpc
  44x/akebono_defconfig powerpc-5.3
  44x/currituck_defconfig powerpc
  44x/currituck_defconfig powerpc-5.3
  amigaone_defconfig powerpc
  amigaone_defconfig powerpc-5.3
  chrp32_defconfig powerpc
  chrp32_defconfig powerpc-5.3
  corenet_basic_defconfig powerpc
  corenet_basic_defconfig powerpc-5.3
  holly_defconfig powerpc
  holly_defconfig powerpc-5.3
  mpc85xx_basic_defconfig powerpc
  mpc85xx_basic_defconfig powerpc-5.3
  pmac32_defconfig powerpc
  pmac32_defconfig powerpc-5.3
  pmac32_defconfig+KVM powerpc
  pmac32_defconfig+KVM powerpc-5.3
  pmac32_defconfig+SMP powerpc
  pmac32_defconfig+SMP powerpc-5.3
  pmac32_defconfig+kexec powerpc
  pmac32_defconfig+kexec powerpc-5.3
  ppc6xx_defconfig powerpc
  ppc6xx_defconfig powerpc-5.3

arch/powerpc/include/asm/cputable.h:614:6: error: enumerator value for 'CPU_FTRS_ALWAYS' is not an integer constant:
  44x/akebono_defconfig powerpc
  44x/akebono_defconfig powerpc-5.3
  44x/currituck_defconfig powerpc
  44x/currituck_defconfig powerpc-5.3
  amigaone_defconfig powerpc
  amigaone_defconfig powerpc-5.3
  chrp32_defconfig powerpc
  chrp32_defconfig powerpc-5.3
  corenet_basic_defconfig powerpc
  corenet_basic_defconfig powerpc-5.3
  holly_defconfig powerpc
  holly_defconfig powerpc-5.3
  mpc85xx_basic_defconfig powerpc
  mpc85xx_basic_defconfig powerpc-5.3
  pmac32_defconfig powerpc
  pmac32_defconfig powerpc-5.3
  pmac32_defconfig+KVM powerpc
  pmac32_defconfig+KVM powerpc-5.3
  pmac32_defconfig+SMP powerpc
  pmac32_defconfig+SMP powerpc-5.3
  pmac32_defconfig+kexec powerpc
  pmac32_defconfig+kexec powerpc-5.3
  ppc6xx_defconfig powerpc
  ppc6xx_defconfig powerpc-5.3

arch/powerpc/include/asm/cputable.h:505:6: error: implicit declaration of function 'ASM_CONST' [-Werror=implicit-function-declaration]:
  amigaone_defconfig powerpc
  chrp32_defconfig powerpc
  corenet_basic_defconfig powerpc
  holly_defconfig powerpc
  mpc85xx_basic_defconfig powerpc
  pmac32_defconfig powerpc
  pmac32_defconfig+KVM powerpc
  pmac32_defconfig+SMP powerpc
  pmac32_defconfig+kexec powerpc
  ppc6xx_defconfig powerpc

arch/powerpc/kernel/machine_kexec.c:155:22: error: 'KDUMP_KERNELBASE' undeclared (first use in this function):
  44x/fsp2_defconfig powerpc-5.3

arch/powerpc/include/asm/cputable.h:158:32: error: implicit declaration of function 'ASM_CONST' [-Werror=implicit-function-declaration]:
  44x/akebono_defconfig powerpc-5.3
  44x/currituck_defconfig powerpc-5.3
  chrp32_defconfig powerpc-5.3
  pmac32_defconfig+SMP powerpc-5.3
  ppc6xx_defconfig powerpc-5.3

arch/powerpc/include/asm/cputable.h:515:6: error: implicit declaration of function 'ASM_CONST' [-Werror=implicit-function-declaration]:
  44x/akebono_defconfig powerpc
  44x/currituck_defconfig powerpc
