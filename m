Message-ID: <405B4037.6090206@embeddededge.com>
Date: Fri, 19 Mar 2004 13:47:19 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Lou Rickard <lou_rickard@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: coffboot?
References: <20040319173859.61444.qmail@web21113.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lou Rickard wrote:

> When I build the kernel from my 2.4 directory, I end
> up with a zImage.gz in the boot/images directory, but
> it doesn't work.

That file certainly won't boot, it's an intermedia file
that is left over from the build process.

> I'm guessing there's something I've got to do to
> convert the zImage.gz in my 2.4 boot/images directory

You can do one of two things.  Load the zImage.elf as
a binary to some address (say 400000) and start at the
code past the ELF header (g 410000).

Second, you can 'objcopy -O binary zImage.elf zImage.bin',
then load the zImage.bin (say 400000), then jump to the
address where it was loaded (g 400000).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
