Message-ID: <3D9BFFA9.3020604@elsoft.ch>
Date: Thu, 03 Oct 2002 10:28:25 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
References: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com> <20020930040143.GF10265@zax> <20021001052121.GV10265@zax> <3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax> <3D9AA452.5070004@elsoft.ch> <20021003011233.GC1102@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
[stuff deleted]

> Fair enough.  I'm just trying to come up with the simplest approach
> that still provides the flexibility we need.  Based on the evidence
> immediately available, what I posted seemed like it.  How about you
> tell me something about the non-standard PCI mappings, so I can come
> up with something better.
>

Ok, here is the mapping i'm currently using . For the E000'0000 -
E0ff'ffff area i have to program PMM1 with "non-standard" values.


	/*  PCI mapping:
         **
         **  PLB addr                    PCI memory addr
         **  ---------------------       ---------------------
         **  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
         **  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
	**  E000'0000 - E0ff'ffff --->  0000'0000 - 00ff'ffff
         **
         **  PLB addr                    PCI io addr
         **  ---------------------       ---------------------
         **  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
         **
         */


I'm also thinking about splitting the 8000'0000 - Bfff'ffff area into a
prefetchable and a non-prefectable one, so i will be urged to programm
PMM2 as well.


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
