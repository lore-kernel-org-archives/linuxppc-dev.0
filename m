Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZ6HD5NmjzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 11:20:56 +1000 (AEST)
Date: Wed, 22 Jun 2016 09:20:46 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/6] kexec_file: Add buffer hand-over for the next kernel
Message-ID: <20160622012046.GD2938@dhcp-128-65.nay.redhat.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20/16 at 10:44pm, Thiago Jung Bauermann wrote:
> Hello,
> 
> This patch series implements a mechanism which allows the kernel to pass on
> a buffer to the kernel that will be kexec'd. This buffer is passed as a
> segment which is added to the kimage when it is being prepared by
> kexec_file_load.
> 
> How the second kernel is informed of this buffer is architecture-specific.
> On PowerPC, this is done via the device tree, by checking the properties
> /chosen/linux,kexec-handover-buffer-start and
> /chosen/linux,kexec-handover-buffer-end, which is analogous to how the
> kernel finds the initrd.
> 
> This feature was implemented because the Integrity Measurement Architecture
> subsystem needs to preserve its measurement list accross the kexec reboot.
> This is so that IMA can implement trusted boot support on the OpenPower
> platform, because on such systems an intermediary Linux instance running as
> part of the firmware is used to boot the target operating system via kexec.
> Using this mechanism, IMA on this intermediary instance can hand over to the
> target OS the measurements of the components that were used to boot it.

We have CONFIG_KEXEC_VERIFY_SIG, why not verifying the kernel to be
loaded instead?  I feel IMA should rebuild its measurement instead of
passing it to another kernel. Kexec reboot is also a reboot. If we have
to preserve something get from firmware we can do it, but other than
that I think it sounds not a good idea.

> 
> Because there could be additional measurement events between the
> kexec_file_load call and the actual reboot, IMA needs a way to update the
> buffer with those additional events before rebooting. One can minimize
> the interval between the kexec_file_load and the reboot syscalls, but as
> small as it can be, there is always the possibility that the measurement
> list will be out of date at the time of reboot.
> 
> To address this issue, this patch series also introduces kexec_update_segment,
> which allows a reboot notifier to change the contents of the image segment
> during the reboot process.
> 
> There's one patch which makes kimage_load_normal_segment and
> kexec_update_segment share code. It's not much code that they can share
> though, so I'm not sure if it's worth including this patch.
> 
> The last patch is not intended to be merged, it just demonstrates how this
> feature can be used.
> 
> This series applies on top of v2 of the "kexec_file_load implementation
> for PowerPC" patch series at:

The kexec_file_load patches should be addressed first, no?

> 
> http://lists.infradead.org/pipermail/kexec/2016-June/016078.html
> 
> Thiago Jung Bauermann (6):
>   kexec_file: Add buffer hand-over support for the next kernel
>   powerpc: kexec_file: Add buffer hand-over support for the next kernel
>   kexec_file: Allow skipping checksum calculation for some segments.
>   kexec_file: Add mechanism to update kexec segments.
>   kexec: Share logic to copy segment page contents.
>   IMA: Demonstration code for kexec buffer passing.
> 
>  arch/powerpc/include/asm/kexec.h       |   9 ++
>  arch/powerpc/kernel/kexec_elf_64.c     |  50 +++++++-
>  arch/powerpc/kernel/machine_kexec_64.c |  64 ++++++++++
>  arch/x86/kernel/crash.c                |   4 +-
>  arch/x86/kernel/kexec-bzimage64.c      |   6 +-
>  include/linux/ima.h                    |  11 ++
>  include/linux/kexec.h                  |  47 +++++++-
>  kernel/kexec_core.c                    | 205 ++++++++++++++++++++++++++-------
>  kernel/kexec_file.c                    | 102 ++++++++++++++--
>  security/integrity/ima/ima.h           |   5 +
>  security/integrity/ima/ima_init.c      |  26 +++++
>  security/integrity/ima/ima_template.c  |  79 +++++++++++++
>  12 files changed, 547 insertions(+), 61 deletions(-)
> 
> -- 
> 1.9.1
> 

Thanks
Dave
