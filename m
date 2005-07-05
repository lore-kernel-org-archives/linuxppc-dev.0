Return-Path: <davidkwho@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id F169B67C84
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 02:36:52 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 36so938274wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 05 Jul 2005 09:36:51 -0700 (PDT)
Message-ID: <4dd15d1805070509361339d08e@mail.gmail.com>
Date: Tue, 5 Jul 2005 12:36:51 -0400
From: David Ho <davidkwho@gmail.com>
To: appro@fy.chalmers.se, linuxppc-embedded@ozlabs.org, openssl-dev@openssl.org
In-Reply-To: <4dd15d1805070508451b76afae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <19EE6EC66973A5408FBE4CB7772F6F0A02C8770E@ltnmail.xyplex.com>
	<4dd15d1805070508312427a0ba@mail.gmail.com>
	<4dd15d1805070508451b76afae@mail.gmail.com>
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

First pass debugging results from gdb on ppc8xx.  Executing ssh-keygen
with following arguments.

(gdb) show args
Argument list to give program being debugged when it is started is
    "-t rsa1 -f /etc/ssh/ssh_host_key -N """.

Program received signal SIGSEGV, Segmentation fault.
BN_bn2dec (a=3D0x1002d9f0) at bn_print.c:136
136                             *lp=3DBN_div_word(t,BN_DEC_CONV);

(gdb) i r
r0             0x0      0
r1             0x7fffd580       2147472768
r2             0x30012868       805382248
r3             0x80000000       2147483648
r4             0xfef33fc        267334652
r5             0x25     37
r6             0xfccdef8        265084664
r7             0x7fffd4c0       2147472576
r8             0xfbad2887       4222429319
r9             0x84044022       2214871074
r10            0x0      0
r11            0x2      2
r12            0xfef2054        267329620
r13            0x10030bc8       268635080
r14            0x0      0
r15            0x0      0
r16            0x0      0
r17            0x0      0
r18            0x0      0
r19            0x0      0
r20            0x0      0
r21            0x0      0
r22            0x0      0
r23            0x64     100
r24            0x5      5
r25            0x1002d438       268620856
r26            0x1002d9f0       268622320
r27            0x1002c578       268617080
r28            0x1      1
r29            0x10031000       268636160
r30            0xffbf7d0        268171216
r31            0x1002d9f0       268622320
pc             0xfef2058        267329624
ps             0xd032   53298
cr             0x24044022       604258338
lr             0xfef2054        267329620
ctr            0xfccefa0        265088928
xer            0x20000000       536870912
fpscr          0x0      0
vscr           0x0      0
vrsave         0x0      0

(gdb) p/x $pc
$1 =3D 0xfef2058

0x0fef2058 <BN_bn2dec+472>:     stw     r3,0(r29)

(gdb) x 0x10031000
0x10031000:     Cannot access memory at address 0x10031000










On 7/5/05, David Ho <davidkwho@gmail.com> wrote:
> This is the second confirmed report of the same problem on the ppc8xx.
>=20
> After reading my email.  I must say I was the unfriendly one, I
> apologize for that.
>=20
> More debugging evidence to come.
>=20
> ---------- Forwarded message ----------
> From: Murch, Christopher <cmurch@mrv.com>
> Date: Jul 1, 2005 9:46 AM
> Subject: RE: PPC bn_div_words routine rewrite
> To: David Ho <davidkwho@gmail.com>
>=20
>=20
> David,
> I had observed the same issue on ppc 8xx machines after upgrading to the =
asm
> version of the BN routines.  Thank you very much for your work for the fi=
x.
> My question is, do you have high confidence in the other new asm ppc BN
> routines after observing this issue or do you think they might have simil=
iar
> problems?
> Thanks.
> Chris
>=20
> -----Original Message-----
> From: David Ho [mailto:davidkwho@gmail.com]
> Sent: Thursday, June 30, 2005 6:22 PM
> To: openssl-dev@openssl.org; linuxppc-embedded@ozlabs.org
> Subject: Re: PPC bn_div_words routine rewrite
>=20
>=20
> The reason I had to redo this routine, in case anyone is wondering, is
> because ssh-keygen  segfaults when this assembly routine returns junk
> to the BN_div_word function. On a ppc, if you issue the command
>=20
> ssh-keygen -t rsa1 -f /etc/ssh/ssh_host_key -N ""
>=20
> The program craps out when it tries to write the public key in ascii
> decimal.
>=20
> Regards,
> David
>=20
> On 6/30/05, David Ho <davidkwho@gmail.com> wrote:
> > Hi all,
> >
> > This is a rewrite of the bn_div_words routine for the PowerPC arch,
> > tested on a MPC8xx processor.
> > I initially thought there is maybe a small mistake in the code that
> > requires a one-liner change but it turns out I have to redo the
> > routine.
> > I guess this routine is not called very often as I see that most other
> > routines are hand-crafted, whereas this routine is compiled from a C
> > function that apparently has not gone through a whole lot of testing.
> >
> > I wrote a C function to confirm correctness of the code.
> >
> > unsigned long div_words (unsigned long h,
> >                          unsigned long l,
> >                          unsigned long d)
> > {
> >   unsigned long i_h; /* intermediate dividend */
> >   unsigned long i_q; /* quotient of i_h/d */
> >   unsigned long i_r; /* remainder of i_h/d */
> >
> >   unsigned long i_cntr;
> >   unsigned long i_carry;
> >
> >   unsigned long ret_q; /* return quotient */
> >
> >   /* cannot divide by zero */
> >   if (d =3D=3D 0) return 0xffffffff;
> >
> >   /* do simple 32-bit divide */
> >   if (h =3D=3D 0) return l/d;
> >
> >   i_q =3D h/d;
> >   i_r =3D h - (i_q*d);
> >   ret_q =3D i_q;
> >
> >   i_cntr =3D 32;
> >
> >   while (i_cntr--)
> >   {
> >     i_carry =3D (l & 0x80000000) ? 1:0;
> >     l =3D l << 1;
> >
> >     i_h =3D (i_r << 1) | i_carry;
> >     i_q =3D i_h/d;
> >     i_r =3D i_h - (i_q*d);
> >
> >     ret_q =3D (ret_q << 1) | i_q;
> >   }
> >
> >   return ret_q;
> > }
> >
> >
> > Then I handcrafted the routine in PPC assembly.
> > The result is a 26 line assembly that is easy to understand and
> > predictable as opposed to a 81liner that I am still trying to
> > decipher...
> > If anyone is interested in incorporating this routine to the openssl
> > code I'll be happy to assist.
> > At this point I think I will be taking a bit of a break from this 3
> > day debugging/fixing marathon.
> >
> > Regards,
> > David Ho
> >
> >
> > #
> > #       Handcrafted version of bn_div_words
> > #
> > #       r3 =3D h
> > #       r4 =3D l
> > #       r5 =3D d
> >
> >         cmplwi  0,r5,0                  # compare r5 and 0
> >         bc      BO_IF_NOT,CR0_EQ,.Lppcasm_div1  # proceed if d!=3D0
> >         li      r3,-1                   # d=3D0 return -1
> >         bclr    BO_ALWAYS,CR0_LT
> > .Lppcasm_div1:
> >         cmplwi  0,r3,0                  # compare r3 and 0
> >         bc      BO_IF_NOT,CR0_EQ,.Lppcasm_div2  # proceed if h !=3D 0
> >         divwu   r3,r4,r5                # ret_q =3D l/d
> >         bclr    BO_ALWAYS,CR0_LT        # return result in r3
> > .Lppcasm_div2:
> >         divwu   r9,r3,r5                # i_q =3D h/d
> >         mullw   r10,r9,r5               # i_r =3D h - (i_q*d)
> >         subf    r10,r10,r3
> >         mr      r3,r9                   # req_q =3D i_q
> > .Lppcasm_set_ctr:
> >         li      r12,32                  # ctr =3D bitsizeof(d)
> >         mtctr   r12
> > .Lppcasm_div_loop:
> >         addc    r4,r4,r4                # l =3D l << 1 -> i_carry
> >         adde    r11,r10,r10             # i_h =3D (i_r << 1) | i_carry
> >         divwu   r9,r11,r5               # i_q =3D i_h/d
> >         mullw   r10,r9,r5               # i_r =3D i_h - (i_q*d)
> >         subf    r10,r10,r11
> >         add     r3,r3,r3                # ret_q =3D ret_q << 1 | i_q
> >         add     r3,r3,r9
> >         bc      BO_dCTR_NZERO,CR0_EQ,.Lppcasm_div_loop
> > .Lppc_div_end:
> >         bclr    BO_ALWAYS,CR0_LT        # return result in r3
> >         .long   0x00000000
> >
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
