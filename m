Message-Id: <4.3.2.20000329150052.048a51d0@mail.munich.netsurf.de>
Date: Wed, 29 Mar 2000 15:11:03 +0200
To: Gabriel Paubert <paubert@iram.es>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Some issues to resolve with XFree 4.0 yet 
Cc: David Edelsohn <dje@watson.ibm.com>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPX.4.10.10003291229460.14656-100000@gra-ux1.iram.es>
References: <200003271913.OAA28080@mal-ach.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:45 29.03.00, Gabriel Paubert wrote:
>BTW, did anybody think of adding a __builtin_byteswap to GCC ?
>
>This would allow the compiler to directly generate *brx instructions on
>PPC by combining them with memory loads and stores. I'm aware that it
>would require an additional constraint letter for indexed addressing modee
>only but this is required for Altivec anyway.
>
>And this would open opportunities for quite a lot of optimizations, for
>example when setting or clearing some bits in a device register. In this
>latter case (and in the given example) operands are often constants and
>the compiler could generate non byte swapped load and stores and byte swap
>the constants.

Hmm, I was thinking about adding __attribute__((little_endian)) and
__attribute__((big_endian)) to further describe variables. This should give
us optimum optimization on various platforms. Even things like:

union {
         unsigned long little_var __attribute__((little_endian));
         unsigned long big_var __attribute__((big_endian));
}

should be possible then.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
