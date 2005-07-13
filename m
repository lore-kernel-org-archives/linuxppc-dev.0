Return-Path: <mlei30@yahoo.com>
Received: from web61016.mail.yahoo.com (web61016.mail.yahoo.com
	[209.73.179.10]) by ozlabs.org (Postfix) with SMTP id 03F8567C3D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 07:48:03 +1000 (EST)
Message-ID: <20050713214802.68288.qmail@web61016.mail.yahoo.com>
Date: Wed, 13 Jul 2005 14:48:02 -0700 (PDT)
From: ming lei <mlei30@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <2c008f2a8b3ef3ba33ec3d0f8a5c3390@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: double kernel page table entry for the same physical page?!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I am worried about memory corruption if there are two
PTE entries point to the same physical page.
Considering this case: vmalloc a page to a virt
address V1 and somehow other code uses V0(which is in
identy mapping) to modify the same physical page.

I checked i386 and looks like they have the same
problem.

Why linux kernel does such thing and no one consider
it's a problem? 

Thanks
Ming

--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Jul 13, 2005, at 1:10 PM, ming lei wrote:
> 
> > Question: does the linux ever touch this section
> of
> > page table(virt address from PAGE_OFFSET to
> > PAGE_OFFSET+A) again? like remove or modify one of
> the
> > entry?
> 
> Not usually.  We used to do it on 8xx for mapping
> uncached pages for coherent DMA.
> 
> > Question: For every physical page, it should
> already
> > be mapped in #1, but vmalloc maps it again to a
> virt
> > address higher. Does it mean in kernel page table,
> we
> > may have two PTE entries pointing to the same
> physical
> > page, even their virt addresses are different?
> 
> Yep.
> 
> > Last question:
> > If this is true, is this platform implemention
> > specific? Does i386 implemention have same
> situation?
> 
> Other architectures will do the same, yes.  The
> level to which they do this will vary depending upon
> architectural features we have to hide/expose to
> other functions.
> 
> One potential problem that arises is you have to be
> careful about the virtual address access path to
> these
> pages.  All processors will behave errantly if you
> access the same physical page, but with different
> attributes, through the different VAs.  How they
> behave
> will depend upon the attributes.  If the PTEs have
> different cache modes or page sizes, it's usually
> a big problem.  If they just share different write
> permissions, it's usually OK.  These problems
> usually
> arise when device driver writers either don't
> understand
> the mapping issues or try something that may work
> on one architecture but not on another.
> 
> 
> 	-- Dan
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
