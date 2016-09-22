Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfnL72tzPzDsTQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 16:54:55 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id i5so103718pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 23:54:55 -0700 (PDT)
Received: from canetoad.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id i8sm1094314paw.25.2016.09.21.23.54.51
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Sep 2016 23:54:52 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [v3] XZ compressed zImage support
Date: Thu, 22 Sep 2016 16:54:28 +1000
Message-Id: <1474527274-10897-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for using XZ compression in addition to gzip in the
kernel boot wrapper. Currently this is only enabled for 64bit Book3S processors
since it seems that some embedded platforms rely on uBoot (or similar) to
decompress the image rather than having the kernel decompress itself. Enabling
it for other platforms should be fairly straight forward though.

Supporting other compression algorithms (like ARM and x86 do) is possible, but
painful. Each algorithm includes some kernel headers even when the #defines
that are supposed to make them usable in a pre-boot environment are set.
Including kernel headers is an issue because on powerpc  the boot wrapper is
compiled with a different toolchain and possibly for a different target for
backwards compatibility reasons*. This makes it difficult to include kernel
headers since the include paths, etc are not setup for BOOTCC.

This can be worked around by rewriting parts of the each decompressor with sed
scripts, but the rewriting requried is specific to each decompressor.

-oliver

*powermacs have 32bit firmware that cannot directly load a 64bit kernel. A 64
bit big endian kernel has a 32bit wrapper to work around this. On 64bit little
endian we don't have this legacy problem so the wrapper is also 64bit little
endian, but the toolchain issues are still there.

---
Changes from v1:
        fixed some missing dependecies in the Makefile that were causing random
        build breaks.

        Fixed "make clean" so that it would remove the files copied into
        arch/powerpc/boot/ when the wrapper was built.

        previously this series renamed "zlibheader" to "zlibheaders". There were
        consequences.

Changes from v2:
	Adding missing stdint.h and stdbool.h

	Reduced XZ compression level from -9 to -6. Using compression levels
	above -6 requires the decompressor to construct a 64MB dictionary. The
	firmware on some platforms cannot satisfy large allocations (even when
	the memory is physically present) causing decompression failures.
	Luckily using the lower compression level doesn't have much of a
	penalty.
---
