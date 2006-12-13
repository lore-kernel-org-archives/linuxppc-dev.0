Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 8BF7467C01
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 23:58:32 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id BC55522D6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 13:58:28 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200B I2S driver
References: <BAY122-F958549D2AE5C2CEC3F7EDCAD60@phx.gbl>
In-Reply-To: <BAY122-F958549D2AE5C2CEC3F7EDCAD60@phx.gbl>
MIME-Version: 1.0
Message-ID: <200612131358.28434.roman.fietze@telemotive.de>
Date: Wed, 13 Dec 2006 13:58:28 +0100
Content-Type: multipart/signed; boundary="nextPart14049313.PFCfyRRia4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart14049313.PFCfyRRia4
Content-Type: multipart/mixed;
  boundary="Boundary-01=_0j/fFCA+48jpCgh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_0j/fFCA+48jpCgh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Pedro,

Here the kernel part of the driver.


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--Boundary-01=_0j/fFCA+48jpCgh
Content-Type: text/x-chdr;
  charset="iso-8859-1";
  name="mpc5xxx.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mpc5xxx.h"

/*
 * include/asm-ppc/mpc5xxx.h
 *
 * Prototypes, etc. for the Motorola MPC5xxx embedded cpu chips
 *
 * Author: Dale Farnsworth <dfarnsworth@mvista.com>
 *
 * 2003 (c) MontaVista, Software, Inc.  This file is licensed under
 * the terms of the GNU General Public License version 2.  This program
 * is licensed "as is" without any warranty of any kind, whether express
 * or implied.
 */
#ifndef __ASM_MPC5XXX_H
#define __ASM_MPC5XXX_H

#define MPC5xxx_FEC_DEBUG	0
#define MPC5xxx_SDMA_DEBUG	2

#ifndef __ASSEMBLY__
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/pci.h>
#include <linux/slab.h>
#include <linux/config.h>

#include <asm/byteorder.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <asm/uaccess.h>
#include <asm/machdep.h>
#endif /* __ASSEMBLY */

#define MPC5xxx_MBAR		0xf0000000
#define MPC5xxx_MBAR_SIZE	0x10000000
#define MPC5xxx_SDRAM_START	(MPC5xxx_MBAR + 0x0034)
#define MPC5xxx_SDRAM_CONFIG_0	(MPC5xxx_MBAR + 0x0034)
#define MPC5xxx_SDRAM_STOP	(MPC5xxx_MBAR + 0x0038)
#define MPC5xxx_SDRAM_CONFIG_1	(MPC5xxx_MBAR + 0x0038)
#define MPC5xxx_ADREN		(MPC5xxx_MBAR + 0x0054)
#define MPC5xxx_CDM		(MPC5xxx_MBAR + 0x0200)
#define MPC5xxx_SFTRST		(MPC5xxx_MBAR + 0x0220)
#define MPC5xxx_SFTRST_BIT	0x01000000
#define MPC5xxx_CSC		(MPC5xxx_MBAR + 0x0300)
#define MPC5xxx_CS0CFG		(MPC5xxx_MBAR + 0x0300)
#define MPC5xxx_INTR		(MPC5xxx_MBAR + 0x0500)
#define MPC5xxx_GPT		(MPC5xxx_MBAR + 0x0600) /* General Purpose Timers 0..7=
 */
#define MPC5xxx_GPT0		(MPC5xxx_MBAR + 0x0600) /* General Purpose Timers 0..=
7 */
#define MPC5xxx_GPT1		(MPC5xxx_MBAR + 0x0610)
#define MPC5xxx_GPT2		(MPC5xxx_MBAR + 0x0620)
#define MPC5xxx_GPT3		(MPC5xxx_MBAR + 0x0630)
#define MPC5xxx_GPT4		(MPC5xxx_MBAR + 0x0640)
#define MPC5xxx_GPT5		(MPC5xxx_MBAR + 0x0650)
#define MPC5xxx_GPT6		(MPC5xxx_MBAR + 0x0660)
#define MPC5xxx_GPT7		(MPC5xxx_MBAR + 0x0670)
#define MPC5xxx_MSCAN1		(MPC5xxx_MBAR + 0x0900)	/* MSCAN Module 1 */
#define MPC5xxx_MSCAN2		(MPC5xxx_MBAR + 0x0980)	/* MSCAN Module 2 */
#define MPC5xxx_GPIO		(MPC5xxx_MBAR + 0x0b00)
#define MPC5xxx_WU_GPIO         (MPC5xxx_MBAR + 0x0c00)
#define MPC5xxx_PCI		(MPC5xxx_MBAR + 0x0d00)
#define MPC5xxx_SPI		(MPC5xxx_MBAR + 0x0f00)
#define MPC5xxx_USB_OHCI	(MPC5xxx_MBAR + 0x1000)
#define MPC5xxx_SDMA		(MPC5xxx_MBAR + 0x1200)
#define MPC5xxx_XLB		(MPC5xxx_MBAR + 0x1f00)
#define MPC5xxx_PSC1		(MPC5xxx_MBAR + 0x2000)
#define MPC5xxx_PSC2		(MPC5xxx_MBAR + 0x2200)
#define MPC5xxx_PSC3		(MPC5xxx_MBAR + 0x2400)
#define MPC5xxx_PSC4		(MPC5xxx_MBAR + 0x2600)
#define MPC5xxx_PSC5		(MPC5xxx_MBAR + 0x2800)
#define MPC5xxx_PSC6		(MPC5xxx_MBAR + 0x2C00)
#define MPC5xxx_FEC		(MPC5xxx_MBAR + 0x3000)
#define MPC5xxx_PCI_MCTI	(MPC5xxx_MBAR + 0x3800)
#define MPC5xxx_ATA		(MPC5xxx_MBAR + 0x3a00)
#define MPC5xxx_I2C1		(MPC5xxx_MBAR + 0x3d00)
#define MPC5xxx_I2C_MICR	(MPC5xxx_MBAR + 0x3d20)
#define MPC5xxx_I2C2		(MPC5xxx_MBAR + 0x3d40)
#ifdef CONFIG_MPC5100
#define MPC5xxx_SRAM		(MPC5xxx_MBAR + 0x4000)
#define MPC5xxx_SRAM_SIZE	(8*1024)
#define MPC5xxx_SDMA_MAX_TASKS	8
#elif defined(CONFIG_MPC5200)
#define MPC5xxx_SRAM		(MPC5xxx_MBAR + 0x8000)
#define MPC5xxx_SRAM_SIZE	(16*1024)
#define MPC5xxx_SDMA_MAX_TASKS		16
#define MPC5xxx_SDMA_MAX_INITIATORS	32
#endif

/* Bit definitions for PCI window configuration regsiers.
 *
 * Attention: here Motorola/FreeScale suddenly counts bits from right to le=
ft as all the others
 * do! */
#define	MPC5xxx_INIT_WINDOW_DISABLE		(0U << 0)
#define	MPC5xxx_INIT_WINDOW_ENABLE		(1U << 0)

#define	MPC5xxx_INIT_WINDOW_READ		(0U << 1)
#define	MPC5xxx_INIT_WINDOW_READ_LINE		(1U << 1)
#define	MPC5xxx_INIT_WINDOW_READ_MULTIPLE	(2U << 1)

#define MPC5xxx_INIT_WINDOW_MEM			(0U << 3)
#define MPC5xxx_INIT_WINDOW_IO			(1U << 3)

/* Interrupt priority register bits */
#define MPC5xxx_PERPRI_MASK(x)		(0xF0000000U >> (((x) & 0x07U) * (uint32_t)=
4))
#define MPC5xxx_PERPRI_PRI(x,p)		(((p) & 0x0FU) << ((7UL - ((x) & 0x07U)) *=
 (uint32_t)4))
#define MPC5xxx_PERPRI_REG(x)		((&((struct mpc5xxx_intr *)MPC5xxx_INTR)->pe=
r_pri1) + ((x) / 8U))
#define MPC5xxx_PERPRI_SET(x,p)		do{*MPC5xxx_PERPRI_REG(x)=3D(*MPC5xxx_PERP=
RI_REG(x)&~MPC5xxx_PERPRI_MASK(x))|MPC5xxx_PERPRI_PRI((x),(p));} while(0)


/* GPT General Purpose Timers registers */

/* GPT Counter Input Register */
#define MPC5xxx_GPT_CIR_PRESCALE(prescale)	((uint32_t)((prescale) & 0xFFFFU=
) << 16)
#define MPC5xxx_GPT_CIR_COUNT(count)		((count) & 0xFFFFU)

/* GPT PWM Configuration Register */
#define MPC5xxx_GPT_PWMCR_WIDTH(width)		((uint32_t)((width) & 0xFFFFU) << 1=
6)
#define MPC5xxx_GPT_PWMCR_PWMOP			(1U << 16)
#define MPC5xxx_GPT_PWMCR_LOAD			(1U << 0)

/* GPT Enable and Mode Select Register */
#define MPC5xxx_GPT_EMSR_WDEN			(1U << 15)
#define MPC5xxx_GPT_EMSR_CE			(1U << 12)
#define MPC5xxx_GPT_EMSR_OPEN_DRAIN		(1U << 9)
#define MPC5xxx_GPT_EMSR_GPIO(x)		(((x) & 0x03U) << 4)
#define MPC5xxx_GPT_EMSR_GPIO_MASK		MPC5xxx_GPT_EMSR_GPIO(3)
#define MPC5xxx_GPT_EMSR_GPIO_INPUT		MPC5xxx_GPT_EMSR_GPIO(0)
#define MPC5xxx_GPT_EMSR_GPIO_OUTPUT_0		MPC5xxx_GPT_EMSR_GPIO(2)
#define MPC5xxx_GPT_EMSR_GPIO_OUTPUT_1		MPC5xxx_GPT_EMSR_GPIO(3)
#define MPC5xxx_GPT_EMSR_TIMER_MS(x)		(((x) & 0x07U) << 0)
#define MPC5xxx_GPT_EMSR_TIMER_DISABLED		MPC5xxx_GPT_EMSR_TIMER_MS(0)
#define MPC5xxx_GPT_EMSR_TIMER_INPUT_CAPTURE	MPC5xxx_GPT_EMSR_TIMER_MS(1)
#define MPC5xxx_GPT_EMSR_TIMER_OUTPUT_COMPARE	MPC5xxx_GPT_EMSR_TIMER_MS(2)
#define MPC5xxx_GPT_EMSR_TIMER_PWM		MPC5xxx_GPT_EMSR_TIMER_MS(3)
#define MPC5xxx_GPT_EMSR_TIMER_GPIO		MPC5xxx_GPT_EMSR_TIMER_MS(4)
#define MPC5xxx_GPT_EMSR_TIMER_PIN  	    	(1U << 8)


/* MSCAN control register 0 (CANCTL0) bits */
#define MPC5xxx_MSCAN_RXFRM			(1U << 7)
#define MPC5xxx_MSCAN_RXACT			(1U << 6)
#define MPC5xxx_MSCAN_CSWAI			(1U << 5)
#define MPC5xxx_MSCAN_SYNCH			(1U << 4)
#define MPC5xxx_MSCAN_TIME			(1U << 3)
#define MPC5xxx_MSCAN_WUPE			(1U << 2)
#define MPC5xxx_MSCAN_SLPRQ			(1U << 1)
#define MPC5xxx_MSCAN_INITRQ			(1U << 0)

/* MSCAN control register 1 (CANCTL1) bits */
#define MPC5xxx_MSCAN_CANE			(1U << 7)
#define MPC5xxx_MSCAN_CLKSRC			(1U << 6)
#define MPC5xxx_MSCAN_LOOPB			(1U << 5)
#define MPC5xxx_MSCAN_LISTEN			(1U << 4)
#define MPC5xxx_MSCAN_WUPM			(1U << 2)
#define MPC5xxx_MSCAN_SLPAK			(1U << 1)
#define MPC5xxx_MSCAN_INITAK			(1U << 0)

/* MSCAN receiver flag register (CANRFLG) bits */
#define MPC5xxx_MSCAN_WUPIF			(1U << 7)
#define MPC5xxx_MSCAN_CSCIF			(1U << 6)
#define MPC5xxx_MSCAN_RSTAT1			(1U << 5)
#define MPC5xxx_MSCAN_RSTAT0			(1U << 4)
#define MPC5xxx_MSCAN_TSTAT1			(1U << 3)
#define MPC5xxx_MSCAN_TSTAT0			(1U << 2)
#define MPC5xxx_MSCAN_OVRIF			(1U << 1)
#define MPC5xxx_MSCAN_RXF			(1U << 0)

/* MSCAN receiver interrupt enable register (CANRIER) bits */
#define MPC5xxx_MSCAN_WUPIE			(1U << 7)
#define MPC5xxx_MSCAN_CSCIE			(1U << 6)
#define MPC5xxx_MSCAN_RSTATE1			(1U << 5)
#define MPC5xxx_MSCAN_RSTATE0			(1U << 4)
#define MPC5xxx_MSCAN_TSTATE1			(1U << 3)
#define MPC5xxx_MSCAN_TSTATE0			(1U << 2)
#define MPC5xxx_MSCAN_OVRIE			(1U << 1)
#define MPC5xxx_MSCAN_RXFIE			(1U << 0)

/* MSCAN transmitter flag register (CANTFLG) bits */
#define MPC5xxx_MSCAN_TXE2			(1U << 2)
#define MPC5xxx_MSCAN_TXE1			(1U << 1)
#define MPC5xxx_MSCAN_TXE0			(1U << 0)
#define MPC5xxx_MSCAN_TXE			(MPC5xxx_MSCAN_TXE2 | MPC5xxx_MSCAN_TXE1 | MPC5=
xxx_MSCAN_TXE0)

/* MSCAN transmitter interrupt enable register (CANTIER) bits */
#define MPC5xxx_MSCAN_TXIE2			MPC5xxx_MSCAN_TXE2
#define MPC5xxx_MSCAN_TXIE1			MPC5xxx_MSCAN_TXE1
#define MPC5xxx_MSCAN_TXIE0			MPC5xxx_MSCAN_TXIE0
#define MPC5xxx_MSCAN_TXIE			MPC5xxx_MSCAN_TXE

/* MSCAN transmitter message abort request (CANTARQ) bits */
#define MPC5xxx_MSCAN_ABTRQ2			MPC5xxx_MSCAN_TXE2
#define MPC5xxx_MSCAN_ABTRQ1			MPC5xxx_MSCAN_TXE1
#define MPC5xxx_MSCAN_ABTRQ0			MPC5xxx_MSCAN_TXE0

/* MSCAN transmitter message abort ack (CANTAAK) bits */
#define MPC5xxx_MSCAN_ABTAK2			MPC5xxx_MSCAN_TXE2
#define MPC5xxx_MSCAN_ABTAK1			MPC5xxx_MSCAN_TXE1
#define MPC5xxx_MSCAN_ABTAK0			MPC5xxx_MSCAN_TXE0

/* MSCAN transmit buffer selection (CANTBSEL) bits */
#define MPC5xxx_MSCAN_TX2			MPC5xxx_MSCAN_TXE2
#define MPC5xxx_MSCAN_TX1			MPC5xxx_MSCAN_TXE1
#define MPC5xxx_MSCAN_TX0			MPC5xxx_MSCAN_TXE0

/* MSCAN ID acceptance control register (CANIDAC) bits */
#define MPC5xxx_MSCAN_IDAM1			(1U << 5)
#define MPC5xxx_MSCAN_IDAM0			(1U << 4)
#define MPC5xxx_MSCAN_IDHIT2			MPC5xxx_MSCAN_TXE2
#define MPC5xxx_MSCAN_IDHIT1			MPC5xxx_MSCAN_TXE1
#define MPC5xxx_MSCAN_IDHIT0			MPC5xxx_MSCAN_TXE0


/* SDMA bits */
#define MPC5xxx_SDMA_IPR_HOLD			(1U << 7)


/* XLB bits */
#define MPC5xxx_XLB_CONFIG_PLDIS		(1U << 31)
#define MPC5xxx_XLB_CONFIG_USE_WWF		(1U << 14)


/* CDM bits */

/* CDM clock enable register bits */
#define MPC5xxx_CDM_CER_PSC6			(1U << 4)
#define MPC5xxx_CDM_CER_PSC1			(1U << 5)
#define MPC5xxx_CDM_CER_PSC2			(1U << 6)
#define MPC5xxx_CDM_CER_PSC345			(1U << 7)
#define MPC5xxx_CDM_PCI_CLK			(1U << 18)


/* GPIO port_config bits	*/
#define MPC5xxx_GPIO_PC_PSC1(x)			(((x) & 0x0FU) << 0)
#define MPC5xxx_GPIO_PC_PSC1_MASK		MPC5xxx_GPIO_PC_PSC1(0xFU)
#define MPC5xxx_GPIO_PC_PSC1_CODEC1_USB2	MPC5xxx_GPIO_PC_PSC1(0x1U)
#define MPC5xxx_GPIO_PC_PSC1_UART_NO_CD		MPC5xxx_GPIO_PC_PSC1(0x4U)
#define MPC5xxx_GPIO_PC_PSC1_UART_CD		MPC5xxx_GPIO_PC_PSC1(0x5U)
#define MPC5xxx_GPIO_PC_PSC1_CODEC1		MPC5xxx_GPIO_PC_PSC1(0x6U)
#define MPC5xxx_GPIO_PC_PSC1_CODEC1_MCLK	MPC5xxx_GPIO_PC_PSC1(0x7U)

#define MPC5xxx_GPIO_PC_PSC2(x)			(((x) & 0x0FU) << 4)
#define MPC5xxx_GPIO_PC_PSC2_MASK		MPC5xxx_GPIO_PC_PSC2(0xFU)
#define MPC5xxx_GPIO_PC_PSC2_GPIO		MPC5xxx_GPIO_PC_PSC3(0x0U)
#define MPC5xxx_GPIO_PC_PSC2_CAN		MPC5xxx_GPIO_PC_PSC2(0x1U)
#define MPC5xxx_GPIO_PC_PSC2_AC97		MPC5xxx_GPIO_PC_PSC2(0x2U)
#define MPC5xxx_GPIO_PC_PSC2_UART_NO_CD		MPC5xxx_GPIO_PC_PSC2(0x4U)
#define MPC5xxx_GPIO_PC_PSC2_UART_CD		MPC5xxx_GPIO_PC_PSC2(0x5U)
#define MPC5xxx_GPIO_PC_PSC2_CODEC2		MPC5xxx_GPIO_PC_PSC2(0x6U)
#define MPC5xxx_GPIO_PC_PSC2_CODEC2_MCLK	MPC5xxx_GPIO_PC_PSC2(0x7U)

#define MPC5xxx_GPIO_PC_PSC3(x)			(((x) & 0x0FU) << 8)
#define MPC5xxx_GPIO_PC_PSC3_MASK		MPC5xxx_GPIO_PC_PSC3(0xFU)
#define MPC5xxx_GPIO_PC_PSC3_GPIO		MPC5xxx_GPIO_PC_PSC3(0x0U)
#define MPC5xxx_GPIO_PC_PSC3_USB2		MPC5xxx_GPIO_PC_PSC3(0x1U)
#define MPC5xxx_GPIO_PC_PSC3_UART_NO_CD		MPC5xxx_GPIO_PC_PSC3(0x4U)
#define MPC5xxx_GPIO_PC_PSC3_UART_CD		MPC5xxx_GPIO_PC_PSC3(0x5U)
#define MPC5xxx_GPIO_PC_PSC3_CODEC3		MPC5xxx_GPIO_PC_PSC3(0x6U)
#define MPC5xxx_GPIO_PC_PSC3_CODEC3_MCLK	MPC5xxx_GPIO_PC_PSC3(0x7U)
#define MPC5xxx_GPIO_PC_PSC3_SPI		MPC5xxx_GPIO_PC_PSC3(0x8U)

#define MPC5xxx_GPIO_PC_USB(x)			(((x) & 0x03U) << 12)
#define MPC5xxx_GPIO_PC_USB_MASK		MPC5xxx_GPIO_PC_USB(0x3U)
#define MPC5xxx_GPIO_PC_USB_GPIO		MPC5xxx_GPIO_PC_USB(0x0U)
#define MPC5xxx_GPIO_PC_USB_USB			MPC5xxx_GPIO_PC_USB(0x1U)
#define MPC5xxx_GPIO_PC_USB_UARTS		MPC5xxx_GPIO_PC_USB(0x2U)

#define MPC5xxx_GPIO_PC_USB_SE			(1U << 14)
#define MPC5xxx_GPIO_PC_PCI_DIS			(1U << 15)

#define MPC5xxx_GPIO_PC_PSC6(x)			(((x) & 0x07U) << 20)
#define MPC5xxx_GPIO_PC_PSC6_MASK		MPC5xxx_GPIO_PC_PSC6(0x7U)
#define MPC5xxx_GPIO_PC_PSC6_UART_NO_CD		MPC5xxx_GPIO_PC_PSC6(0x5U)
#define MPC5xxx_GPIO_PC_PSC6_CODEC6		MPC5xxx_GPIO_PC_PSC6(0x7U)

#define MPC5xxx_GPIO_PC_IR_USB_CLK		(1U << 23)

#define MPC5xxx_GPIO_PC_ATA(x)			(((x) & 0x03U) << 24)
#define MPC5xxx_GPIO_PC_ATA_MASK		MPC5xxx_GPIO_PC_PSC2(0x3U)
#define MPC5xxx_GPIO_PC_ATA_NONE		MPC5xxx_GPIO_PC_PSC2(0x0U)
#define MPC5xxx_GPIO_PC_ATA_CSB45		MPC5xxx_GPIO_PC_PSC2(0x1U)
#define MPC5xxx_GPIO_PC_ATA_I2C2		MPC5xxx_GPIO_PC_PSC2(0x2U)
#define MPC5xxx_GPIO_PC_ATA_TMR01		MPC5xxx_GPIO_PC_PSC2(0x3U)


#define MPC5xxx_GPIO_PC_ALT(x)			(((x) & 0x03U) << 28)
#define MPC5xxx_GPIO_PC_ALT_MASK		MPC5xxx_GPIO_PC_ALT(0x3U)
#define MPC5xxx_GPIO_PC_ALT_NONE		MPC5xxx_GPIO_PC_ALT(0x0U)
#define MPC5xxx_GPIO_PC_ALT_CAN			MPC5xxx_GPIO_PC_ALT(0x1U)
#define MPC5xxx_GPIO_PC_ALT_SPI			MPC5xxx_GPIO_PC_ALT(0x2U)
#define MPC5xxx_GPIO_PC_ALT_BOTH		MPC5xxx_GPIO_PC_ALT(0x3U)


/* GPIO Simple GPIO bits, bit numbers are pin numbers, Valid for
 * simple_gpioe, simple_ode, simple_ddr, simple_dvo and simple_ival in
 * mpc5xxx_gpio.
 */
#define MPC5xxx_GPIO_BIT_PSC2_2			(1U << 6)
#define MPC5xxx_GPIO_BIT_PSC3_6			(1U << 12)
#define MPC5xxx_GPIO_BIT_PSC3_7			(1U << 13)
#define MPC5xxx_GPIO_BIT_USB1_0			(1U << 16)

/* GPIO Simple Interrupt bits
 */
#define MPC5xxx_GPIO_SINT_0			(1U << 0)
#define MPC5xxx_GPIO_SINT_1			(1U << 1)
#define MPC5xxx_GPIO_SINT_2			(1U << 2)
#define MPC5xxx_GPIO_SINT_3			(1U << 3)


/* Wakeup GPIO bits
 */
#define MPC5xxx_WU_GPIO_0			(1U << 0)
#define MPC5xxx_WU_GPIO_2			(1U << 2)
#define MPC5xxx_WU_GPIO_6			(1U << 6)
#define MPC5xxx_WU_GPIO_7			(1U << 7)


/* PSC definitions */

#define MPC5xxx_PSC_FIFO_SIZE		(512U)

/* PSC CTUR bits		*/
#define MPC5xxx_PSC_CTUR_CODEC(x)	((x) & 0xFFU)

/* PSC CTLR bits		*/
#define MPC5xxx_PSC_CTLR_CODEC(x)	((x) & 0xFFU)

/* PSC CCR bits			*/
#define MPC5xxx_PSC_CCR_CODEC(fsd,bcd)	((((uint16_t)(fsd) & 0xFFU) << 8) | =
((bcd) & 0xFFU))

/* PSC MCLOCK			*/
#define MPC5xxx_PSC_MCLOCK_ENABLE	(1U << 15)
#define MPC5xxx_PSC_MCLOCK_MCLKDIV(x)	((uint16_t)(x) & 0x1FFU)


/* PSC SICR bits		*/
#define MPC5xxx_PSC_SICR_DTS1_AFTER	(1UL << 29)
#define MPC5xxx_PSC_SICR_SHDIR_LSB	(1UL << 28)

#define MPC5xxx_PSC_SICR_SIM(x)		(((uint32_t)(x) & 0x0FU) << 24)
#define MPC5xxx_PSC_SICR_SIM_UART	MPC5xxx_PSC_SICR_SIM(0U)
#define MPC5xxx_PSC_SICR_SIM_CODEC_8	MPC5xxx_PSC_SICR_SIM(1U)
#define MPC5xxx_PSC_SICR_SIM_CODEC_16	MPC5xxx_PSC_SICR_SIM(2U)
#define MPC5xxx_PSC_SICR_SIM_AC97	MPC5xxx_PSC_SICR_SIM(3U)
#define MPC5xxx_PSC_SICR_SIM_SIR	MPC5xxx_PSC_SICR_SIM(4U)
#define MPC5xxx_PSC_SICR_SIM_MIR	MPC5xxx_PSC_SICR_SIM(5U)
#define MPC5xxx_PSC_SICR_SIM_FIR	MPC5xxx_PSC_SICR_SIM(6U)
#define MPC5xxx_PSC_SICR_SIM_CODEC_24	MPC5xxx_PSC_SICR_SIM(7U)
#define MPC5xxx_PSC_SICR_SIM_UART_DCD	MPC5xxx_PSC_SICR_SIM(8U)
#define MPC5xxx_PSC_SICR_SIM_SIR_DCD	MPC5xxx_PSC_SICR_SIM(12U)
#define MPC5xxx_PSC_SICR_SIM_CODEC_32	MPC5xxx_PSC_SICR_SIM(15U)

#define MPC5xxx_PSC_SICR_GENCLK_INT	(1UL << 23)
#define MPC5xxx_PSC_SICR_MULTIWD	(1UL << 22)
#define MPC5xxx_PSC_SICR_CLKPOL_RISE	(1UL << 21)
#define MPC5xxx_PSC_SICR_SYNCPOL_RISE	(1UL << 20)

#define MPC5xxx_PSC_SICR_SPI		(1UL << 15)
#define MPC5xxx_PSC_SICR_MSTR		(1UL << 14)
#define MPC5xxx_PSC_SICR_CPOL		(1UL << 13)
#define MPC5xxx_PSC_SICR_CPHA		(1UL << 12)
#define MPC5xxx_PSC_SICR_USEEOF		(1UL << 11)


/* SPI control1 bits		*/
#define MPC5xxx_SPI_CONTROL1_LSBFE	(1U << 0)
#define MPC5xxx_SPI_CONTROL1_SSOE	(1U << 1)
#define MPC5xxx_SPI_CONTROL1_CPHA	(1U << 2)
#define MPC5xxx_SPI_CONTROL1_CPOL	(1U << 3)
#define MPC5xxx_SPI_CONTROL1_MSTR	(1U << 4)
#define MPC5xxx_SPI_CONTROL1_SPE	(1U << 6)
#define MPC5xxx_SPI_CONTROL1_SPIE	(1U << 7)

/* SPI control2 bits		*/
#define MPC5xxx_SPI_CONTROL2_SPC0	(1U << 0)
#define MPC5xxx_SPI_CONTROL2_SPISWAI	(1U << 1)

/* SPI baud bits		*/
#define MPC5xxx_SPI_BAUD_SPR(x)		(((x) & 0x07U) << 0)
#define MPC5xxx_SPI_BAUD_SPPR(x)	(((x) & 0x07U) << 4)

/* SPI status bits		*/
#define MPC5xxx_SPI_STATUS_MODF		(1U << 4)
#define MPC5xxx_SPI_STATUS_WCOL		(1U << 6)
#define MPC5xxx_SPI_STATUS_SPIF		(1U << 7)


/* I2Cn address register */
#define MPC5xxx_I2C_ADDR(x)	(((x) & 0x7FU) << 25)

/* I2Cn frequency divider register possible values */
#define MPC5xxx_I2C_100HZ	0x1F	/* 100HZ Clock */

/* I2Cn control register bits */
#define MPC5xxx_I2C_EN		0x80	/* Enable I2Cn module */
#define MPC5xxx_I2C_IEN		0x40	/* Enable interrupt from I2Cn module */
#define MPC5xxx_I2C_STA		0x20	/* Master/Slave mode select */
#define MPC5xxx_I2C_TX		0x10	/* Transmit/Receive mode select */
#define MPC5xxx_I2C_TXAK	0x08	/* Transmit ack enable */
#define MPC5xxx_I2C_RSTA	0x04	/* Repeat start */
#define MPC5xxx_I2C_INIT_MASK	(MPC5xxx_I2C_EN | MPC5xxx_I2C_STA | MPC5xxx_I=
2C_TX | MPC5xxx_I2C_RSTA)

/* I2Cn status register bits */
#define MPC5xxx_I2C_CF		0x80	/* Data transferring */
#define MPC5xxx_I2C_AAS		0x40	/* Addressed as slave */
#define MPC5xxx_I2C_BB		0x20	/* Bus busy */
#define MPC5xxx_I2C_AL		0x10	/* Arbitration lost */
#define MPC5xxx_I2C_SRW		0x04	/* Slave Read/Write */
#define MPC5xxx_I2C_IF		0x02	/* I2Cn Interrupt */
#define MPC5xxx_I2C_RXAK	0x01	/* Receive ack */


/* Programmable Serial Controller (PSC) status register bits */
#define MPC5xxx_PSC_SR_CDE	0x0080
#define MPC5xxx_PSC_SR_RXRDY	0x0100
#define MPC5xxx_PSC_SR_RXFULL	0x0200
#define MPC5xxx_PSC_SR_TXRDY	0x0400
#define MPC5xxx_PSC_SR_TXEMP	0x0800
#define MPC5xxx_PSC_SR_OE	0x1000
#define MPC5xxx_PSC_SR_PE	0x2000
#define MPC5xxx_PSC_SR_FE	0x4000
#define MPC5xxx_PSC_SR_RB	0x8000

/* PSC Command values */
#define MPC5xxx_PSC_RX_ENABLE		0x0001
#define MPC5xxx_PSC_RX_DISABLE		0x0002
#define MPC5xxx_PSC_TX_ENABLE		0x0004
#define MPC5xxx_PSC_TX_DISABLE		0x0008
#define MPC5xxx_PSC_SEL_MODE_REG_1	0x0010
#define MPC5xxx_PSC_RST_RX		0x0020
#define MPC5xxx_PSC_RST_TX		0x0030
#define MPC5xxx_PSC_RST_ERR_STAT	0x0040
#define MPC5xxx_PSC_RST_BRK_CHG_INT	0x0050
#define MPC5xxx_PSC_START_BRK		0x0060
#define MPC5xxx_PSC_STOP_BRK		0x0070

/* PSC FIFO status bits */
#define MPC5xxx_PSC_FIFO_ERR		(1U << 6)
#define MPC5xxx_PSC_FIFO_UF		(1U << 5)
#define MPC5xxx_PSC_FIFO_OF		(1U << 4)
#define MPC5xxx_PSC_FIFO_FR		(1U << 3)
#define MPC5xxx_PSC_FIFO_FULL		(1U << 2)
#define MPC5xxx_PSC_FIFO_ALARM		(1U << 1)
#define MPC5xxx_PSC_FIFO_EMPTY		(1U << 0)

/* Programmable Serial Controller (PSC) interrupt status register bits */
#define MPC5xxx_PSC_ISR_DEOF		(1U << 7)
#define MPC5xxx_PSC_ISR_TXRDY		(1U << 8)
#define MPC5xxx_PSC_ISR_RXRDY		(1U << 9)
#define MPC5xxx_PSC_ISR_DB		(1U << 10)
#define MPC5xxx_PSC_ISR_URERR		(1U << 11)
#define MPC5xxx_PSC_ISR_ORERR		(1U << 12)
#define MPC5xxx_PSC_ISR_IPC		(1U << 15)

/* PSC interrupt mask bits */
#define MPC5xxx_PSC_IMR_TXRDY		MPC5xxx_PSC_ISR_TXRDY
#define MPC5xxx_PSC_IMR_RXRDY		MPC5xxx_PSC_ISR_RXRDY
#define MPC5xxx_PSC_IMR_DB		MPC5xxx_PSC_ISR_DB
#define MPC5xxx_PSC_IMR_URERR		MPC5xxx_PSC_ISR_URERR
#define MPC5xxx_PSC_IMR_ORERR		MPC5xxx_PSC_ISR_ORERR
#define MPC5xxx_PSC_IMR_IPC		MPC5xxx_PSC_ISR_IPC

/* PSC input port change bit */
#define MPC5xxx_PSC_CTS			0x01
#define MPC5xxx_PSC_DCD			0x02
#define MPC5xxx_PSC_D_CTS		0x10
#define MPC5xxx_PSC_D_DCD		0x20

/* PSC mode fields */

/* MR1 */
#define MPC5xxx_PSC_MODE_5_BITS		0x00
#define MPC5xxx_PSC_MODE_6_BITS		0x01
#define MPC5xxx_PSC_MODE_7_BITS		0x02
#define MPC5xxx_PSC_MODE_8_BITS		0x03
#define MPC5xxx_PSC_MODE_PAREVEN	0x00
#define MPC5xxx_PSC_MODE_PARODD		0x04
#define MPC5xxx_PSC_MODE_PARFORCE	0x08
#define MPC5xxx_PSC_MODE_PARNONE	0x10
#define MPC5xxx_PSC_MODE_RESERVED	0x20
#define MPC5xxx_PSC_MODE_FFULL		0x40
#define MPC5xxx_PSC_MODE_RXRTS		0x80

/* MR2 */
#define MPC5xxx_PSC_MODE2_TXCTS			(1U << 4)
#define MPC5xxx_PSC_MODE2_TXRTS			(1U << 5)
#define MPC5xxx_PSC_MODE2_SB(n)			(((n) & 0x0FU) << 0)
#define MPC5xxx_PSC_MODE2_ONE_STOP_5_BITS	MPC5xxx_PSC_MODE2_SB(0)
#define MPC5xxx_PSC_MODE2_ONE_STOP		MPC5xxx_PSC_MODE2_SB(7)
#define MPC5xxx_PSC_MODE2_TWO_STOP		MPC5xxx_PSC_MODE2_SB(15)


#define MPC5xxx_PSC_RFNUM_MASK		0x01ff

/* Memory allocation block size */
#define MPC5xxx_SDRAM_UNIT	0x8000		/* 32K byte */

#define MPC5xxx_CRIT_IRQ_NUM	4
#define MPC5xxx_MAIN_IRQ_NUM	17
#define MPC5xxx_SDMA_IRQ_NUM	17
#define MPC5xxx_PERP_IRQ_NUM	22

#define MPC5xxx_CRIT_IRQ_BASE	0
#define MPC5xxx_MAIN_IRQ_BASE	(MPC5xxx_CRIT_IRQ_BASE + MPC5xxx_CRIT_IRQ_NUM)
#define MPC5xxx_SDMA_IRQ_BASE	(MPC5xxx_MAIN_IRQ_BASE + MPC5xxx_MAIN_IRQ_NUM)
#define MPC5xxx_PERP_IRQ_BASE	(MPC5xxx_SDMA_IRQ_BASE + MPC5xxx_SDMA_IRQ_NUM)

#define MPC5xxx_IRQ0			(MPC5xxx_CRIT_IRQ_BASE + 0)
#define MPC5xxx_SLICE_TIMER_0_IRQ	(MPC5xxx_CRIT_IRQ_BASE + 1)
#define MPC5xxx_HI_INT_IRQ		(MPC5xxx_CRIT_IRQ_BASE + 2)
#define MPC5xxx_CCS_IRQ			(MPC5xxx_CRIT_IRQ_BASE + 3)

#define MPC5xxx_IRQ1			(MPC5xxx_MAIN_IRQ_BASE + 1)
#define MPC5xxx_IRQ2			(MPC5xxx_MAIN_IRQ_BASE + 2)
#define MPC5xxx_IRQ3			(MPC5xxx_MAIN_IRQ_BASE + 3)

#define MPC5xxx_SDMA_IRQ		(MPC5xxx_PERP_IRQ_BASE + 0)
#define MPC5xxx_PSC1_IRQ		(MPC5xxx_PERP_IRQ_BASE + 1)
#define MPC5xxx_PSC2_IRQ		(MPC5xxx_PERP_IRQ_BASE + 2)
#define MPC5xxx_PSC3_IRQ		(MPC5xxx_PERP_IRQ_BASE + 3)
#define MPC5xxx_PSC6_IRQ		(MPC5xxx_PERP_IRQ_BASE + 4)
#define MPC5xxx_IRDA_IRQ		(MPC5xxx_PSC6_IRQ)
#define MPC5xxx_FEC_IRQ			(MPC5xxx_PERP_IRQ_BASE + 5)
#define MPC5xxx_USB_IRQ			(MPC5xxx_PERP_IRQ_BASE + 6)
#define MPC5xxx_ATA_IRQ			(MPC5xxx_PERP_IRQ_BASE + 7)
#define MPC5xxx_PCI_CNTRL_IRQ		(MPC5xxx_PERP_IRQ_BASE + 8)
#define MPC5xxx_PCI_SCIRX_IRQ		(MPC5xxx_PERP_IRQ_BASE + 9)
#define MPC5xxx_PCI_SCITX_IRQ		(MPC5xxx_PERP_IRQ_BASE + 10)
#define MPC5xxx_PSC4_IRQ		(MPC5xxx_PERP_IRQ_BASE + 11)
#define MPC5xxx_PSC5_IRQ		(MPC5xxx_PERP_IRQ_BASE + 12)
#define MPC5xxx_SPI_MODF_IRQ		(MPC5xxx_PERP_IRQ_BASE + 13)
#define MPC5xxx_SPI_SPIF_IRQ		(MPC5xxx_PERP_IRQ_BASE + 14)
#define MPC5xxx_I2C1_IRQ		(MPC5xxx_PERP_IRQ_BASE + 15)
#define MPC5xxx_I2C2_IRQ		(MPC5xxx_PERP_IRQ_BASE + 16)
#define MPC5xxx_CAN1_IRQ		(MPC5xxx_PERP_IRQ_BASE + 17)
#define MPC5xxx_CAN2_IRQ		(MPC5xxx_PERP_IRQ_BASE + 18)
#define MPC5xxx_IR_RX_IRQ		(MPC5xxx_PERP_IRQ_BASE + 19)
#define MPC5xxx_IR_TX_IRQ		(MPC5xxx_PERP_IRQ_BASE + 20)
#define MPC5xxx_XLB_ARB_IRQ		(MPC5xxx_PERP_IRQ_BASE + 21)

#define PCI_WINDOW_TRANSLATION(proc_start, proc_end, pci_start, pci_end) \
	((((proc_start >> 24) & 0xff) << 24) | \
	((((proc_end - proc_start) >> 24) & 0xff) << 16) | \
	(((pci_start >> 24) & 0xff) << 8))

#define PCI_WINDOW_CONTROL(win0, win1, win2)	(((win0) << 24) | ((win1) << 1=
6) | ((win2) << 8))

#ifndef __ASSEMBLY__

#define MPC5xxx_PCI_FIFO_SIZE		(512U)

struct mpc5xxx_pci {
	volatile uint32_t	idr;		/* PCI + 0x00 */
	volatile uint32_t	scr;		/* PCI + 0x04 */
	volatile uint32_t	ccrir;		/* PCI + 0x08 */
	volatile uint32_t	cr1;		/* PCI + 0x0C */
	volatile uint32_t	bar0;		/* PCI + 0x10 */
	volatile uint32_t	bar1;		/* PCI + 0x14 */
	volatile uint8_t	reserved1[16];	/* PCI + 0x18 */
	volatile uint32_t	ccpr;		/* PCI + 0x28 */
	volatile uint32_t	sid;		/* PCI + 0x2C */
	volatile uint32_t	erbar;		/* PCI + 0x30 */
	volatile uint32_t	cpr;		/* PCI + 0x34 */
	volatile uint8_t	reserved2[4];	/* PCI + 0x38 */
	volatile uint32_t	cr2;		/* PCI + 0x3C */
	volatile uint8_t	reserved3[32];	/* PCI + 0x40 */
	volatile uint32_t	gscr;		/* PCI + 0x60 */
	volatile uint32_t	tbatr0;		/* PCI + 0x64 */
	volatile uint32_t	tbatr1;		/* PCI + 0x68 */
	volatile uint32_t	tcr;		/* PCI + 0x6C */
	volatile uint32_t	iw0btar;	/* PCI + 0x70 */
	volatile uint32_t	iw1btar;	/* PCI + 0x74 */
	volatile uint32_t	iw2btar;	/* PCI + 0x78 */
	volatile uint8_t	reserved4[4];	/* PCI + 0x7C */
	volatile uint32_t	iwcr;		/* PCI + 0x80 */
	volatile uint32_t	icr;		/* PCI + 0x84 */
	volatile uint32_t	isr;		/* PCI + 0x88 */
	volatile uint32_t	arb;		/* PCI + 0x8C */
	volatile uint8_t	reserved5[104];	/* PCI + 0x90 */
	volatile uint32_t	car;		/* PCI + 0xF8 */
	volatile uint8_t	reserved6[4];	/* PCI + 0xFC */
};


struct mpc5xxx_pci_mcti {
	volatile uint16_t	pcitpsr;	/* PCI_MCTI + 0x00 */
	volatile uint16_t	reservedtpsr;	/* PCI_MCTI + 0x02 */
	volatile uint32_t	pcitsar;	/* PCI_MCTI + 0x04 */
	volatile uint32_t	pcittcr;	/* PCI_MCTI + 0x08 */
	volatile uint16_t	pciter;		/* PCI_MCTI + 0x0C */
	volatile uint16_t	reservedter;	/* PCI_MCTI + 0x0E */
	volatile uint32_t	pcitnar;	/* PCI_MCTI + 0x10 */
	volatile uint32_t	pcitlwr;	/* PCI_MCTI + 0x14 */
	volatile uint16_t	pcitdcr_bd;	/* PCI_MCTI + 0x18 */
	volatile uint16_t	pcitdcr_pd;	/* PCI_MCTI + 0x1A */
	volatile uint16_t	pcitsr;		/* PCI_MCTI + 0x1C */
	volatile uint16_t	reservedtsr;	/* PCI_MCTI + 0x1A */
	volatile uint32_t	reservedt[8];	/* PCI_MCTI + 0x20 */
	volatile uint32_t	pcitfdr;	/* PCI_MCTI + 0x40 */
	volatile uint16_t	pcitfsr;	/* PCI_MCTI + 0x44 */
	volatile uint16_t	reservedtfsr;	/* PCI_MCTI + 0x46 */
	volatile uint16_t	pcitfcr;	/* PCI_MCTI + 0x48 */
	volatile uint16_t	reservedtfcr;	/* PCI_MCTI + 0x4A */
	volatile uint32_t	pcitfar;	/* PCI_MCTI + 0x4C */
	volatile uint32_t	pcitfrpr;	/* PCI_MCTI + 0x50 */
	volatile uint32_t	pcitfwpr;	/* PCI_MCTI + 0x54 */

	volatile uint32_t	reserved[10];	/* PCI_MCTI + 0x58 */

	volatile uint16_t	pcirpsr;	/* PCI_MCTI + 0x80 */
	volatile uint16_t	reservedrpsr;	/* PCI_MCTI + 0x82 */
	volatile uint32_t	pcirsar;	/* PCI_MCTI + 0x84 */
	volatile uint32_t	pcirtcr;	/* PCI_MCTI + 0x88 */
	volatile uint16_t	pcirer;		/* PCI_MCTI + 0x8C */
	volatile uint16_t	reservedrer;	/* PCI_MCTI + 0x8E */
	volatile uint32_t	pcirnar;	/* PCI_MCTI + 0x90 */
	volatile uint32_t	pcirlwr;	/* PCI_MCTI + 0x94 */
	volatile uint16_t	pcirdcr_bd;	/* PCI_MCTI + 0x98 */
	volatile uint16_t	pcirdcr_pd;	/* PCI_MCTI + 0x9A */
	volatile uint16_t	pcirsr;		/* PCI_MCTI + 0x9C */
	volatile uint16_t	reservedrsr;	/* PCI_MCTI + 0x9C */
	volatile uint32_t	reservedr[8];	/* PCI_MCTI + 0xA0 */
	volatile uint32_t	pcirfdr;	/* PCI_MCTI + 0xC0 */
	volatile uint16_t	pcirfsr;	/* PCI_MCTI + 0xC4 */
	volatile uint16_t	reservedrfsr;	/* PCI_MCTI + 0xC6 */
	volatile uint16_t	pcirfcr;	/* PCI_MCTI + 0xC8 */
	volatile uint16_t	reservedrfcr;	/* PCI_MCTI + 0xCA */
	volatile uint32_t	pcirfar;	/* PCI_MCTI + 0xCC */
	volatile uint32_t	pcirfrpr;	/* PCI_MCTI + 0xD0 */
	volatile uint32_t	pcirfwpr;	/* PCI_MCTI + 0xD4 */
};

struct mpc5xxx_psc {
	volatile uint8_t	mode;		/* PSC + 0x00 */
	volatile uint8_t	reserved0[3];
	union {					/* PSC + 0x04 */
		volatile uint16_t	status;
		volatile uint16_t	clock_select;
	} sr_csr;
#define mpc5xxx_psc_status	sr_csr.status
#define mpc5xxx_psc_clock_select sr_csr.clock_select
	volatile uint16_t	reserved1;
	volatile uint8_t	command;	/* PSC + 0x08 */
	volatile uint8_t	reserved2[3];
	union {					/* PSC + 0x0c */
		volatile uint8_t	buffer_8;
		volatile uint16_t	buffer_16;
		volatile uint32_t	buffer_32;
	} buffer;
#define mpc5xxx_psc_buffer_8	buffer.buffer_8
#define mpc5xxx_psc_buffer_16	buffer.buffer_16
#define mpc5xxx_psc_buffer_32	buffer.buffer_32
	union {					/* PSC + 0x10 */
		volatile uint8_t	ipcr;
		volatile uint8_t	acr;
	} ipcr_acr;
#define mpc5xxx_psc_ipcr		ipcr_acr.ipcr
#define mpc5xxx_psc_acr		ipcr_acr.acr
	volatile uint8_t	reserved3[3];
	union {					/* PSC + 0x14 */
		volatile uint16_t	isr;
		volatile uint16_t	imr;
	} isr_imr;
#define mpc5xxx_psc_isr		isr_imr.isr
#define mpc5xxx_psc_imr		isr_imr.imr
	volatile uint16_t	reserved4;
	volatile uint8_t	ctur;		/* PSC + 0x18 */
	volatile uint8_t	reserved5[3];
	volatile uint8_t	ctlr;		/* PSC + 0x1c */
	volatile uint8_t	reserved6[3];
	volatile uint16_t	ccr;		/* PSC + 0x20 */
	volatile uint8_t	reserved7[14];
	volatile uint8_t	ivr;		/* PSC + 0x30 */
	volatile uint8_t	reserved8[3];
	volatile uint8_t	ip;		/* PSC + 0x34 */
	volatile uint8_t	reserved9[3];
	volatile uint8_t	op1;		/* PSC + 0x38 */
	volatile uint8_t	reserved10[3];
	volatile uint8_t	op0;		/* PSC + 0x3c */
	volatile uint8_t	reserved11[3];
	volatile uint32_t	sicr;		/* PSC + 0x40 */
	volatile uint8_t	ircr1;		/* PSC + 0x44 */
	volatile uint8_t	reserved13[3];
	volatile uint8_t	ircr2;		/* PSC + 0x44 */
	volatile uint8_t	reserved14[3];
	volatile uint8_t	irsdr;		/* PSC + 0x4c */
	volatile uint8_t	reserved15[3];
	volatile uint8_t	irmdr;		/* PSC + 0x50 */
	volatile uint8_t	reserved16[3];
	volatile uint8_t	irfdr;		/* PSC + 0x54 */
	volatile uint8_t	reserved17[3];
	volatile uint16_t	rfnum;		/* PSC + 0x58 */
	volatile uint16_t	reserved18;
	volatile uint16_t	tfnum;		/* PSC + 0x5c */
	volatile uint16_t	reserved19;
	volatile uint32_t	rfdata;		/* PSC + 0x60 */
	volatile uint16_t	rfstat;		/* PSC + 0x64 */
	volatile uint16_t	reserved20;
	volatile uint8_t	rfcntl;		/* PSC + 0x68 */
	volatile uint8_t	reserved21[5];
	volatile uint16_t	rfalarm;	/* PSC + 0x6e */
	volatile uint16_t	reserved22;
	volatile uint16_t	rfrptr;		/* PSC + 0x72 */
	volatile uint16_t	reserved23;
	volatile uint16_t	rfwptr;		/* PSC + 0x76 */
	volatile uint16_t	reserved24;
	volatile uint16_t	rflrfptr;	/* PSC + 0x7a */
	volatile uint16_t	reserved25;
	volatile uint16_t	rflwfptr;	/* PSC + 0x7e */
	volatile uint32_t	tfdata;		/* PSC + 0x80 */
	volatile uint16_t	tfstat;		/* PSC + 0x84 */
	volatile uint16_t	reserved26;
	volatile uint8_t	tfcntl;		/* PSC + 0x88 */
	volatile uint8_t	reserved27[5];
	volatile uint16_t	tfalarm;	/* PSC + 0x8e */
	volatile uint16_t	reserved28;
	volatile uint16_t	tfrptr;		/* PSC + 0x92 */
	volatile uint16_t	reserved29;
	volatile uint16_t	tfwptr;		/* PSC + 0x96 */
	volatile uint16_t	reserved30;
	volatile uint16_t	tflrfptr;	/* PSC + 0x9a */
	volatile uint16_t	reserved31;
	volatile uint16_t	tflwfptr;	/* PSC + 0x9e */
};

#define PSC_ADDRESS(num)	((struct mpc5xxx_psc *)(MPC5xxx_PSC1 + (((num) - 1=
) * 0x200)))

struct mpc5xxx_spi {
	volatile uint8_t	control1;	/* SPI + 0x00 */
	volatile uint8_t	control2;	/* SPI + 0x01 */
	volatile uint8_t	reserved0[2];	/* SPI + 0x02 */
	volatile uint8_t	baud;		/* SPI + 0x04 */
	volatile uint8_t	status;		/* SPI + 0x05 */
	volatile uint8_t	reserved1[3];	/* SPI + 0x06 */
	volatile uint8_t	data;		/* SPI + 0x09 */
	volatile uint8_t	reserved2[3];	/* SPI + 0x0a */
	volatile uint8_t	port;		/* SPI + 0x0d */
	volatile uint8_t	reserved3[2];	/* SPI + 0x0e */
	volatile uint8_t	dir;		/* SPI + 0x10 */
};

struct mpc5xxx_intr {
	volatile uint32_t	per_mask;	/* INTR + 0x00 */
	volatile uint32_t	per_pri1;	/* INTR + 0x04 */
	volatile uint32_t	per_pri2;	/* INTR + 0x08 */
	volatile uint32_t	per_pri3;	/* INTR + 0x0c */
	volatile uint32_t	ctrl;		/* INTR + 0x10 */
	volatile uint32_t	main_mask;	/* INTR + 0x14 */
	volatile uint32_t	main_pri1;	/* INTR + 0x18 */
	volatile uint32_t	main_pri2;	/* INTR + 0x1c */
	volatile uint32_t	reserved1;	/* INTR + 0x20 */
	volatile uint32_t	enc_status;	/* INTR + 0x24 */
	volatile uint32_t	crit_status;	/* INTR + 0x28 */
	volatile uint32_t	main_status;	/* INTR + 0x2c */
	volatile uint32_t	per_status;	/* INTR + 0x30 */
	volatile uint32_t	reserved2;	/* INTR + 0x34 */
	volatile uint32_t	per_error;	/* INTR + 0x38 */
};

struct mpc5xxx_gpio {
	volatile uint32_t	port_config;	/* GPIO + 0x00 */
	volatile uint32_t	simple_gpioe;	/* GPIO + 0x04 */
	volatile uint32_t	simple_ode;	/* GPIO + 0x08 */
	volatile uint32_t	simple_ddr;	/* GPIO + 0x0c */
	volatile uint32_t	simple_dvo;	/* GPIO + 0x10 */
	volatile uint32_t	simple_ival;	/* GPIO + 0x14 */
	volatile uint8_t	outo_gpioe;	/* GPIO + 0x18 */
	volatile uint8_t	reserved1[3];	/* GPIO + 0x19 */
	volatile uint8_t	outo_dvo;	/* GPIO + 0x1c */
	volatile uint8_t	reserved2[3];	/* GPIO + 0x1d */
	volatile uint8_t	sint_gpioe;	/* GPIO + 0x20 */
	volatile uint8_t	reserved3[3];	/* GPIO + 0x21 */
	volatile uint8_t	sint_ode;	/* GPIO + 0x24 */
	volatile uint8_t	reserved4[3];	/* GPIO + 0x25 */
	volatile uint8_t	sint_ddr;	/* GPIO + 0x28 */
	volatile uint8_t	reserved5[3];	/* GPIO + 0x29 */
	volatile uint8_t	sint_dvo;	/* GPIO + 0x2c */
	volatile uint8_t	reserved6[3];	/* GPIO + 0x2d */
	volatile uint8_t	sint_inten;	/* GPIO + 0x30 */
	volatile uint8_t	reserved7[3];	/* GPIO + 0x31 */
	volatile uint16_t	sint_itype;	/* GPIO + 0x34 */
	volatile uint16_t	reserved8;	/* GPIO + 0x36 */
	volatile uint8_t	gpio_control;	/* GPIO + 0x38 */
	volatile uint8_t	reserved9[3];	/* GPIO + 0x39 */
	volatile uint8_t	sint_istat;	/* GPIO + 0x3c */
	volatile uint8_t	sint_ival;	/* GPIO + 0x3d */
	volatile uint8_t	bus_errs;	/* GPIO + 0x3e */
	volatile uint8_t	reserved10;	/* GPIO + 0x3f */
};

struct mpc5xxx_wu_gpio {
	volatile u8 wu_gpioe;		/* WU_GPIO + 0x00 */
	volatile u8 reserved1[3];	/* WU_GPIO + 0x01 */
	volatile u8 wu_ode;		/* WU_GPIO + 0x04 */
	volatile u8 reserved2[3];	/* WU_GPIO + 0x05 */
	volatile u8 wu_ddr;		/* WU_GPIO + 0x08 */
	volatile u8 reserved3[3];	/* WU_GPIO + 0x09 */
	volatile u8 wu_dvo;		/* WU_GPIO + 0x0c */
	volatile u8 reserved4[3];	/* WU_GPIO + 0x0d */
	volatile u8 wu_inten;		/* WU_GPIO + 0x10 */
	volatile u8 reserved5[3];	/* WU_GPIO + 0x11 */
	volatile u8 wu_individual;	/* WU_GPIO + 0x14 */
	volatile u8 reserved6[3];	/* WU_GPIO + 0x15 */
	volatile u16 wu_itype;	    	/* WU_GPIO + 0x18 */
	volatile u16 reserved7;		/* WU_GPIO + 0x1A */
	volatile u8 gpio_control;	/* WU_GPIO + 0x1C */
	volatile u8 reserved8[3];	/* WU_GPIO + 0x1D */
	volatile u8 wu_ival;		/* WU_GPIO + 0x20 */
	volatile u8 reserved9[3];	/* WU_GPIO + 0x21 */
	volatile u8 wu_istat;		/* WU_GPIO + 0x24 */
	volatile u8 reserved10[3];	/* WU_GPIO + 0x25 */
};

struct mpc5xxx_gpt {
	volatile uint32_t	emsr;		/* GPT + 0x00 */
	volatile uint32_t	cir;		/* GPT + 0x04 */
	volatile uint32_t	pwmcr;		/* GPT + 0x08 */
	volatile uint32_t	sr;		/* GPT + 0x0c */
};


struct mpc5xxx_sdma {
	volatile uint32_t	taskBar;	/* SDMA + 0x00 */
	volatile uint32_t	currentPointer;	/* SDMA + 0x04 */
	volatile uint32_t	endPointer;	/* SDMA + 0x08 */
	volatile uint32_t	variablePointer;/* SDMA + 0x0c */

	volatile uint8_t	IntVect1;	/* SDMA + 0x10 */
	volatile uint8_t	IntVect2;	/* SDMA + 0x11 */
	volatile uint16_t	PtdCntrl;	/* SDMA + 0x12 */

	volatile uint32_t	IntPend;	/* SDMA + 0x14 */
	volatile uint32_t	IntMask;	/* SDMA + 0x18 */

#if 0
	volatile uint16_t	tcr_0;		/* SDMA + 0x1c */
	volatile uint16_t	tcr_1;		/* SDMA + 0x1e */
	volatile uint16_t	tcr_2;		/* SDMA + 0x20 */
	volatile uint16_t	tcr_3;		/* SDMA + 0x22 */
	volatile uint16_t	tcr_4;		/* SDMA + 0x24 */
	volatile uint16_t	tcr_5;		/* SDMA + 0x26 */
	volatile uint16_t	tcr_6;		/* SDMA + 0x28 */
	volatile uint16_t	tcr_7;		/* SDMA + 0x2a */
	volatile uint16_t	tcr_8;		/* SDMA + 0x2c */
	volatile uint16_t	tcr_9;		/* SDMA + 0x2e */
	volatile uint16_t	tcr_a;		/* SDMA + 0x30 */
	volatile uint16_t	tcr_b;		/* SDMA + 0x32 */
	volatile uint16_t	tcr_c;		/* SDMA + 0x34 */
	volatile uint16_t	tcr_d;		/* SDMA + 0x36 */
	volatile uint16_t	tcr_e;		/* SDMA + 0x38 */
	volatile uint16_t	tcr_f;		/* SDMA + 0x3a */
#else
	volatile uint16_t	tcr[MPC5xxx_SDMA_MAX_TASKS]; /* SDMA + 0x1c..0x3a */
#endif

#if 0
	volatile uint8_t	IPR0;		/* SDMA + 0x3c */
	volatile uint8_t	IPR1;		/* SDMA + 0x3d */
	volatile uint8_t	IPR2;		/* SDMA + 0x3e */
	volatile uint8_t	IPR3;		/* SDMA + 0x3f */
	volatile uint8_t	IPR4;		/* SDMA + 0x40 */
	volatile uint8_t	IPR5;		/* SDMA + 0x41 */
	volatile uint8_t	IPR6;		/* SDMA + 0x42 */
	volatile uint8_t	IPR7;		/* SDMA + 0x43 */
	volatile uint8_t	IPR8;		/* SDMA + 0x44 */
	volatile uint8_t	IPR9;		/* SDMA + 0x45 */
	volatile uint8_t	IPR10;		/* SDMA + 0x46 */
	volatile uint8_t	IPR11;		/* SDMA + 0x47 */
	volatile uint8_t	IPR12;		/* SDMA + 0x48 */
	volatile uint8_t	IPR13;		/* SDMA + 0x49 */
	volatile uint8_t	IPR14;		/* SDMA + 0x4a */
	volatile uint8_t	IPR15;		/* SDMA + 0x4b */
	volatile uint8_t	IPR16;		/* SDMA + 0x4c */
	volatile uint8_t	IPR17;		/* SDMA + 0x4d */
	volatile uint8_t	IPR18;		/* SDMA + 0x4e */
	volatile uint8_t	IPR19;		/* SDMA + 0x4f */
	volatile uint8_t	IPR20;		/* SDMA + 0x50 */
	volatile uint8_t	IPR21;		/* SDMA + 0x51 */
	volatile uint8_t	IPR22;		/* SDMA + 0x52 */
	volatile uint8_t	IPR23;		/* SDMA + 0x53 */
	volatile uint8_t	IPR24;		/* SDMA + 0x54 */
	volatile uint8_t	IPR25;		/* SDMA + 0x55 */
	volatile uint8_t	IPR26;		/* SDMA + 0x56 */
	volatile uint8_t	IPR27;		/* SDMA + 0x57 */
	volatile uint8_t	IPR28;		/* SDMA + 0x58 */
	volatile uint8_t	IPR29;		/* SDMA + 0x59 */
	volatile uint8_t	IPR30;		/* SDMA + 0x5a */
	volatile uint8_t	IPR31;		/* SDMA + 0x5b */
#else
	volatile uint8_t	IPR[MPC5xxx_SDMA_MAX_INITIATORS]; /* SDMA + 0x3c..0x5b */
#endif

	volatile uint32_t	res1;		/* SDMA + 0x5c */
#ifdef CONFIG_MPC5100
	volatile uint32_t	res2;		/* SDMA + 0x60 */
	volatile uint32_t	res3;		/* SDMA + 0x64 */
#else
	volatile uint32_t	task_size0;	/* SDMA + 0x60 */
	volatile uint32_t	task_size1;	/* SDMA + 0x64 */
#endif
	volatile uint32_t	MDEDebug;	/* SDMA + 0x68 */
	volatile uint32_t	ADSDebug;	/* SDMA + 0x6c */
	volatile uint32_t	Value1;		/* SDMA + 0x70 */
	volatile uint32_t	Value2;		/* SDMA + 0x74 */
	volatile uint32_t	Control;	/* SDMA + 0x78 */
	volatile uint32_t	Status;		/* SDMA + 0x7c */
	volatile uint32_t	EU00;		/* SDMA + 0x80 */
	volatile uint32_t	EU01;		/* SDMA + 0x84 */
	volatile uint32_t	EU02;		/* SDMA + 0x88 */
	volatile uint32_t	EU03;		/* SDMA + 0x8c */
	volatile uint32_t	EU04;		/* SDMA + 0x90 */
	volatile uint32_t	EU05;		/* SDMA + 0x94 */
	volatile uint32_t	EU06;		/* SDMA + 0x98 */
	volatile uint32_t	EU07;		/* SDMA + 0x9c */
	volatile uint32_t	EU10;		/* SDMA + 0xa0 */
	volatile uint32_t	EU11;		/* SDMA + 0xa4 */
	volatile uint32_t	EU12;		/* SDMA + 0xa8 */
	volatile uint32_t	EU13;		/* SDMA + 0xac */
	volatile uint32_t	EU14;		/* SDMA + 0xb0 */
	volatile uint32_t	EU15;		/* SDMA + 0xb4 */
	volatile uint32_t	EUINT16_T;		/* SDMA + 0xb8 */
	volatile uint32_t	EU17;		/* SDMA + 0xbc */
	volatile uint32_t	EU20;		/* SDMA + 0xc0 */
	volatile uint32_t	EU21;		/* SDMA + 0xc4 */
	volatile uint32_t	EU22;		/* SDMA + 0xc8 */
	volatile uint32_t	EU23;		/* SDMA + 0xcc */
	volatile uint32_t	EU24;		/* SDMA + 0xd0 */
	volatile uint32_t	EU25;		/* SDMA + 0xd4 */
	volatile uint32_t	EU26;		/* SDMA + 0xd8 */
	volatile uint32_t	EU27;		/* SDMA + 0xdc */
	volatile uint32_t	EU30;		/* SDMA + 0xe0 */
	volatile uint32_t	EU31;		/* SDMA + 0xe4 */
	volatile uint32_t	EUINT32_T;		/* SDMA + 0xe8 */
	volatile uint32_t	EU33;		/* SDMA + 0xec */
	volatile uint32_t	EU34;		/* SDMA + 0xf0 */
	volatile uint32_t	EU35;		/* SDMA + 0xf4 */
	volatile uint32_t	EU36;		/* SDMA + 0xf8 */
	volatile uint32_t	EU37;		/* SDMA + 0xfc */
};

struct mscan_buffer {
	volatile uint8_t  idr[0x8];	/* 0x00 */
	volatile uint8_t  dsr[0x10];	/* 0x08 */
	volatile uint8_t  dlr;		/* 0x18 */
	volatile uint8_t  tbpr;		/* 0x19 */	/* This register is not applicable for=
 receive buffers */
	volatile uint16_t rsrv1;	/* 0x1A */
	volatile uint8_t  tsrh;		/* 0x1C */
	volatile uint8_t  tsrl;		/* 0x1D */
	volatile uint16_t rsrv2;	/* 0x1E */
};

struct mpc5xxx_mscan {
	volatile uint8_t  canctl0;	/* MSCAN + 0x00 */
	volatile uint8_t  canctl1;	/* MSCAN + 0x01 */
	volatile uint16_t rsrv1;	/* MSCAN + 0x02 */
	volatile uint8_t  canbtr0;	/* MSCAN + 0x04 */
	volatile uint8_t  canbtr1;	/* MSCAN + 0x05 */
	volatile uint16_t rsrv2;	/* MSCAN + 0x06 */
	volatile uint8_t  canrflg;	/* MSCAN + 0x08 */
	volatile uint8_t  canrier;	/* MSCAN + 0x09 */
	volatile uint16_t rsrv3;	/* MSCAN + 0x0A */
	volatile uint8_t  cantflg;	/* MSCAN + 0x0C */
	volatile uint8_t  cantier;	/* MSCAN + 0x0D */
	volatile uint16_t rsrv4;	/* MSCAN + 0x0E */
	volatile uint8_t  cantarq;	/* MSCAN + 0x10 */
	volatile uint8_t  cantaak;	/* MSCAN + 0x11 */
	volatile uint16_t rsrv5;	/* MSCAN + 0x12 */
	volatile uint8_t  cantbsel;	/* MSCAN + 0x14 */
	volatile uint8_t  canidac;	/* MSCAN + 0x15 */
	volatile uint16_t rsrv6[3];	/* MSCAN + 0x16 */
	volatile uint8_t  canrxerr;	/* MSCAN + 0x1C */
	volatile uint8_t  cantxerr;	/* MSCAN + 0x1D */
	volatile uint16_t rsrv7;	/* MSCAN + 0x1E */
	volatile uint8_t  canidar0;	/* MSCAN + 0x20 */
	volatile uint8_t  canidar1;	/* MSCAN + 0x21 */
	volatile uint16_t rsrv8;	/* MSCAN + 0x22 */
	volatile uint8_t  canidar2;	/* MSCAN + 0x24 */
	volatile uint8_t  canidar3;	/* MSCAN + 0x25 */
	volatile uint16_t rsrv9;	/* MSCAN + 0x26 */
	volatile uint8_t  canidmr0;	/* MSCAN + 0x28 */
	volatile uint8_t  canidmr1;	/* MSCAN + 0x29 */
	volatile uint16_t rsrv10;	/* MSCAN + 0x2A */
	volatile uint8_t  canidmr2;	/* MSCAN + 0x2C */
	volatile uint8_t  canidmr3;	/* MSCAN + 0x2D */
	volatile uint16_t rsrv11;	/* MSCAN + 0x2E */
	volatile uint8_t  canidar4;	/* MSCAN + 0x30 */
	volatile uint8_t  canidar5;	/* MSCAN + 0x31 */
	volatile uint16_t rsrv12;	/* MSCAN + 0x32 */
	volatile uint8_t  canidar6;	/* MSCAN + 0x34 */
	volatile uint8_t  canidar7;	/* MSCAN + 0x35 */
	volatile uint16_t rsrv13;	/* MSCAN + 0x36 */
	volatile uint8_t  canidmr4;	/* MSCAN + 0x38 */
	volatile uint8_t  canidmr5;	/* MSCAN + 0x39 */
	volatile uint16_t rsrv14;	/* MSCAN + 0x3A */
	volatile uint8_t  canidmr6;	/* MSCAN + 0x3C */
	volatile uint8_t  canidmr7;	/* MSCAN + 0x3D */
	volatile uint16_t rsrv15;	/* MSCAN + 0x3E */

	struct mscan_buffer canrxfg;	/* MSCAN + 0x40 */    /* Foreground receive b=
uffer */
	struct mscan_buffer cantxfg;	/* MSCAN + 0x60 */    /* Foreground transmit =
buffer */
};

struct mpc5xxx_i2c {
	volatile uint32_t madr;		/* I2Cn + 0x00 */
	volatile uint32_t mfdr;		/* I2Cn + 0x04 */
	volatile uint32_t mcr;		/* I2Cn + 0x08 */
	volatile uint32_t msr;		/* I2Cn + 0x0C */
	volatile uint32_t mdr;		/* I2Cn + 0x10 */
};

struct mpc5xxx_xlb {
	volatile uint8_t  reserved[0x40];
	volatile uint32_t config;		/* XLB + 0x40 */
	volatile uint32_t version;		/* XLB + 0x44 */
	volatile uint32_t status;		/* XLB + 0x48 */
	volatile uint32_t int_enable;		/* XLB + 0x4c */
	volatile uint32_t addr_capture;		/* XLB + 0x50 */
	volatile uint32_t bus_sig_capture;	/* XLB + 0x54 */
	volatile uint32_t addr_timeout;		/* XLB + 0x58 */
	volatile uint32_t data_timeout;		/* XLB + 0x5c */
	volatile uint32_t bus_act_timeout;	/* XLB + 0x60 */
	volatile uint32_t master_pri_enable;	/* XLB + 0x64 */
	volatile uint32_t master_priority;	/* XLB + 0x68 */
	volatile uint32_t base_address;		/* XLB + 0x6c */
	volatile uint32_t snoop_window;		/* XLB + 0x70 */
};

struct mpc5xxx_cdm {
	volatile uint32_t jtag_id;		/* MBAR_CDM + 0x00  reg0 read only */
	volatile uint32_t rstcfg;		/* MBAR_CDM + 0x04  reg1 read only */
	volatile uint32_t breadcrumb;		/* MBAR_CDM + 0x08  reg2 */

	volatile uint8_t  ddr_mode;		/* MBAR_CDM + 0x0c  reg3 byte0 read only */
	volatile uint8_t  xlb_clk_sel;		/* MBAR_CDM + 0x0d  reg3 byte1 read only */
	volatile uint8_t  ipb_clk_sel;		/* MBAR_CDM + 0x0e  reg3 byte2 */
	volatile uint8_t  pci_clk_sel;		/* MBAR_CDM + 0x0f  reg3 byte3 */

	volatile uint8_t  ext_48mhz_en;		/* MBAR_CDM + 0x10  reg4 byte0 */
	volatile uint8_t  fd_enable;		/* MBAR_CDM + 0x11  reg4 byte1 */
	volatile uint16_t fd_counters;		/* MBAR_CDM + 0x12  reg4 byte2,3 */

	volatile uint32_t clk_enables;		/* MBAR_CDM + 0x14  reg5 */

	volatile uint8_t  osc_disable;		/* MBAR_CDM + 0x18  reg6 byte0 */
	volatile uint8_t  reserved0[3];		/* MBAR_CDM + 0x19  reg6 byte1,2,3 */

	volatile uint8_t  ccs_sleep_enable;	/* MBAR_CDM + 0x1c  reg7 byte0 */
	volatile uint8_t  osc_sleep_enable;	/* MBAR_CDM + 0x1d  reg7 byte1 */
	volatile uint8_t  reserved1;		/* MBAR_CDM + 0x1e  reg7 byte2 */
	volatile uint8_t  ccs_qreq_test;	/* MBAR_CDM + 0x1f  reg7 byte3 */

	volatile uint8_t  soft_reset;		/* MBAR_CDM + 0x20  uint8_t byte0 */
	volatile uint8_t  no_ckstp;		/* MBAR_CDM + 0x21  uint8_t byte0 */
	volatile uint8_t  reserved2[2];		/* MBAR_CDM + 0x22  uint8_t byte1,2,3 */

	volatile uint8_t  pll_lock;		/* MBAR_CDM + 0x24  reg9 byte0 */
	volatile uint8_t  pll_looselock;	/* MBAR_CDM + 0x25  reg9 byte1 */
	volatile uint8_t  pll_sm_lockwin;	/* MBAR_CDM + 0x26  reg9 byte2 */
	volatile uint8_t  reserved3;		/* MBAR_CDM + 0x27  reg9 byte3 */

	volatile uint16_t reserved4;		/* MBAR_CDM + 0x28  reg10 byte0,1 */
	volatile uint16_t mclken_div_psc1;	/* MBAR_CDM + 0x2a  reg10 byte2,3 */

	volatile uint16_t reserved5;		/* MBAR_CDM + 0x2c  reg11 byte0,1 */
	volatile uint16_t mclken_div_psc2;	/* MBAR_CDM + 0x2e  reg11 byte2,3 */

	volatile uint16_t reserved6;		/* MBAR_CDM + 0x30  reg12 byte0,1 */
	volatile uint16_t mclken_div_psc3;	/* MBAR_CDM + 0x32  reg12 byte2,3 */

	volatile uint16_t reserved7;		/* MBAR_CDM + 0x34  reg13 byte0,1 */
	volatile uint16_t mclken_div_psc6;	/* MBAR_CDM + 0x36  reg13 byte2,3 */
};

#define MPC5xxx_SDMA_VAR_SIZE		256
#define MPC5xxx_SDMA_VAR_ALIGN_SHIFT	8
#define MPC5xxx_SDMA_FDT_SIZE		128
#define MPC5xxx_SDMA_FDT_ALIGN_SHIFT	8
#define MPC5xxx_SDMA_CSAVE_SIZE		256
#define MPC5xxx_SDMA_CSAVE_ALIGN_SHIFT	8

#define MPC5xxx_SDMA_TASK_ENABLE		0x8000

/* Function to read the current timebase of the 603e core */
static inline uint64_t readTBx(void)
{
	/* "bind" result to the registers r3 & r4 (because of 64bit int,
	   result will use 2 registers).=20
	*/
	register uint64_t result asm("r3");
	__asm__("1:   	          \n\t"
		"mftbu %%r3       \n\t"	// get TBU
		"mftb  %%r4       \n\t"	// get TBL
		"mftbu %%r5       \n\t"	// get TBU once again
		"cmpw  %%r5, %%r3 \n\t"	// see if 'old' =3D 'new'
		"bne 1b		\n\t"
		: : : "r3", "r4", "r5");

        /* The current value of the timebase is now stored r3 & r4 (TBU & T=
BL).
           Because of assigning result to that registers, their value can be
           returned as a one  64bit uint by just returning result.=20
        */
	return result;
}

extern int mpc5xxx_bestcomm_init(void);
extern void mpc5xxx_get_sysclocks(uint32_t *_fsystem, uint32_t *_xlb, uint3=
2_t *_ipb, uint32_t *_pci);


static inline uint16_t
mpc5xxx_sdma_task_status(size_t task)
{
	struct mpc5xxx_sdma *sdma =3D (struct mpc5xxx_sdma *)MPC5xxx_SDMA;
	return in_be16(sdma->tcr + task);
}


static inline void
mpc5xxx_sdma_enable_task(size_t task)
{
	struct mpc5xxx_sdma *sdma =3D (struct mpc5xxx_sdma *)MPC5xxx_SDMA;
	uint16_t val16 =3D in_be16(sdma->tcr + task);
	val16 |=3D MPC5xxx_SDMA_TASK_ENABLE;
	out_be16(sdma->tcr + task, val16);
}


static inline void
mpc5xxx_sdma_disable_task(size_t task)
{
	struct mpc5xxx_sdma *sdma =3D (struct mpc5xxx_sdma *)MPC5xxx_SDMA;
	uint16_t val16 =3D in_be16(sdma->tcr + task);
	val16 &=3D ~MPC5xxx_SDMA_TASK_ENABLE;
	out_be16(sdma->tcr + task, val16);
}

static inline void
mpc5xxx_sdma_set_initator_priority(size_t initiator, uint8_t value)
{
	struct mpc5xxx_sdma *sdma =3D (struct mpc5xxx_sdma *)MPC5xxx_SDMA;
	out_8(sdma->IPR + initiator, value);
}

void mpc5xxx_init_irq(void);
int mpc5xxx_get_irq(struct pt_regs *regs);
void mpc5xxx_pci_init_windows(uint8_t win0_ctrl, uint32_t win0_translation,
			      uint8_t win1_ctrl, uint32_t win1_translation,
			      uint8_t win2_ctrl, uint32_t win2_translation);

enum mpc5xxx_gpio_t
{
	MPC5XXX_GPIO_INVALID,
	MPC5XXX_GPIO_PSC2_2,
	MPC5XXX_GPIO_PSC3_6,
	MPC5XXX_GPIO_PSC3_7,
	MPC5XXX_GPIO_TIMER5,
	MPC5XXX_GPIO_TIMER7
};

extern int mpc5xxx_config_gpio(enum mpc5xxx_gpio_t port, int output, int op=
endrain);
extern int mpc5xxx_set_gpio(enum mpc5xxx_gpio_t port, int value);
extern int mpc5xxx_get_gpio(enum mpc5xxx_gpio_t port);


/* System Version Register Definitions */
#define MPC52XX_SVR(major,minor)	((uint32_t)(0x80110000UL | ((major)<<4) | =
(minor)))
#define MPC52XX_SVR_1_0			MPC52XX_SVR(1,0)
#define MPC52XX_SVR_1_1			MPC52XX_SVR(1,1)
#define MPC52XX_SVR_1_2			MPC52XX_SVR(1,2)
#define MPC52XX_SVR_2_2			MPC52XX_SVR(2,2)
extern uint32_t mpc52xx_get_system_version(void);


#if defined(CONFIG_GLACIER)
#include <platforms/glacier.h>
#elif defined(CONFIG_ICECUBE)
#include <platforms/icecube.h>
#elif defined(CONFIG_TELEMOTIVE_PPC)
#include <platforms/telemotive.h>
#elif defined(CONFIG_PM520)
#include <platforms/pm520.h>
#elif defined(CONFIG_PP01)
#include <platforms/pp01.h>
#elif defined(CONFIG_TOP5200)
#include <platforms/top5200.h>
#elif defined(CONFIG_TQM5200)
#include <platforms/tqm5200.h>
#elif defined(CONFIG_INKA4X0)
#include <platforms/inka4x0.h>
#endif

#endif /* __ASSEMBLY__ */

#endif /* __ASM_MPC5XXX_H */

--Boundary-01=_0j/fFCA+48jpCgh
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="snd-psc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-psc.c"

/************************************************************************
 **
 ** snd_psc.c
 **
 ** Derived from i2s.c. Provides some functions to support an ALSA
 ** driver module providing playback and capture on an I2S PSC
 ** connection.
 **
 ** This file is subject to the terms and conditions of the GNU General Public
 ** License.  See the file COPYING in the main directory of this archive for
 ** more details.
 **
 ** Copyright 2005 (C) Roman Fietze (roman.fietze@telemotive.de)
 **
 ************************************************************************/


#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/interrupt.h>
#include <linux/poll.h>
#include <linux/list.h>
#include <linux/miscdevice.h>
#include <linux/config.h>
#include <linux/module.h>
#include <linux/version.h>

#include <linux/types.h>
#include <linux/errno.h>
#include <linux/delay.h>
#include <linux/proc_fs.h>
#include <linux/smp_lock.h>
#include <linux/crc32.h>
#include <linux/vmalloc.h>

#include <linux/slab.h>
#include <linux/ioport.h>
#include <linux/fcntl.h>
#include <asm/io.h>
#include <asm/uaccess.h>
#include <asm/system.h>
#include <asm/delay.h>

#include <linux/ctype.h>

#include <linux/init.h>

#include <mgt5200/mgt5200.h>
#include <mgt5200/sdma.h>

#ifdef CONFIG_UBOOT
#include <asm/ppcboot.h>
#endif

#include <bestcomm_api.h>
#include <dma_image.capi.h>

#include <asm/mpc5xxx.h>
#include <asm/mpc5xxx_snd.h>

#undef SND_PSC_DEBUG
// #define SND_PSC_DEBUG

#undef SND_PSC_CYCLIC_STATUS
// #define SND_PSC_CYCLIC_STATUS

#if !defined(CONFIG_BESTCOMM_IMAGE2)
#error Can only be used with BestComm Image 2!
#endif

#if defined(SND_PSC_DEBUG)
#define PRDEBUG(level, format, x... )  do {if (level <= debug) printk(KERN_INFO format, ## x );} while (0)
#else
#define PRDEBUG(level, format, x... )	do {} while(0)
#endif

static int debug = -1;

#if defined(SND_PSC_DEBUG)
static int fixed = 0;
static struct mpc5xxx_psc *status_psc = NULL;
#endif

#ifdef SND_PSC_CYCLIC_STATUS
# define SND_PSC_STATUS_TIMER_PERIOD	(HZ/2)
struct timer_list status_timer;
#endif

enum snd_psc_trace_tokens
{
	ST_ASSIGN
};

#if SND_PSC_TRACE
static int lognum = -1;
static const char *snd_psc_token_text[] =
{
	"ASSIGN"
};

static inline void
snd_psc_add_timestamp(snd_mpc5xxx_i2s_substream_t *_s, enum snd_psc_trace_tokens t)
{
	trace_add_timestamp(_s->trace_handle, t);
}
#else
static inline void
snd_psc_add_timestamp(snd_mpc5xxx_i2s_substream_t *_s, enum snd_psc_trace_tokens t)
{
}
#endif



/* SICR as found in the old I2S driver */
#define SND_PSC_I2S_SLAVE_SICR	((uint32_t)(MPC5xxx_PSC_SICR_DTS1_AFTER | \
				MPC5xxx_PSC_SICR_SIM_CODEC_32 | \
				MPC5xxx_PSC_SICR_CLKPOL_RISE))

#define SND_PSC_I2S_MASTER_SICR	(SND_PSC_I2S_SLAVE_SICR | MPC5xxx_PSC_SICR_GENCLK_INT)

#define SND_PSC_SPI_SICR	((uint32_t)(MPC5xxx_PSC_SICR_SPI | \
				MPC5xxx_PSC_SICR_GENCLK_INT | \
				MPC5xxx_PSC_SICR_SHDIR_LSB | \
				MPC5xxx_PSC_SICR_CPHA | \
				MPC5xxx_PSC_SICR_MULTIWD | \
				MPC5xxx_PSC_SICR_SIM_CODEC_16 | \
				MPC5xxx_PSC_SICR_MSTR))

/* The used IRQs, PSC and DMA channel. */
#define sdma		((struct mpc5xxx_sdma *)MPC5xxx_SDMA)

typedef TaskId (*snd_psc_tx_setup_func_t)(TASK_GEN_TX_BD_api_t *taskapi, TaskSetupParamSet_t *param);
typedef TaskId (*snd_psc_rx_setup_func_t)(TASK_GEN_RX_BD_api_t *taskapi, TaskSetupParamSet_t *param);

typedef struct _snd_psc_card_setup
{
	volatile uint16_t * mclken_div;		/* pointer to mclk divider register */
	uint32_t config_mask;			/* GPIO port config mask */
	uint32_t config_set;			/* GPIO port config bits */
	uint32_t clken;				/* CDM clock enable bit mask */
	int irq[2];				/* in BestComm mode both are used, w/o BestComm only the first one */
} snd_psc_card_setup_t;


#define MPC5xxx_CDM_P	((struct mpc5xxx_cdm *)MPC5xxx_CDM)

#define MPC5xxx_CDM_CER_PSC3		MPC5xxx_CDM_CER_PSC345

#define SND_PSC_MK_DIV(psc)		&MPC5xxx_CDM_P->mclken_div_psc ## psc
#define SND_PSC_MK_MASK(psc)		MPC5xxx_GPIO_PC_PSC ## psc ## _MASK
#define SND_PSC_MK_CODEC(psc)		MPC5xxx_GPIO_PC_PSC ## psc ## _CODEC ## psc
#define SND_PSC_MK_CLKEN(psc)		MPC5xxx_CDM_CER_PSC ## psc
#define SND_PSC_MK_PSC_IRQ(psc)		MPC5xxx_PSC ## psc ## _IRQ
#define SND_PSC_MK_TASK_IRQNUM(psc,d)	(MPC5xxx_SDMA_IRQ_BASE + TASK_GEN_## d ## X ## psc ## _BD)

#define SND_PSC_SETUP_UNDEFINED		{NULL,0UL,0UL,0UL,{-1,-1}}

#define SND_PSC_SETUP(psc)		{SND_PSC_MK_DIV(psc),SND_PSC_MK_MASK(psc),SND_PSC_MK_CODEC(psc),SND_PSC_MK_CLKEN(psc),\
					 {SND_PSC_MK_TASK_IRQNUM(psc, T),SND_PSC_MK_TASK_IRQNUM(psc, R)}}

static snd_psc_card_setup_t snd_psc_setups[8] =
{
	SND_PSC_SETUP_UNDEFINED,
	SND_PSC_SETUP(1),
	SND_PSC_SETUP(2),
	SND_PSC_SETUP(3),
	SND_PSC_SETUP_UNDEFINED,
	SND_PSC_SETUP_UNDEFINED,
	SND_PSC_SETUP(6),
	SND_PSC_SETUP_UNDEFINED
};


#define SND_PSC_NUM_BDS		(4)

#define SND_PSC_TFALARM		(0x100)
#define SND_PSC_TFCNTL		(4)
#define SND_PSC_RFALARM		(0x100)
#define SND_PSC_RFCNTL		(4)


/* delay in ms */
static inline void
snd_psc_delay(const char *text, unsigned long delay, int interruptible)
{
	if (delay)
	{
		wait_queue_head_t wait;
		init_waitqueue_head(&wait);
		if (interruptible)
			interruptible_sleep_on_timeout(&wait, (HZ * delay) / 1000UL);
		else
			sleep_on_timeout(&wait, (HZ * delay) / 1000UL);
	}
}


static inline void psc_tx_enable(struct mpc5xxx_psc *psc)
{
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_TX_ENABLE);
	psc->command = MPC5xxx_PSC_TX_ENABLE;
}


static inline void psc_tx_disable(struct mpc5xxx_psc *psc)
{
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_TX_DISABLE);
	psc->command = MPC5xxx_PSC_TX_DISABLE;
}


static inline void psc_rx_enable(struct mpc5xxx_psc *psc)
{
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_RX_ENABLE);
	psc->command = MPC5xxx_PSC_RX_ENABLE;
}


static inline void psc_rx_disable(struct mpc5xxx_psc *psc)
{
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_RX_DISABLE);
	psc->command = MPC5xxx_PSC_RX_DISABLE;
}


static inline void psc_tx_rx_enable(struct mpc5xxx_psc *psc)
{
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_RX_ENABLE | MPC5xxx_PSC_TX_ENABLE);
	psc->command = MPC5xxx_PSC_RX_ENABLE | MPC5xxx_PSC_TX_ENABLE;
}


static inline void psc_tx_rx_disable(struct mpc5xxx_psc *psc)
{
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_RX_DISABLE | MPC5xxx_PSC_TX_DISABLE);
	psc->command = MPC5xxx_PSC_RX_DISABLE | MPC5xxx_PSC_TX_DISABLE;
}


static inline void psc_reset(struct mpc5xxx_psc *psc)
{
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_RST_RX);
	psc->command = MPC5xxx_PSC_RST_RX;
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_RST_TX);
	psc->command = MPC5xxx_PSC_RST_TX;
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_SEL_MODE_REG_1);
	psc->command = MPC5xxx_PSC_SEL_MODE_REG_1;
	PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_RST_ERR_STAT);
	psc->command = MPC5xxx_PSC_RST_ERR_STAT;
}


#ifdef SND_PSC_DEBUG
static int snd_psc_tx_rx_status_dump(int level, char *buf, char locationid)
{
	int len = 0;

	if (status_psc)
	{
		static char qbits[] = "oudrt";
		static char sbits[] = "outfr";
		static char tfsbits[] = "xuorfae";
		static char rfsbits[] = "xuorfae";

		static uint16_t lastq = 0xFFFFU;
		static uint16_t lasts = 0xFFFFU;
		static uint16_t lasttfs = 0xFFFFU;
		static uint16_t lastrfs = 0xFFFFU;

		int i;

		uint16_t q = status_psc->mpc5xxx_psc_isr;

		if (q != lastq)
		{
			char *pqbits = qbits + 4;

			lastq = q;

			q >>= 8;
			for (i = 0; i < 5; i++)
			{
				if (q & 1)
					*pqbits = toupper(*pqbits);
				else
					*pqbits = tolower(*pqbits);

				q >>= 1;
				pqbits--;
			}
		}

		uint16_t s = status_psc->mpc5xxx_psc_status;

		if (s != lasts)
		{
			char *psbits = sbits + 4;

			lasts = s;

			s >>= 8;
			for (i = 0; i < 5; i++)
			{
				if (s & 1)
					*psbits = toupper(*psbits);
				else
					*psbits = tolower(*psbits);

				s >>= 1;
				psbits--;
			}
		}

		uint16_t tfs = status_psc->tfstat;

		if (tfs != lasttfs)
		{
			char *ptfsbits = tfsbits + 6;

			lasttfs = tfs;

			for (i = 0; i < 7; i++)
			{
				if (tfs & 1)
					*ptfsbits = toupper(*ptfsbits);
				else
					*ptfsbits = tolower(*ptfsbits);

				tfs >>= 1;
				ptfsbits--;
			}
		}

		uint16_t rfs = status_psc->rfstat;

		if (rfs != lastrfs)
		{
			char *prfsbits = rfsbits + 6;

			lastrfs = rfs;

			for (i = 0; i < 7; i++)
			{
				if (rfs & 1)
					*prfsbits = toupper(*prfsbits);
				else
					*prfsbits = tolower(*prfsbits);

				rfs >>= 1;
				prfsbits--;
			}
		}

		if (buf)
		{
			/* proc fs output */
			len = sprintf(buf,
				      "ISR: %s %04x | SR: %s %04x | tx: %s %02x n=%3u w=%3u r=%3u | rx: %s %02x n=%3u w=%3u r=%3u\n",
				      qbits,
				      lastq,
				      sbits,
				      lasts,
				      tfsbits,
				      lasttfs,
				      status_psc->tfnum,
				      status_psc->tfwptr,
				      status_psc->tfrptr,
				      rfsbits,
				      lastrfs,
				      status_psc->rfnum,
				      status_psc->rfwptr,
				      status_psc->rfrptr);
		}
		else
		{
			/* printk output */
			PRDEBUG(level, "PSC(%c): | ISR: %s %04x | SR: %s %04x | tx: %s %02x n=%3u w=%3u r=%3u | rx: %s %02x n=%3u w=%3u r=%3u\n",
				locationid,
				qbits,
				lastq,
				sbits,
				lasts,
				tfsbits,
				lasttfs,
				status_psc->tfnum,
				status_psc->tfwptr,
				status_psc->tfrptr,
				rfsbits,
				lastrfs,
				status_psc->rfnum,
				status_psc->rfwptr,
				status_psc->rfrptr);
		}
	}
	else
	{
		if (buf)
			len = sprintf(buf, "%s: PSC not yet defined!\n", __FUNCTION__);
		else
			PRDEBUG(level, "%s: PSC not yet defined!\n", __FUNCTION__);
	}

	return (len);
}
#endif


static inline void snd_psc_tx_rx_status(int level, char locationid)
{
#ifdef SND_PSC_DEBUG
	if (debug >= level)
		snd_psc_tx_rx_status_dump(level, 0, locationid);
#endif
}


#if defined(SND_PSC_DEBUG)
static void snd_psc_dump_buffer(int level, char id, const void *_pc, size_t n)
{
	if (debug >= level)
	{
		const uint8_t *pc = _pc;
		size_t col = 0;
		while (n--)
		{
			if (col == 0)
				printk(KERN_INFO "%c: %p:", id, pc);

			printk(" %02x", *pc);
			if (col == 15)
			{
				col = 0;
				printk("\n");
			}
			else
			{
				col++;
			}

			pc++;
		}

		if (col != 0)
			printk("\n");
	}
}
#else
static inline void snd_psc_dump_buffer(int level, char id, const void *pc, size_t n)
{
}
#endif


static irqreturn_t snd_psc_irq(int irq, void *dev_id, struct pt_regs *regs)
{
	snd_mpc5xxx_i2s_substream_t *s = dev_id;

	if (s->dma_started)
	{
		PRDEBUG(5, "%s(%d,%p,...) name=%s\n", __FUNCTION__, irq, dev_id, s->name);

		snd_mpc5xxx_i2s_card_t *card = s->card;
		size_t num = 0;
		size_t tc;
		static size_t maxnum = 0;
		TaskBD1_t *pbd;
		BDIdx bdidx;

		TaskIntClear(s->task_id);

		tc = s->period_size;
		if (tc > SND_PSC_MAX_PERIOD_SIZE)
			tc = SND_PSC_MAX_PERIOD_SIZE;

		spin_lock(&card->lock);
		pbd = (TaskBD1_t *)TaskGetBD(s->task_id, s->bdidx);

		while (!(pbd->Status & SDMA_BD_MASK_READY))
		{
			s->bdidx = TaskBDRelease(s->task_id);
			s->irqpos += tc;
			s->irqpos %= s->buffer_size;
			s->processed += tc;
			num++;
			PRDEBUG(5, "%s: %s: %u:  bdidx=%d processed=%u dmapos=%u irqpos=%u\n",
				__FUNCTION__, s->name, num, s->bdidx, s->processed, s->dmapos, s->irqpos);
#if defined(SND_PSC_DEBUG)
			if (fixed && tc >= 4 * sizeof(uint16_t))
			{
				static const uint16_t valid[4] = {0x55AAU, 0x0C0CU, 0x55AAU, 0x0C0CU};
				const uint16_t *pdata = phys_to_virt(s->dma_addr + s->dmapos);
				PRDEBUG(2, "%s: pdata=%p %04x %04x %04x %04x %04x ...\n",
					__FUNCTION__,
					pdata,
					pdata[0], pdata[1], pdata[2], pdata[3], pdata[4]);

				if (memcmp(valid, pdata, sizeof(valid)))
				{
					PRDEBUG(1, "%s: data mismatch for fixed data WAV sample\n", __FUNCTION__);
					snd_psc_dump_buffer(1, 'F', pdata, tc);
				}
			}
#endif
			bdidx = TaskBDAssign(s->task_id, (void *)(s->dma_addr + s->dmapos), NULL, tc, 0);
			if (bdidx < 0)
				printk(KERN_ERR "snd-psc: %s: error %d assigning BD\n", s->name, bdidx);
			s->dmapos += tc;
			s->dmapos %= s->buffer_size;
			pbd = (TaskBD1_t *)TaskGetBD(s->task_id, s->bdidx);
		}

		if (s->processed >= s->period_size)
		{
			s->processed %= s->period_size;
			spin_unlock(&card->lock);
			PRDEBUG(5, "%s: handler\n", __FUNCTION__);
			s->handler(s->stream);
		}
		else
		{
			spin_unlock(&card->lock);
		}

		if (num > maxnum)
			maxnum = num;
		if (num != 1)
			PRDEBUG(1, "%s: num=%u maxnum=%u\n", __FUNCTION__, num, maxnum);
	}
}


size_t snd_psc_get_substream_pos(snd_mpc5xxx_i2s_substream_t *_s)
{
	PRDEBUG(5, "%s(%s) return %u\n", __FUNCTION__, _s->name, _s->irqpos);
	return _s->irqpos;
}


int snd_psc_substream_open(snd_mpc5xxx_i2s_substream_t *_s, void *_stream)
{
	snd_mpc5xxx_i2s_card_t *card = _s->card;
	unsigned long flags;
	PRDEBUG(1, "%s(%s,%p)\n", __FUNCTION__, _s->name, _stream);
	spin_lock_irqsave(&card->lock, flags);
	_s->stream = _stream;
	_s->dma_addr = 0;
	spin_unlock_irqrestore(&card->lock, flags);
	return 0;
}


int snd_psc_substream_params(snd_mpc5xxx_i2s_substream_t *_s,
			     uint32_t _rate, size_t _channels, size_t _bits,
			     size_t _buffer_size, size_t _period_size)
{
	snd_mpc5xxx_i2s_card_t *card = _s->card;
	const uint32_t bitrate = _rate * _channels * _bits;
	int ret = -EINVAL;
	unsigned long flags;

	PRDEBUG(1, "%s(%s,%u,%u,%u,%u,%u) bitrate=%uHz\n",
		__FUNCTION__,
		_s->name, _rate, _channels, _bits, _buffer_size, _period_size,
		bitrate);

	spin_lock_irqsave(&card->lock, flags);

	// In slave mode this wouldn't work:
	// if (card->rate != _rate || card->channels != _channels || card->bits != _bits)

	// so we always go in here until we understand why :)
	if (1)
	{
		spin_unlock_irqrestore(&card->lock, flags);

		PRDEBUG(1, "%s: changing some parameters\n", __FUNCTION__);
		PRDEBUG(1, "%s: card: old: rate=%u channels=%u bits=%u\n", __FUNCTION__, card->rate, card->channels, card->bits);

		struct mpc5xxx_psc *psc = PSC_ADDRESS(card->pscnum);
		struct mpc5xxx_gpio * const gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
		const snd_psc_card_setup_t *setup = snd_psc_setups + card->pscnum;

		uint32_t mclk;
		uint32_t mclkdiv;
		uint32_t bitclkdiv;
		uint32_t testmclkdiv;
		uint32_t testbitclkdiv;
		uint32_t maxerr;
		uint32_t currerr;
		uint32_t btmp;
		uint8_t ctur;
		uint8_t ctlr;
		uint16_t ccr;
		uint32_t sicr;
		uint32_t port_config;

#ifdef CONFIG_UBOOT
		extern unsigned char __res[];
		const bd_t * const bd = (bd_t *)__res;
		uint32_t fsystem = 0;

		if (MPC5xxx_CDM_P->rstcfg & ( 1 << 5))
			fsystem = bd->bi_busfreq * 8;
		else
			fsystem = bd->bi_busfreq * 4;

		PRDEBUG(3, "%s: cdm->rstcfg = 0x%08x fsystem=%uHz\n", __FUNCTION__, MPC5xxx_CDM_P->rstcfg, fsystem);
#else
		return -EINVAL;
#endif

		const uint32_t MCLKDIV_MAX	= (1U << 9);
		const uint32_t BITCLKDIV_MAX	= (1U << 8);

		PRDEBUG(4, "  psc->command=%02x\n", MPC5xxx_PSC_TX_DISABLE | MPC5xxx_PSC_RX_DISABLE);

		spin_lock_irqsave(&card->lock, flags);

		psc_tx_rx_disable(psc);
		psc_reset(psc);

		PRDEBUG(4, "  psc->mode=0\n");
		psc->mode = 0;

		PRDEBUG(4, "snd-psc: %s\n", __FUNCTION__);

		if (!card->slave)
		{
			/* Calculate CDM MCLK, PSC CCR BitClkDiv from bitrate. As well
			 * calculate PSC CCR FrameSyncDiv from mclk and check that it
			 * is not too large.
			 */
			maxerr = UINT32_MAX;

			for (testmclkdiv = 1; ret && testmclkdiv < MCLKDIV_MAX; testmclkdiv++)
			{
				mclk = fsystem / (testmclkdiv + 1);
				PRDEBUG(5, "snd-psc: mclk=%u\n", mclk);
				if (mclk > bitrate)
				{
					for (testbitclkdiv = 1; ret && testbitclkdiv < BITCLKDIV_MAX; testbitclkdiv++)
					{
						btmp = mclk / (testbitclkdiv + 1);
						if (btmp != bitrate)
						{
							if (btmp > bitrate)
								currerr = btmp - bitrate;
							else
								currerr = bitrate - btmp;

							if (currerr < maxerr)
							{
								maxerr = currerr;
								mclkdiv = testmclkdiv;
								bitclkdiv = testbitclkdiv;

								PRDEBUG(5,
									"snd-psc: currerr=%u mclkdiv=%u bitclkdiv=%u\n",
									currerr, testmclkdiv, testbitclkdiv);
							}
						}
						else
						{
							maxerr = 0;
							mclkdiv = testmclkdiv;
							bitclkdiv = testbitclkdiv;
							ret = 0;
						}
					}
				}
			}

			if (maxerr < bitrate / 10)
				ret = 0;

			PRDEBUG(1,
				"snd-psc: maxerr=%u mclkdiv=%u bitclkdiv=%u bitrate=%u resulting br=%u\n",
				maxerr, mclkdiv, bitclkdiv, bitrate, fsystem / (mclkdiv+1) / (bitclkdiv+1));

			PRDEBUG(1, "snd-psc: mclkdiv=%u, bitclkdiv=%u, ret=%d\n", mclkdiv, bitclkdiv, ret);

			if (ret < 0)
			{
				printk(KERN_ERR
				       "%s: cannot find correct clock dividers for a sample rate of %u.\n",
				       __FUNCTION__,
				       _rate);
				return ret;
			}
		}

		if (card->spi)
		{
			const uint32_t ipb = bd->bi_ipbfreq;
			const uint16_t dtl = 2;
			const uint32_t ct = (dtl * ipb) / 1000000U;
			ctur = MPC5xxx_PSC_CTUR_CODEC(ct >> 8);		/* DTL high byte */
			ctlr = MPC5xxx_PSC_CTLR_CODEC(ct);		/* DTL low byte */
			ccr = MPC5xxx_PSC_CCR_CODEC(0, bitclkdiv);	/* DSCKL as low as possible: TBR */
			sicr = SND_PSC_SPI_SICR;
		}
		else
		{
			ctur = MPC5xxx_PSC_CTUR_CODEC(8 * sizeof(uint16_t) - 1);
			ctlr = 0;
			ccr = MPC5xxx_PSC_CCR_CODEC(2 * 8 * sizeof(uint16_t) - 1, bitclkdiv);
			sicr = card->slave ? SND_PSC_I2S_SLAVE_SICR : SND_PSC_I2S_MASTER_SICR;
		}

		PRDEBUG(4, "  cdm->mclken_div_psc%u=%08x\n", card->pscnum,
			MPC5xxx_PSC_MCLOCK_ENABLE | MPC5xxx_PSC_MCLOCK_MCLKDIV(mclkdiv));
		*(setup->mclken_div) = MPC5xxx_PSC_MCLOCK_ENABLE | MPC5xxx_PSC_MCLOCK_MCLKDIV(mclkdiv);
		PRDEBUG(4, "  cdm->clk_enables|=%08x\n", setup->clken);
		MPC5xxx_CDM_P->clk_enables |= setup->clken;
		PRDEBUG(4, "  psc->ctur=%02x\n", ctur);
		psc->ctur = ctur;
		PRDEBUG(4, "  psc->ctlr=%02x\n", ctlr);
		psc->ctlr = ctlr;
		PRDEBUG(4, "  psc->ccr=%04x\n", ccr);
		psc->ccr = ccr;
		port_config = gpio->port_config;
		port_config = (port_config & ~setup->config_mask) | setup->config_set;
		PRDEBUG(4, "  gpio->port_config = %08x\n", port_config);
		gpio->port_config = port_config;
		PRDEBUG(4, "  psc->tfstat=%04x\n", MPC5xxx_PSC_FIFO_ERR | MPC5xxx_PSC_FIFO_UF | MPC5xxx_PSC_FIFO_OF);
		psc->tfstat = MPC5xxx_PSC_FIFO_ERR | MPC5xxx_PSC_FIFO_UF | MPC5xxx_PSC_FIFO_OF;	// reset some status bits
		PRDEBUG(4, "  psc->rfstat=%04x\n", MPC5xxx_PSC_FIFO_ERR | MPC5xxx_PSC_FIFO_UF | MPC5xxx_PSC_FIFO_OF);
		psc->rfstat = MPC5xxx_PSC_FIFO_ERR | MPC5xxx_PSC_FIFO_UF | MPC5xxx_PSC_FIFO_OF;
		PRDEBUG(4, "  psc->tfalarm=%d\n", SND_PSC_TFALARM);
		psc->tfalarm = SND_PSC_TFALARM;		/* alarm threshold level */
		PRDEBUG(4, "  psc->rfalarm=%d\n", SND_PSC_RFALARM);
		psc->rfalarm = SND_PSC_RFALARM;
		PRDEBUG(4, "  psc->tfcntl=%d\n", SND_PSC_TFCNTL);
		psc->tfcntl = SND_PSC_TFCNTL;		/* granularity */
		PRDEBUG(4, "  psc->rfcntl=%d\n", SND_PSC_RFCNTL);
		psc->rfcntl = SND_PSC_RFCNTL;
		PRDEBUG(4, "  psc->imr=0\n");
		psc->mpc5xxx_psc_imr = 0;	/* disable interrupts */
		PRDEBUG(1, "%s: %s: sicr=%08x\n", __FUNCTION__, _s->name, sicr);
		psc->sicr = sicr;

		if (card->loopback)
		{
			volatile int val;
			printk(KERN_INFO "snd-psc: ************** local loop back mode enabled on PSC%u\n", card->pscnum);
			val = psc->mode;	/* to switch from mode1 to mode2 */
			val++;			/* ??? short delay ??? */
			psc->mode = 0x80;
		}

#if defined(SND_PSC_DEBUG)
		if (fixed)
			snd_psc_tx_rx_status(1, 'P');
#endif

		/* reset PSC again */
		psc_reset(psc);
		if (card->psc_started)
			psc_tx_rx_enable(psc);

		card->rate = _rate;
		card->channels = _channels;
		card->bits = _bits;
	}

	_s->buffer_size = _buffer_size;
	_s->period_size = _period_size;

	spin_unlock_irqrestore(&card->lock, flags);

	return 0;
}


int snd_psc_substream_start(snd_mpc5xxx_i2s_substream_t *_s, dma_addr_t _dma_addr)
{
	snd_mpc5xxx_i2s_card_t *card = _s->card;
	unsigned long flags;

	PRDEBUG(1, "snd-psc: %s(s=%s,dma_addr=%08x) id=%d\n", __FUNCTION__, _s->name, _dma_addr, _s->id);

	spin_lock_irqsave(&card->lock, flags);

	if (!_s->dma_started)
	{
		struct mpc5xxx_psc *psc = PSC_ADDRESS(card->pscnum);
		size_t i;
		size_t tc;
		BDIdx bdidx;

		card->streams[_s->id] = _s;
		_s->processed = 0;

		_s->dma_addr = _dma_addr;
		_s->dmapos = _s->irqpos = 0;

		if (_s->id)
		{
			uint32_t tmp;

			/* empty RX FIFO to remove noise */
			while (psc->rfnum >= sizeof(uint32_t))
				tmp = psc->mpc5xxx_psc_buffer_32;
		}

		tc = _s->period_size;
		if (tc > SND_PSC_MAX_PERIOD_SIZE)
			tc = SND_PSC_MAX_PERIOD_SIZE;

		bdidx = TaskBDReset(_s->task_id);
		if (bdidx < 0)
			printk(KERN_ERR "snd-psc: %s: error %d resetting BDs\n", _s->name, bdidx);

		for (i = 0; i < SND_PSC_NUM_BDS; i++)
		{
			PRDEBUG(3, "%s: assign BD at dma_addr[%u] (%08x)\n",
				__FUNCTION__,
				_s->dmapos, _s->dma_addr + _s->dmapos);
			bdidx = TaskBDAssign(_s->task_id, (void *)(_s->dma_addr + _s->dmapos), NULL, tc, 0);
			if (bdidx < 0)
				printk(KERN_ERR "snd-psc: %s: error %d assigning BD\n", _s->name, bdidx);
			_s->dmapos += tc;
			_s->dmapos %= _s->buffer_size;
		}

		if (!card->psc_started)
			psc_tx_rx_enable(psc);
		card->psc_started |= 1 << _s->id;

#if defined(SND_PSC_DEBUG)
		if (fixed)
			snd_psc_tx_rx_status(1, 'S');
#endif

		TaskStart(_s->task_id, TASK_AUTOSTART_ENABLE, _s->task_id, TASK_INTERRUPT_ENABLE);

		_s->dma_started = 1;
	}

	spin_unlock_irqrestore(&card->lock, flags);

	return 0;
}


int snd_psc_substream_stop(snd_mpc5xxx_i2s_substream_t *_s)
{
	snd_mpc5xxx_i2s_card_t *card = _s->card;
	unsigned long flags;

	PRDEBUG(3, "snd-psc: %s(%s)\n", __FUNCTION__, _s->name);

	spin_lock_irqsave(&card->lock, flags);
	if (_s->dma_started)
	{
		struct mpc5xxx_psc *psc = PSC_ADDRESS(card->pscnum);

		_s->dma_started = 0;
		card->streams[_s->id] = NULL;

		/* stop the tasks */
		card->psc_started &= ~(1 << _s->id);
		if (!card->psc_started)
			psc_tx_rx_disable(psc);

		TaskStop(_s->task_id);
		TaskBDReset(_s->task_id);
	}

	spin_unlock_irqrestore(&card->lock, flags);

	return 0;
}


/* Initialize as much as possible of the BestComm init
 * structures.
 */
int snd_psc_substream_create(snd_mpc5xxx_i2s_substream_t **_s,
			     snd_mpc5xxx_i2s_card_t *_card,
			     const char *_name,
			     int _id,			/* 0..1 */
			     snd_psc_irq_handler_t _handler)
{
	struct mpc5xxx_psc *psc = PSC_ADDRESS(_card->pscnum);
	TaskSetupParamSet_t setup;
	int ret;

	snd_mpc5xxx_i2s_substream_t *s = kmalloc(sizeof(snd_mpc5xxx_i2s_substream_t), GFP_KERNEL);
	*_s = s;
	if (s == NULL)
		return -ENOMEM;

	/* first of all, disable all PSC interrupts */
	psc->mpc5xxx_psc_imr = 0;

	PRDEBUG(1, "snd-psc: %s(s=%p,card=%p,name=%s,id=%d,handler=%p) substream=%p\n",
		__FUNCTION__,
		_s, _card,
		_name, _id, _handler,
		s);

	s->id = _id;
	s->card = _card;
	s->stream = NULL;
	strncpy(s->name, _name, sizeof(s->name));
	s->task_id = 0;
	s->bdidx = 0;
	s->irq = snd_psc_setups[_card->pscnum].irq[_id];
	s->dmapos = s->irqpos = 0;
	s->dma_started = 0;
	s->processed = 0;
	s->handler = _handler;
	s->stream = NULL;

#if SND_PSC_TRACE
	trace_create(&s->trace_handle, lognum, snd_psc_token_text, ARRAY_SIZE(snd_psc_token_text), SND_PSC_TRACE);
#endif

	memset(&setup, 0, sizeof(setup));
	/* setup.Initiator will be setup by the task setup function automatically */
	setup.NumBD = SND_PSC_NUM_BDS;
	setup.Size.MaxBuf = SND_PSC_MAX_PERIOD_SIZE;
	setup.StartAddrSrc = setup.StartAddrDst = 0;
	setup.SzSrc = setup.SzDst = sizeof(uint32_t);

	PRDEBUG(4, "%s: pscnum=%u Initiator=%u\n", __FUNCTION__, _card->pscnum, setup.Initiator);

	if (!_id)
	{
		/* task to transmit data */
		setup.StartAddrDst = (uint32_t)&(psc->mpc5xxx_psc_buffer_32);
		setup.IncrSrc = sizeof(uint32_t);
		setup.IncrDst = 0;
		PRDEBUG(3, "%s: setup TX\n", __FUNCTION__);
		s->task_id = TaskSetup_TASK_GEN_TX_BD(_card->pscnum, &setup, 0);
	}
	else
	{
		/* task to receive data */
		setup.StartAddrSrc = (uint32_t)&(psc->mpc5xxx_psc_buffer_32);
		setup.IncrSrc = 0;
		setup.IncrDst = sizeof(uint32_t);
		PRDEBUG(3, "%s: setup RX\n", __FUNCTION__);
		s->task_id = TaskSetup_TASK_GEN_RX_BD(_card->pscnum, &setup, 0);
	}

	if (s->task_id < 0)
	{
		printk(KERN_ERR "snd-psc: cannot setup BestComm task: err=%d\n", s->task_id);
		kfree(s);
		*_s = NULL;
		return -EFAULT;
	}

	PRDEBUG(3, "%s: pscnum=%u _s->task_id=%u, request IRQ%d\n", __FUNCTION__, _card->pscnum, s->task_id, s->irq);

	if ((ret = request_irq(s->irq, snd_psc_irq, SA_INTERRUPT, s->name, s)))
	{
		printk(KERN_ERR
		       "%s: PSC DMA irq (%d) allocation failed, error %d\n",
		       s->name,
		       s->irq,
		       -ret);

		kfree(s);
		*_s = NULL;
		return ret;
	}

	return 0;
}


int snd_psc_substream_close(snd_mpc5xxx_i2s_substream_t *_s)
{
	PRDEBUG(1, "%s(%s)\n", __FUNCTION__, _s->name);
	return 0;
}


int snd_psc_substream_free(snd_mpc5xxx_i2s_substream_t *_s)
{
	struct mpc5xxx_psc *psc = PSC_ADDRESS(_s->card->pscnum);

	PRDEBUG(1, "%s(%p)\n", __FUNCTION__, _s);

	/* stop the PSC */
	psc_tx_disable(psc);
	psc_rx_disable(psc);

	psc_reset(psc);

	free_irq(_s->irq, _s);

#if SND_PSC_TRACE
	trace_dump(_s->trace_handle);
	trace_free(_s->trace_handle);
#endif

	return 0;
}


#ifdef SND_PSC_CYCLIC_STATUS
static void snd_psc_status_timer_interrupt(unsigned long arg)
{
	snd_psc_tx_rx_status(1, 'T');

	if (status_psc)
		mod_timer(&status_timer, jiffies + SND_PSC_STATUS_TIMER_PERIOD);
}
#endif


int snd_psc_card_create(snd_mpc5xxx_i2s_card_t **_card,
			uint16_t _pscnum,
			int _slave, int _spi, int _loopback)
{
	static const char *request_names[8] =
		{
			"invalid_PSC",
			"snd_psc_PS1",
			"snd_psc_PS2",
			"snd_psc_PS3",
			"invalid_PSC",
			"invalid_PSC",
			"snd_psc_PS6",
			"invalid_PSC"
		};

	size_t i;
	struct mpc5xxx_psc *psc = PSC_ADDRESS(_pscnum);

	snd_mpc5xxx_i2s_card_t *card = kmalloc(sizeof(snd_mpc5xxx_i2s_card_t), GFP_KERNEL);
	*_card = card;
	if (card == NULL)
	{
		return -ENOMEM;
	}

	MOD_INC_USE_COUNT;

#if defined(SND_PSC_DEBUG)
	status_psc = psc;
#else
	if (debug != -1)
		printk(KERN_WARNING "%s: compiled without debug support\n", __FUNCTION__);
#endif

	PRDEBUG(1,
		"%s(card=%p,pscnum=%u,slave=%d,spi=%d,loopback=%d) card=%p\n",
		__FUNCTION__,
		_card, _pscnum, _slave, _spi, _loopback, card);

	/* Can't fail */
	request_region((unsigned long)psc, sizeof(struct mpc5xxx_psc), request_names[_pscnum]);
	snprintf(card->name, sizeof(card->name), "snd_psc_psc%u", _pscnum);
	card->pscnum = _pscnum;
	card->rate = 0;
	card->channels = 0;
	card->bits = 0;
	card->slave = _slave;
	card->spi = _spi;
	card->loopback = _loopback;
	spin_lock_init(&card->lock);
	for (i = 0; i < SND_PSC_MAX_STREAMS; i++)
		card->streams[i] = NULL;

	card->psc_started = 0;
	psc->mpc5xxx_psc_imr = 0;

#ifdef SND_PSC_CYCLIC_STATUS
	/* Start timer interrupt to get transfer status every second. */
	PRDEBUG(1, "snd-psc: starting cyclic status\n");
	init_timer(&status_timer);
	status_timer.function = snd_psc_status_timer_interrupt;
	status_timer.data = 0;
	add_timer(&status_timer);
#endif

	return 0;
}


void snd_psc_card_free(snd_mpc5xxx_i2s_card_t *_card)
{
	PRDEBUG(1, "%s(%p)\n", __FUNCTION__, _card);

	if (_card)
	{
		struct mpc5xxx_psc *psc = PSC_ADDRESS(_card->pscnum);
		release_region((unsigned long)psc, sizeof(struct mpc5xxx_psc));
	}

#ifdef SND_PSC_CYCLIC_STATUS
	if (status_psc)
	{
		PRDEBUG(1, "snd-psc: stopping cyclic status\n");
		status_psc = NULL;
		del_timer_sync(&status_timer);
	}
#endif

	MOD_DEC_USE_COUNT;
}


static int __init snd_psc_init(void)
{
	PRDEBUG(1, "%s() debug=%d fixed=%d\n", __FUNCTION__, debug, fixed);
	printk(KERN_INFO "MPC5200 PSC I2S Audio DMA Driver\n");
	return 0;
}


static void __exit snd_psc_exit(void)
{
	PRDEBUG(1, "%s\n", __FUNCTION__);
}


module_init(snd_psc_init);
module_exit(snd_psc_exit);

MODULE_DESCRIPTION("Driver for the MPC5200 PSC in CODEC SND_PSC mode.");
MODULE_AUTHOR("Roman Fietze, Telemotive AG, roman.fietze@telemotive.de");
MODULE_SUPPORTED_DEVICE("MPC5200 PSC SND_PSC Codec");

MODULE_LICENSE("GPL");

#if defined(SND_PSC_DEBUG)
MODULE_PARM(debug, "i");
MODULE_PARM_DESC(debug, "debug level (0-6)");
MODULE_PARM(fixed, "i");
MODULE_PARM_DESC(fixed, "check fixed data stream (0-1)");
#endif

#if SND_PSC_TRACE
MODULE_PARM(lognum, "i");
MODULE_PARM_DESC(lognum, "Log file number (/var/log/tmproto-<num>) (0-99)");
#endif

EXPORT_SYMBOL(snd_psc_card_create);
EXPORT_SYMBOL(snd_psc_card_free);

EXPORT_SYMBOL(snd_psc_substream_create);
EXPORT_SYMBOL(snd_psc_substream_open);
EXPORT_SYMBOL(snd_psc_substream_params);
EXPORT_SYMBOL(snd_psc_substream_start);
EXPORT_SYMBOL(snd_psc_get_substream_pos);
EXPORT_SYMBOL(snd_psc_substream_stop);
EXPORT_SYMBOL(snd_psc_substream_close);
EXPORT_SYMBOL(snd_psc_substream_free);

--Boundary-01=_0j/fFCA+48jpCgh--

--nextPart14049313.PFCfyRRia4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFf/j0p5XY/BK//MIRAqfsAJ9q9dJMGU2PaJxCPqwiIgck9oo1gwCfd/Ss
vFz0x09RHbDvA/OyOX1nNEg=
=rE7/
-----END PGP SIGNATURE-----

--nextPart14049313.PFCfyRRia4--
