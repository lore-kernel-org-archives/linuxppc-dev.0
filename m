Message-ID: <3C92650F.BBF660E8@americasm01.nt.com>
Date: Fri, 15 Mar 2002 16:18:08 -0500
From: "Etienne Martineau" <etiennem@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8245 Uart & I2C 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm actually using PpcBoot & Linux HHL2.0 on a 8245 Custom board.
Everything work fine now bud I  had to tweek some stuff to make it work
! (Uart, I2C, EPIC)

So here is how I did that (if anyone interested!)

UART:
    I set the EUMBAR in ppcboot to be 0xf8f04500.
    I also match this value in Linux sandpoint.h #define COM1 0xf8f04500

    In Sandpoint_setup.c you point the Uart  ppc_md.progress to
sandpoint_progress...
    The first problem arrive when the CPU hit the code in
mpc10x_common.c
        -> /* Map EPIC register part of EUMB into vitual memory */
          OpenPIC_Addr =
               ioremap(phys_eumb_base + MPC10X_EUMB_EPIC_OFFSET,
                MPC10X_EUMB_EPIC_SIZE);
    This stuff basically remap the EUMBAR and so for the UART. The
OpenPIC_Addr handle is used
    by the open_pic.c file to basically set the IRQ stuff.
    The trick I did to avoid playing with the OpenPIC ioremap stuff is
that I create a
    var named: void* Uart_EUMBAR_Addr;  which is global and AFTER the
ioremap I assign
    this var to the new address of the Uart
        ->Uart_EUMBAR_Addr = ioremap(phys_eumb_base + 0x4500 ,0x4000);
                 if (ppc_md.progress) ppc_md.progress =
new_sandpoint_progress;
                 if (ppc_md.progress) ppc_md.progress("After Set
EUMBAR", 0x100);    /*This Display stuff After EUMBAR Manipulation by
Linux*/

So you understand that the Redirection of ppc_md.progress need support
...
So In Sandpoint_setup.c I had that stuff.

extern void* Uart_EUMBAR_Addr;

void new_sandpoint_putc(volatile char s)
{
  volatile struct NS16550 *com_port;
  com_port = (volatile struct NS16550 *)(Uart_EUMBAR_Addr);
  while ((com_port->lsr & LSR_THRE) == 0) ;
  com_port->thr = s;
}

void
new_sandpoint_progress(char *s, unsigned short hex)
{
        volatile char c;
        volatile struct NS16550 *com_port;
        com_port = (volatile struct NS16550 *)(Uart_EUMBAR_Addr);
        while ((c = *s++) != 0) {
          new_sandpoint_putc(c);
                if (c == '\n') {
                  new_sandpoint_putc('\r');
                }
        }
 return;
}
void new_sandpoint_printhex(unsigned int value, int cr)
{
  int i;
  const char hex[] = "0123456789abcdef";
    for (i = 0; i < 8; i++)
      new_sandpoint_putc(hex[value >> (28 - i * 4) & 0xf]);
    if (cr)
        new_sandpoint_putc('\n');
}

So now you have debug printout that look like that
Now booting the kernel
id mach(): doneMMU:enterMMU:hash inithash:enterhash:find
piecehash:patchhash:don
eMMU:mapinMMU:setbatMMU:exitsetup_arch: entersetup_arch:
bootmemmpc10x:enterAfte
r Set EUMBARmpc10x:exitarch: exitopenpic enteropenpic timeropenpic
extopenpic sp
uriousopenpic exit
The Serial Driver as to be fixed /driver/char/serial.c
-> static _INLINE_ unsigned int serial_in(struct async_struct *info, int
offset)
{
#ifdef CONFIG_yourflag
 extern void* Uart_EUMBAR_Addr;
 return readb((unsigned long) Uart_EUMBAR_Addr + offset);
#endif

->static _INLINE_ void serial_out(struct async_struct *info, int offset,

    int value)
{
#ifdef CONFIG_yourflag
 extern void* Uart_EUMBAR_Addr;
  writeb(value, (unsigned long) Uart_EUMBAR_Addr + offset);
  return;
#endif

for the IRQ stuff I define the Irq array in sandpoint_setup.c as
    static u_char sandpoint_openpic_initsenses[16+130] __initdata;
And in Open_PIC.c I add that stuff in the function openpic_init (...

/*Uart IRQ*/
  CurrIrq = 121+16;
  irq_desc[CurrIrq].status = IRQ_LEVEL;
  /* Enabled, Priority 8 or 9 */
  openpic_initirq(CurrIrq, 8, CurrIrq, 0, 1);
  /* Processor 0 */
  openpic_mapirq(CurrIrq, 1<<0);

/* PMC 82559 Ethernet */
  CurrIrq = 4+16;
  irq_desc[CurrIrq].status = IRQ_LEVEL;
  /* Enabled, Priority 8 or 9 */
  openpic_initirq(CurrIrq, 8, CurrIrq, 0, 1);
  /* Processor 0 */
  openpic_mapirq(CurrIrq, 1<<0);

The Uart IRQ is 137 (I know it's look strange but with the OpenPic Stuff
that the Only way I found to access it with minimal code change)
you should modify SERIAL_PORT_DFNS Irq field to match that stuff in
/include/asm/serial.h
The Baudrate should be also set correctly and also the BASE_BAUD that
depend of you board speed (SDRAM_CLK).
NB: I'm using EPIC in parallel mode Ex: ethernet controller is on
External IRQ 4 >>> use 4 +16 to map it (the +16 is to deal with OpenPIC
vs EPIC difference)

I2C:
This is an User Space (mmap) driver for a generic I2C access.
I map the EUMBAR and I talk to the I2C engine directly.
I think I took that driver from PPCBOOT source tree but I can't remember
exactly anyway it's in a
primitive but working state.

->#include <linux/types.h>
#include <linux/stat.h>
#include <linux/fcntl.h>
#include <asm/io.h>
#include <sys/mman.h>
#include <stdio.h>
#include <string.h>

#ifdef I2C_DEBUG_ON
#define PRINTF printf
#else
#define PRINTF
#endif

 #define OK    0
#define ERROR    -1

#define EEPROM_TYPE_MPC8240  0
#define I2C_DRV_TYPE   EEPROM_TYPE_MPC8240

/* low level definitions, specific */

#define SYNC __asm__ volatile ("sync")


#define BYTE_SWAP_16_BIT(x)    ( (((x) & 0x00ff) << 8) | ( (x) >> 8) )
#define LONGSWAP(x) ((((x) & 0x000000ff) << 24) | (((x) & 0x0000ff00) <<
8)|\
                     (((x) & 0x00ff0000) >>  8) | (((x) & 0xff000000) >>
24) )
#define PCISWAP(x)   LONGSWAP(x)



/* Mpc8240 IO / Internal Register */
#define MPC8240_EUMBAR 0xf8000000 - 0x100000
//#define I2C_BAR  MPC8240_EUMBAR+0x41000
#define I2C_BAR  MPC8240_EUMBAR+0x3000

typedef struct{
 unsigned long i2cAddrReg;
 unsigned long i2cFreqDivReg;
 unsigned long i2cControlReg;
 unsigned long i2cStatusReg;
 unsigned long i2cDataReg;
}I2CStruct;
static volatile I2CStruct *I2Cptr;

#ifdef STUB
I2CStruct mystub;
#endif

static FILE *fh;

#define MPC8240_I2C_ADR_REG (unsigned long)&(I2Cptr->i2cAddrReg)
#define MPC8240_I2C_FREQ_DIV_REG (unsigned long)&(I2Cptr->i2cFreqDivReg)

#define MPC8240_I2C_CONTROL_REG (unsigned long)&(I2Cptr->i2cControlReg)
#define MPC8240_I2C_STATUS_REG (unsigned long)&(I2Cptr->i2cStatusReg)
#define MPC8240_I2C_DATA_REG (unsigned long)&(I2Cptr->i2cDataReg)

/* Mpc8240 Register masks */
#define MPC8240_I2C_ADDRESS_REG_MASK  0x000000FE
#define MPC8240_I2C_FREQ_DIV_REG_MASK 0x0000003F
#define MPC8240_I2C_CONTROL_REG_MASK 0x000000FC
#define MPC8240_I2C_STATUS_REG_MASK 0x000000F7
#define MPC8240_I2C_DATA_REG_MASK 0x000000FF

/* Mpc8240 Control register values */
#define MPC8240_I2C_CONTROL_REG_MEN (1<<7) /* module enable */
#define MPC8240_I2C_CONTROL_REG_MIEN (1<<6) /* module interrupt enable
*/
#define MPC8240_I2C_CONTROL_REG_MSTA (1<<5) /* master/slave mode */
#define MPC8240_I2C_CONTROL_REG_MTX (1<<4) /* transmit/receiver mode  */

#define MPC8240_I2C_CONTROL_REG_TXAK (1<<3) /* transfer ack enable */
#define MPC8240_I2C_CONTROL_REG_RSTA (1<<2) /* repeat start */

/* Mpc8240 Status register values */
#define MPC8240_I2C_STATUS_REG_MCF (1<<7) /* data transferring */
#define MPC8240_I2C_STATUS_REG_MAAS (1<<6) /* addressed as a slave */
#define MPC8240_I2C_STATUS_REG_MBB (1<<5) /* bus busy */
#define MPC8240_I2C_STATUS_REG_MAL (1<<4) /* arbitration lost */
#define MPC8240_I2C_STATUS_REG_SRW (1<<2) /* slave read/write */
#define MPC8240_I2C_STATUS_REG_MIF (1<<1) /* module interrupt */
#define MPC8240_I2C_STATUS_REG_RXAK (1<<0) /* receive ack */

/*Application Specific*/
#define PRPMC600_EEPROM_WP  0x08
#define PRPMC600_SYS_STAT_REG1  0xffe00000
#define REAL_SPD_SIZE 256

/* forward declarations */
static unsigned long sysCalcBusSpd (void);
static unsigned long i2cPciInLong (unsigned long *);
static unsigned char i2cPciInByte (unsigned char *);
static void i2cPciOutLong (unsigned long *, unsigned long);
static void i2cPciOutByte (unsigned char *, unsigned char);
static int _abs(unsigned int);
static int _delta(unsigned int, unsigned int);
static unsigned long i2cPciIoctl(unsigned long, unsigned long,
    unsigned long, unsigned long);
void mpc8240_mpc107_write8(unsigned int address, unsigned char data);
void mpc8240_mpc107_write16(unsigned int address, unsigned short data);
void mpc8240_mpc107_write32(unsigned int address, unsigned int data);
unsigned char mpc8240_mpc107_read8(unsigned int address);
unsigned short mpc8240_mpc107_read16(unsigned int address);
unsigned int mpc8240_mpc107_read32(unsigned int address);


int I2CDoRepeatStart = 0; /* indicates if a "Repeat Start" is requested
*/

/******************************************************************************

*
* i2cDrvInit - initialize the i2c device
*
* This function's purpose is to the initialize the I2C device
* controller device for operation.  This function should only
* be executed once during system initialization time.
*
* RETURNS: OK, or ERROR if not prpmc600 board.
*/

int i2cCycleMpc8240Init
    (
    int i2cControllerType  /* I2C controller type */
    )
    {
    unsigned int busSpeed = 0;
    unsigned char  temp;
    unsigned int   statusReg;
 int memoryhandle;

#ifndef STUB
 /*Open an Handle to Access this Kernel Memory from User Process*/
 fh = fopen ("/dev/mem", "rw+");
  memoryhandle= (unsigned long) mmap (
       /* where to map to: don't mind */
       NULL,
       /* how many bytes ? */
       sizeof(I2CStruct),
       /* want to read and write */
       PROT_READ | PROT_WRITE,
       /* no copy on write */
       MAP_SHARED,
       /* handle to /dev/mem */
       fileno (fh),
       /*Addr of the physical Page*/
       I2C_BAR);
 if(memoryhandle ==-1){
  PRINTF("Failure on Allocation of region\n");
  return 1;
 }
  /*Here I assign the I2C Structure to the Virtual Mem Addr that
   as been mapped to Physical Addr*/
 I2Cptr = (I2CStruct*)memoryhandle;
#endif
#ifdef STUB
  /*Here I assign the Download Structure to the Virtual Mem Addr that
   as been mapped to Physical Addr STUB*/
 I2Cptr = (I2CStruct*)&mystub;
#endif

    /*
     * Check for unknown controller type, and initialize I2C controller
     * for operation (if needed).  Note: a switch will not work here if
     * executing from ROM due to branch history table creation.
     */

    if (i2cControllerType == 0) /* Mpc8240(MPC8240) */
        {
    /* disable the I2C module, set the device to Master Mode */
        i2cPciIoctl(3, (unsigned long)MPC8240_I2C_CONTROL_REG,
                    ~MPC8240_I2C_CONTROL_REG_MEN, 0);
        SYNC;

    /*Set Frequency*/
    i2cPciIoctl(4, (unsigned long)MPC8240_I2C_FREQ_DIV_REG,
                        (~MPC8240_I2C_FREQ_DIV_REG_MASK), 0x29);


        /* set the slave address */
        i2cPciIoctl(4, (unsigned long)MPC8240_I2C_ADR_REG,
                    (~MPC8240_I2C_ADDRESS_REG_MASK), 0x02);
        SYNC;
        /* enable the interface */
        i2cPciIoctl(2, (unsigned long)MPC8240_I2C_CONTROL_REG,
                    MPC8240_I2C_CONTROL_REG_MEN, 0);
        SYNC;

    PRINTF("\n  I2C init:\n");
     statusReg = i2cPciIoctl(1, (unsigned long)MPC8240_I2C_STATUS_REG,
0, 0);
        PRINTF("status: 0x%08x  ", statusReg);
        statusReg = i2cPciIoctl(1, (unsigned
long)MPC8240_I2C_CONTROL_REG, 0, 0);
        PRINTF("control: 0x%08x  ", statusReg);
        statusReg = i2cPciIoctl(1, (unsigned
long)MPC8240_I2C_FREQ_DIV_REG, 0, 0);
        PRINTF("Freq: 0x%08x\n", statusReg);
        statusReg = i2cPciIoctl(1, (unsigned long)MPC8240_I2C_ADR_REG,
0, 0);
        PRINTF("Adr: 0x%08x\n", statusReg);

       }
    else
        {
        return (-1);
        }

    return (0);

    }

int i2cCycleMpc8240Close(void)
{
#ifndef STUB
 munmap((caddr_t) I2C_BAR, sizeof(I2CStruct));
 fclose (fh);
#endif
 return 0;
}

/******************************************************************************

*
* i2cCycleMpc8240Start - perform I2C "start" cycle
*
* This function's purpose is to perform an I2C start cycle.
*
* RETURNS:
* zero  = operation successful
* non-zero = operation failed
*/

int i2cCycleMpc8240Start (void)
    {
    unsigned int timeOutCount;
    unsigned int statusReg = 0;

    /*
     * if this is a repeat start, then set the required bits and return.

     *
     * NOTE:
     * this driver ONLY supports one repeat start between the start
     * stop and cycles.
     */

    if(I2CDoRepeatStart == 1)
        {
        i2cCycleMpc8240Delay(1);
        i2cPciIoctl(2, (unsigned long)MPC8240_I2C_CONTROL_REG,
                    (MPC8240_I2C_CONTROL_REG_RSTA |
                     MPC8240_I2C_CONTROL_REG_MSTA |
                     MPC8240_I2C_CONTROL_REG_MTX),0);
        SYNC;
        i2cCycleMpc8240Delay(1);
        I2CDoRepeatStart = 0;  /* one repeat start only, so clear this
bit */
        return(0);
        }

    /*
     * wait until the I2C bus is free.  if it doesn't become free
     * within a *reasonable* amount of time, exit with an error.
     */

    for (timeOutCount = 10; timeOutCount; timeOutCount--)
        {
        i2cCycleMpc8240Delay(1);

        statusReg = i2cPciIoctl(1, (unsigned
long)MPC8240_I2C_STATUS_REG, 0, 0);
        SYNC;

        if (!(statusReg & MPC8240_I2C_STATUS_REG_MBB))
            {
            break;
            }
        }

    if (!timeOutCount)
        {
        return (-1);
        }

    /*
     * since this is the first time through, generate a START(MSTA) and
     * place the I2C interface into a master transmitter mode(MTX).
     */

    i2cPciIoctl(2, (unsigned long)MPC8240_I2C_CONTROL_REG,
                (MPC8240_I2C_CONTROL_REG_MTX |
                 MPC8240_I2C_CONTROL_REG_MSTA),0);
    SYNC;
    i2cCycleMpc8240Delay(1);

    /*
     * The first time through, set "I2CDoRepeatStart".  If this function

     * is called again BEFORE a STOP is sent, then we are doing a
     * "dummy write", which sets the devices internal byte pointer
     * to the byte we intend to read.
     */

    I2CDoRepeatStart = 1;

    return (0);

    }


/******************************************************************************

*
* i2cCycleMpc8240Stop - perform I2C "stop" cycle
*
* This function's purpose is to perform an I2C stop cycle.
*
* RETURNS:
* zero  = operation successful
* non-zero = operation failed
*/

int i2cCycleMpc8240Stop (void)
    {

    i2cCycleMpc8240Delay(1);

    /*
     * turn off MSTA bit(which will generate a STOP bus cycle)
     * turn off MTX bit(which places the MPC8240 interface into receive
mode
     * turn off TXAK bit(which allows 9th clock cycle acknowledges)
     */

    i2cPciIoctl(3, (unsigned long)MPC8240_I2C_CONTROL_REG,
                (~(MPC8240_I2C_CONTROL_REG_MTX  |
                MPC8240_I2C_CONTROL_REG_MSTA |
                MPC8240_I2C_CONTROL_REG_TXAK)),0);
    SYNC;
    i2cCycleMpc8240Delay(1);

    /*
     * Clear the global I2C "Repeat Start" flag.
     */

    I2CDoRepeatStart = 0;

    return (0);

    }


/******************************************************************************

*
* i2cCycleMpc8240Read - perform I2C "read" cycle
*
* This function's purpose is to perform an I2C read cycle.
*
* RETURNS:
* zero  = operation successful
* non-zero = operation failed
*/
int ReadAckFlag =0;

void  ReadAckFlag_ON(void)
{
 ReadAckFlag =1;
}
void  ReadAckFlag_OFF(void)
{
 ReadAckFlag =0;
}

int i2cCycleMpc8240Read
    (
    unsigned char *pReadDataBuf /* pointer to read data buffer */
    )
    {
    unsigned int readData = 0;

    i2cCycleMpc8240Delay(1);

    if(ReadAckFlag ==0){
    /*
     * place the I2C interface into receive mode(MTX=0) and set the
interface
     * to NOT acknowledge(TXAK=1) the incoming data on the 9th clock
cycle.
     * this is required when doing random reads of a I2C device.
     */

     i2cPciIoctl(4, (unsigned long)MPC8240_I2C_CONTROL_REG,
                (~MPC8240_I2C_CONTROL_REG_MTX),
                MPC8240_I2C_CONTROL_REG_TXAK);
     SYNC;
    }
    else{
     i2cPciIoctl(3, (unsigned long)MPC8240_I2C_CONTROL_REG,
                (~MPC8240_I2C_CONTROL_REG_MTX),0);
     i2cPciIoctl(3, (unsigned long)MPC8240_I2C_CONTROL_REG,
                (~MPC8240_I2C_CONTROL_REG_TXAK),0);

     SYNC;
  }
    i2cCycleMpc8240Delay(1);

    /* do a "dummy read".  this latches the data off the bus. */

    i2cPciIoctl(1, (unsigned long)MPC8240_I2C_DATA_REG, 0, 0);

    SYNC;
    i2cCycleMpc8240Delay(1);

    /* now do the actual read, make this one count */

    readData = i2cPciIoctl(1, (unsigned long)MPC8240_I2C_DATA_REG, 0,
0);
    SYNC;

    *pReadDataBuf = (unsigned char)readData;

    return (0);

    }


/******************************************************************************

*
* i2cCycleMpc8240Write - perform I2C "write" cycle
*
* This function's purpose is to perform an I2C write cycle.
*
* RETURNS:
* zero  = operation successful
* non-zero = operation failed
*/

int i2cCycleMpc8240Write
    (
    unsigned char writeData /* character to write */
    )
    {

    i2cCycleMpc8240Delay(1);

    /*
     * write the requested data to the data register, which will cause
     * it to be transmitted on the I2C bus.
     */

    i2cPciIoctl(0, (unsigned long)MPC8240_I2C_DATA_REG, writeData, 0);

    SYNC;
    i2cCycleMpc8240Delay(1);

    return (0);

    }


/******************************************************************************

*
* i2cCycleMpc8240AckIn - perform I2C "acknowledge-in" cycle
*
* This function's purpose is to perform an I2C acknowledge-in
* cycle.
*
* RETURNS:
* zero  = operation successful
* non-zero = operation failed
*/

int i2cCycleMpc8240AckIn (void)
    {
    unsigned int statusReg = 0;
    unsigned int timeOutCount;

    /*
     * wait until an *internal* device interrupt has been generated,
then
     * clear it.  if it is not received, return with an error.
     * we are polling, so NO processor interrupt is generated.
     */

    for (timeOutCount = 100; timeOutCount; timeOutCount--)
        {
        i2cCycleMpc8240Delay(1);

        statusReg = i2cPciIoctl(1, (unsigned
long)MPC8240_I2C_STATUS_REG, 0, 0);
        SYNC;

        if (statusReg & MPC8240_I2C_STATUS_REG_MIF)
            {
            i2cPciIoctl(3, (unsigned long)MPC8240_I2C_STATUS_REG,
                        (~MPC8240_I2C_STATUS_REG_MIF), 0);
            SYNC;
            break;
            }
        }

    if (!timeOutCount)
        {
        return (-1);
        }

    return (0);

    }


/******************************************************************************

*
* i2cCycleMpc8240AckOut - perform I2C "acknowledge-out" cycle
*
* This function's purpose is to perform an I2C acknowledge-out
* cycle.
*
* RETURN:
* zero  = operation successful
* non-zero = operation failed
*/

int i2cCycleMpc8240AckOut (void)
    {
    return (0);
    }


/******************************************************************************

*
* i2cCycleMpc8240KnownState - initialize the I2C bus to a known state
*
* This function's purpose is to initialize the I2C bus to a
* known state.
*
* RETURNS:
* zero  = operation successful
* non-zero = operation failed
*/

int i2cCycleMpc8240KnownState (void)
    {
    int status;
    unsigned int   timeOutCount;
    unsigned int   statusReg;

    status = OK;

    /*
     * wait u til the I2C bus is free.  if it doesn't become free
     * within a *reasonable* amount of time, exit with an error.
     */

    for (timeOutCount = 10; timeOutCount; timeOutCount--)
        {
        i2cCycleMpc8240Delay(1);

        statusReg = i2cPciIoctl(1, (unsigned
long)MPC8240_I2C_STATUS_REG, 0, 0);
        SYNC;
        PRINTF("statusReg: 0x%08x  MBB: 0x%08x  Reg: 0x%08x\n",
               statusReg,MPC8240_I2C_STATUS_REG_MBB,(statusReg &
MPC8240_I2C_STATUS_REG_MBB) );

        if (!(statusReg & MPC8240_I2C_STATUS_REG_MBB))
            {
     status = OK;
            break;
            }

        /*
  * re-initialize the I2C if the BUS BUSY does not clear
  * after trying half the *reasonable* amount of reads of the
  * status register.
  */

   }
    if (!timeOutCount)
 status = ERROR;

    return (status);
    }


/******************************************************************************

*
* i2cCycleMpc8240Delay - perform interface's I2C delay routine
*
* This function's purpose is to perform whatever delay
*       required for the device.
*
* RETURNS:
*       none.
*/

void i2cCycleMpc8240Delay
    (
    int mSeconds /* time to delay in milliseconds */
    )
    {
       int i = 0;
       for(i = 0;i < (mSeconds * 1000);i++){}
    }




/******************************************************************************

*
* i2cPciIoctl - i2cPciIn/OutLong and/or-ing wrapper.
*
* The purpose of this function is to perform and, or and
* and/or i2cPciIn/OutLong operations with syncronization.
*
* RETURNS: UINT32, for read operations.
*/

static unsigned long i2cPciIoctl
    (
    unsigned long ioctlflg,  /* input/ouput control flag
                        * 0, write
                              * 1, read
                              * 2, read/modify/write (ORing)
                              * 3, read/modify/write (ANDing)
                              * 4, read/modify/write (AND/ORing)
                              */
    unsigned long address,    /* address of device register to be
operated upon */
    unsigned long wdata1,     /* data item 1 for read/write operation */

    unsigned long wdata2      /* data item 2 for read/write operation */

    )
    {
    unsigned long u32temp;

    if (ioctlflg == 0) /* write */
        i2cPciOutLong((unsigned long *)address, wdata1);
    if (ioctlflg == 1) /* read */
        {
        wdata1 = i2cPciInLong((unsigned long *)address);
        }
    if (ioctlflg == 2) /* ORing */
        {
        u32temp = i2cPciInLong((unsigned long *)address);
        SYNC;
        u32temp |= wdata1;
        i2cPciOutLong((unsigned long *)address, u32temp);
        }
    if (ioctlflg == 3) /* ANDing */
        {
        u32temp = i2cPciInLong((unsigned long *)address);
        SYNC;
        u32temp &= wdata1;
        i2cPciOutLong((unsigned long *)address, u32temp);
        }
    if (ioctlflg == 4) /* AND/ORing */
        {
        u32temp = i2cPciInLong((unsigned long *)address);
        SYNC;
        u32temp &= wdata1;
        u32temp |= wdata2;
        i2cPciOutLong((unsigned long *)address, u32temp);
        }
    SYNC;
    return (wdata1);

    }


#define BAUD_RATE           9600
#define BAUD_RATE_CODE      12
#define EDGES_PER_PERIOD    2       /* one rising, one falling = 2 */
#define BAUD_CLOCK_RATIO    16      /* UART's BAUDOUT is 16x baud rate
*/
#define TIME_BASE_RATIO     4       /* time base clock is 1/4 bus
frequency */

#define MULTIPLIER (EDGES_PER_PERIOD * BAUD_CLOCK_RATIO *
TIME_BASE_RATIO)

static unsigned long sysCalcBusSpd (void)
    {
    extern unsigned int sysTimeEdges(unsigned int);

#if 0 /* We don't need to do this since we're already initialized */

    UCHAR * pUart = (UCHAR *) PRPMC600_COM1_UART;

    /* configure the uart for 9600 baud */

    pUart[UART_LCR * UART_REG_ADDR_INTERVAL] |= I8250_LCR_DLAB;
    pUart[UART_BRDL * UART_REG_ADDR_INTERVAL] = BAUD_RATE_CODE;
    pUart[UART_BRDH * UART_REG_ADDR_INTERVAL] = 0;
    pUart[UART_LCR * UART_REG_ADDR_INTERVAL] &= ~I8250_LCR_DLAB;
    SYNC;
#endif

    /*
     * call low-level edge timing routine, calculate bus frequency and
     * return the result.
     */
#if 0
    return (sysTimeEdges (BAUD_RATE) * MULTIPLIER);
#else
    return(1);
#endif


    }



static int _abs(unsigned int x){
    if(x < 0) return (-x);
    else      return (x);
}

static int _delta(unsigned int x,unsigned int y){
    return( _abs((int)x - (int)y) );
}


/*****************************************************************************

*
* i2cPciInLong - reads a longword from PCI I/O or Memory space
*
* This function reads a longword from a specified PCI I/O or Memory
address
* via the PCI bridge chip.  This function should be used for access
* to the I/O or Memory mapped registers of a PCI device.  These
* registers are mapped as little-endian, so we byte reverse the data in
order
* to make the value returned look the same as it would in PCI space.
*
* RETURNS: longword from address.
*
*/

static unsigned long i2cPciInLong (unsigned long * dataPtr)
    {
 return(mpc8240_mpc107_read32((unsigned int)dataPtr));

    }


/*****************************************************************************

*
* i2cPciOutLong - writes a longword to PCI I/O or Memory space
*
* This function writes a longword to a specified PCI I/O or Memory
address
* via the PCI bridge chip.  This function should be used for access
* to the I/O or Memory mapped registers of a PCI device.  These
* registers are mapped as little-endian, so we byte reverse the data in
order
* to make the value written correct for the registers in PCI space.
*
* RETURNS: N/A
*
*/

static void i2cPciOutLong
    (
    unsigned long * dataPtr,
    unsigned long data
    )
    {
mpc8240_mpc107_write32((unsigned int)dataPtr,data);

    }


/*****************************************************************************

*
* i2cPciInByte - reads a byte from PCI I/O or Memory space
*
* This function reads a byte from a specified PCI I/O or Memory address
* via the PCI bridge chip.  This function should be used for access
* to the I/O or Memory mapped registers of a PCI device.  Since this
routine
* accesses only a single byte of data no address or data manipulation is

* required.
*
* RETURNS: byte from address.
*/

static unsigned char i2cPciInByte (unsigned char * dataPtr)
    {
 return(mpc8240_mpc107_read8((unsigned int)dataPtr));

    }


/*****************************************************************************

*
* i2cPciOutByte - writes a byte to PCI I/O or Memory space
*
* This function writes a byte to a specified PCI I/O or Memory address
* via the QSPAN bridge chip.  This function should be used for writing
* to the I/O or Memory mapped registers of a PCI device.  Since this
routine
* writes only a single byte of data no address or data manipulation is
* required.
*
* RETURNS: N/A
*
*/

static void i2cPciOutByte
    (
    unsigned char * dataPtr,
    unsigned char data
    )
{
 mpc8240_mpc107_write8((unsigned int)dataPtr,data);

}





/*
 *  Write a byte (8 bits) to a memory location.
 */
void
mpc8240_mpc107_write8(unsigned int addr, unsigned char data)
{
  *(unsigned char*)addr = data;
  __asm__("sync");
}
/*
 *  Write a word (16 bits) to a memory location after the value
 *  has been byte swapped (big to little endian or vice versa)
 */

void
mpc8240_mpc107_write16(unsigned int address, unsigned short data)
{
  *(volatile unsigned short *)address = BYTE_SWAP_16_BIT(data);
  __asm__("sync");
}

/*
 *  Write a long word (32 bits) to a memory location after the value
 *  has been byte swapped (big to little endian or vice versa)
 */

void
mpc8240_mpc107_write32(unsigned int address, unsigned int data)
{
  *(volatile unsigned int *)address = LONGSWAP(data);
  __asm__("sync");
}

/*
 *  Read a byte (8 bits) from a memory location.
 */
unsigned char
mpc8240_mpc107_read8(unsigned int addr)
{
  return *(volatile unsigned char*)addr;
}


/*
 *  Read a word (16 bits) from a memory location, and byte swap the
 *  value before returning to the caller.
 */
unsigned short
mpc8240_mpc107_read16(unsigned int address)
{
  unsigned short retVal;
  retVal = BYTE_SWAP_16_BIT(*(unsigned short*)address);
  return retVal;
}


/*
 *  Read a long word (32 bits) from a memory location, and byte
 *  swap the value before returning to the caller.
 */
unsigned int
mpc8240_mpc107_read32(unsigned int address)
{
    unsigned int retVal;
    retVal = LONGSWAP(*(unsigned int *)address);
    return (retVal);
}

Etienne


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
