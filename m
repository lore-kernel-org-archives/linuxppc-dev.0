Date: Tue,  1 Jun 2004 14:34:46 +0200
Message-Id: <HYMQXY$68CD56C10E486DAA5C77966D406CE84C@scarlet.be>
Subject: align.c handling of lswi / stswi
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "Stef Simoens" <stef.simoens@pi.be>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


(this is to be read after the MPC601 MQ patch - it is also a solution for the BUS errors with stswi / lswi instructions (cfr. archive Nov 2003))

Hi (again!)

While testing the PPC601 MQ patch, some programs were giving reproducible BUS errors. gcc 601-optimized code uses lswi / stswi, and the fix_alignment function didn't know how to handle this. I worked the alignment fix out for these instructions (arch/ppc/kernel/align.c)

My changes work (testing right now, with the MQ patch), however I'm not sure if my coding style is OK.
The main changes are:
- "union data" to "union data[7]" to store up to 4 * 8 = 32 bytes.
- extracting the number of bytes from the instruction, storing the number in (new var) mb (Multiple Bytes)
- calculating the number of required registers (rounding up if neccesary) in (new var) mr (Multiple Registers)
- introduced for loops in the LD and ST setting and storing parts. (with new var j)

I looked in the 64-bit alignment code (arch/ppc64/kernel/align.c) and found 'switch (nb)' cleaner than the existing 'for (i = 0; i < nb; ++i)'.

Questions:
Is my patch to fix the alignment of stswi / lswi wanted? I'm not planning to use #ifdef because stswi/lswi are valid ppc instructions (however, because of timing, gcc probably won't generate them on non 601).

Is it wanted to 'restyle' the ppc32 align.c to the ppc64 version -- with only ppc32 instructions and the same functionality of the existing ppc32 align.c of course...

If you'd answer both questions YES, would you like ONE big patch or two separate patches? I already presume you want a patch for 2.6 (and I will, when i'm sure my current 2.4 kernel runs smoothly with my patches.)

Sincere greetings

Stef


---------------------------------------------------------
With Scarlet ADSL your upload speed could reach 384 Kbits
More info at http://www.scarlet.be/nl/consumer/adsl/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
