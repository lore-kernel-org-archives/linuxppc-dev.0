Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDYgK0M6KzDr3R
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 12:52:44 +1000 (AEST)
Date: Wed, 17 Aug 2016 10:52:26 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-ima-devel@lists.sourceforge.net,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
 Petko Manolov <petkan@mip-labs.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 David Laight <David.Laight@ACULAB.COM>,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/6] kexec_file: Add buffer hand-over for the next
 kernel
Message-ID: <20160817025226.GA4638@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> Hello,
> 
> This patch series implements a mechanism which allows the kernel to pass
> on a buffer to the kernel that will be kexec'd. This buffer is passed
> as a segment which is added to the kimage when it is being prepared
> by kexec_file_load.
> 
> How the second kernel is informed of this buffer is architecture-specific.
> On powerpc, this is done via the device tree, by checking
> the properties /chosen/linux,kexec-handover-buffer-start and
> /chosen/linux,kexec-handover-buffer-end, which is analogous to how the
> kernel finds the initrd.
> 
> This is needed because the Integrity Measurement Architecture subsystem
> needs to preserve its measurement list accross the kexec reboot. The
> following patch series for the IMA subsystem uses this feature for that
> purpose:
> 
> https://lists.infradead.org/pipermail/kexec/2016-August/016745.html
> 
> This is so that IMA can implement trusted boot support on the OpenPower
> platform, because on such systems an intermediary Linux instance running
> as part of the firmware is used to boot the target operating system via
> kexec. Using this mechanism, IMA on this intermediary instance can
> hand over to the target OS the measurements of the components that were
> used to boot it.
> 
> Because there could be additional measurement events between the
> kexec_file_load call and the actual reboot, IMA needs a way to update the
> buffer with those additional events before rebooting. One can minimize
> the interval between the kexec_file_load and the reboot syscalls, but as
> small as it can be, there is always the possibility that the measurement
> list will be out of date at the time of reboot.
> 
> To address this issue, this patch series also introduces
> kexec_update_segment, which allows a reboot notifier to change the
> contents of the image segment during the reboot process.
> 
> Patch 5 makes kimage_load_normal_segment and kexec_update_segment share
> code. It's not much code that they can share though, so I'm not sure if
> the result is actually better.
> 
> The last patch is not intended to be merged, it just demonstrates how
> this feature can be used.
> 
> This series applies on top of v5 of the "kexec_file_load implementation
> for PowerPC" patch series (which applies on top of v4.8-rc1):
> 
> https://lists.infradead.org/pipermail/kexec/2016-August/016843.html

I'm trying to review your patches, but seems I can not apply them
cleanly to mainline kernel or v4.8-rc1

Apply the kexec_file_load series failed as below on v4.8-rc1:

Applying: kexec_file: Allow arch-specific memory walking for
kexec_add_buffer
error: patch failed: include/linux/kexec.h:149
error: include/linux/kexec.h: patch does not apply
Patch failed at 0001 kexec_file: Allow arch-specific memory walking for
kexec_add_buffer
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

What is the order of your patch series of the three patchset?

[PATCH v2 0/2] extend kexec_file_load system call
[PATCH v5 00/13] kexec_file_load implementation for PowerPC
[PATCH v2 0/6] kexec_file: Add buffer hand-over for the next kernel

Do they depend on other patches?

Thanks
Dave
