Message-Id: <l03130301b2a1312f4205@[172.16.10.14]>
In-Reply-To: <367A328E.9ED@post.uni-bielefeld.de>
References: <l03130300b29d351e3bbc@[172.16.10.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 19 Dec 1998 23:34:16 +1300
To: jenschrr@post.uni-bielefeld.de
From: Bryan Christianson <bryanc@ihug.co.nz>
Subject: Re: Porting  a driver from x86 to LinucPPC
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Bryan Christianson wrote:
>>
>> I'm trying to port a device driver from x86 to linuxppc. I am running into
>> problems with big/little endian-ness.
>>
>> The device is a PCI card. Do I need to explicitly translate the data
>> between big-endian and little-endian or will the io routines (outl, inl and
>> inw) take care of this for me? On x86 I didn't even think about this issue,
>> but now I have a feeling that maybe I should have.
>
>I just fixed the NE2000 driver for this.
>
>inl/outl will fix PCI's liddle-endianess to host-endianness. There is
>some documentation in include/asm/io.h.
>

Thanks - I've got the thing working now. The inl/outl stuff worked fine,
but this card also uses inw. I had to flip the bytes on the returned value
and the card burst into life.

Bryan

--
Bryan Christianson
email:		<mailto:bryanc@ihug.co.nz>
Home Page:	<http://crash.ihug.co.nz/~bryanc>



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
