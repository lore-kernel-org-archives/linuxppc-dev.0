Return-Path: <takahiro.akashi@linaro.org>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpPhk4MvdzDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 11:37:09 +1000 (AEST)
Received: by mail-pa0-x232.google.com with SMTP id hu1so752300pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 18:37:09 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
 bhe@redhat.com, bauerman@linux.vnet.ibm.com, arnd@arndb.de
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 0/3] extend kexec_file_load system call
Date: Tue, 12 Jul 2016 10:41:58 +0900
Message-Id: <20160712014201.11456-1-takahiro.akashi@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Device tree blob must be passed to a second kernel on DTB-capable
archs, like powerpc and arm64, but the current kernel interface
lacks this support.
  
This patch extends kexec_file_load system call by adding an extra
argument to this syscall so that an arbitrary number of file descriptors
can be handed out from user space to the kernel.

See the background [1].

Please note that the new interface looks quite similar to the current
system call, but that it won't always mean that it provides the "binary
compatibility."

[1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html


AKASHI Takahiro (3):
  syscall: add kexec_file_load to generic unistd.h
  kexec: add dtb info to struct kimage
  kexec: extend kexec_file_load system call

 include/linux/fs.h                |  1 +
 include/linux/kexec.h             |  5 +++-
 include/linux/syscalls.h          |  4 ++-
 include/uapi/asm-generic/unistd.h |  8 ++++-
 include/uapi/linux/kexec.h        | 17 +++++++++++
 kernel/kexec_file.c               | 62 ++++++++++++++++++++++++++++++++++-----
 6 files changed, 87 insertions(+), 10 deletions(-)

-- 
2.9.0
