Date: Wed, 29 Mar 2000 12:45:18 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet 
In-Reply-To: <200003271913.OAA28080@mal-ach.watson.ibm.com>
Message-ID: <Pine.HPX.4.10.10003291229460.14656-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Mar 2000, David Edelsohn wrote:

>
> 	Gabriel's patch is the correct way to address the problem and
> should be the one which goes into the public sources.

Thanks, and sorry for the delay. I was busy on other fronts (my wife had
surgery on Monday, nothing serious however).

> 	I do not understand, however, why the patch only includes the "=m"
> constraint on regw() and not regw16().  All of the inlined functions
> should have constraints which reference the actual memory address read or
> written to ensure proper dependencies in optimized code.

Well, I overlooked that. What I wanted to insist upon in my patch was that
the volatile was absolutely unnecessary.

Actually, if it were my call I would have declared the variable as
volatile unsigned  char *, which is the right type for address arithmetic
and eliminates any need for cast on byte accesses. I consider minimizing
the number or required casts as the right guideline to choose the variable
type in this case.

BTW, did anybody think of adding a __builtin_byteswap to GCC ?

This would allow the compiler to directly generate *brx instructions on
PPC by combining them with memory loads and stores. I'm aware that it
would require an additional constraint letter for indexed addressing modee
only but this is required for Altivec anyway.

And this would open opportunities for quite a lot of optimizations, for
example when setting or clearing some bits in a device register. In this
latter case (and in the given example) operands are often constants and
the compiler could generate non byte swapped load and stores and byte swap
the constants.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
