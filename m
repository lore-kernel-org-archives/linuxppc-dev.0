Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBFBA679EA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 09:25:13 +1100 (EST)
Message-ID: <442C5A75.7030107@digis.net>
Date: Thu, 30 Mar 2006 15:23:49 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	John Rigby <jcrigby@gmail.com>, Dale Farnsworth <dale@farnsworth.org>,
	Andrey Volkov <avolkov@varma-el.com>
Subject: Bestcomm Firmware update
Content-Type: multipart/mixed; boundary="------------030100020004000306040506"
Cc: Sylvain Munaut <tnt@246tNt.com>
Reply-To: bennett78@digis.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030100020004000306040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

SoSoComm Dudes:

  I was able to contact Davide Santo, AN2604 "Introduction to BestComm". 
He admitted
the short commings of his document in the area of Firmware instruction 
info and gave
me a name of a guy, Ed in the ASIC design area in Austin.  Ed has agreed 
to answer
questions, push for resources to provide a support tool and provided me 
with a document
from their head programmer "SmartDMA Hand-Assembly Guides" (see attached 
pdf).

With this secret decoded ring I was able to put together a disassembler, 
see attached
disasm.c. Cut and paste your favorite Task into fw[] array at the 
beginning,
"cc -o d disasm.c ; d"  It's not perfect, but useful- Enjoy.  Sorry I'm not
sure where or if you guys want to check this stuff into a git 
repository, somewhere
and hope ozlabs is not fussy about attachments!

If we can formulate a list of questions Ed might be able to help, I'll 
start:
    o what does init=31 mean?
       AN2604 say init=0 means always requestor and 31 is reserved but 
referenced
       alot in the F/W comments
    o Need more info on how MORE works
    o Tell us about LCD levels. Only 2? (let's call a LCD indent a level)
      LCD seems to reset DRD to 1A. DRD2B1or2 follow a DRD2A (ext=1)?
    o LCD[28:23]orLCD[20:15] or LCD[11:6] what is extraN?
        drop 101nnn - extraN
        add  1nnnnn - indexN
    o how many DRD2B1[2] can be stacked up?
    o when is/can a LDC Literal used? and how?

*/Frank Bennett
Technical Contractor/*

/Triad Systems Engineering
200 West Mountain Avenue
Fort. Collins, CO 80521
/http://www.traidsyseng.com <http://www.triadsyseng.com>
frank.bennett@triadsyseng.com <mailto:frank.bennett@triadsyseng.com>/
/office: 970-493-7586

*//*


--------------030100020004000306040506
Content-Type: text/x-c;
 name="disasm.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disasm.c"

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

--------------030100020004000306040506
Content-Type: application/pdf;
 name="sdHandAssemblyLcdDrd.pdf"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sdHandAssemblyLcdDrd.pdf"

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
MCBSCi9GMyA2IDAgUgovRjQgNyAwIFIKL0Y1IDggMCBSCi9GNiA5IDAgUgo+PgovRXh0R1N0
YXRlIDw8Ci9HUzEgMTAgMCBSCj4+Cj4+CmVuZG9iagoxMyAwIG9iago8PAovTGVuZ3RoIDI3
NTUKL0ZpbHRlciAvRmxhdGVEZWNvZGUKPj4Kc3RyZWFtDQpIiexX247cxhF9n6/gI8fAcPtK
NvNmRZJhw4oDaYwkkPywkcbCGtrdYHfl29enyKruqp6uXY0cwIETQZY1h3361IV94bHd283Z
Fy9s9/Z2Y7ppdt1oXbebZjvMobs5bL7fPNpvzp66znb77zcwZuAP/DPBf/DP/hKmvYW/+9fL
/37avOwfP39sP+9e9VfX3WFr4+D7n+8OV7cX11e33fm7d9dbF/ufDm9ebf+0/W7/Fcza2TCY
5H23f7xZZrtl9sXVxd3F+buFtf9hJfkhLow1gHtkX/VH6lLQD5Mku3vJZ08DVpbWwlI3z4OZ
unFOwzgbu9TX+5zB4FbR3i4PLBBG35WHDctkVmSSOybNp5DSKaTpFNJYMncPsOLyYBym9ADH
nqSk9cCe0oOGpPWgIWk9aEij9vYa1tqDNIRJ1nfMsoP187L0X/Zm3u4SsGGNebfdWcgBql+W
2M7HYTTWL9NwVa67pf96EduZwYxpEoH/vDzefwY7AfOcDAw7XPv9k+M0/74+GIyrNPbchzxz
n6O5lATzHznaX/OPJzQ3we7O26h/dhz3m0x/TgnYKEZJY3KAi8b+WONpTilgc+gx1T0bz3V/
SVRnquz/QsFrgTXQEtaV8l/2X67nyd31zXbnDezu2D8/nL9ZX9A4RDtWGZzfnZPyvJyGeeBl
/+Li1+UccXCcLDP9YBOELkH+BuowHPuLOySYwdoq44+RnkQDXuReWd8slubp5/Q0ynfyNXbF
TJAPH4/PDpfYEli3v3SYv8h+9E5qPD7c3l1cnd/BAYrbYxwdb7X71boX1+9vXh+2Ozc72Az9
k29XfWuHYEcnl8T7q9dZHXrn67f9/vKfh5u1EWEefIQadr5sw2ndVMaYssxo3dGjZbG2P5/s
gfsF/P0KTv8foN0mdD9Bf9LYPetefme6NxvbXXSbOQzRdTFF2EDdJcEx+QW+2zz6bOkVTNxY
k+Au60Y/IzFjnEhML6kRRZgabCPqYD8GIUpYE8UhFiWqIgrHkhOaCDXJdYQVkagIhjRMk1Ak
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
80ylYnRQhYmwyg4NVGEglAzyT5lBUHsTi4MqNPitZUTuqdAQKv0gR1T6kbHyDmioaOaZogb0
ToWBUK0BrVNhIlQrQedUmAglk4xTZhCsGOibCgOhlhf6pnyjIJI3CjoSOxvpbQhKQhgrQhiP
+04876S1ISiFbKoICCXBhIqAUHFRS47MQ7TS/i3AALstUIoKZW5kc3RyZWFtCmVuZG9iagox
NCAwIG9iago8PAovUHJvY1NldCBbL1BERiAvVGV4dCBdCi9Gb250IDw8Ci9GMiA1IDAgUgov
RjQgNyAwIFIKPj4KL0V4dEdTdGF0ZSA8PAovR1MxIDEwIDAgUgo+Pgo+PgplbmRvYmoKMTYg
MCBvYmoKPDwKL0xlbmd0aCAxMzQwCi9GaWx0ZXIgL0ZsYXRlRGVjb2RlCj4+CnN0cmVhbQ0K
SIm8V9tuGzcQfd+v4OOuADEc3tdpCzS1EyBA3CJR2gfZD4q1djeQdwNJduS/73Cv5Fq2Lk0s
wwZHnDPncMghx0BuolfvPgG5WUWMmJQTDZyMTQo0lWSZRdfRm0n06q0gQCbXUUoY/qSEg6TK
EMM4mdwi8AZ/J1fuz/coPiuuynle3CSTrxEAtZpjREatEIJMTqP4n2W+zshptlrnxWydl4Vz
HGNExqX0Pafxl3w9VZfJmAtQzlhN5Qm7TC4n71GTqjUhwDCbkjFQrbWpgSwZi5RbmsaF+6Al
BUqO72fLc/Ir+WVV3mbrf1Hkb6+raJMRgqADsQCUF/Nssw8MAtjoaVyX0DEwynHRknL8VOk5
/XhKPmS35fKB1Jn6VN4trzKXJIUpMtattPP+e7a4q+YgpVK5NLB+skaS8roJOG5SP1vPqpxz
pGVud4BK/HQ5X031iUu7SFNF9aPEy1Y7lQZ3Kkw8Zl4Lm1JoM6+kNZgbLwfh/nGgSuGpcoIx
V26HXjt1PU/tEdJAR8PYMTR5cXUgDRxDk23Wy9lhRMCYS2JDdLZJBKMizq7uXKmQz0W+xvAf
s9XdYn1CyJNCBKdGYvhOyvVFfJEMlLROz2mB57XAC2qBHXnhL6llR17Ey2mBzQa1qDRFLUia
LbFyGY7vE+7KN0tYPO+vKx8K7HgoYh1UiiOg3kYeDO3zfl5WSfVu4v7ywYVVSzP4Au1D4kHD
AvyjLNZZsV65W/T3+XyZrVbkr0Q6xzLHqTkh65J8STjDbx4wKDn7vFeBYuKE7bd+tG3va59g
5wdC4QChlU58J2yrc5/alZxa9y7vENp4PSMVDsnpI6n7lPaPk/q/srpP5f8oqYeVvg+Fuj60
UvtBvZfwqHe9boZ2v4QeERxFNAqYuj5LU25c79R3WlPXamFviRng8Z/fsuWsmDtT4lY2PVdl
6fhtni2qKdX0W0EfBE1kryu7iGeLBcHrKVuSrGmHV9hOY5bvs/lFEmhD/UJu79y+Lcv73IHJ
vOvZ8J5RAI96tqpPVhynH3fKXbqpFo9ekmRsLE9xlW2/ppmixh0DSWXs+uWL2DWxzJ10LkhZ
LB5wBf313AUAqC/OOgC+ivgtf6JzGWwhbrC2abOJVSkMDkrj8IR0xwzPM8NPY4Yda+Y/j3nH
msXPYgaP+fEr3Dmy4ES5usRGKd6cb/OFwHc0cD6b4D+X7/D3Par+SjhlknwnAv+5JB/I9JKR
eQQkJxFY7JYEwQuE3LYGtgBkEb0ZRYxqBEWcCypT9NHo0xqpoVzVbtxiabXT1diAaKZqXry+
MdemoWmMjkbiNVrZvNIAtQYeasCvtXK0vY8zQpY6kLZeIGf4gVof7QfSJlCilR9A8e0swo8g
mggG3zVDuEpxrh7rNheNAJDG9ShcVfDaUNb22cTrzaTNfGNoUKEGhU0uxq15GqMjUkLUtnQi
bC1CDra0ioS8nYsbDziqMAqX1/mYcC2ti/LCKBuowH63n5OhQsU9HB/gwMMNVibTHufGwZzt
cW4czGkPpwc45eHUACc8nBjguIfjAxzzcCzEibTHuXEwZ3qcGwdz2sPpAU56ODnACQ8nBjjw
cDDAMQ/HQhz3jg+3IY57x4YbsfVoce/c8PbcAHZTaBvlyqMeczE4vcx1AKRiaMacpX0FGU0t
NNP1mOPlFBax1U5BxdKMOxbXPlV2LUHWElQowRjKtKP1fNAYkFSBIJW9kzOC+6jxMV4gZ/hK
QPsBdCgTpI+UA6TwkYMFAvhIGCCZj2Qh0npAu33RxoObBv2fAAMAzurWtQplbmRzdHJlYW0K
ZW5kb2JqCjE3IDAgb2JqCjw8Ci9Qcm9jU2V0IFsvUERGIC9UZXh0IF0KL0ZvbnQgPDwKL0Yz
IDYgMCBSCi9GNCA3IDAgUgovRjUgOCAwIFIKPj4KL0V4dEdTdGF0ZSA8PAovR1MxIDEwIDAg
Ugo+Pgo+PgplbmRvYmoKMTAgMCBvYmoKPDwKL1R5cGUgL0V4dEdTdGF0ZQovU0EgZmFsc2UK
L1NNIDAuMDIKL1RSMiAvRGVmYXVsdAo+PgplbmRvYmoKNCAwIG9iago8PAovVHlwZSAvRm9u
dAovU3VidHlwZSAvVHlwZTEKL0VuY29kaW5nIC9XaW5BbnNpRW5jb2RpbmcKL0Jhc2VGb250
IC9UaW1lcy1Cb2xkCj4+CmVuZG9iago1IDAgb2JqCjw8Ci9UeXBlIC9Gb250Ci9TdWJ0eXBl
IC9UeXBlMQovRW5jb2RpbmcgL1dpbkFuc2lFbmNvZGluZwovQmFzZUZvbnQgL1RpbWVzLVJv
bWFuCj4+CmVuZG9iago2IDAgb2JqCjw8Ci9UeXBlIC9Gb250Ci9TdWJ0eXBlIC9UeXBlMQov
RW5jb2RpbmcgL1dpbkFuc2lFbmNvZGluZwovQmFzZUZvbnQgL0hlbHZldGljYS1Cb2xkCj4+
CmVuZG9iago3IDAgb2JqCjw8Ci9UeXBlIC9Gb250Ci9TdWJ0eXBlIC9UeXBlMQovRW5jb2Rp
bmcgL01hY1JvbWFuRW5jb2RpbmcKL0Jhc2VGb250IC9IZWx2ZXRpY2EKPj4KZW5kb2JqCjgg
MCBvYmoKPDwKL1R5cGUgL0ZvbnQKL1N1YnR5cGUgL1R5cGUxCi9FbmNvZGluZyAvV2luQW5z
aUVuY29kaW5nCi9CYXNlRm9udCAvQ291cmllcgo+PgplbmRvYmoKOSAwIG9iago8PAovVHlw
ZSAvRm9udAovU3VidHlwZSAvVHlwZTEKL0VuY29kaW5nIC9XaW5BbnNpRW5jb2RpbmcKL0Jh
c2VGb250IC9Db3VyaWVyLU9ibGlxdWUKPj4KZW5kb2JqCjEgMCBvYmoKPDwKL1R5cGUgL1Bh
Z2UKL1BhcmVudCAxMSAwIFIKL1Jlc291cmNlcyAzIDAgUgovQ29udGVudHMgMiAwIFIKPj4K
ZW5kb2JqCjEyIDAgb2JqCjw8Ci9UeXBlIC9QYWdlCi9QYXJlbnQgMTEgMCBSCi9SZXNvdXJj
ZXMgMTQgMCBSCi9Db250ZW50cyAxMyAwIFIKPj4KZW5kb2JqCjE1IDAgb2JqCjw8Ci9UeXBl
IC9QYWdlCi9QYXJlbnQgMTEgMCBSCi9SZXNvdXJjZXMgMTcgMCBSCi9Db250ZW50cyAxNiAw
IFIKPj4KZW5kb2JqCjE4IDAgb2JqCjw8Ci9TIC9ECj4+CmVuZG9iagoxOSAwIG9iago8PAov
TnVtcyBbMCAxOCAwIFIgXQo+PgplbmRvYmoKMTEgMCBvYmoKPDwKL1R5cGUgL1BhZ2VzCi9L
aWRzIFsxIDAgUiAxMiAwIFIgMTUgMCBSXQovQ291bnQgMwovTWVkaWFCb3ggWzAgMCA2MTIg
NzkyXQo+PgplbmRvYmoKMjAgMCBvYmoKPDwKL0NyZWF0aW9uRGF0ZSAoRDoyMDA2MDMyOTE0
MjQyMC0wNicwMCcpCi9Nb2REYXRlIChEOjIwMDYwMzI5MTQyNDIwLTA2JzAwJykKL1Byb2R1
Y2VyIChOb3JtYWxpemVyIDUuMC41IGZtbm9ybSkKL0NyZWF0b3IgKEZyYW1lIDcuMCkKPj4K
ZW5kb2JqCjIxIDAgb2JqCjw8Ci9UeXBlIC9NZXRhZGF0YQovU3VidHlwZSAvWE1MCi9MZW5n
dGggNjYyCj4+CnN0cmVhbQ0KPD94cGFja2V0IGJlZ2luPScnIGlkPSdXNU0wTXBDZWhpSHpy
ZVN6TlRjemtjOWQnIGJ5dGVzPSc2NjEnPz48cmRmOlJERiB4bWxuczpyZGY9J2h0dHA6Ly93
d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMnIHhtbG5zOmlYPSdodHRwOi8v
bnMuYWRvYmUuY29tL2lYLzEuMC8nPjxyZGY6RGVzY3JpcHRpb24gYWJvdXQ9JycgeG1sbnM9
J2h0dHA6Ly9ucy5hZG9iZS5jb20vcGRmLzEuMy8nIHhtbG5zOnBkZj0naHR0cDovL25zLmFk
b2JlLmNvbS9wZGYvMS4zLycgcGRmOkNyZWF0aW9uRGF0ZT0nMjAwNi0wMy0yOVQyMDoyNDoy
MFonIHBkZjpNb2REYXRlPScyMDA2LTAzLTI5VDIwOjI0OjIwWicgcGRmOlByb2R1Y2VyPSdO
b3JtYWxpemVyIDUuMC41IGZtbm9ybScgcGRmOkNyZWF0b3I9J0ZyYW1lIDcuMCcvPgo8cmRm
OkRlc2NyaXB0aW9uIGFib3V0PScnIHhtbG5zPSdodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8x
LjAvJyB4bWxuczp4YXA9J2h0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8nIHhhcDpDcmVh
dGVEYXRlPScyMDA2LTAzLTI5VDIwOjI0OjIwWicgeGFwOk1vZGlmeURhdGU9JzIwMDYtMDMt
MjlUMjA6MjQ6MjBaJyB4YXA6TWV0YWRhdGFEYXRlPScyMDA2LTAzLTI5VDIwOjI0OjIwWicv
Pgo8L3JkZjpSREY+PD94cGFja2V0IGVuZD0ncic/PgplbmRzdHJlYW0KZW5kb2JqCjIyIDAg
b2JqCjw8Ci9UeXBlIC9DYXRhbG9nCi9QYWdlcyAxMSAwIFIKL01ldGFkYXRhIDIxIDAgUgov
UGFnZUxhYmVscyAxOSAwIFIKPj4KZW5kb2JqCnhyZWYKMCAyMwowMDAwMDAwMDAwIDY1NTM1
IGYgCjAwMDAwMDc5NzIgMDAwMDAgbiAKMDAwMDAwMDAxNiAwMDAwMCBuIAowMDAwMDAyNjk1
IDAwMDAwIG4gCjAwMDAwMDczNzcgMDAwMDAgbiAKMDAwMDAwNzQ3NSAwMDAwMCBuIAowMDAw
MDA3NTc0IDAwMDAwIG4gCjAwMDAwMDc2NzYgMDAwMDAgbiAKMDAwMDAwNzc3NCAwMDAwMCBu
IAowMDAwMDA3ODY5IDAwMDAwIG4gCjAwMDAwMDczMDUgMDAwMDAgbiAKMDAwMDAwODI4OSAw
MDAwMCBuIAowMDAwMDA4MDUzIDAwMDAwIG4gCjAwMDAwMDI4NDAgMDAwMDAgbiAKMDAwMDAw
NTY2OSAwMDAwMCBuIAowMDAwMDA4MTM3IDAwMDAwIG4gCjAwMDAwMDU3NzUgMDAwMDAgbiAK
MDAwMDAwNzE4OSAwMDAwMCBuIAowMDAwMDA4MjIxIDAwMDAwIG4gCjAwMDAwMDgyNDkgMDAw
MDAgbiAKMDAwMDAwODM4NSAwMDAwMCBuIAowMDAwMDA4NTM5IDAwMDAwIG4gCjAwMDAwMDky
ODMgMDAwMDAgbiAKdHJhaWxlcgo8PAovU2l6ZSAyMwovUm9vdCAyMiAwIFIKL0luZm8gMjAg
MCBSCi9JRCBbPDZhYWU0ZjI2M2JkYmY0ZThiZDk2YzRlMWRjMzZmYzQ5Pjw2YWFlNGYyNjNi
ZGJmNGU4YmQ5NmM0ZTFkYzM2ZmM0OT5dCj4+CnN0YXJ0eHJlZgo5MzcwCiUlRU9GCg==
--------------030100020004000306040506--
