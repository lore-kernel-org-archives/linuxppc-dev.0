Return-Path: <lagrange@fr.oleane.com>
Received: from smtp5.clb.oleane.net (smtp5.clb.oleane.net [213.56.31.25])
	by ozlabs.org (Postfix) with ESMTP id 61A7667A03
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Feb 2006 19:45:08 +1100 (EST)
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp5.clb.oleane.net with ESMTP id k1S8ixYM020867
	for <linuxppc-embedded@ozlabs.org>; Tue, 28 Feb 2006 09:45:01 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Minor bug in file irq.h
Date: Tue, 28 Feb 2006 09:50:50 +0100
Message-ID: <000201c63c44$14a9c1b0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I use a Linux 2.6.9 on MPC85xx.

In the ./linux/include/asm-ppc/irq.h file, I encountered a problem with the
timer3 interrupt definition :
#define     SIU_INT_TIMER3          ((uint)0x0e+CPM_IRQ_OFFSET)

This definition generates a compilation error  because is interpreted as
something like
((uint)0x0(e+CPM_IRQ_OFFSET)) ie 0x0 exponent  + CPM_IRQ_OFFSET.

To work around just parenthesis or add a space character between 'e' and '+'
#define     SIU_INT_TIMER3          ((uint)0x0e +CPM_IRQ_OFFSET)

Laurent
