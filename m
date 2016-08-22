Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHlQ12qkhzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:22:17 +1000 (AEST)
Date: Mon, 22 Aug 2016 15:22:00 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-ima-devel@lists.sourceforge.net,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
 Petko Manolov <petkan@mip-labs.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 David Laight <David.Laight@aculab.com>,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/6] powerpc: kexec_file: Add buffer hand-over support
 for the next kernel
Message-ID: <20160822072200.GA32673@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1471058305-30198-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160822032135.GB30489@dhcp-128-65.nay.redhat.com>
 <5233171.lLzbU6ABRT@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5233171.lLzbU6ABRT@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/16 at 12:38am, Thiago Jung Bauermann wrote:
> Am Montag, 22 August 2016, 11:21:35 schrieb Dave Young:
> > On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> > > diff --git a/arch/powerpc/kernel/machine_kexec_64.c
> > > b/arch/powerpc/kernel/machine_kexec_64.c index
> > > a484a6346146..190c652e49b7 100644
> > > --- a/arch/powerpc/kernel/machine_kexec_64.c
> > > +++ b/arch/powerpc/kernel/machine_kexec_64.c
> > > @@ -490,6 +490,60 @@ int arch_kimage_file_post_load_cleanup(struct
> > > kimage *image)> 
> > >  	return image->fops->cleanup(image->image_loader_data);
> > >  
> > >  }
> > > 
> > > +bool kexec_can_hand_over_buffer(void)
> > > +{
> > > +	return true;
> > > +}
> > > +
> > > +int arch_kexec_add_handover_buffer(struct kimage *image,
> > > +				   unsigned long load_addr, unsigned long 
> size)
> > > +{
> > > +	image->arch.handover_buffer_addr = load_addr;
> > > +	image->arch.handover_buffer_size = size;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int kexec_get_handover_buffer(void **addr, unsigned long *size)
> > > +{
> > > +	int ret;
> > > +	u64 start_addr, end_addr;
> > > +
> > > +	ret = of_property_read_u64(of_chosen,
> > > +				   "linux,kexec-handover-buffer-start",
> > > +				   &start_addr);
> > > +	if (ret == -EINVAL)
> > > +		return -ENOENT;
> > > +	else if (ret)
> > > +		return -EINVAL;
> > > +
> > > +	ret = of_property_read_u64(of_chosen,
> > > "linux,kexec-handover-buffer-end", +				   
> &end_addr);
> > > +	if (ret == -EINVAL)
> > > +		return -ENOENT;
> > > +	else if (ret)
> > > +		return -EINVAL;
> > > +
> > > +	*addr =  __va(start_addr);
> > > +	/* -end is the first address after the buffer. */
> > > +	*size = end_addr - start_addr;
> > > +
> > > +	return 0;
> > > +}
> > 
> > This depends on dtb, so if IMA want to extend it to arches like x86 in
> > the future you will have to think about other way to pass it.
> > 
> > How about think about a general way now?
> 
> The only general way I can think of is by adding a kernel command line 
> parameter which the first kernel would pass to the second kernel, but IMHO 
> that is ugly, because such parameter wouldn't be useful to a user, and it 
> would also be something that, from the perspective of the user, would 
> magically appear in the kernel command line of the second kernel...

Sorry I just brought up the question, actually I have no idea either.
Maybe we have to do this with arch specific ways..

Thanks
Dave
