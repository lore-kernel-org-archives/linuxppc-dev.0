Message-ID: <40F45973.7080908@rossvideo.com>
Date: Tue, 13 Jul 2004 17:51:47 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: early UART mapping in head_44x.S
References: <40F452D6.9020806@rossvideo.com>
In-Reply-To: <40F452D6.9020806@rossvideo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ralph Siemsen wrote:
> Can anyone explain how this is meant to work?  Specifically, the
>     ori    r3,r3,PPC44x_TLB_TS
> would clear the other bits in this register, including the "valid" bit,
> so how is this mapping supposed to work?
Clearly demonstrating that I have been staring that this line of code
too long... the ori instruction sets the TS bit and shouldn't affect the
others...

However, if I dump the TLB entry after the isync using the BDI
interface, it shows the EPN is zero'd out:

IDX TID      EPN  SIZE VTS          RPN   USER WIMGE USRSVC
  1 : 00 00000000   1KB -0 -> 1_40000000 U:0000 -I-G- -WR-WR

whereas without the second "tlbwe" instructions, I get the expected and
functioning mapping:

  1 : 00 e0000000 256MB V0 -> 1_40000000 U:0000 -I-G- ----WR

What's the secret?
-R

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
