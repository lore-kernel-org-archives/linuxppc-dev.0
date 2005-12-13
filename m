Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep5.connect.com.au (fep5.mfe.bur.connect.com.au [203.63.86.5])
	by ozlabs.org (Postfix) with ESMTP id 782FF688B8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 12:22:36 +1100 (EST)
Received: from [192.168.1.100] (cor11-ppp3577.hay.dsl.connect.net.au
	[61.69.222.21])
	by mfep5.connect.com.au (Postfix) with ESMTP id 4E7EDCCD9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 12:22:34 +1100 (EST)
Message-ID: <439E21C7.8070404@rftechnology.com.au>
Date: Tue, 13 Dec 2005 12:20:07 +1100
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: 82xx cascaded timers
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have the following code:

#define CPMTIMER_TGCR_GM1       0x08  /* gate mode */
#define CPMTIMER_TGCR_FRZ1      0x04  /* freeze timer */
#define CPMTIMER_TGCR_STP1      0x02  /* stop timer */
#define CPMTIMER_TGCR_RST1      0x01  /* restart timer */

#define CPMTIMER_TGCR_CAS2      0x80  /* cascade timer */
#define CPMTIMER_TGCR_FRZ2      0x40  /* freeze timer */
#define CPMTIMER_TGCR_STP2      0x20  /* stop timer */
#define CPMTIMER_TGCR_RST2      0x10  /* restart timer */

#define CPMTIMER_TMR_ORI        0x0010  /* output reference interrupt 
enable */
#define CPMTIMER_TMR_FRR        0x0008  /* free run/restart */
#define CPMTIMER_TMR_ICLK_INT16 0x0004  /* source internal clock/16 */
#define CPMTIMER_TMR_ICLK_INT   0x0002  /* source internal clock */
-----
[ SCENARIO 1 ]: 16bit Timer1 is triggering interrupt handler (every 
2.25microsec no matter what value of cpmt_trr1 is ??? )

    immap->im_cpmtimer.cpmt_tgcr1 &= ~(CPMTIMER_TGCR_CAS2 |
                                       CPMTIMER_TGCR_GM1  |
                                       CPMTIMER_TGCR_RST1 |
                                       CPMTIMER_TGCR_FRZ1 |
                                       CPMTIMER_TGCR_STP1);

    immap->im_cpmtimer.cpmt_tmr1 =  CPMTIMER_TMR_ORI | CPMTIMER_TMR_FRR 
| CPMTIMER_TMR_ICLK_INT16;

    immap->im_cpmtimer.cpmt_trr1 = 10000;
    immap->im_cpmtimer.cpmt_tcr1 = 0;
    immap->im_cpmtimer.cpmt_tcn1 = 0;
    immap->im_cpmtimer.cpmt_ter1 = 0;

    request_irq(SIU_INT_TIMER1,
                &timer_handler,
                SA_INTERRUPT,
                "timer_handler",
                NULL);

    /* and start timer1 */
    immap->im_cpmtimer.cpmt_tgcr1 |= CPMTIMER_TGCR_RST1;

-----
[ SCENARIO 2 ]: Cascaded timers: 32bit Timer1 and Timer2 - does not work 
- interrupt never occurs.

    immap->im_cpmtimer.cpmt_tgcr1 = CPMTIMER_TGCR_CAS2 | CPMTIMER_TGCR_GM1;

    immap->im_cpmtimer.cpmt_trr1 = 10000;
    immap->im_cpmtimer.cpmt_tcr1 = 0;
    immap->im_cpmtimer.cpmt_tcr2 = 0;
    immap->im_cpmtimer.cpmt_tcn1 = 0;
    immap->im_cpmtimer.cpmt_tcn2 = 0;
    immap->im_cpmtimer.cpmt_ter1 = 0;
    immap->im_cpmtimer.cpmt_ter2 = 0;

    immap->im_cpmtimer.cpmt_tmr1 = 0;
    immap->im_cpmtimer.cpmt_tmr2 = CPMTIMER_TMR_ORI | CPMTIMER_TMR_FRR | 
CPMTIMER_TMR_ICLK_INT16;

    request_irq(SIU_INT_TIMER2,
                &timer_handler,
                SA_INTERRUPT,
                "timer_handler",
                NULL);

    immap->im_cpmtimer.cpmt_tgcr1 |= CPMTIMER_TGCR_RST1;

Does anybody knows what I missed in cascaded timers initialisation 
(Scenario2) and why when I use 16 bit timer (Scenario1) it always 
triggers interrupt within 2.25microsec no matter what "trr1" value is?

Thank you very much for any help.
