Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C8CF6801D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 03:13:27 +1000 (EST)
In-Reply-To: <4309E2AC.9080404@icarus.com>
References: <4309E2AC.9080404@icarus.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <20d4aca8d8032c5762deb047185d2c6e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 22 Aug 2005 13:09:57 -0400
To: Stephen Williams <steve@icarus.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mmap nocache on PPC, 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 22, 2005, at 10:35 AM, Stephen Williams wrote:

> In an embedded system, I want a big chunk of virtual memory in the
> user process to be uncached.

Why?  What processor it this?  Who else touches this memory?

> .... I've created a virtual device driver that
> has this mmap method:

Even if this did what you thought it should, I'm not sure you
would be happy with the results.  The challenge is ensuring
anyone that touches these physical pages also does so
uncached.  Depending upon the processor, this isn't something
that is trivial to change in the kernel, since we always map
all of memory as efficiently as possible with a cached mapping.
The caching of memory has many desirable performance
side effects, making the trade off the manage coherency in
software if needed an overall system gain.

Thanks.

	-- Dan
