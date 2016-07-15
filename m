Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrlRX6yZ5zDr0W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 07:03:49 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6FL3igY120964
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:03:45 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 246k0uvsfv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:03:45 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 15 Jul 2016 18:03:42 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 26D891DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:03:31 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6FL3dCI23331208
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 18:03:39 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6FL3cHY010869
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 18:03:39 -0300
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
 Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Fri, 15 Jul 2016 18:03:35 -0300
In-Reply-To: <3489461.zQnV5C1bXR@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160715134209.GF1041@n2100.armlinux.org.uk> <3489461.zQnV5C1bXR@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1808359.GMbkTHC4O6@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, 15 Juli 2016, 22:26:09 schrieb Arnd Bergmann:
> On Friday, July 15, 2016 2:42:10 PM CEST Russell King - ARM Linux wrote:
> > On other architectures, DT can also contain open-firmware "functions"
> > but I don't think there's much support in the kernel for that - maybe
> > the PPC folk can reply on that point.
> 
> The open firmware runtime interface are shut down by the time we have
> a flattened device tree, so those are not accessible any more. IIRC
> SPARC leaves the open firmware interface live, but it doesn't use
> fdt, so that's not relevant here.
> 
> However, the powerpc specific RTAS runtime services provide a similar
> interface to the UEFI runtime support and allow to call into
> binary code from the kernel, which gets mapped from a physical
> address in the "linux,rtas-base" property in the rtas device node.
> 
> Modifying the /rtas node will definitely give you a backdoor into
> priviledged code, but modifying only /chosen should not let you get
> in through that specific method.

Except that arch/powerpc/kernel/rtas.c looks for any node in the tree called 
"rtas", so it will try to use /chosen/rtas, or /chosen/foo/rtas.

We can forbid subnodes in /chosen in the dtb passed to kexec_file_load, 
though that means userspace can't use the simple-framebuffer binding via 
this mechanism.

We also have to blacklist the device_type and compatible properties in 
/chosen to avoid the problem Mark mentioned.

Still doable, but not ideal. :-/

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
