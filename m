Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNh6b29tzzDrhS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 18:11:02 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g202so785527pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 01:11:02 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com
Subject: XZ compressed zImage support
Date: Tue, 30 Aug 2016 18:10:30 +1000
Message-Id: <1472544636-7837-1-git-send-email-oohall@gmail.com>
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
