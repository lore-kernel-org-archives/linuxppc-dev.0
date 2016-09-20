Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdVCW3gVxzDsff
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 14:29:42 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id n24so332650pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 21:29:42 -0700 (PDT)
Received: from canetoad.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h67sm46153521pfg.32.2016.09.19.21.29.39
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Sep 2016 21:29:40 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [v2] XZ compressed zImage support
Date: Tue, 20 Sep 2016 14:29:18 +1000
Message-Id: <1474345764-28038-1-git-send-email-oohall@gmail.com>
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
---
