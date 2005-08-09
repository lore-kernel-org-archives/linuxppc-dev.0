Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C53D67FFE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 02:37:24 +1000 (EST)
In-Reply-To: <6d145b42050809075718c70574@mail.gmail.com>
References: <6d145b42050808193058ee05b4@mail.gmail.com>
	<5c9191bc3e15d90c966735662c28fa5e@embeddededge.com>
	<6d145b42050809075718c70574@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e0e99d07a5f20187cf45caac1ee9fa10@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 9 Aug 2005 12:37:43 -0400
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


On Aug 9, 2005, at 10:57 AM, Prashant Alange wrote:

> Since the existing UART/ethernet drivers are using cpm_hostalloc() so
> I am also using the same function.

As I have said too many times before, cpm_hostalloc() is only used
to allocate small memory regions that would otherwise be wasteful
with the normal Linux memory allocators.  This function does not
do anything special with the memory, aside from allowing us have
multiple drivers share a page for efficiency.

>  Then can I use kmalloc() to alloc
> such huge memory.

Yes, and you should.

>  If at all I have to configure BATx to just test how
> it behaves.

No, that's not all you have to do.  It's not a trivial process
easily described here.

> .....   One more thing is that
> totally I am allocating about 1MB memory in a chunk of 200K.

I can't comprehend a reason why you need to allocate so much
space in a driver, especially for CPM devices.  The driver is just
a temporary FIFO for data flowing to/from other consumer/producers
of the data in the system.  If the software above a driver needs
that kind of buffering, it should manage that itself.

If you do need so much space, use the beauty of the CPM and
link multiple BDs with reasonable sized buffers more easily
managed by the existing Linux allocators.

The other alternative is just reserve memory using the 'mem='
start parameter so it isn't know to Linux, and manage entirely
yourself.


	-- Dan
