Return-Path: <davidkwho@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.206])
	by ozlabs.org (Postfix) with ESMTP id C232367BB8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 08:29:27 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i6so200165wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 15:29:26 -0700 (PDT)
Message-ID: <4dd15d1805063015226379a52c@mail.gmail.com>
Date: Thu, 30 Jun 2005 18:22:12 -0400
From: David Ho <davidkwho@gmail.com>
To: openssl-dev@openssl.org, linuxppc-embedded@ozlabs.org
In-Reply-To: <4dd15d1805063003587276af7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4dd15d1805063003587276af7e@mail.gmail.com>
Subject: Re: PPC bn_div_words routine rewrite
Reply-To: David Ho <davidkwho@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The reason I had to redo this routine, in case anyone is wondering, is
because ssh-keygen  segfaults when this assembly routine returns junk
to the BN_div_word function. On a ppc, if you issue the command

ssh-keygen -t rsa1 -f /etc/ssh/ssh_host_key -N ""

The program craps out when it tries to write the public key in ascii decima=
l.

Regards,
David=20

On 6/30/05, David Ho <davidkwho@gmail.com> wrote:
> Hi all,
>=20
> This is a rewrite of the bn_div_words routine for the PowerPC arch,
> tested on a MPC8xx processor.
> I initially thought there is maybe a small mistake in the code that
> requires a one-liner change but it turns out I have to redo the
> routine.
> I guess this routine is not called very often as I see that most other
> routines are hand-crafted, whereas this routine is compiled from a C
> function that apparently has not gone through a whole lot of testing.
>=20
> I wrote a C function to confirm correctness of the code.
>=20
> unsigned long div_words (unsigned long h,
>                          unsigned long l,
>                          unsigned long d)
> {
>   unsigned long i_h; /* intermediate dividend */
>   unsigned long i_q; /* quotient of i_h/d */
>   unsigned long i_r; /* remainder of i_h/d */
>=20
>   unsigned long i_cntr;
>   unsigned long i_carry;
>=20
>   unsigned long ret_q; /* return quotient */
>=20
>   /* cannot divide by zero */
>   if (d =3D=3D 0) return 0xffffffff;
>=20
>   /* do simple 32-bit divide */
>   if (h =3D=3D 0) return l/d;
>=20
>   i_q =3D h/d;
>   i_r =3D h - (i_q*d);
>   ret_q =3D i_q;
>=20
>   i_cntr =3D 32;
>=20
>   while (i_cntr--)
>   {
>     i_carry =3D (l & 0x80000000) ? 1:0;
>     l =3D l << 1;
>=20
>     i_h =3D (i_r << 1) | i_carry;
>     i_q =3D i_h/d;
>     i_r =3D i_h - (i_q*d);
>=20
>     ret_q =3D (ret_q << 1) | i_q;
>   }
>=20
>   return ret_q;
> }
>=20
>=20
> Then I handcrafted the routine in PPC assembly.
> The result is a 26 line assembly that is easy to understand and
> predictable as opposed to a 81liner that I am still trying to
> decipher...
> If anyone is interested in incorporating this routine to the openssl
> code I'll be happy to assist.
> At this point I think I will be taking a bit of a break from this 3
> day debugging/fixing marathon.
>=20
> Regards,
> David Ho
>=20
>=20
> #
> #       Handcrafted version of bn_div_words
> #
> #       r3 =3D h
> #       r4 =3D l
> #       r5 =3D d
>=20
>         cmplwi  0,r5,0                  # compare r5 and 0
>         bc      BO_IF_NOT,CR0_EQ,.Lppcasm_div1  # proceed if d!=3D0
>         li      r3,-1                   # d=3D0 return -1
>         bclr    BO_ALWAYS,CR0_LT
> .Lppcasm_div1:
>         cmplwi  0,r3,0                  # compare r3 and 0
>         bc      BO_IF_NOT,CR0_EQ,.Lppcasm_div2  # proceed if h !=3D 0
>         divwu   r3,r4,r5                # ret_q =3D l/d
>         bclr    BO_ALWAYS,CR0_LT        # return result in r3
> .Lppcasm_div2:
>         divwu   r9,r3,r5                # i_q =3D h/d
>         mullw   r10,r9,r5               # i_r =3D h - (i_q*d)
>         subf    r10,r10,r3
>         mr      r3,r9                   # req_q =3D i_q
> .Lppcasm_set_ctr:
>         li      r12,32                  # ctr =3D bitsizeof(d)
>         mtctr   r12
> .Lppcasm_div_loop:
>         addc    r4,r4,r4                # l =3D l << 1 -> i_carry
>         adde    r11,r10,r10             # i_h =3D (i_r << 1) | i_carry
>         divwu   r9,r11,r5               # i_q =3D i_h/d
>         mullw   r10,r9,r5               # i_r =3D i_h - (i_q*d)
>         subf    r10,r10,r11
>         add     r3,r3,r3                # ret_q =3D ret_q << 1 | i_q
>         add     r3,r3,r9
>         bc      BO_dCTR_NZERO,CR0_EQ,.Lppcasm_div_loop
> .Lppc_div_end:
>         bclr    BO_ALWAYS,CR0_LT        # return result in r3
>         .long   0x00000000
>
