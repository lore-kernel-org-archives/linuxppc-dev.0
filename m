Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrc1c27RyzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 01:29:23 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6FFTF6n062346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 11:29:21 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 246hemens7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 11:29:21 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 15 Jul 2016 12:29:17 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 52A3D352005F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 11:28:57 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6FFTFnm15859968
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 12:29:15 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6FFTEFN014270
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 12:29:14 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>,
 linux-arm-kernel@lists.infradead.org, bhe@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Fri, 15 Jul 2016 12:29:09 -0300
In-Reply-To: <20160715133346.GD19840@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160715132610.GD23514@redhat.com> <20160715133346.GD19840@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1565504.8BCDUlPeYg@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, 15 Juli 2016, 14:33:47 schrieb Mark Rutland:
> On Fri, Jul 15, 2016 at 09:26:10AM -0400, Vivek Goyal wrote:
> > On Fri, Jul 15, 2016 at 09:31:02AM +0200, Arnd Bergmann wrote:
> > > On Thursday, July 14, 2016 10:44:14 PM CEST Thiago Jung Bauermann 
wrote:
> > > > Am Donnerstag, 14 Juli 2016, 10:29:11 schrieb Arnd Bergmann:
> > > > > Right, but the question remains whether this helps while you allow
> > > > > the
> > > > > boot loader to modify the dtb. If an attacker gets in and cannot
> > > > > modify
> > > > > the kernel or initid but can modify the DT, a successful attack
> > > > > would
> > > > > be a bit harder than having a modified kernel, but you may still
> > > > > need
> > > > > to treat the system as compromised.
> > > > 
> > > > Yes, and the same question also remains regarding the kernel command
> > > > line.
> > > > 
> > > > We can have the kernel perform sanity checks on the device tree,
> > > > just as the kernel needs to sanity check the command line.
> > > > 
> > > > There's the point that was raised about not wanting to increase the
> > > > attack surface, and that's a valid point. But at least in the way
> > > > Petitboot works today, it needs to modify the device tree and pass
> > > > it to the kernel.
> > > > 
> > > > One thing that is unavoidable to come from userspace is
> > > > /chosen/linux,stdout-path, because it's Petitboot that knows from
> > > > which
> > > > console the user is interacting with. The other modification to set
> > > > properties in vga@0 can be done in the kernel.
> > > > 
> > > > Given that on DTB-based systems /chosen is an important and
> > > > established way to pass information to the operating system being
> > > > booted, I'd like to suggest the following, then:
> > > > 
> > > > Extend the syscall as shown in this RFC from Takahiro AKASHI, but
> > > > instead of accepting a complete DTB from userspace, the syscall
> > > > would accept a DTB containing only a /chosen node. If the DTB
> > > > contains any other node, the syscall fails with EINVAL. The kernel
> > > > can then add the properties in /chosen to the device tree that it
> > > > will pass to the next kernel.
> > > > 
> > > > What do you think?
> > > 
> > > I think that helps, as it makes the problem space correspond to that
> > > of modifying the command line, but I can still come up with countless
> > > attacks based on modifications of the /chosen node and/or the command
> > > line, in fact it's probably easier than any other node.
> > 
> > I don't know anything about DTB. So here comes a very basic question.
> > Does DTB allow passing an executable blob to kernel or pass the
> > location of some unsigned executable code at kernel level. I think from
> > secureboot point of view that would be a concern. Being able to trick
> > kernel to execute an unsigned code at privileged level.
> 
> The DTB itself won't contain executable code.
> 
> However, arbitrary bindings could point kernel at such code. For
> instance, /chosen/linux,uefi-system-table could point the kernel at a
> faked EFI system table, with pointers to malicious code. So
> arbitrary modification of /chosen is not safe.

PowerPC doesn't have UEFI so this option is not a concern in that 
architecture. I'm having a look at what a PowerPC kernel gets from /chosen 
and haven't found anything of concern so far, but I'm still looking.

On the other hand, the kernel command line has the option acpi_rsdp, which 
is used to pass the address of the RSDP. I don't really know much about EFI 
so I'm not sure if it can be used to point to code that the kernel can 
execute, but it does point to tables that contain AML code.

> Bindings describe arbitrary system features (devices, firmware
> interfaces, etc), so in general they might provide mechanisms to execute
> code.

Even bindings in /chosen?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
