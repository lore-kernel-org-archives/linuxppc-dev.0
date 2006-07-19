Return-Path: <paravpandit@yahoo.com>
Received: from web36604.mail.mud.yahoo.com (web36604.mail.mud.yahoo.com
	[209.191.85.21]) by ozlabs.org (Postfix) with SMTP id D8D5267A3E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 14:45:12 +1000 (EST)
Message-ID: <20060719044510.24117.qmail@web36604.mail.mud.yahoo.com>
Date: Tue, 18 Jul 2006 21:45:10 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: Re: page locking in PowerPC cores
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20060718233554.GA27549@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--- Eugene Surovegin <ebs@ebshome.net> wrote:
> >   We allocate memory for DMA operation on PCI
> device using pci_alloc_constistent().
> >    
> >   I want to know how this function is boil down to
> the actual instruction which locks the page in the
> RAM so that it cannot be paged out and dma can do
> its work.
> 
> This is trivial - you can start with looking at the
> implementation.
> 

[Parav]
I did it, but after reaching __alloc_pages() its
getting difficult to understand.
Here is the sequence:
pci_alloc_consistent()
-> __get_free_pages()
   ->alloc_pages(gfp_mask, order)
      ->alloc_pages_current()
         -> __alloc_pages()

It does something with zones. Looks like zone memory
pages are locked in the beginning.
Still could not figure out the instuctions for page
locking.


> >    
> >   Can anybody tell me which instructions do we use
> to set this page entry in TLB and page table?
> >   What bit gets set in the PTE for this?
> 
> Why do you need this page in TLB?

[Parav] No, I don't want. I just wanted to see the
code for locking inside TLB or in page table.


> 
> In general you don't have to worry about _any_
> memory you allocated in 
> the kernel to be paged out.
> 

[Parav] As driver writer, I agree I don't need to, but
to better understand the system I am eager to do that.

Regards,
Parav


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
