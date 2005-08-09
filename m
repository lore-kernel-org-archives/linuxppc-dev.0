Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C75D67F9D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 00:36:56 +1000 (EST)
In-Reply-To: <6d145b42050808193058ee05b4@mail.gmail.com>
References: <6d145b42050808193058ee05b4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5c9191bc3e15d90c966735662c28fa5e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 9 Aug 2005 10:37:11 -0400
To: Prashant Alange <prashant.alange@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to disable dcache on MPC82xx platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 8, 2005, at 10:30 PM, Prashant Alange wrote:

> I am using alloc_bootmem_page() function to allocate memory required
> in my custom ethernet driver.

Why?  Just use the normal Linux memory allocators.

>  So I am thinking this could be because of cache since this
> driver is working fine on non-os platform. I want to disable the
> dcache for this memory region.

This is a fully cache coherent processor, there is no need to
disable caching, nor is there any easy way to do this in the
current Linux implementation.  This would require a custom
kernel, and you couldn't take advantage of the general
performance gain using BATs.

Thanks.

	-- Dan
