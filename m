Message-ID: <3B34616F.2090403@noos.fr>
Date: Sat, 23 Jun 2001 11:29:19 +0200
From: Guillaume =?ISO-8859-1?Q?Laur=E8s?= <guillaume.laures@noos.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Cc: "Leonard N. Zubkoff" <lnz@dandelion.com>
Subject: another endianness issue...
References: <3B2E747A.6090607@noos.fr> <01061823464800.00690@reality.internal> <3B2F0871.2070304@noos.fr> <0106192003070C.00609@reality.internal>
Content-Type: multipart/mixed;
 boundary="------------050204040903090301040400"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------050204040903090301040400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

I've tracked down the problem with the DAC960 driver (drivers/block), a
module that handles the mylex range of raid cards.

All the structures dealing with the card sound like this one:

typedef union DAC960_LA_InboundDoorBellRegister
{
   unsigned char All;
   struct {
     boolean HardwareMailboxNewCommand:1;                /* Bit 0 */
     boolean AcknowledgeHardwareMailboxStatus:1;         /* Bit 1 */
     boolean GenerateInterrupt:1;                        /* Bit 2 */
     boolean ControllerReset:1;                          /* Bit 3 */
     boolean MemoryMailboxNewCommand:1;                  /* Bit 4 */
     unsigned char :3;                                   /* Bits 5-7 */
   } Write;
   struct {
     boolean HardwareMailboxEmpty:1;                     /* Bit 0 */
     boolean InitializationNotInProgress:1;              /* Bit 1 */
     unsigned char :6;                                   /* Bits 2-7 */
   } Read;
}
DAC960_LA_InboundDoorBellRegister_T

And I guess on ppc we would need all the bits line reversed.

So, my question is how to handle this in the best approach, the goal
being a unified driver nt too difficult to maintain

I've attached a little sample written by hollis that reproduces the
problem. I've managed to get gcc choose the right structure according to
the endianness of the host with endian.h and a couple of #ifdef, but
this is still rather bad since we have to maintain two versions of the
structs.

Does antbody has a good idea on this or an example of driver we could
follow ?

Thanks,

GoM

--------------050204040903090301040400
Content-Type: text/plain;
 name="struct_endian.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="struct_endian.c"

/**********************************************
 *                                            *
 * gcc -Wall struct_endian.c -o struct_endian *
 *                                            *
 **********************************************/

#include <stdio.h>
#include <endian.h>

#if __BYTE_ORDER == __LITTLE_ENDIAN
union byte {
  unsigned char all;
  struct {
    unsigned char zero:1;
    unsigned char one:1;
    unsigned char two:1;
    unsigned char three:1;
    unsigned char four:1;
    unsigned char five:1;
    unsigned char size:1;
    unsigned char seven:1;
  } split;
};
#elif __BYTE_ORDER == __BIG_ENDIAN
union byte {
  unsigned char all;
  struct {
    unsigned char seven:1;
    unsigned char size:1;
    unsigned char five:1;
    unsigned char four:1;
    unsigned char three:1;
    unsigned char two:1;
    unsigned char one:1;
    unsigned char zero:1;
  } split;
};
#endif


int main(void)
{
  union byte a;
  unsigned char c;

  a.all = 0x1;
  c = 0x1;

  printf("struct:\n");
  printf("  bit 0 = %u\n", a.split.zero);
  printf("  bit 7 = %u\n", a.split.seven);

  printf("char:\n");
  printf("  bit 0 = %u\n", c & 0x1);
  printf("  bit 7 = %u\n", c >> 7);

  return 0;
}


--------------050204040903090301040400--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
