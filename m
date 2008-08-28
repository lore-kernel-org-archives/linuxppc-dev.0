Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A0C78DDF73
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 10:21:57 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: vb <vb@vsbe.com>
Subject: Re: mmap and ppc460gt
References: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
	<ada3akri1i5.fsf@cisco.com> <200808271013.18659.arnd@arndb.de>
	<f608b67d0808271613g2092b287o44c3418fb7d33499@mail.gmail.com>
Date: Wed, 27 Aug 2008 17:11:14 -0700
In-Reply-To: <f608b67d0808271613g2092b287o44c3418fb7d33499@mail.gmail.com>
	(vb@vsbe.com's message of "Wed, 27 Aug 2008 16:13:52 -0700")
Message-ID: <adawsi2j8wt.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 > The problem now is that that PCI register space gets mapped with
 > caching enabled (by looking at the TLB contents), so I still can't
 > control the device. I did some search and indeed UIO device driver
 > came up, I'll read the article. I was wondering  though if there is a
 > simpler way to modify cache attributes of a region. mmap() doesn't
 > seem to provide an interface for that, is there some other function to
 > call to configure 'cache inhibit' attribute for a region?

The issue would be related to phys_mem_access_prot() not doing the right
thing in this case.  In fact it looks like the arch/powerpc
page_is_ram() implementation has the same bug that I fixed a long time
ago for arch/ppc in 8b150478 ("[PATCH] ppc: make phys_mem_access_prot()
work with pfns instead of addresses").  I'll send a patch a little later
that you can try out.

 - R.
