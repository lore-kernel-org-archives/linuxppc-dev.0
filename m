Return-Path: <vbendeb@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 3B425DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 10:21:30 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so55386wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 17:21:28 -0700 (PDT)
Message-ID: <f608b67d0808271721n374acb05kd842a884cc4bf5c@mail.gmail.com>
Date: Wed, 27 Aug 2008 17:21:28 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: mmap and ppc460gt
In-Reply-To: <adawsi2j8wt.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
	<ada3akri1i5.fsf@cisco.com> <200808271013.18659.arnd@arndb.de>
	<f608b67d0808271613g2092b287o44c3418fb7d33499@mail.gmail.com>
	<adawsi2j8wt.fsf@cisco.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 27, 2008 at 5:11 PM, Roland Dreier <rdreier@cisco.com> wrote:
>  > The problem now is that that PCI register space gets mapped with
>  > caching enabled (by looking at the TLB contents), so I still can't
>  > control the device. I did some search and indeed UIO device driver
>  > came up, I'll read the article. I was wondering  though if there is a
>  > simpler way to modify cache attributes of a region. mmap() doesn't
>  > seem to provide an interface for that, is there some other function to
>  > call to configure 'cache inhibit' attribute for a region?
>
> The issue would be related to phys_mem_access_prot() not doing the right
> thing in this case.  In fact it looks like the arch/powerpc
> page_is_ram() implementation has the same bug that I fixed a long time
> ago for arch/ppc in 8b150478 ("[PATCH] ppc: make phys_mem_access_prot()
> work with pfns instead of addresses").  I'll send a patch a little later
> that you can try out.
>

Ronald, I will appreciate the patch that very much!

TIA,
/vb


>  - R.
>
