Return-Path: <DavidHo@nanometrics.ca>
Received: from mail.nanometrics.ca (mail.nanometrics.ca [206.191.47.130])
	by ozlabs.org (Postfix) with SMTP id CF85267B58
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 02:05:51 +1000 (EST)
To: openssl-dev@openssl.org, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <OF343DDBB2.05522533-ON8525702F.005604F7-8525702F.0056D2E5@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Wed, 29 Jun 2005 11:50:36 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: PowerPC bn_div_words routine rewrite
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

This is a rewrite of the bn_div_words routine for the PowerPC arch, tested
on a MPC8xx processor.
I initially thought there is maybe a small mistake in the code that
requires a one-liner change but it turns out I have to redo the routine.
I guess this routine is not called very often as I see that most other
routines are hand-crafted, whereas this routine is compiled from a C
function that apparently has not gone through a whole lot of testing.

I wrote a C function to confirm correctness of the code.

unsigned long div_words (unsigned long h,
                         unsigned long l,
                         unsigned long d)
{
  unsigned long i_h; /* intermediate dividend */
  unsigned long i_q; /* quotient of i_h/d */
  unsigned long i_r; /* remainder of i_h/d */

  unsigned long i_cntr;
  unsigned long i_carry;

  unsigned long ret_q; /* return quotient */

  /* cannot divide by zero */
  if (d == 0) return 0xffffffff;

  /* do simple 32-bit divide */
  if (h == 0) return l/d;

  i_q = h/d;
  i_r = h - (i_q*d);
  ret_q = i_q;

  i_cntr = 32;

  while (i_cntr--)
  {
    i_carry = (l & 0x80000000) ? 1:0;
    l = l << 1;

    i_h = (i_r << 1) | i_carry;
    i_q = i_h/d;
    i_r = i_h - (i_q*d);

    ret_q = (ret_q << 1) | i_q;
  }

  return ret_q;
}


Then I handcrafted the routine in PPC assembly.
The result is a 26 line assembly that is easy to understand and predictable
as opposed to a 81liner that I am still trying to decipher...
If anyone is interested in incorporating this routine to the openssl code
I'll be happy to assist.
At this point I think I will be taking a bit of a break from this 3 day
debugging/fixing marathon.

Regards,
David Ho


#
#       Handcrafted version of bn_div_words
#
#       r3 = h
#       r4 = l
#       r5 = d

        cmplwi  0,r5,0                  # compare r5 and 0
        bc      BO_IF_NOT,CR0_EQ,.Lppcasm_div1  # proceed if d!=0
        li      r3,-1                   # d=0 return -1
        bclr    BO_ALWAYS,CR0_LT
.Lppcasm_div1:
        cmplwi  0,r3,0                  # compare r3 and 0
        bc      BO_IF_NOT,CR0_EQ,.Lppcasm_div2  # proceed if h != 0
        divwu   r3,r4,r5                # ret_q = l/d
        bclr    BO_ALWAYS,CR0_LT        # return result in r3
.Lppcasm_div2:
        divwu   r9,r3,r5                # i_q = h/d
        mullw   r10,r9,r5               # i_r = h - (i_q*d)
        subf    r10,r10,r3
        mr      r3,r9                   # req_q = i_q
.Lppcasm_set_ctr:
        li      r12,32                  # ctr = bitsizeof(d)
        mtctr   r12
.Lppcasm_div_loop:
        addc    r4,r4,r4                # l = l << 1 -> i_carry
        adde    r11,r10,r10             # i_h = (i_r << 1) | i_carry
        divwu   r9,r11,r5               # i_q = i_h/d
        mullw   r10,r9,r5               # i_r = i_h - (i_q*d)
        subf    r10,r10,r11
        add     r3,r3,r3                # ret_q = ret_q << 1 | i_q
        add     r3,r3,r9
        bc      BO_dCTR_NZERO,CR0_EQ,.Lppcasm_div_loop
.Lppc_div_end:
        bclr    BO_ALWAYS,CR0_LT        # return result in r3
        .long   0x00000000
