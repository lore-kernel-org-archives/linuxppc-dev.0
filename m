Date: Wed, 28 Apr 1999 22:21:32 +1000
Message-Id: <199904281221.WAA31584@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Christian.Bauer@uni-mainz.de
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199904280958.LAA24884@student.physik.uni-mainz.de>
	(Christian.Bauer@uni-mainz.de)
Subject: Re: Endianess problems in linuxppc kernel
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199904280958.LAA24884@student.physik.uni-mainz.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christian Bauer <Christian.Bauer@uni-mainz.de> wrote:

> The "le16_to_cpus(&hdr->count)" fixes a real bug in the driver (it wouldn't
> work on big-endian machines, no matter how outsl/insl works), but everything
> else looks like the outsl/insl functions work with the wrong byte order
> (little-endian vs. big-endian).

Well, the driver is using insl/outsl to transfer a buffer of bytes,
not a buffer of longwords, whereas in[s]l/out[s]l are defined to
transfer longwords (32 bits), and byte-swapping is the right thing to
do when you're transferring longwords.  The driver is using insl/outsl
in order to transfer the bytes in 4 byte chunks; what it really should
use is an insl_ns/outsl_ns which doesn't do byteswapping.

> Playing a module with "mikmod" results in rhythmic noise (16 bit) or silence
> (8 bit). When I change every instance of
> 
>   out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);
> 
> to
> 
>   out_le32(&awacs->byteswap, sound.hard.format == AFMT_S16_BE);
> 
> in "drivers/sound/dmasound.c", both 8 and 16 bit output work fine.

Is the application perhaps using AFMT_S16_NE (native endianness) but
assuming that that means little-endian?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
