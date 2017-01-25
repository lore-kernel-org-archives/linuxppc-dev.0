Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v80s75P9QzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 10:00:59 +1100 (AEDT)
Date: Thu, 26 Jan 2017 10:00:44 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 rric@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, oprofile-list@lists.sf.net
Subject: gcc trunk fails to build kernel on PowerPC64 due to oprofile warnings
Message-ID: <20170126100044.7e439f72@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

gcc trunk has failed to build PowerPC64 kernels for a month or so. The issue
is in oprofile, which is common code but ends up being sucked into
arch/powerpc and therefore subject to the -Werror applied to arch/powerpc:
=20
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c: In =
function =E2=80=98oprofile_create_stats_files=E2=80=99:
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:2=
5: error: =E2=80=98%d=E2=80=99 directive output may be truncated writing be=
tween 1 and 11 bytes into a region of size 7 [-Werror=3Dformat-truncation=
=3D]
   snprintf(buf, 10, "cpu%d", i);
                         ^~
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:2=
1: note: using the range [1, -2147483648] for directive argument
   snprintf(buf, 10, "cpu%d", i);
                     ^~~~~~~
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:3=
: note: format output between 5 and 15 bytes into a destination of size 10
   snprintf(buf, 10, "cpu%d", i);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  LD      crypto/async_tx/built-in.o
  CC      lib/random32.o
cc1: all warnings being treated as errors

Anton
