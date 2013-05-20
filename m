Return-Path: <adam@os.inf.tu-dresden.de>
Received: from os.inf.tu-dresden.de (os.inf.tu-dresden.de
 [IPv6:2002:8d4c:3001:48::99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AF9952C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 01:36:18 +1000 (EST)
Received: from erwin.inf.tu-dresden.de ([141.76.48.80]
 helo=os.inf.tu-dresden.de)
 by os.inf.tu-dresden.de with esmtps (TLSv1:DHE-RSA-AES128-SHA:128) (Exim
 4.80.1) id 1UeRmw-0004im-BX
 for linuxppc-dev@lists.ozlabs.org; Mon, 20 May 2013 17:14:14 +0200
Date: Mon, 20 May 2013 17:14:11 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Build failure with 3.9.3 (Regression 3.9.2->3.9.3)
Message-ID: <20130520151411.GD27420@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

3.9.3 introduced the following build failure:

  CC      arch/powerpc/kernel/rtas.o
arch/powerpc/kernel/rtas.c: In function =E2=80=98rtas_cpu_state_change_mask=
=E2=80=99:
arch/powerpc/kernel/rtas.c:843:4: error: implicit declaration of function =
=E2=80=98cpu_down=E2=80=99 [-Werror=3Dimplicit-function-declaration]
cc1: all warnings being treated as errors
make[1]: *** [arch/powerpc/kernel/rtas.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

My kernel config has CONFIG_HOTPLUG_CPU off, that's why cpu_down is not
defined. Shall CONFIG_HOTPLUG_CPU just be enabled or should the code in
rtas.c be adapted?


Thanks,
Adam
--=20
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
