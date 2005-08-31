Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 04ACE68210
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 00:05:16 +1000 (EST)
Message-ID: <4315B8A0.4040600@anagramm.de>
Date: Wed, 31 Aug 2005 16:03:12 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Stephen Williams <steve@icarus.com>
References: <431496FC.3090208@icarus.com>
In-Reply-To: <431496FC.3090208@icarus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mapping huge user buffers for DMA
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Stephen!

Please have a look at the whole thread around my posts at:
http://lkml.org/lkml/2005/8/4/201

I am working on an mpc8540 (e500) ppc and we are pushing
data from the local bus directly to the userspace
mlock()ed memory with the dma engine, using scatter/gather
(chaining and page/chunk-defragmentation/compression) transfers.

Currently, I send the application's user virtual and mlock()ed
address to the kernel driver through an ioctl and do an iopa()
at the user virtual addresses (pages) to get to the physical
addresses (pages). The system works stable and we can fill up
the whole memory (192MByte) with currently 144MByte/s
(still improvements possible).

If you are interested in our design, feel free to contact
me directly.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19


Stephen Williams wrote:
> 
> I have a PPC405GPr system with an image processing device, that
> is creating potentially huge amounts of data. In one setup I
> have a 256Meg system, and I'm trying to map a 192Meg destination
> buffer using map_user_kiovec and an array of kiobufs.
> 
> I'm finding, however, that I'm getting an Oops in map_user_kiovec
> when it tries this, and I'm wondering where I need to look for
> any limits I might be overrunning.
> 
> Also, I've been considering skipping kiobufs all together and
> instead using code like this (lifted from map_user_kiobuf)
> 
>     /* Try to fault in all of the necessary pages */
>     down_read(&mm->mmap_sem);
>     /* rw==READ means read from disk, write into memory area */
>     err = get_user_pages(current, mm, va, pgcount,
>             (rw==READ), 0, iobuf->maplist, NULL);
>     up_read(&mm->mmap_sem);
> 
> to get the user pages directly. This is really what I want, and
> I do not need the other functionality of kiobufs. Is the
> get_user_pages function kosher for use by drivers? Is there
> a limit to what get_user_pages may map?
> 
> 
