Message-ID: <3B35F23B.5030003@noos.fr>
Date: Sun, 24 Jun 2001 15:59:23 +0200
From: Guillaume =?ISO-8859-1?Q?Laur=E8s?= <guillaume.laures@noos.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: another endianness issue...
References: <3B2E747A.6090607@noos.fr> <01061823464800.00690@reality.internal> <3B2F0871.2070304@noos.fr> <0106192003070C.00609@reality.internal> <3B34616F.2090403@noos.fr> <v04220800b75a8da0ed9d@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Timothy A. Seufert wrote:

> Kill the struct definition, and replace it with a bunch of accessor
> macros that mask-and-shift.  When moving the register value to or
> from the hardware, use le32_to_cpu() and cpu_to_le32() as appropriate.

Okay, so as this are my first steps in kernel programming, let's take an
example :-)

Somewhere at the beginning of the driver we have something like this:

while (DAC960_LA_InitializationInProgressP(BaseAddress))
{blabla}

DAC960_LA_InitializationInProgressP() is defined as follows in the .h:

static inline
boolean DAC960_BA_InitializationInProgressP(void *ControllerBaseAddress)
{
  DAC960_BA_InboundDoorBellRegister_T InboundDoorBellRegister;
  InboundDoorBellRegister.All =
   readb(ControllerBaseAddress + DAC960_BA_InboundDoorBellRegisterOffset);
  return !InboundDoorBellRegister.Read.InitializationNotInProgress;
}

and, for the record, the DAC960_BA_InboundDoorBellRegister_T is
something like this:

typedef union DAC960_BA_InboundDoorBellRegister
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
DAC960_BA_InboundDoorBellRegister_T;



What would I do now is modify  DAC960_LA_InitializationInProgressP() as
follows:

static inline
boolean DAC960_BA_InitializationInProgressP(void *ControllerBaseAddress)
{
  unsigned long InboundDoorBellRegister =
   le32_to_cpu(ControllerBaseAddress +
DAC960_BA_InboundDoorBellRegisterOffset);
  return (boolean) !(InboundDoorBellRegister & 0x0002);
}

Is it correct ?
And where can I find the cpu_to_le32() and le32_to_cpu() declaration or
a guide on how to use them ?

Thanks


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
