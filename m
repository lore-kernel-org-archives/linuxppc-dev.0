Return-Path: <bennett78@lpbroadband.net>
Received: from omta0106.mta.everyone.net (imta-38.everyone.net
	[216.200.145.38]) by ozlabs.org (Postfix) with ESMTP id 829ADDDF9A
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 02:59:46 +1100 (EST)
Message-ID: <4975F4F2.2040006@lpbroadband.net>
Date: Tue, 20 Jan 2009 08:59:46 -0700
From: Frank Bennett <bennett78@lpbroadband.net>
MIME-Version: 1.0
To: arieswar24b@yahoo.de
Subject: Re: Bestcomm tasks and interrupts on MPC5200(B)
References: <381238.78267.qm@web25801.mail.ukl.yahoo.com>
In-Reply-To: <381238.78267.qm@web25801.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Reply-To: bennett78@lpbroadband.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Best wrote:
> I'm trying to write a driver which uses the Local Plus Bus on my MPC5200B and therefore have to use BestComm DMA, which requires me to use a Gen_BD task for data transfer with Local Plus.
> I tried to follow the fec driver that is currently used and took a peek at the mpc52xx-ac97 driver which at least uses the same kind of bus as I.
>
> Initialising the task, resetting and enabling works fine. Even request_irq reports no error, but when I start a transfer it hangs and if I am lucky, an interrupt occurs after quite some time. But it's always the BestComm ethernet rx task which produces an RFIFO interrupt, presumably after the watchdog catches on. 
> If this happens my interrupt occurs to.
>
> I tried to debug this situation but I am still clueless.
> If I use the MPC5200 Interrupt emulation registers to force an interrupt for my interface to occur, nothing happens except that it hangs.
>
> Any hints, tips or help appreciated.
>   
Below is a Disassembler I wrote a couple years ago. Just paste
the hex of interest in the array below, re-compile and run.

Cheers,
-Frank
> Dave
>
>
>       
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   

/*
 * disasm.c - disassembler for MPC5200 Bestcomm DMA Firmware
 *            copy and paste task code into fw, compile a run
 * by Frank bennett, 3/29/2006
 *
 * Based on Freescale pdf "SmartDMA Hand-Assembly Guides"
 *
 * TODO:
 *  o add inc[0:7] array (maybe var) to deternmine proper term condition (upper 3 bits)
 *  o need to review sheet 3 of the pdf
 *  o simulator would be nice
 *
 */
// Task12 (TASK_GEN_TX_BD) : Start of TDT -> 0xf0008528
// linuxppc_2_4_devel/arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos1/"dma_image.reloc.c
//
// 31,30,29,28|27,26,25,24|23,22,21,20|19,18,17,16|15,14,13,12|11,10, 9, 8| 7, 6, 5, 4| 3, 2, 1, 0
//  0  0  0  1  0  0| 0  0  0  0  0| 0  0| 0  0| 0| 0  0  0  1  0  0| 1| 1  0  0  0  0  1| 0  0  0
// 0x10001308, /* 000C      DRD1A: var4 = idx1; FN=0 MORE init=0 WS=0 RS=2 */
//  1  0  0| 1  1  0  0  1  0| 0| 0| 1  1  0  0  1  0| 0  0| 0| 0  0  0  0  0  0| 1  1  0| 1  1  0
// 0x99190036, /* 002C    LCD: idx2 = idx2; idx2 once var0; idx2 += inc6 */
// 31,30,29,28|27,26,25,24|23,22,21,20|19,18,17,16|15,14,13,12|11,10, 9, 8| 7, 6, 5, 4| 3, 2, 1, 0
// 1   0| 0  1  1  0, 0  1  0  1,    1  0  0, 0  0  1| 1  0| 1  0  0  1  0  0  0  0  1  0  0  0  0
// 0x9950d210

/* Task12(TASK_GEN_TX_BD): Start of TDT -> 0xf0008528 */
unsigned long fw[] = {
    0x800220e3, /* 0000  LCD: idx0 = var0, idx1 = var4; idx1 <= var3; idx0 += inc4, idx1 += inc3 */
    0x13e01010, /* 0004    DRD1A: var4 = var2; FN=0 MORE init=24 WS=0 RS=0 */
    0xb8808264, /* 0008    LCD: idx2 = *idx1, idx3 = var1; idx2 < var9; idx2 += inc4, idx3 += inc4 */
    0x10001308, /* 000C      DRD1A: var4 = idx1; FN=0 MORE init=0 WS=0 RS=2 */
    0x60140002, /* 0010      DRD2A: EU0=0 EU1=0 EU2=0 EU3=2 EXT init=0 WS=2 RS=2 */
    0x0cccfcca, /* 0014      DRD2B1: *idx3 = EU3(); EU3(*idx3,var10)  */
    0xd9190300, /* 0018    LCDEXT: idx2 = idx2; idx2 > var12; idx2 += inc0 */
    0xb8c5e009, /* 001C    LCD: idx3 = *(idx1 + var00000015); ; idx3 += inc1 */
    0x03fec398, /* 0020      DRD1A: *idx0 = *idx3; FN=0 init=24 WS=3 RS=2 */
    0x9919826a, /* 0024    LCD: idx2 = idx2, idx3 = idx3; idx2 > var9; idx2 += inc5, idx3 += inc2 */
    0x0feac398, /* 0028      DRD1A: *idx0 = *idx3; FN=0 TFD INT init=24 WS=1 RS=2 */
    0x99190036, /* 002C    LCD: idx2 = idx2; idx2 once var0; idx2 += inc6 */
    0x60000005, /* 0030      DRD2A: EU0=0 EU1=0 EU2=0 EU3=5 EXT init=0 WS=0 RS=0 */
    0x0c4cf889, /* 0034      DRD2B1: *idx1 = EU3(); EU3(idx2,var9)  */
    0x000001f8, /* 0038    NOP */
    0x9950d210,
	0x2c4cf889,
    0
};

union
{
    unsigned long i;
    struct
    {
        unsigned sb:3;     // [02:00] increment #2
        unsigned sa:3;     // [05:03] increment #1
        unsigned tc:6;     // [11:06] variable to which idx is compared   
        unsigned drtc:1;   //    [12] dr ? *(tc) : (tc)
        unsigned tu:2;     // [14:13] term usage 00-idx_a, 01-idx_b, 10- lit init 11-no cond
        unsigned ib:6;     // [20:15] init_b 
        unsigned drib:1;   //    [21] dr ? *(init_a) : (init_a)
        unsigned p:1;      //    [22] indx plus offset
        unsigned ia:6;     // [28:23] init_a 
        unsigned dria:1;   //    [29] dr ? *(init_a) : (init_a)
        unsigned ext:1;    //    [30] = 2 or 3 for LCD
        unsigned op:1;     //    [31] = 2 or 3 for LCD
    } lcd;
    struct
    {
        unsigned ll:13;    // [12:00] literal init low
        unsigned tu:2;     // [14:13] term usage == 2
        unsigned lh:15;    // [29:15] literal init hi 
        unsigned bas:1;    //    [30] = 2 or 3 for LCD
        unsigned op:1;     //    [31] = 2 or 3 for LCD
    } lcdl;

    struct
    {
        unsigned fn:3;     // [02:00]
        unsigned src:6;    // [08:03]
        unsigned drs:1;    //    [09] deref src?
        unsigned dst:6;    // [15:10]
        unsigned drd:1;    //    [16] deref dst? scal?
        unsigned ws:2;     // [18:17] 0-32bit, 1-1 byte, 2-16 word, 3-dynamic/reserved??
        unsigned rs:2;     // [20:19] 0-32bit, 1-1 byte, 2-16 word, 3-dynamic/reserved??
        unsigned init:5;   // [25:21]
        unsigned intr:1;   //    [26]
        unsigned tfd:1;    //    [27]
        unsigned more:1;   //    [28]      
        unsigned type:1;   //    [29] 
        unsigned ext:1;    //    [30] 
        unsigned op:1;     //    [31] = 0 for DRD
    } drd1a;
    struct
    {
        unsigned eu3:4;    // [03:00] Execution Unit3 Function number
        unsigned eu2:4;    // [07:04] Execution Unit3 Function number
        unsigned eu1:4;    // [11:08] Execution Unit3 Function number
        unsigned eu0:4;    // [15:12] Execution Unit3 Function number
        unsigned drd:1;    //    [16] deref dst? scal?
        unsigned ws:2;     // [18:17] 0-32bit, 1-1 byte, 2-16 word, 3-dynamic/reserved??
        unsigned rs:2;     // [20:19] 0-32bit, 1-1 byte, 2-16 word, 3-dynamic/reserved??
        unsigned init:5;   // [25:21]
        unsigned int:1;    //    [26]
        unsigned tfd:1;    //    [27]
        unsigned more:1;   //    [28]      
        unsigned type:1;   //    [29] 
        unsigned ext:1;    //    [30] 
        unsigned op:1;     //    [31] = 0 for DRD
    } drd2a;
    struct
    {
        unsigned od1:6;    // [05:00] EU operand 1
        unsigned od0:6;    // [11:06] EU operand 0
        unsigned eu:2;     // [13:12] EU#, only #3 available on MPC5200
        unsigned mems:6;   // [19:14] memory write source
        unsigned drds:1;   //    [20]      
        unsigned rsv2:1;   //    [21]      
        unsigned memd:6;   // [27:22] memory write destination
        unsigned rsv1:1;   //    [28] reserved?
        unsigned type:1;   //    [29] 
        unsigned ext:1;    //    [30] 
        unsigned op:1;     //    [31] = 0 for DRD
    } drd2b1;
    struct
    {
        unsigned odb1:6;   // [05:00] EUb operand 1/3/5/7
        unsigned odb0:6;   // [11:06] EUb operand 0/2/4/6
        unsigned eub:2;    // [13:12] EUb#, only #3 available on MPC5200
        unsigned oda1:6;   // [19:14] EUa operand 1/3/5/7
        unsigned oda0:6;   // [25:20] EUa operand 0/2/4/6
        unsigned eua:2;    // [27:26] EUa#, only #3 available on MPC5200
        unsigned rsv1:1;   //    [28]      
        unsigned type:1;   //    [29] 
        unsigned ext:1;    //    [30] 
        unsigned op:1;     //    [31] = 0 for DRD
    } drd2b2;
} x;

// Condition codes (first 4 bits of the increments)
// >=   c
// >    4
// once 0
// !=   6
// <=   a
// <    2

char *ft[] = {
    "ld_acc", "unld_acc", "and", "or", "xor" "andn", "not",
    "add", "sub", "lsh", "rsh", "crc8", "crc16", "crc32", 
	"endian32", "endian16"
};

char s[8];
indvar (int i)
{
    switch ((i & 0x3f) >> 4)
    {
    case 0:
        sprintf (s, "var%d", i & 0x1f); // varN
        break;
    case 1:
        sprintf (s, "inc%d", i & 0x07); // incN
        break;
    case 2:    			                // extraN
    case 3:
        sprintf (s, "idx%d", i & 0x0f); // idxN
        break;
    }
}

#define L2 LLev*2
main ()
{
    int i, j, LLev = 0, drdt, ex = 0, ml;
    char in[12];

    for (i = 0; fw[i]; i++)
    {
        x.i = fw[i];
        if (x.i == 0x1f8)
            printf ("0x%08x, // NOP\n", x.i);
        else if (x.lcd.op)      	// LCD
        {
            if (LLev == 0)
                strcpy (in, "");
            else
                strcpy (in, "  ");

            if (x.lcd.ext)			// LCDEXT
            {
                indvar (x.lcd.tc);
                printf
                    ("0x%08x, // %sLCDEXT: idx%d=idx%d; idx%d >%s%s ; idx%d += inc%d\n",
                     x.i, in, L2, L2, L2, x.lcd.drtc ? "*" : " ", s, L2,
                     x.lcd.sb);
            } else if (x.lcd.tu == 2)	 // LCDLIT
            {
                printf ("0x%08x, // %sLCDLIT: idx%d = 0x%07x ??\n",
                        x.i, in, L2, (x.lcdl.lh << 13) | x.lcdl.ll);
            } else                	// LCD
            {
                printf ("0x%08x, // %sLCD: ", x.i, in);
                if (x.lcd.p)    // indexed p-plus
                {
                    indvar (x.lcd.ia);
                    printf ("idx%d = %s(%s + ", L2 + 1, x.lcd.dria ? "*" : " ", s);
                    indvar (x.lcd.ib);
                    printf ("%s%s); ; ", x.lcd.drib ? "*" : " ", s);
                } else
                {
                    indvar (x.lcd.ia);
                    printf ("idx%d=%s%s, ", L2, x.lcd.dria ? "*" : " ", s);
                    indvar (x.lcd.ib);
                    printf ("idx%d=%s%s, ", L2 + 1, x.lcd.drib ? "*" : " ", s);
                }
                if (x.lcd.tu < 2)
                {
                    indvar (x.lcd.tc);
                    printf ("idx%d <=%s%s, ", (x.lcd.tu == 0) ? L2 : L2 + 1,
                            x.lcd.drtc ? "*" : " ", s);
                }
                if (x.lcd.tu != 3)
                    printf ("idx%d += inc%01x, ", L2, x.lcd.sa);
                printf ("idx%d += inc%01x\n", L2 + 1, x.lcd.sb);
                ex = 0;
            }
        }
        else
        {
            // DRD
            if (LLev == 0)
                strcpy (in, "  ");
            else
                strcpy (in, "    ");
            drdt = (ex << 2) | (x.drd1a.ext << 1) | x.drd1a.type;
            switch (drdt)
            {
            case 0:            // DRD1A
                printf ("0x%08x, // %sDRD1A: ", x.i, in);
                indvar (x.drd1a.dst);
                printf ("%s%s =", x.drd1a.drd ? "*" : " ", s);
                indvar (x.drd1a.src);
                printf ("%s%s; ", x.drd1a.drs ? "*" : " ", s);
                printf ("FN=%d (%s) ", x.drd1a.fn, ft[x.drd1a.fn]);
                if (x.drd1a.more)
                    printf ("MORE ");
                if (x.drd1a.tfd)
                    printf ("TFD ");
                if (x.drd1a.intr)
                    printf ("INT ");
                printf ("init=%d ", x.drd1a.init);
                printf ("WS=%d RS=%d \n", x.drd1a.ws, x.drd1a.rs);
                break;
            case 3:            // DRD2A
                ex = x.drd2a.ext;
                printf ("0x%08x, // %sDRD2A: ", x.i, in);
                printf ("EU0=0 EU1=0 EU2=0 EU3=%d (%s) EXT init=%d ",
                        x.drd2a.eu3, ft[x.drd2a.eu3], x.drd2a.init);
                printf ("WS=%d RS=%d \n", x.drd2a.ws, x.drd2a.rs);
                break;
            case 4:            // DRD2B1
                printf ("0x%08x, // %sDRD2B1: ", x.i, in);
                indvar (x.drd2b1.memd);   // mems ??
                printf ("*%s=EU%d(); ", s, x.drd2b1.eu);
                indvar (x.drd2b1.od0); printf ("EU%d(%s, ", x.drd2b1.eu, s);
                indvar (x.drd2b1.od1); printf ("%s) \n", s);
                break;
            case 5:            // DRD2B2
            case 7:            // DRD2B2?
                printf ("0x%08x, // %sDRD2B2: ", x.i, in);
                indvar (x.drd2b2.oda0); printf ("EU%d(%s, ", x.drd2b2.eub, s);
                indvar (x.drd2b2.oda1); printf ("%s) , ", s);
                indvar (x.drd2b2.odb0); printf ("EU%d(%s, ", x.drd2b2.eua, s);
                indvar (x.drd2b2.odb1); printf ("%s) ??\n", s);
				break;
            case 1:
            case 2:
            case 6:
                printf ("fix_me\n");
                ex = x.drd1a.ext;
                break;
            }
            LLev |= 1;
        }
    }
}
