Date: Sun, 17 Nov 2002 17:27:45 -0800
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v548)
Cc: <linuxppc-dev@lists.linuxppc.org>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
From: Tim Seufert <tas@mindspring.com>
In-Reply-To: <001701c28e91$8ab64b80$0200a8c0@telia.com>
Message-Id: <F0E56D1E-FA94-11D6-9841-003065F22EAA@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sunday, November 17, 2002, at 03:32  PM, Joakim Tjernlund wrote:

>> Not used.  CTR cannot be specified as the source or destination of
>> most
>> instructions.  In order to access its contents you have to use special
>> instructions that move between it and a normal general purpose
>> register.
>
> OK, so how about if I modify the crc32 loop:
>
> unsigned char * end = data +len;
> while(data < end) {
>         result = (result << 8 | *data++) ^ crctab[result >> 24];
> }
>
> will that be possible to optimze in with something similar as bdnz
> also?

Nope.  If the pointer was put into the CTR register, it would have to
be copied back out with an extra instruction in order to be
dereferenced.  Also, I'm fairly sure there is no way to compare CTR to
anything but zero, so loops really need to be of the form "while
(counter--)" to use it.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
