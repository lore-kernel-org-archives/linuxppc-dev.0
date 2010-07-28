Return-Path: <Simon.Richter@kleinhenz.com>
Received: from kleinhenz.com (static.88-198-202-190.clients.your-server.de
	[88.198.202.190]) by ozlabs.org (Postfix) with ESMTP id DEB4BB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 00:49:18 +1000 (EST)
Date: Wed, 28 Jul 2010 16:21:40 +0200
From: Simon Richter <Simon.Richter@hogyros.de>
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: Memory Mapping Buffers smaller than page size?
Message-ID: <20100728142140.GA9494@richter>
References: <AANLkTikVrftUUC2W+NgWyZi6cc4H4c+mPza9MfsDKuxF@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikVrftUUC2W+NgWyZi6cc4H4c+mPza9MfsDKuxF@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Jul 28, 2010 at 06:44:10PM +0530, Ravi Gupta wrote:

> I am new to linux device drivers development. I have created 16 buffers of
> size 256 bytes each(using kmalloc()) in my device driver code. I want to
> memory map these buffers to user space. Now is it possible to memory map
> these buffer(16*256 = 4096 = 1 page on 32 bit linux) into a single page in
> user space OR i have to map them in individual pages in user space? Note,
> all the buffers may not be stored in continuous memory location.

Pages are the smallest unit for mappings, so each buffer would end up in
its own mapping. If you want the buffers to be accessible without an
offset, then you cannot have them in continuous locations, as you cannot
map memory from the middle of a page to the beginning either.

So your options are: one page per buffer (wasteful, but gives you
granular access control), or allocating all the buffers as a single
block.

   Simon
