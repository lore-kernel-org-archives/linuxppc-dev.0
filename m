Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKxhv3cQdzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 07:12:46 +1000 (AEST)
Date: Thu, 25 Aug 2016 14:12:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Dave
 Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Baoquan He
 <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Stewart Smith
 <stewart@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Eric
 Richter <erichte@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 0/5] kexec_file: Add buffer hand-over for the next
 kernel
Message-Id: <20160825141243.e8a3f0f864b5d9dee496a1e4@linux-foundation.org>
In-Reply-To: <1472149111-30598-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1472149111-30598-1-git-send-email-bauerman@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 25 Aug 2016 15:18:26 -0300 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:

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
> The last patch is not intended to be merged, it just demonstrates how
> this feature can be used.
> 
> This series applies on top of v6 of the "kexec_file_load implementation
> for PowerPC" patch series (which applies on top of v4.8-rc1):
> 
> https://lists.infradead.org/pipermail/kexec/2016-August/016960.html

I grabbed these two patch series.  I also merged the "IMA:
Demonstration code for kexec buffer passing." demonstration patch just
to get things a bit of testing.  I assume that once the "ima: carry the
measurement list across kexec" series has stabilised, I should drop the
demo patch and also grab those?  If so, pelase start cc'ing me.
