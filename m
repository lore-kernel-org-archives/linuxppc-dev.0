Date: Sun, 24 Jun 2001 16:52:34 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guillaume =?ISO-8859-1?Q?Laur=E8s?= <guillaume.laures@noos.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: another endianness issue...
In-Reply-To: <3B35F23B.5030003@noos.fr>
Message-ID: <Pine.LNX.4.05.10106241648530.16559-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Jun 2001, Guillaume Laurès wrote:
> Timothy A. Seufert wrote:
> > Kill the struct definition, and replace it with a bunch of accessor
> > macros that mask-and-shift.  When moving the register value to or
> > from the hardware, use le32_to_cpu() and cpu_to_le32() as appropriate.
>
> Okay, so as this are my first steps in kernel programming, let's take an
> example :-)
>
> Somewhere at the beginning of the driver we have something like this:
>
> while (DAC960_LA_InitializationInProgressP(BaseAddress))
> {blabla}
>
> DAC960_LA_InitializationInProgressP() is defined as follows in the .h:
>
> static inline
> boolean DAC960_BA_InitializationInProgressP(void *ControllerBaseAddress)
> {
>   DAC960_BA_InboundDoorBellRegister_T InboundDoorBellRegister;
>   InboundDoorBellRegister.All =
>    readb(ControllerBaseAddress + DAC960_BA_InboundDoorBellRegisterOffset);
>   return !InboundDoorBellRegister.Read.InitializationNotInProgress;
> }
>
> and, for the record, the DAC960_BA_InboundDoorBellRegister_T is
> something like this:
>
> typedef union DAC960_BA_InboundDoorBellRegister
> {
>   unsigned char All;
>   struct {
>    boolean HardwareMailboxNewCommand:1;                /* Bit 0 */
>    boolean AcknowledgeHardwareMailboxStatus:1;         /* Bit 1 */
>    boolean GenerateInterrupt:1;                        /* Bit 2 */
>    boolean ControllerReset:1;                          /* Bit 3 */
>    boolean MemoryMailboxNewCommand:1;                  /* Bit 4 */
>    unsigned char :3;                                   /* Bits 5-7 */
>   } Write;
>   struct {
>    boolean HardwareMailboxEmpty:1;                     /* Bit 0 */
>    boolean InitializationNotInProgress:1;              /* Bit 1 */
>    unsigned char :6;                                   /* Bits 2-7 */
>   } Read;
> }
> DAC960_BA_InboundDoorBellRegister_T;
>
>
>
> What would I do now is modify  DAC960_LA_InitializationInProgressP() as
> follows:
>
> static inline
> boolean DAC960_BA_InitializationInProgressP(void *ControllerBaseAddress)
> {
>   unsigned long InboundDoorBellRegister =
>    le32_to_cpu(ControllerBaseAddress +
> DAC960_BA_InboundDoorBellRegisterOffset);
>   return (boolean) !(InboundDoorBellRegister & 0x0002);
> }
>
> Is it correct ?

No, you must still use readb(), not a direct memory access.
Furthermore readw() and readl() do byteswapping theirselves on big-endian
architectures.

For this case le32_to_cpu() is wrong too, because it's meant for 32-bit
access while the original code used readb(), which does an 8 bit-access.
And 8-bit accesses don't have to be swapped.

Their is another issue with bitfields, though: their definition is reversed
for little and big endian machines. So you need two different struct
definitions, depending on the endianness.

> And where can I find the cpu_to_le32() and le32_to_cpu() declaration or
> a guide on how to use them ?

include/linux/byteorder/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
