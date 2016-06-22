Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZVYd52NGzDqvy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 02:34:45 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MGXveD058769
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:34:43 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23qaeexr92-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:34:43 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 13:34:41 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 13F7A3520068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:34:22 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MGYcLf33816902
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 13:34:38 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MGYbtA027214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 13:34:38 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/6] kexec_file: Add buffer hand-over for the next kernel
Date: Wed, 22 Jun 2016 13:34:36 -0300
In-Reply-To: <20160622012046.GD2938@dhcp-128-65.nay.redhat.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160622012046.GD2938@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2989292.sja9PMOcvE@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Dave,

Thanks for your considerations on this feature.

Am Mittwoch, 22 Juni 2016, 09:20:46 schrieb Dave Young:
> On 06/20/16 at 10:44pm, Thiago Jung Bauermann wrote:
> > This feature was implemented because the Integrity Measurement
> > Architecture subsystem needs to preserve its measurement list accross
> > the kexec reboot. This is so that IMA can implement trusted boot
> > support on the OpenPower platform, because on such systems an
> > intermediary Linux instance running as part of the firmware is used to
> > boot the target operating system via kexec. Using this mechanism, IMA
> > on this intermediary instance can hand over to the target OS the
> > measurements of the components that were used to boot it.
> We have CONFIG_KEXEC_VERIFY_SIG, why not verifying the kernel to be
> loaded instead?  I feel IMA should rebuild its measurement instead of
> passing it to another kernel.

In trusted boot, each stage of the boot process (firmware, boot loader, 
target OS) measures the following stage before passing control to it, and 
records that measurement cumulatively so that the target OS can look back 
and see measurements of all the components that were used from the earliest 
boot stages until the target OS was loaded (including a measurement of the 
OS itself).

If IMA had to rebuild the measurements, it would mean that one stage is 
measuring itself. This violates this design property of the trusted boot 
process (i.e., each boot stage is measured by the one before it) so it's not 
really an option. It has to receive the measurements from the boot stage 
that ran before it.

> Kexec reboot is also a reboot. If we have
> to preserve something get from firmware we can do it, but other than
> that I think it sounds not a good idea.

OpenPower uses a Linux kernel (and initrd with a tiny system image) as a 
boot loader, so in this platform a kexec reboot is not a reboot. It is part 
of the boot process itself as the way of passing control from the boot 
loader to the target OS.

> > This series applies on top of v2 of the "kexec_file_load implementation
> 
> > for PowerPC" patch series at:
> The kexec_file_load patches should be addressed first, no?

Yes. I posted this series for two reasons:

1. The PowerPC maintainer asked why he would want to have the 
kexec_file_load system call, and this feature is one of the reasons. I 
wanted to show that it is not an hypothetical feature, there is a 
functioning implementation.

2. I want to start discussion on this feature with the community early, so 
that I can incorporate feedback and have it ready to be accepted (or closer 
to ready at least) by the time the kexec_file_load patches are accepted.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
