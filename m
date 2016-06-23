Return-Path: <ruyang@redhat.com>
Received: from mx5-phx2.redhat.com (mx5-phx2.redhat.com [209.132.183.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZr560bfYzDqhT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 15:44:41 +1000 (AEST)
Date: Thu, 23 Jun 2016 01:44:07 -0400 (EDT)
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Message-ID: <2090497645.1524307.1466660647378.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160623023052.GB12575@dhcp-128-11.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1466538521-31216-4-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160622101801.GB7752@dhcp-128-65.nay.redhat.com>
 <5025034.R6Ttz76WZM@hactar>
 <20160623023052.GB12575@dhcp-128-11.nay.redhat.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole
 from kexec_add_buffer.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



----- Original Message -----
From: "Dave Young" <dyoung@redhat.com>
To: "Thiago Jung Bauermann" <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric Biederman" <ebiederm@xmission.com>
Sent: Thursday, June 23, 2016 10:30:52 AM
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from kexec_add_buffer.

On 06/22/16 at 08:34pm, Thiago Jung Bauermann wrote:
> Am Mittwoch, 22 Juni 2016, 18:18:01 schrieb Dave Young:
> > On 06/21/16 at 04:48pm, Thiago Jung Bauermann wrote:
> > > +/**
> > > + * kexec_locate_mem_hole - find free memory to load segment or use in
> > > purgatory + * @image:	kexec image being updated.
> > > + * @size:	Memory size.
> > > + * @align:	Minimum alignment needed.
> > > + * @min_addr:	Minimum starting address.
> > > + * @max_addr:	Maximum end address.
> > > + * @top_down	Find the highest free memory region?
> > > + * @addr	On success, will have start address of the memory region
> > > found.
> > > + *
> > > + * Return: 0 on success, negative errno on error.
> > > + */
> > > +int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
> > > +			  unsigned long align, unsigned long min_addr,
> > > +			  unsigned long max_addr, bool top_down,
> > > +			  unsigned long *addr)
> > > +{
> > > +	int ret;
> > > +	struct kexec_buf buf;
> > > +
> > > +	memset(&buf, 0, sizeof(struct kexec_buf));
> > > +	buf.image = image;
> > > +
> > > +	buf.memsz = size;
> > > +	buf.buf_align = align;
> > > +	buf.buf_min = min_addr;
> > > +	buf.buf_max = max_addr;
> > > +	buf.top_down = top_down;
> > 
> > Since patch 2/9 moved kexec_buf from internal header file to kexec.h it
> > will be natural to passing a kexec_buf pointer intead of passing all
> > these arguments in kexec_locate_mem_hole.
> > 
> > kbuf.mem can be used for addr.
> 
> Ok. What about this version?
> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
> 
> Subject: [PATCH 3/9] kexec_file: Factor out kexec_locate_mem_hole from
>  kexec_add_buffer.
> 
> kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
> implementation to find free memory for the purgatory stack.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/kexec.h | 12 +++++++++---
>  kernel/kexec_file.c   | 25 ++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 3d91bcfc180d..e8b099da47f5 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -147,9 +147,14 @@ struct kexec_file_ops {
>  #endif
>  };
>  
> -/*
> - * Keeps track of buffer parameters as provided by caller for requesting
> - * memory placement of buffer.
> +/**
> + * struct kexec_buf - parameters for finding a place for a buffer in memory
> + * @image:	kexec image in which memory to search.
> + * @size:	Memory size for the buffer.
> + * @align:	Minimum alignment needed.
> + * @min_addr:	Minimum starting address.
> + * @max_addr:	Maximum end address.
> + * @top_down:	Find the highest free memory region?

Hmm, hold on. For declaring a struct in a header file, comment should be
just after each fields, like below, your format is for a function instead:
struct pci_slot {
        struct pci_bus *bus;            /* The bus this slot is on */
        struct list_head list;          /* node in list of slots on this bus */
        struct hotplug_slot *hotplug;   /* Hotplug info (migrate over time) */
        unsigned char number;           /* PCI_SLOT(pci_dev->devfn) */
        struct kobject kobj;
};

BTW, what is @size? there's no size field in kexec_buf. I think it is not
necessary to add these comment, they are easy to understand. If you really
want, please rewrite them correctly, for example "image" description is wrong.
It is not only for searching memory only, top_down description is also bad.

Thanks
Dave
