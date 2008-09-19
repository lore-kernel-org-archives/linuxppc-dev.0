Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 08C1CDDED8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Sep 2008 08:09:45 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: vb <vb@vsbe.com>
Subject: Re: Allocating uncached memory in 2.6.25(powerpc/440)
References: <f608b67d0809191447q2bd5c05bof4610a3df17f8512@mail.gmail.com>
	<f608b67d0809191456p7193a0bfh3529d9241a304301@mail.gmail.com>
Date: Fri, 19 Sep 2008 15:09:35 -0700
In-Reply-To: <f608b67d0809191456p7193a0bfh3529d9241a304301@mail.gmail.com>
	(vb@vsbe.com's message of "Fri, 19 Sep 2008 14:56:11 -0700")
Message-ID: <ada1vzfaiu8.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 > basically, a block of contiguous memory is allocated. This block is
 > needed to set up some DMA descriptors, so it needs to be uncached, and
 > I thought this is what GFP_DMA flag is for.

No, GFP_DMA doesn't have that meaning.  To allocate uncached memory, use
dma_alloc_coherent().

 - R.
