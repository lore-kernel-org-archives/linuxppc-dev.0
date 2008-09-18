Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by ozlabs.org (Postfix) with ESMTP id 39119DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 16:12:56 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3503356rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Sep 2008 23:12:54 -0700 (PDT)
Message-ID: <fa686aa40809172312r6f527e1ahbae83b17f8062c62@mail.gmail.com>
Date: Wed, 17 Sep 2008 23:12:54 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Misbah khan" <misbah_khan@engineer.com>
Subject: Re: Ioremap related concern ...
In-Reply-To: <19545826.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <19545826.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Sep 17, 2008 at 9:43 PM, Misbah khan <misbah_khan@engineer.com> wrote:
>
> Hi all,
>
> i am facing a problem regarding the usage of ioremap function which is
> described as:-
>
> 1) I am remaping the SDRAM memory into three continews buffer as
>        ptr1 = (unsigned int *)ioremap(0x0001000,0x1000);
>        ptr2 = (unsigned int *)ioremap(0x0002000,0x1000);
>        ptr3 = (unsigned int *)ioremap(0x0003000,0x1000);

Ah, this doesn't work.  You can't just choose a region of ram and
ioremap it.  Besides, the base of RAM is already used by the interrupt
vectors.

If you need to allocate a region for DMA buffers, then take a look at
dma_alloc_coherent().  If you just need to allocate some buffers, then
just use kzalloc().

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
