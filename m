Date: Mon, 3 Mar 2003 16:14:19 +1100
From: Erik Christiansen <erik@dd.nec.com.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Calling __eabi
Message-ID: <20030303051419.GB1169@dd.nec.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   Despite compiling with;

powerpc-linux-gcc -Iinclude -g -meabi -c -o obj/app_init.o app_init.c

   the expected compiler-generated call to __eabi() is not magically inserted
at the start of main. (Using powerpc-linux-gcc version 2.95.3)

   Have I perhaps misinterpreted the following in the GNU CC Manual?:

>>>
   Selecting -meabi means that the stack is aligned to an 8 byte boundary, a
function __eabi is called to from main to set up the eabi environment, and the
`-msdata' option can use both r2 and r13 to point to two separate small data
areas.
<<<

   And in Motorola's AN1809:

>>>
   Much of the required EABI register setup is accomplished through a call to
   __eabi(). The user does not call this function directly. Instead, the
   compiler inserts the call to __eabi() at the beginning of main() in the user
   program.
<<<

   From an objdump of the object file:

>>>
int main(void)^M
{^M
  104258:   94 21 ff f0    stwu  r1,-16(r1)
  10425c:   7c 08 02 a6    mflr  r0
  104260:   93 e1 00 0c    stw   r31,12(r1)
  104264:   90 01 00 14    stw   r0,20(r1)
  104268:   7c 3f 0b 78    mr r31,r1
   init_led();                               // Whoof! Into it, but no __eabi!?
  10426c:   48 00 07 89    bl 1049f4 <init_led>
<<<

   There's sommat else that needs to be done, to tickle it into
delivering the goods, and I haven't twigged to it yet.

Regards,
Erik


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
