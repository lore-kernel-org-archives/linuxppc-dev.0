Message-ID: <3A37867B.2070606@galileo.co.il>
Date: Wed, 13 Dec 2000 16:23:55 +0200
From: Rabeeh Khoury <rabeeh@galileo.co.il>
Reply-To: rabeeh@galileo.co.il
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: problems with powerpc-linux-gcc
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I'm having trouble with compiling some code that I will use for our
embedded system when booting the system.

The function that I'm having trouble with is the printf function. I used
this function in i386 and mips environement (cross compiling) and it
worked fine, the argumenents are forwarded to the function are put in
the stack and the printf fetches them and then displays the formatted
output.

In the powerpc environemnt (using GNU powerpc-linux-gcc cross compiler),
the compiler puts the arguments in registers instead of the stack ; due
to that the printf can only print the constant characters but the %d %x
etc can not print them right.

here is the code :


static char *do_printf(char *buf, const char *fmt, const int *dp)
{
   register char *p;
   char tmp[16];
...
...
...
}


void printf(const char *fmt, ...)
{
   char buf[256],*p;
   p = buf;
   do_printf(buf, fmt, ((const int *)&fmt)+1);
   while (*p) putchar(*p++);
}


The calling function -
for (temp = 0 ; temp < 15 ; temp ++) {
   printf ("???? %d\n",temp);
}

and the output is -
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184
???? 565184

and the disassembly of the calling function is -

  400000:       94 21 ff f0     stwu    r1,-16(r1)
  400004:       7c 08 02 a6     mflr    r0
  400008:       bf c1 00 08     stmw    r30,8(r1)
  40000c:       90 01 00 14     stw     r0,20(r1)
  400010:       3b e0 00 00     li      r31,0
  400014:       3f c0 00 41     lis     r30,65
  400018:       7f e4 fb 78     mr      r4,r31
  40001c:       38 7e fa 80     addi    r3,r30,-1408
  400020:       48 00 66 e5     bl      406704 <printf>
  400024:       3b ff 00 01     addi    r31,r31,1
  400028:       28 1f 00 0e     cmplwi  r31,14
  40002c:       40 81 ff ec     ble     400018 <boot_entry+0x18>






Thank you a milion -
Rabeeh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
