Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id EA973681CE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 03:27:26 +1000 (EST)
Received: from [192.168.1.7] (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id j7UHRPl24288
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 Aug 2005 10:27:25 -0700
Message-ID: <431496FC.3090208@icarus.com>
Date: Tue, 30 Aug 2005 10:27:24 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Mapping huge user buffers for DMA
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have a PPC405GPr system with an image processing device, that
is creating potentially huge amounts of data. In one setup I
have a 256Meg system, and I'm trying to map a 192Meg destination
buffer using map_user_kiovec and an array of kiobufs.

I'm finding, however, that I'm getting an Oops in map_user_kiovec
when it tries this, and I'm wondering where I need to look for
any limits I might be overrunning.

Also, I've been considering skipping kiobufs all together and
instead using code like this (lifted from map_user_kiobuf)

	/* Try to fault in all of the necessary pages */
	down_read(&mm->mmap_sem);
	/* rw==READ means read from disk, write into memory area */
	err = get_user_pages(current, mm, va, pgcount,
			(rw==READ), 0, iobuf->maplist, NULL);
	up_read(&mm->mmap_sem);

to get the user pages directly. This is really what I want, and
I do not need the other functionality of kiobufs. Is the
get_user_pages function kosher for use by drivers? Is there
a limit to what get_user_pages may map?


-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
