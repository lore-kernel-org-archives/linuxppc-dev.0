Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rb5Fl3w4wzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 01:38:02 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NFY12Q119475
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:38:00 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q6ynfr8y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:38:00 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 12:37:57 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 38DD01DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:37:48 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5NFbt6T16580906
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 12:37:55 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5NFbtSS017673
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 12:37:55 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Thu, 23 Jun 2016 12:37:49 -0300
In-Reply-To: <2090497645.1524307.1466660647378.JavaMail.zimbra@redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160623023052.GB12575@dhcp-128-11.nay.redhat.com>
 <2090497645.1524307.1466660647378.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <4923900.bfxGnX6mM2@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 23 Juni 2016, 01:44:07 schrieb Dave Young:
> Hmm, hold on. For declaring a struct in a header file, comment should be
> just after each fields, like below, your format is for a function instead:
> struct pci_slot {
>         struct pci_bus *bus;            /* The bus this slot is on */
>         struct list_head list;          /* node in list of slots on this
> bus */ struct hotplug_slot *hotplug;   /* Hotplug info (migrate over
> time) */ unsigned char number;           /* PCI_SLOT(pci_dev->devfn) */
> struct kobject kobj;
> };

The comment style you mention above is not extractable documentation. The 
style I used is what is described in section "kernel-doc for structs, 
unions, enums, and typedefs" in Documentation/kernel-doc-nano-HOWTO.txt.
 
> BTW, what is @size? there's no size field in kexec_buf. I think it is not
> necessary to add these comment, they are easy to understand. If you really
> want, please rewrite them correctly, for example "image" description is
> wrong. It is not only for searching memory only, top_down description is
> also bad.

Sorry, I moved these comments from kexec_locate_mem_hole but forgot to 
rename the parameters to what they are called in struct kexec_buf. @size 
should have been @memsz (other fields also have wrong names, I'll fix them 
as well). The image description is correct in the context of where struct 
kexec_buf is used and explains what it will be used for in the function 
taking kexec_buf as an argument. It is not meant as a general description of 
the purpose of struct kimage. What is bad about the description of top_down?

I decided to add these comments because struct kexec_buf is now part of the 
kernel API for kexec. kernel-doc-nano-HOWTO.txt says:

> We definitely need kernel-doc formatted documentation for functions
> that are exported to loadable modules using EXPORT_SYMBOL.
> 
> We also look to provide kernel-doc formatted documentation for
> functions externally visible to other kernel files (not marked
> "static").
> 
> We also recommend providing kernel-doc formatted documentation
> for private (file "static") routines, for consistency of kernel
> source code layout.  But this is lower priority and at the
> discretion of the MAINTAINER of that kernel source file.

If you think they are not necessary or just add clutter I can leave them 
out.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
