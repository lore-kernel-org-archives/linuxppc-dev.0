Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slSdr2hZ3zDsj1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 07:39:43 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 29 Sep 2016 16:37:50 -0500
In-Reply-To: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com> (Mimi
 Zohar's message of "Mon, 26 Sep 2016 13:30:19 -0400")
Message-ID: <87y42axu8h.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v5 00/10] ima: carry the measurement list across kexec
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

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

So I just went through the kexec portions of this and I don't see
anything particularly worrying.

I have one thing that I think could be improved, but is not wrong.
Having both receiving and transmitting the ima measurments both under
HAVE_IMA_KEXEC seems wrong.  There may be people who want to receive the
measurment list but don't want to support kexec'ing other kernels or the
other way around.  I can very much see bootloaders that expect they will
be the first kernel to not want to compile in the extra code for
receiving the measurment list.

But again that is a nit, and not a problem.

So for the series, from the kexec point of view.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> These patches can also be found in the next-kexec-restore branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>
> Changelog v5:
> - Included patches from Thiago Bauermann's "kexec buffer handover"
> patch series for carrying the IMA measurement list across kexec.
> - Added CONFIG_HAVE_IMA_KEXEC
> - Renamed functions to variations of ima_kexec_buffer instead of
> variations of kexec_handover_buffer
>
> Changelog v4:
> - Fixed "spinlock bad magic" BUG - reported by Dmitry Vyukov
> - Rebased on Thiago Bauermann's v5 patch set
> - Removed the skip_checksum initialization  
>
> Changelog v3:
> - Cleaned up the code for calculating the requested kexec segment size
> needed for the IMA measurement list, limiting the segment size to half
> of the totalram_pages.
> - Fixed kernel test robot reports as enumerated in the respective
> patch changelog.
>
> Changelog v2:
> - Canonical measurement list support added
> - Redefined the ima_kexec_hdr struct to use well defined sizes
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
>  Documentation/kernel-parameters.txt       |   4 +
>  arch/Kconfig                              |   3 +
>  arch/powerpc/Kconfig                      |   1 +
>  arch/powerpc/include/asm/ima.h            |  29 +++
>  arch/powerpc/include/asm/kexec.h          |  16 +-
>  arch/powerpc/kernel/Makefile              |   4 +
>  arch/powerpc/kernel/ima_kexec.c           | 223 +++++++++++++++++++++++
>  arch/powerpc/kernel/kexec_elf_64.c        |   2 +-
>  arch/powerpc/kernel/machine_kexec_64.c    | 116 ++++++------
>  include/linux/ima.h                       |  12 ++
>  kernel/kexec_file.c                       |   4 +
>  security/integrity/ima/Kconfig            |  12 ++
>  security/integrity/ima/Makefile           |   1 +
>  security/integrity/ima/ima.h              |  31 ++++
>  security/integrity/ima/ima_crypto.c       |   6 +-
>  security/integrity/ima/ima_fs.c           |  30 ++-
>  security/integrity/ima/ima_init.c         |   2 +
>  security/integrity/ima/ima_kexec.c        | 168 +++++++++++++++++
>  security/integrity/ima/ima_main.c         |   1 +
>  security/integrity/ima/ima_queue.c        |  76 +++++++-
>  security/integrity/ima/ima_template.c     | 293 ++++++++++++++++++++++++++++--
>  security/integrity/ima/ima_template_lib.c |   7 +-
>  22 files changed, 952 insertions(+), 89 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/ima.h
>  create mode 100644 arch/powerpc/kernel/ima_kexec.c
>  create mode 100644 security/integrity/ima/ima_kexec.c
