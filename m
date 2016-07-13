Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqSTF3NBSzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 04:45:52 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DIhrIL028040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:45:49 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24567cgfwn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:45:49 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 15:45:47 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 08C721DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:45:37 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DIjjNN4087956
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:45:45 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DIjiNm015712
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:45:44 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org,
 bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Wed, 13 Jul 2016 15:45:41 -0300
In-Reply-To: <7352796.seiSnHrYPy@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160713094127.GC14522@leverpostej> <7352796.seiSnHrYPy@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2222184.ZN0KkkXgPC@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 13 Juli 2016, 15:13:42 schrieb Arnd Bergmann:
> On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > On Wed, Jul 13, 2016 at 10:01:33AM +0200, Arnd Bergmann wrote:
> > > - kboot/petitboot with all of the user space being part of the trusted
> > > boot> > 
> > >   chain: it would be good to allow these to modify the dtb as needed
> > >   without breaking the trust chain, just like we allow grub or u-boot
> > >   to modify the dtb before passing it to the kernel.
> > 
> > It depends on *what* we need to modify here. We can modify the bootargs
> > and initrd properties as part of the kexec_file_load syscall, so what
> > else would we want to alter?
> 
> I guess petitboot can also just use kexec_load() instead of
> kexec_file_load(), as long as the initramfs containing petitboot is
> trusted by the kernel.

For secure boot, Petitboot needs to use kexec_file_load, because of the 
following two features which the system call enables:

1. only allow loading of signed kernels.
2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
   command line and other boot inputs for the Integrity Measurement
   Architecture subsystem.

Those can't be done with kexec_load.

As for what we need to modify, Petitboot does the following modifications to 
the DTB:

1. Set /chosen/linux,stdout-path based on which console is being used to 
interact with it, as Stewart mentioned in another email.
2. Set display properties on /pciex@n/.../vga@0 in machines with an 
OpenFirmware framebuffer.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
