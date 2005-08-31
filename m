Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 2993D68144
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 10:35:17 +1000 (EST)
Received: from [192.168.1.7] (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id j7V0ZGl28458
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 Aug 2005 17:35:17 -0700
Message-ID: <4314FB44.8000406@icarus.com>
Date: Tue, 30 Aug 2005 17:35:16 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <431496FC.3090208@icarus.com>
	<200508310210.51561.roger.larsson@norran.net>
In-Reply-To: <200508310210.51561.roger.larsson@norran.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Roger Larsson wrote:
> On Tuesday 30 August 2005 19.27, Stephen Williams wrote:
> 
>>I have a PPC405GPr system with an image processing device, that
>>is creating potentially huge amounts of data. In one setup I
>>have a 256Meg system, and I'm trying to map a 192Meg destination
>>buffer using map_user_kiovec and an array of kiobufs.
> 
> 
> Never tried to map that amount at once. Our code looks, or looked, like this.
> Found some code...
> /usr/src/linuxppc_2_4_devel/arch/cris/drivers/examples/kiobuftest.c 

That's similar to where I'm at now, and I'm finding it inadequate.

>>I'm finding, however, that I'm getting an Oops in map_user_kiovec
>>when it tries this, and I'm wondering where I need to look for
>>any limits I might be overrunning.
> 
> 
> What does the Oops say??
> Hmm... How much space will the vector itself require?

If placed into a single kiobuf, it would need 49,152 page pointers,
which would be 192K bytes for the maplist. Since the kernel uses
kmalloc to allocate the maplist, that won't work. Thus, I've
created an array of kiobufs to hold a smaller chunk of the pages
for the user buffer.

The Oops is a sig11 within the map_user_kiovec. (?!)

I also see errors from the kernel being unable to allocate
pages, so it seems like something is not handling an OOM
situation very well.

> 
>>Also, I've been considering skipping kiobufs all together and
>>instead using code like this (lifted from map_user_kiobuf)
>>
>>	/* Try to fault in all of the necessary pages */
>>	down_read(&mm->mmap_sem);
>>	/* rw==READ means read from disk, write into memory area */
>>	err = get_user_pages(current, mm, va, pgcount,
>>			(rw==READ), 0, iobuf->maplist, NULL);
>>	up_read(&mm->mmap_sem);
>>
>>to get the user pages directly. This is really what I want, and
>>I do not need the other functionality of kiobufs. Is the
>>get_user_pages function kosher for use by drivers? Is there
>>a limit to what get_user_pages may map?
> 
> 
> Isn't this the way it is done in 2.6 anyway?

Well that's how the map_user_kiovec in 2.4 does it. I'm just
wondering if I were to do it myself using get_user_pages, would
I be peeking around the curtain at interfaces not meant to be
public. I'm thinking I need to ues get_user_pages myself to
avoid the extra overhead of kiobufs, and I can use vmalloc'ed
memory to hold those page pointers for later unmap so I don't
run up against the kmalloc limit.

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
