Return-Path: <amoll@avat.de>
Received: from mail.ganssloser.com (mail.ganssloser.com [212.71.208.2])
	by ozlabs.org (Postfix) with ESMTP id A06A3DDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 01:19:16 +1100 (EST)
Subject: RE: MPC5200B TxRTS auto-toggle mode. (Txema Lopez)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF0886F27A.F554CD9A-ONC125729C.004BF911-C125729C.004C7652@avat.local>
From: "Albrecht Moll" <amoll@avat.de>
Date: Mon, 12 Mar 2007 14:55:10 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: Txema Lopez <tlopez@aotek.es>
Reply-To: amoll@ganssloser.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Date: Wed, 10 Jan 2007 11:13:44 +0100
> From: Txema Lopez <tlopez@aotek.es>
> Subject: MPC5200B TxRTS auto-toggle mode.
> To: Linuxppc-embedded@ozlabs.org
> Message-ID: <45A4BC58.5010700@aotek.es>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hi all,
>
> I'm working in a MPC5200B based plataform. I want to use the TXRTS
> feature of the MPC5200B's PSC-UART(auto toggle when the transmitter
> ends) to manage a rs485 transceiver but I'm unable to do it. Googling,
> I've found that a year ago Stefan Eletzhofer asked for the same
> question, but I can't find any answer to this question (neither in the
> linuxppc-embedded mailing list archives). Did anyone find a solution? Is
> there a patch available for a Denx's 2.4.25 kernel?.

Maybe this is of interest for you - I got this answer from Freescale
support after I asked a
Freescale engineer at embedded world fair in Nuremberg:

Dear Mr. Moll,
please find below answers to your question concerning RTS deassertion on
MPC5200B  PSC in UART mode.

Basically it works that RTS is negated when the shift register of the
PSC has transmitted the current data word.
Please see also:

>MPC5200B Users Manual Chapter  15.3.1.3 Transmitting in UART Mode
>In applications in which the transmitter is disabled after transmission
is complete and RTS is appropriately programmed, RTS is negated one
>bit-time after the character in the shift register is completely
transmitted. The transmitter must be manually re-enabled by reasserting
RTS
>before the next message is to be sent.

However, this is based on a single data word to be sent. Data still
residing in the transmit FIFO would remain there until the next
transmission
is initiated. Both, disabling and re-enabling of the transmitter has to
be done manually.
For your particular case it probably makes more sense to use the TxEMP
interrupt of the PSC and deassert RTS manually in the interrupt
service routine.

(please see Table 15-28. Interrupt Mask Register (0x14) for UART / SIR
Mode  in the MPC5200B Users Manual)

Unfortunately there is no MPC5200 App-Note or demo application for the
use of EIA-485 available.
