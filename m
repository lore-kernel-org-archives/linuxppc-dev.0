Message-ID: <40C58140.9090400@fh-landshut.de>
Date: Tue, 08 Jun 2004 11:05:04 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: VME driver patch for PowerPC [Continued]
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com> <40C48A1C.30602@fh-landshut.de>
In-Reply-To: <40C48A1C.30602@fh-landshut.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I modified your vmemcpy() function and put it into driver master module like
below: (message continues after code)

/*===========================================================================
  * Copy data using the width specified
  * Returns: 0 or -1
  */
int vmemcpy_fromio(void *dest, const void *src, int nelem, int dw)
{
   int ii;

   /*
    * Depending on data width use byte, word or long word accesses.
    */
   switch (dw) {
   case VME_D8:
     {
       const uint8_t *s = src;
       uint8_t *d = dest;

       for (ii = 0; ii < nelem; ++ii, ++s, ++d)
	*d = readb(s);
     }
     break;
   case VME_D16:
     {
       const uint16_t *s = src;
       uint16_t *d = dest;

       for (ii = 0; ii < nelem; ++ii, ++s, ++d)
	*d = readw(s);
     }
     break;
   case VME_D32:
     {
       const uint32_t *s = src;
       uint32_t *d = dest;

       for (ii = 0; ii < nelem; ++ii, ++s, ++d)
	*d = readl(s);
     }
     break;
   default:
     return -EINVAL;
   }

   return 0;
}

/*===========================================================================
  * Copy data using the width specified
  * Returns: 0 or -1
  */
int vmemcpy_toio(void *dest, const void *src, int nelem, int dw)
{
   int ii;

   /*
    * Depending on data width use byte, word or long word accesses.
    */
   switch (dw) {
   case VME_D8:
     {
       const uint8_t *s = src;
       uint8_t *d = dest;

       for (ii = 0; ii < nelem; ++ii, ++s, ++d)
	writeb(*s, d);
     }
     break;
   case VME_D16:
     {
       const uint16_t *s = src;
       uint16_t *d = dest;

       for (ii = 0; ii < nelem; ++ii, ++s, ++d)
	writew(*s, d);
     }
     break;
   case VME_D32:
     {
       const uint32_t *s = src;
       uint32_t *d = dest;

       for (ii = 0; ii < nelem; ++ii, ++s, ++d)
	writel(*s, d);
     }
     break;
   default:
     return -EINVAL;
   }

   return 0;
}

I left out VME_D64 because it has no direct corresponding readll() and writell()
in include/asm-ppc/io.h.

I tested it with reading 4 bytes, VME data width VME_D8, writing 4 byte, and
reading 4 byte, giving me the following VME tracer results: (message continues
after trace)
          |   TIME     BUS  ADDRESS    DATA   R/W SIZE  STAT   IRQ*  IACK* AM EX
          |   rel.    LEVEL                                  7654321 OC IO
     -----+---------------------------------------------------------------------
=>   TRIG|   0.00 us  3   01000000  ....DE..  R  UBYTE  OK  -------  1 1  0D 1
         1|   1.04 us  3   01000001  ......AD  R  LBYTE  OK  -------  1 1  0D 1
         2|   1.08 us  3   01000002  ....FA..  R  UBYTE  OK  -------  1 1  0D 1
         3|   1.08 us  3   01000003  ......CE  R  LBYTE  OK  -------  1 1  0D 1
         4| 50.892 ms  3   01000000  ....AF..  W  UBYTE  OK  -------  1 1  0D 1
         5|   0.40 us  3   01000001  ......FE  W  LBYTE  OK  -------  1 1  0D 1
         6|   0.44 us  3   01000002  ....AF..  W  UBYTE  OK  -------  1 1  0D 1
         7|   0.44 us  3   01000003  ......FE  W  LBYTE  OK  -------  1 1  0D 1
         8| 38.440 ms  3   01000000  ....AF..  R  UBYTE  OK  -------  1 1  0D 1
         9|   1.24 us  3   01000001  ......FE  R  LBYTE  OK  -------  1 1  0D 1
        10|   1.08 us  3   01000002  ....AF..  R  UBYTE  OK  -------  1 1  0D 1
        11|   1.08 us  3   01000003  ......FE  R  LBYTE  OK  -------  1 1  0D 1

So, this corresponds to reading successfully 0xDEADFACE bytewise from the bus,
writing 0xAFFEAFFE back, and reading that value again successfully
(vmemcpy_fromio - vmemcpy_toio - vmemcpy_fromio), with a data width of VME_D8.

I guess it should be possible to implement read() and write() in terms of these
function, though I'm not entirely sure how to determine how to select the master
window from user space.

Any ideas on read() and write()?

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
