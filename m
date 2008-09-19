Return-Path: <vbendeb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 0F4CCDDF10
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Sep 2008 07:56:12 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so578671rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 14:56:11 -0700 (PDT)
Message-ID: <f608b67d0809191456p7193a0bfh3529d9241a304301@mail.gmail.com>
Date: Fri, 19 Sep 2008 14:56:11 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: Allocating uncached memory in 2.6.25(powerpc/440)
In-Reply-To: <f608b67d0809191447q2bd5c05bof4610a3df17f8512@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f608b67d0809191447q2bd5c05bof4610a3df17f8512@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Oh man, sorry, those damn keyboard shortcuts, let me try again :-)


I wonder if anyone can help with some hints in this situation:

here is a code fragment to illustrate the questions:

 if ((ai = kmalloc(sizeof(alloc_info_t) + 4 * szw, GFP_ATOMIC |
GFP_DMA)) != NULL) {
        ai->src = FROM_KMALLOC;
       printk("\n%s:%d %p\n", __FUNCTION__, __LINE__, ai);

basically, a block of contiguous memory is allocated. This block is
needed to set up some DMA descriptors, so it needs to be uncached, and
I thought this is what GFP_DMA flag is for.

I stop execution using a JTAG probe right after the printk above, and
examine the TLB matching the allocated address.

This is what printk reports:
sal_alloc:163 eee76000

And the TLB record for this memory is the default kernel 256M page:

61 : 00 e0000000 256MB V0 -> 0_20000000 U:0000 ---G- ---XWR

Which is obviously cached (missing the I bit set).

How is this supposed to work?

Is this right to expect the address returned by kmalloc() to be mapped
to uncached TLB in case GFP_DMA flag is passed in?

What are the proper ways of setting up shared memory in this kernel?


Any hints will be highly appreciated,

TIA,
Vadim
