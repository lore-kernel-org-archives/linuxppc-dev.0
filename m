Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 74ED4DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Oct 2008 17:32:50 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so823935rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 23:32:49 -0700 (PDT)
Date: Sat, 18 Oct 2008 00:32:47 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Robert Woodworth <rwoodworth@securics.com>
Subject: Re: Cache control
Message-ID: <20081018063246.GA5594@secretlab.ca>
References: <1BA180A8-1655-4F10-ADDD-E5667DE182BE@securics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1BA180A8-1655-4F10-ADDD-E5667DE182BE@securics.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 16, 2008 at 09:57:27AM -0600, Robert Woodworth wrote:
> I have a Virtex4 VF60 device with 256MB DDR2.
>
> I have told the Linux kernel that the device has only 128MB and its  
> working fine.  There is an HDL module that is populating the next 16MB  
> with sensor data (0x08000000 - 0x09000000)  I mapped the area into my  
> driver via `ioremap()` and also via `mmap / remap_pfn_range()`  It works 
> fine.
>
> I know that PPC cache regions work in 128MB blocks.  I assume that the  
> kernel bootup is turning on cache in the first 128, because it thinks  
> that its the full RAM range, and not cached in the next 128MB.

That's only true when the MMU is off.  Linux runs with the MMU on and
the TLB entries specify the caching per mapping.

> I know that if I declare the area cached, and invalidate the region  
> before I read it,  the reads should be much faster than if it's not  
> cached.

Correct.

> How can I control if the area is cached? and then invalidate it when new 
> data arrives?
>
> Is there a PPC/Linux API call to declare the region cached and  
> invalidate regions before read?

Take a look at dma_alloc_coherent() and related functions.

Cheers,
g.
