Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdZ0K1fHdzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 02:20:01 +1000 (AEST)
Date: Tue, 28 Jun 2016 00:19:48 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Message-ID: <20160627161948.GA5876@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160623023052.GB12575@dhcp-128-11.nay.redhat.com>
 <2090497645.1524307.1466660647378.JavaMail.zimbra@redhat.com>
 <4923900.bfxGnX6mM2@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4923900.bfxGnX6mM2@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/16 at 12:37pm, Thiago Jung Bauermann wrote:
> Am Donnerstag, 23 Juni 2016, 01:44:07 schrieb Dave Young:
> > Hmm, hold on. For declaring a struct in a header file, comment should be
> > just after each fields, like below, your format is for a function instead:
> > struct pci_slot {
> >         struct pci_bus *bus;            /* The bus this slot is on */
> >         struct list_head list;          /* node in list of slots on this
> > bus */ struct hotplug_slot *hotplug;   /* Hotplug info (migrate over
> > time) */ unsigned char number;           /* PCI_SLOT(pci_dev->devfn) */
> > struct kobject kobj;
> > };
> 
> The comment style you mention above is not extractable documentation. The 
> style I used is what is described in section "kernel-doc for structs, 
> unions, enums, and typedefs" in Documentation/kernel-doc-nano-HOWTO.txt.

You are right and I was wrong!

>  
> > BTW, what is @size? there's no size field in kexec_buf. I think it is not
> > necessary to add these comment, they are easy to understand. If you really
> > want, please rewrite them correctly, for example "image" description is
> > wrong. It is not only for searching memory only, top_down description is
> > also bad.
> 
> Sorry, I moved these comments from kexec_locate_mem_hole but forgot to 
> rename the parameters to what they are called in struct kexec_buf. @size 
> should have been @memsz (other fields also have wrong names, I'll fix them 
> as well). The image description is correct in the context of where struct 
> kexec_buf is used and explains what it will be used for in the function 
> taking kexec_buf as an argument. It is not meant as a general description of 
> the purpose of struct kimage. What is bad about the description of top_down?

It is not clear enough to me, I personally think the original one in
source code is better:
/* allocate from top of memory hole */

> 
> I decided to add these comments because struct kexec_buf is now part of the 
> kernel API for kexec. kernel-doc-nano-HOWTO.txt says:
> 
> > We definitely need kernel-doc formatted documentation for functions
> > that are exported to loadable modules using EXPORT_SYMBOL.
> > 
> > We also look to provide kernel-doc formatted documentation for
> > functions externally visible to other kernel files (not marked
> > "static").
> > 
> > We also recommend providing kernel-doc formatted documentation
> > for private (file "static") routines, for consistency of kernel
> > source code layout.  But this is lower priority and at the
> > discretion of the MAINTAINER of that kernel source file.
> 
> If you think they are not necessary or just add clutter I can leave them 
> out.

I'm fine with either way.

THanks
Dave
