From: Brian Waite <waite@skycomputers.com>
To: "Q-ha Park" <qha@infoeq.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: can't find "init" when using 1GB ram on 7455.
Date: Tue, 30 Sep 2003 12:21:21 -0400
References: <007601c38769$ceb77030$2a21a8c0@qha>
In-Reply-To: <007601c38769$ceb77030$2a21a8c0@qha>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200309301221.26184.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I had almost the exact same problem on the ev64260 platform with 1GB of
memory. Tak a look and make sure you are not doing any io_block_mapping()
calls in your platform setup functions. You might have one for early serial
messages. Look at the mapping and make sure it does not overlap. You might
have to reduce the io_block_mapping() size. Just a thought

Thanks
Brian
On Tuesday 30 September 2003 11:44 am, Q-ha Park wrote:
> Well, actually not just init but all "start" programs such as modprobe,
> bash, etc. Linux uses NFS as its filesystem, and kernel thinks NFS is
> mounted correctly, but it doesn't successfully find and execute "start"
> programs like sh, init, etc. The system that works well with 512MB ram.
>
> This is what I attempted to support two 512 MB DIMM rams:
> 1. use 2 more BATs to translate up to 0x40000000 (1GB) in ppcboot,
> changed CFG_INIT_RAM to 0x40000000 accordingly.
> 2. enable high_mem support in the kernel.
>
> When I made the system load the kernel w/o high_mem support
> intentionally, UART doens't work anymore; it doesn't generate interrups.
> Any clues on what might be wrong and what idiotic things I might have
> done?
>
> Thanks in advance!
>
>
> Q-ha Park
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
