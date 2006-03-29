Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C924167A40
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 03:48:57 +1100 (EST)
Message-ID: <442AB9DE.9080806@ovro.caltech.edu>
Date: Wed, 29 Mar 2006 08:46:22 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
Subject: Re: "lseek/write char driver" versus "usermode iomem access"
References: <442A43C6.5050605@cs.fau.de>
In-Reply-To: <442A43C6.5050605@cs.fau.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> besides adapting linux to my custom board, i now have to write a driver 
> for a special device. This device mainly consists of an up to 512 bytes 
> big IO memory. Because performance matters alot, i wonder if i shall 
> write a simple char driver offering a write/lseek-interface to access 
> this memory or if i shall do something new to me, mapping the IO-memory 
> to the userspace, so that the user-program can directly access the 
> device memory. Can anyone tell me how performance probably differs 
> between those two design.
> 
> Thanks, you probably save me alot of time to tryout!

Hi Josef,

Here's a couple of comments that may help:

lseek()/read()/write():

   - read and write need to use copy_to_user and copy_from_user
     commands to copy bytes from the registers into the user-space
     buffer.

mmap()

   - maps pages directly, so avoids the overhead of the copy_xx_user
     calls.

So, if you have a set of control *registers* that you want to
manipulate, then mmap would be recommended.

However, this 512-bytes of memory is just that, *memory*, and the
requirement is to move it off the device as fast as possible,
then you probably want to create a device that has a linked
list of 512-byte buffers internally, and use a DMA channel
to move data from the device into the buffer. Then the
'read' function of the driver would consume the contents of
the buffer.

So, as always, things are application dependent. If you
could describe things in more detail, I can help make
more suggestions and supply you with code.

Regards,
Dave
