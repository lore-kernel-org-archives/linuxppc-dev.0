From: clark@esteem.com
Message-Id: <1.5.4.32.20000901180433.0069b840@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 01 Sep 2000 11:04:33 -0700
To: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
Subject: Re: Re: SDRAM weirdness.
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 02:47 PM 9/1/00 +0900, you wrote:
>Hello.
>
>Verrrry thanks!!!
>
>I solved every problem related SDRAM and now my v.2 board works perfectly.
- HW engineer said that it is the first time to use SDRAM on the project and
he agrees his mistake. -
>
>If you have time please answer one more question. Does SDRAM need
initialization sequence like precharge, refresh and MRS command?
>
>My initializtion code looks like that.
>
>===============================
>    memctl->memc_mptpr = 0x400;
>
>    memctl->memc_mamr = 0x18802114;
>
>    /* run precharge */
>    memctl->memc_mcr = 0x80004105;
>    memctl->memc_mcr = 0x80006105;
>
>    /* run refresh sequence with 8-beat refresh burst */
>    memctl->memc_mamr = 0x18802118;
>    memctl->memc_mcr = 0x80004130;
>    memctl->memc_mcr = 0x80006130;
>
>    /* run MRS command in location 6-7 of UPMA */
>    memctl->memc_mar = 0x88;
>    memctl->memc_mcr = 0x80004106;
>    memctl->memc_mcr = 0x80006106;
>
>    udelay(200);
>
>    /* restore MAMR value */
>    memctl->memc_mamr = 0x18802114;
>
>
>    memctl->memc_mcr = 0x80006106;
>
>    udelay(200);
>
>    /* restore MAMR value */
>    memctl->memc_mamr = 0x18802114;
>=================================
>
>Please let me know.
>
>Once again, I deeply appreciate your kindness. :)
>
>Have a nice day.
>
>----- Original Message -----
>From: <clark@esteem.com>
>To: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
>Cc: <linuxppc-embedded@lists.linuxppc.org>
>Sent: Friday, September 01, 2000 5:12 AM
>Subject: Re: SDRAM weirdness.
>
>
>>
>> At 12:18 AM 9/1/00 +0900, you wrote:
>> >
>> >Hello all.
>> >
>> >My board uses SAMSUNG K4S643232C SDRAM and it's configuration is  512K x
>> 32bit x 4 banks, 11 rows and 8 column.
>> >
>> >The Board quipped 2 SDRAMs (total 16MB) and each uses CS2 and CS3.
>> >
>> >MPC to SDRAM pin configuration is as below.
>> >
>> >MPC                    SDRAM
>> >========================
>> >A29                        A0
>> >A28                        A1
>> >A27                        A2
>> >A26                        A3
>> >A25                        A4
>> >A24                        A5
>> >A23                        A6
>> >A22                        A7
>> >A21                        A8
>> >A20                        A9
>> >GPL_A0                  A10
>> >A9                          BA0
>> >A8                          BA1
>> >OE_GPL_A1            RAS
>> >GPL_A2                  CAS
>> >GPL_A3                  WE
>> >
>> >The problem is that when I write a word to some location then it will
>> appear another location like a mirror.
>> >
>> >The example symptom is - I'm using a BDI2000 for BDM, md is mem. disp. and
>> mm is mem. modify -
>> >
>> >BDI>md 0x0 5
>> >00000000 : 0xffffffff  -         1  ....
>> >00000004 : 0xffffffff  -         1  ....
>> >00000008 : 0xffffffff  -         1  ....
>> >0000000c : 0xffffffff  -         1  ....
>> >00000010 : 0xffffffff  -         1  ....
>> >BDI>md 0x100000 5
>> >00100000 : 0xffffffff  -         1  ....
>> >00100004 : 0xffffffff  -         1  ....
>> >00100008 : 0xffffffff  -         1  ....
>> >0010000c : 0xffffffff  -         1  ....
>> >00100010 : 0xffffffff  -         1  ....
>> >BDI>mm 0x0 0x0
>> >BDI>md 0x0 5
>> >00000000 : 0x00000000            0  ....
>> >00000004 : 0xffffffff  -         1  ....
>> >00000008 : 0xffffffff  -         1  ....
>> >0000000c : 0xffffffff  -         1  ....
>> >00000010 : 0xffffffff  -         1  ....
>> >BDI>md 0x100000 5
>> >00100000 : 0x00000000            0  ....
>> >00100004 : 0xffffffff  -         1  ....
>> >00100008 : 0xffffffff  -         1  ....
>> >0010000c : 0xffffffff  -         1  ....
>> >00100010 : 0xffffffff  -         1  ....
>> >BDI>
>> >
>> >As you can see, mem[addr]=data means mem[addr + 0x100000]=data.
>> >
>> >So, I've made some program to find duplicated memory area and the result is
>> that
>> >
>> >Memory content of left area is equal to right
>> >==============================================
>> >0x0 ~ 0xfffff            eq.            0x100000 ~ 0x1fffff
>> >0x200000 ~ 0x2fffff            eq.            0x300000 ~ 0x3fffff
>> >0x400000 ~ 0x4fffff            eq.            0x500000 ~ 0x5fffff
>> >0x600000 ~ 0x6fffff            eq.            0x700000 ~ 0x7fffff
>> >0x800000 ~ 0x8fffff            eq.            0x900000 ~ 0x9fffff
>> >0xa00000 ~ 0xafffff            eq.            0xb00000 ~ 0xbfffff
>> >0xc00000 ~ 0xcfffff            eq.            0xd00000 ~ 0xdfffff
>> >0xe00000 ~ 0xefffff            eq.            0xf00000 ~ 0xffffff
>> >
>> >How can I solve this?
>> >
>> >What is the point of it? The UPM table? BR, OR values? MAMR value? SDRAM
>> init. sequence? or HW related? I couldn't find any clue of it.
>> >
>> >Please help me.
>> >
>> >
>> >My register configuration for BDI2000 follows. Test program has same
>> register values.
>> >
>> >; bdiGDB configuration file for 850 v.2 board
>> >; -------------------------------------------
>> >;
>> >[INIT]
>> >; init core register
>> >WSPR    149              0x0082000F     ;DER  : for debug MMU
>> >
>> >WSPR    638             0xFF000000      ;IMMR
>> >WSPR    158             0x00000007      ;ICTRL:
>> >WSPR    796             0x00000000      ;M_TWB: invalidate TWB
>> >
>> >; init SIU register
>> >WM32    0xFF000000      0x01E10940      ;SIUMCR
>> >WM32    0xFF000004      0xFFFFFF88      ;SYPCR
>> >WM16    0xFF000200      0x0001          ;TBSCR
>> >WM16    0xFF000240      0x0002          ;PISCR
>> >WM32    0xFF000284      0x0000D000      ;PLPRCR set clock to 25MHz
>> >
>> >; init UPM for Samsung KS4S643232C_2Mx32 SDRAM
>> >SUPM    0xFF000168      0xFF00017c      ;set address for MCR and MDR
>> >WUPM    0x00000000      0x1F07FC04      ;UPMA single read
>> >WUPM    0x00000001      0xEEAEFC04
>> >WUPM    0x00000002      0x11ADFC04
>> >WUPM    0x00000004      0x1FF77C47
>> >WUPM    0x00000005      0x1FF77C34
>> >WUPM    0x00000006      0xEFEABC34
>> >WUPM    0x00000007      0x1FB57C35      ;last
>> >WUPM    0x00000008      0x1F07FC04      ;UPMA burst read
>> >WUPM    0x00000009      0xEEAEFC04
>> >WUPM    0x0000000A      0x10ADFC04
>> >WUPM    0x0000000B      0xF0AFFC00
>> >WUPM    0x0000000C      0xF0AFFC00
>> >WUPM    0x0000000D      0xF1AFFC00
>> >WUPM    0x0000000E      0xEFBBBC00
>> >WUPM    0x0000000F      0x1FF77C47      ;last
>> >WUPM    0x00000010      0xFFFFFFFF
>> >WUPM    0x00000011      0xFFFFFFFF
>> >WUPM    0x00000012      0xFFFFFFFF
>> >WUPM    0x00000013      0xFFFFFFFF
>> >WUPM    0x00000014      0xFFFFFFFF
>> >WUPM    0x00000015      0xFFFFFFFF
>> >WUPM    0x00000016      0xFFFFFFFF
>> >WUPM    0x00000017      0xFFFFFFFF
>> >WUPM    0x00000018      0x1F27FC04      ;UPMA single write
>> >WUPM    0x00000019      0xEEAEBC00
>> >WUPM    0x0000001A      0x01B93C04
>> >WUPM    0x0000001B      0x1FF77C47      ;last
>> >WUPM    0x0000001C      0xFFFFFFFF
>> >WUPM    0x0000001D      0xFFFFFFFF
>> >WUPM    0x0000001E      0xFFFFFFFF
>> >WUPM    0x0000001F      0xFFFFFFFF
>> >WUPM    0x00000020      0x1F07FC04      ;UPMA burst write
>> >WUPM    0x00000021      0xEEAEBC00
>> >WUPM    0x00000022      0x10AD7C00
>> >WUPM    0x00000023      0xF0AFFC00
>> >WUPM    0x00000024      0xF0AFFC00
>> >WUPM    0x00000025      0xE1BBBC04
>> >WUPM    0x00000026      0x1FF77C47      ;last
>> >WUPM    0x00000027      0xFFFFFFFF
>> >WUPM    0x00000028      0xFFFFFFFF
>> >WUPM    0x00000029      0xFFFFFFFF
>> >WUPM    0x0000002A      0xFFFFFFFF
>> >WUPM    0x0000002B      0xFFFFFFFF
>> >WUPM    0x0000002C      0xFFFFFFFF
>> >WUPM    0x0000002D      0xFFFFFFFF
>> >WUPM    0x0000002E      0xFFFFFFFF
>> >WUPM    0x0000002F      0xFFFFFFFF
>> >WUPM    0x00000030      0x1FF5FC84      ;UPMA refresh
>> >WUPM    0x00000031      0xFFFFFC04
>> >WUPM    0x00000032      0xFFFFFC04
>> >WUPM    0x00000033      0xFFFFFC04
>> >WUPM    0x00000034      0xFFFFFC84
>> >WUPM    0x00000035      0xFFFFFC07
>> >WUPM    0x00000036      0xFFFFFFFF
>> >WUPM    0x00000037      0xFFFFFFFF
>> >WUPM    0x00000038      0xFFFFFFFF
>> >WUPM    0x00000039      0xFFFFFFFF
>> >WUPM    0x0000003A      0xFFFFFFFF
>> >WUPM    0x0000003B      0xFFFFFFFF      ;last
>> >WUPM    0x0000003C      0x7FFFFC07      ;UPMA exception ;last
>> >WUPM    0x0000003D      0xFFFFFFFF
>> >WUPM    0x0000003E      0xFFFFFFFF
>> >WUPM    0x0000003F      0xFFFFFFFF
>> >
>> >; init memory controller
>> >WM32    0xFF000100      0xFFD20401      ;BR0    8bit!
>> >WM32    0xFF000104      0xFFC00160      ;OR0
>> >WM32    0xFF000114      0xFF800A00      ;OR2
>> >WM32    0xFF000110      0x00000081      ;BR2
>> >WM32    0xFF00011C      0xFF800A00      ;OR3
>> >WM32    0xFF000118      0x00800081      ;BR3
>> >WM16    0xFF00017A      0x0400          ;MPTPR
>> >WM32    0xFF000170      0x18804114      ;MAMR, loop time is 4
>> >
>> >; start sdram init
>> >WM32    0xFF000168      0x80004105      ;MCR for CS2, precharge
>> >WM32    0xFF000168      0x80006105      ;MCR for CS3, precharge
>> >WM32    0xFF000170      0x18804118      ;MAMR, loop time is 8
>> >WM32    0xFF000168      0x80004130      ;MCR for CS2, run refresh
>> >WM32    0xFF000168      0x80006130      ;MCR for CS3, run refresh
>> >WM32    0xFF000164      0x88            ;MAR
>> >WM32    0xFF000168      0x80004106      ;MCR for CS2, run MRS
>> >WM32    0xFF000168      0x80006106      ;MCR for CS3, run MRS
>> >WM32    0xFF000170      0x18804114      ;MAMR, loop time is 4
>> >
>> >WM32    0xFF000284      0x0010D000      ;PLPRCR set clock to 50MHz
>> >
>> >... sniffed host, flash settings.
>> >------------------------------------------------------------------
>> >
>> >Thanks in advance.
>> >
>> >Have a nice day.
>> >
>> >
>>
>>
>> Your problem is your address line connections.
>> They should be like the following.(changes have * next to them)
>>
>> MPC                    SDRAM
>> ========================
>> A29                        A0
>> A28                        A1
>> A27                        A2
>> A26                        A3
>> A25                        A4
>> A24                        A5
>> A23                        A6
>> A22                        A7
>> A21                        A8
>> A20                        A9
>> GPL_A0                     A10
>> A10*                       BA0
>> A9*                        BA1
>> OE_GPL_A1                  RAS
>> GPL_A2                     CAS
>> GPL_A3                     WE
>>
>> You must sure to program GPL_A0 to act as A11 even though it connects to A10
>> on the RAM.
>>
>>         We are using a Micron part (MT48LC2M32B2) that is similar to yours.
>> Micron has said that they will make a bigger parts in the same foot print.
>>
>> This is how we hooked up our ram to make provisions for the larger parts.
>> (Note that the two additional address lines have an * next to them)
>>
>>
>> MPC                    SDRAM
>> =============================
>> A29                        A0
>> A28                        A1
>> A27                        A2
>> A26                        A3
>> A25                        A4
>> A24                        A5
>> A23                        A6
>> A22                        A7
>> A13                        A8
>> A12                        A9
>> GPL_A0                     A10
>> *A8                        A11 (pin 71)
>> *A7                        A12 (pin 69)
>> A10                        BA0
>> A9                         BA1
>> OE_GPL_A1                  RAS
>> GPL_A2                     CAS
>> GPL_A3                     WE
>>
>>
>>         Good Luck,
>>
>>         Conn Clark
>>
>>
>>
>

    Hyun-Joon,

    Yes, every SDRAM I know of does need initailization. This generaly
involves doing a precharge, 8 refreshes, then a MRS command. From what you
said it sounds like you have it working. It looks like what you have should
work. If it isn't let me know and I will try to look at it more closely.


        Good Luck,

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
