Return-Path: <dmitry.kasatkin@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJs1z2LJ0zDvb8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 04:39:03 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id l20so12014449qta.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:39:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478789780-17719-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1478789780-17719-1-git-send-email-zohar@linux.vnet.ibm.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Wed, 16 Nov 2016 19:38:59 +0200
Message-ID: <CACE9dm9YyRndd27WBbS4ndNk8F6kZuqY9YVLUC-kr1t2nchfvw@mail.gmail.com>
Subject: Re: [PATCHC v7 00/10] ima: carry the measurement list across kexec
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel <linux-ima-devel@lists.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2016 at 4:56 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> [Posting with abbreviated Cc list.]
>
> The TPM PCRs are only reset on a hard reboot.  In order to validate a
> TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> of the running kernel must be saved and then restored on the subsequent
> boot, possibly of a different architecture.
>
> The existing securityfs binary_runtime_measurements file conveniently
> provides a serialized format of the IMA measurement list. This patch
> set serializes the measurement list in this format and restores it.
>
> Up to now, the binary_runtime_measurements was defined as architecture
> native format.  The assumption being that userspace could and would
> handle any architecture conversions.  With the ability of carrying the
> measurement list across kexec, possibly from one architecture to a
> different one, the per boot architecture information is lost and with it
> the ability of recalculating the template digest hash.  To resolve this
> problem, without breaking the existing ABI, this patch set introduces
> the boot command line option "ima_canonical_fmt", which is arbitrarily
> defined as little endian.
>
> The need for this boot command line option will be limited to the
> existing version 1 format of the binary_runtime_measurements.
> Subsequent formats will be defined as canonical format (eg. TPM 2.0
> support for larger digests).
>
> A simplified method of Thiago Bauermann's "kexec buffer handover" patch
> series for carrying the IMA measurement list across kexec is included
> in this patch set.  The simplified method requires all file measurements
> be taken prior to executing the kexec load, as subsequent measurements
> will not be carried across the kexec and restored.
>
> These patches can also be found in the next-kexec-restore branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>
> Changelog v7:
> - Updated to reflect Dmitry Kasatkin's patch review
> - Rebased on top of "next-fixes" branch
>
> Andreas Steffen (1):
>   ima: platform-independent hash value
>
> Mimi Zohar (7):
>   ima: on soft reboot, restore the measurement list
>   ima: permit duplicate measurement list entries
>   ima: maintain memory size needed for serializing the measurement list
>   ima: on soft reboot, save the measurement list
>   ima: store the builtin/custom template definitions in a list
>   ima: support restoring multiple template formats
>   ima: define a canonical binary_runtime_measurements list format
>
> Thiago Jung Bauermann (2):
>   powerpc: ima: Get the kexec buffer passed by the previous kernel
>   powerpc: ima: Send the kexec buffer to the next kernel
>
>  Documentation/kernel-parameters.txt         |   4 +
>  arch/Kconfig                                |   3 +
>  arch/powerpc/Kconfig                        |   1 +
>  arch/powerpc/include/asm/ima.h              |  29 +++
>  arch/powerpc/include/asm/kexec.h            |  15 +-
>  arch/powerpc/kernel/Makefile                |   4 +
>  arch/powerpc/kernel/ima_kexec.c             | 223 +++++++++++++++++++++
>  arch/powerpc/kernel/kexec_elf_64.c          |   2 +-
>  arch/powerpc/kernel/machine_kexec_file_64.c |  15 +-
>  include/linux/ima.h                         |  12 ++
>  kernel/kexec_file.c                         |   4 +
>  security/integrity/ima/Kconfig              |  12 ++
>  security/integrity/ima/Makefile             |   1 +
>  security/integrity/ima/ima.h                |  31 +++
>  security/integrity/ima/ima_crypto.c         |   6 +-
>  security/integrity/ima/ima_fs.c             |  30 ++-
>  security/integrity/ima/ima_init.c           |   2 +
>  security/integrity/ima/ima_kexec.c          | 168 ++++++++++++++++
>  security/integrity/ima/ima_main.c           |   1 +
>  security/integrity/ima/ima_queue.c          |  77 +++++++-
>  security/integrity/ima/ima_template.c       | 297 ++++++++++++++++++++++++++--
>  security/integrity/ima/ima_template_lib.c   |   7 +-
>  22 files changed, 906 insertions(+), 38 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/ima.h
>  create mode 100644 arch/powerpc/kernel/ima_kexec.c
>  create mode 100644 security/integrity/ima/ima_kexec.c
>
> --
> 2.1.0
>

Hi,

Looks good to me.

-- 
Thanks,
Dmitry
