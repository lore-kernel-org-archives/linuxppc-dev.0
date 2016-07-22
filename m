Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwWHX3RjLzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 10:10:00 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6M08fDB031831
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 20:09:58 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24aeanv3de-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 20:09:57 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 21 Jul 2016 21:09:55 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 3675E352006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 20:09:34 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6M09rfX4481110
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:53 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6M09pmr032165
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:52 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Vivek Goyal <vgoyal@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Thu, 21 Jul 2016 21:09:48 -0300
In-Reply-To: <1808359.GMbkTHC4O6@hactar>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <3489461.zQnV5C1bXR@wuerfel> <1808359.GMbkTHC4O6@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <4197460.etrDupniY8@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, 15 Juli 2016, 18:03:35 schrieb Thiago Jung Bauermann:
> Am Freitag, 15 Juli 2016, 22:26:09 schrieb Arnd Bergmann:
> > However, the powerpc specific RTAS runtime services provide a similar
> > interface to the UEFI runtime support and allow to call into
> > binary code from the kernel, which gets mapped from a physical
> > address in the "linux,rtas-base" property in the rtas device node.
> > 
> > Modifying the /rtas node will definitely give you a backdoor into
> > priviledged code, but modifying only /chosen should not let you get
> > in through that specific method.
> 
> Except that arch/powerpc/kernel/rtas.c looks for any node in the tree
> called "rtas", so it will try to use /chosen/rtas, or /chosen/foo/rtas.
> 
> We can forbid subnodes in /chosen in the dtb passed to kexec_file_load,
> though that means userspace can't use the simple-framebuffer binding via
> this mechanism.
> 
> We also have to blacklist the device_type and compatible properties in
> /chosen to avoid the problem Mark mentioned.
> 
> Still doable, but not ideal. :-/

So even if not ideal, the solution above is desirable for powerpc. We would 
like to preserve the ability of allowing userspace to pass parameters to the 
OS via the DTB, even if secure boot is enabled.

I would like to turn the above into a proposal:

Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
accepting a complete DTB from userspace, the syscall accepts a DTB 
containing only a /chosen node. If the DTB contains any other node, the 
syscall fails with EINVAL. If the DTB contains any subnode in /chosen, or if 
there's a compatible or device_type property in /chosen, the syscall fails 
with EINVAL as well.

The kernel can then add the properties in /chosen to the device tree that it 
will pass to the next kernel.

What do you think?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
