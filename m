Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZQF00ZpGzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 23:20:03 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MDIaPs031604
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 09:20:02 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q6ykyta1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 09:20:02 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 18:49:59 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E056A3940062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 18:49:55 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MDJt8734275512
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 18:49:55 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MDJsYi003817
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 18:49:55 +0530
Subject: Re: [PATCH 0/6] kexec_file: Add buffer hand-over for the next kernel
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Eric Richter
 <erichte@linux.vnet.ibm.com>
Date: Wed, 22 Jun 2016 09:19:48 -0400
In-Reply-To: <20160622012046.GD2938@dhcp-128-65.nay.redhat.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160622012046.GD2938@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1466601588.2650.185.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

On Wed, 2016-06-22 at 09:20 +0800, Dave Young wrote:
> On 06/20/16 at 10:44pm, Thiago Jung Bauermann wrote:
> > Hello,
> > 
> > This patch series implements a mechanism which allows the kernel to pass on
> > a buffer to the kernel that will be kexec'd. This buffer is passed as a
> > segment which is added to the kimage when it is being prepared by
> > kexec_file_load.
> > 
> > How the second kernel is informed of this buffer is architecture-specific.
> > On PowerPC, this is done via the device tree, by checking the properties
> > /chosen/linux,kexec-handover-buffer-start and
> > /chosen/linux,kexec-handover-buffer-end, which is analogous to how the
> > kernel finds the initrd.
> > 
> > This feature was implemented because the Integrity Measurement Architecture
> > subsystem needs to preserve its measurement list accross the kexec reboot.
> > This is so that IMA can implement trusted boot support on the OpenPower
> > platform, because on such systems an intermediary Linux instance running as
> > part of the firmware is used to boot the target operating system via kexec.
> > Using this mechanism, IMA on this intermediary instance can hand over to the
> > target OS the measurements of the components that were used to boot it.
> 
> We have CONFIG_KEXEC_VERIFY_SIG, why not verifying the kernel to be
> loaded instead?  I feel IMA should rebuild its measurement instead of
> passing it to another kernel. Kexec reboot is also a reboot. If we have
> to preserve something get from firmware we can do it, but other than
> that I think it sounds not a good idea.

The signature verification is needed for secure boot.  Carrying the IMA
measurement list across kexec is needed for trusted boot.  In this case,
the boot loader is Linux, which needs to carry the measurements, stored
in memory, across kexec to the target system.

The kernel_read_file_from_fd() calls the pre and post security
kernel_read hooks.  These hooks can verify file signatures, store
measurements in the IMA measurement list and extend the TPM.  To enable
both measuring and appraising (signature verification) of the kernel
image and the initramfs, include the following rules in the IMA policy:

measure func=KEXEC_KERNEL_CHECK
appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig
#
measure func=KEXEC_INITRAMFS_CHECK
appraise func=KEXEC_INITRAMFS_CHECK appraise_type=imasig

Thiago's path set provides the means for carrying the trusted boot
measurements across kexec.

Mimi
