Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9NrH1FBZzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:04:30 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BN4DAS031718
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:04:28 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9v7dg2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:04:28 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 20:04:25 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 91A723520068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:04:03 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BN4OQr15663544
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 20:04:24 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BN4MJT019197
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 20:04:23 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] extend kexec_file_load system call
Date: Thu, 11 Aug 2016 20:03:56 -0300
Message-Id: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series is from AKASHI Takahiro. I will use it in my next
version of the kexec_file_load implementation for powerpc, so I am
rebasing it on top of v4.8-rc1.

I dropped the patch which adds __NR_kexec_file_load to
<asm-generic/unistd.h> for simplicity, since the powerpc patches already
add it to powerpc's <asm/unistd.h>. I don't know which approach is
better.

The first patch in this series is unchanged from v1.

The second patch is the same one I posted on July 26th. It has the
following changes from v1:

- Added the arch_kexec_verify_buffer hook, where each architecture can
  verify if the DTB is safe to load.
- Renamed KEXEC_FILE_TYPE_DTB to KEXEC_FILE_TYPE_PARTIAL_DTB.
- Limited max number of fds to KEXEC_SEGMENT_MAX.
- Changed to use fixed size buffer for fdset instead of allocating it.
- Changed to return -EINVAL if an unknown file type is found in fdset.

I am also posting a new version of the kexec_file_load syscall
implementation for powerpc which uses the arch_kexec_verify_buffer hook
to enforce a whitelist of nodes and properties that userspace can pass to
the next kernel, as suggested by Michael Ellerman.

You can find it in a new patch in the powerpc series called
"powerpc: Allow userspace to set device tree properties in kexec_file_load"

Original cover letter:

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

AKASHI Takahiro (1):
  kexec: add dtb info to struct kimage

Thiago Jung Bauermann (1):
  kexec: extend kexec_file_load system call

 include/linux/fs.h         |  1 +
 include/linux/kexec.h      | 10 ++++--
 include/linux/syscalls.h   |  4 ++-
 include/uapi/linux/kexec.h | 22 ++++++++++++
 kernel/kexec_file.c        | 86 ++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 114 insertions(+), 9 deletions(-)

-- 
1.9.1
