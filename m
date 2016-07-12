Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpnPW32HQzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 02:25:19 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6CGJf82074087
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 12:25:17 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24507b1pgn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 12:25:17 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 13:25:14 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 9DDD11DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 12:25:04 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6CGPC3A14745956
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 13:25:12 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6CGPCma026810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 13:25:12 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, vgoyal@redhat.com,
 dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Tue, 12 Jul 2016 13:25:11 -0300
In-Reply-To: <87furf7ztv.fsf@x220.int.ebiederm.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <50662781.Utjsnse3nb@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Eric,

I'm trying to understand your concerns leading to your nack. I hope you 
don't mind expanding your thoughts on them a bit.

Am Dienstag, 12 Juli 2016, 08:25:48 schrieb Eric W. Biederman:
> AKASHI Takahiro <takahiro.akashi@linaro.org> writes:
> > Device tree blob must be passed to a second kernel on DTB-capable
> > archs, like powerpc and arm64, but the current kernel interface
> > lacks this support.
> > 
> > This patch extends kexec_file_load system call by adding an extra
> > argument to this syscall so that an arbitrary number of file descriptors
> > can be handed out from user space to the kernel.
> > 
> > See the background [1].
> > 
> > Please note that the new interface looks quite similar to the current
> > system call, but that it won't always mean that it provides the "binary
> > compatibility."
> > 
> > [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html
> 
> So this design is wrong.  The kernel already has the device tree blob,
> you should not be extracting it from the kernel munging it, and then
> reinserting it in the kernel if you want signatures and everything to
> pass.

I don't understand how the kernel signature will be invalidated. 

There are some types of boot images that can embed a device tree blob in 
them, but the kernel can also be handed a separate device tree blob from 
firmware, the boot loader, or kexec. This latter case is what we are 
discussing, so we are not talking about modifying an embedded blob in the 
kernel image.

> What x86 does is pass it's equivalent of the device tree blob from one
> kernel to another directly and behind the scenes.  It does not go
> through userspace for this.
> 
> Until a persuasive case can be made for going around the kernel and
> probably adding a feature (like code execution) that can be used to
> defeat the signature scheme I am going to nack this.

I also don't understand what you mean by code execution. How does passing a 
device tree blob via kexec enables code execution? How can the signature 
scheme be defeated?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
