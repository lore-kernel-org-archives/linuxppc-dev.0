Message-ID: <386DBEF0.FEFBCEC5@huawei.com.cn>
Date: Sat, 01 Jan 2000 16:46:40 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Jeff Millar <jeff@wa1hco.mv.com>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Please help me...
References: <386C150F.22B1A3D0@huawei.com.cn> <000401bf5016$4757c420$0201a8c0@home> <386C6B4F.FB124BC0@huawei.com.cn> <000c01bf5086$3e358d80$0201a8c0@home> <386D5F54.8878ED25@huawei.com.cn> <001801bf50e1$6d3ad8a0$0201a8c0@home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>





> When you say the download doesn't work, what do you mean?

When I try to download the "zImage" from  TFTP Server to my RAM 0x00200000 on
board,
the download process will stop . That is to say, it cannot download the whole
"zImage" file
but just a part of the "zImage " file. But it I download the "zImage" to my RAM
0x00100000 on
board, it will succeed to download and show a message "starting at
0x00100000..." and halt.

>
>
> How much RAM do you have?

32M.
Notes that I want to download the "zImage" from remote TFTP Server via EHERNET
instead of  from local flash .
I have downloaded the FADSROM and 8xxROM packages and researched them.
They all seem to download the "zImage" from local flash disk, not from remote
TFTP server via ETHERNET. I think the latter is easy to debug applications,
right?
Do you think it will make any difference between these two cases?
When I download the "zImage" from remote TFTP server  via ethernet to RAM
0x00200000 board , how can I dispose the "zImage" at other address , and when
jumping there it will boot the kernel?
Any ideas?


> Downloading zImage to 2MB should work.  You might
> try downloading to 3 or 4MB.  You need to download the relocatable kernel
> image (zImage) so that entirely fits in RAM, low enough that the top end of
> zImage and any attached initrd doesn't over flow the top of RAM.  The
> bootloader will copy the kernel low using 0x0 and up for its data structures
> and executable.  The zImage must not conflict with the kernel executable or
> data structures.  Putting the zImage at 0x00100000 is too low.  During the
> boot load process, the kernel builds data structures upward in memory
> depending on the size of the kernel and number of options.
>
> Copying the image to flash depends on the hardware and flash ROM chips.  You
> will have to write
> a flash ROM erase and writing program.  Assuming your board has flash, find
> the data sheet and read up on the write programming algorithm.  The zImage
> and initrd can load into ROM and the boot
> loader can execute fromm flash rom.

Sorry, I still don't understand your meaning.
When you say "copy image to flash", what does the image contain?
bootrom codes+kernel+RootFileSystems or kernel+RootFileSystems? If so, in what
file format can I write it into flash?
Best regards,
dony


>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
