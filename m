Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D241F2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 23:29:51 +1100 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16869.5506.381522.29009@astp0002.localdomain>
Date: Wed, 12 Jan 2005 14:18:10 +0200
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200501121255.56374.david.jander@protonic.nl>
References: <43395BE65409D911B9FF00110A9BFFDC9F851C@zwg57exm01.ea.mot.com>
	<200501121255.56374.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8xx: Using SCM/SCC and standard 16C550 Uarts together...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> David Jander writes:

    David> On Wednesday 12 January 2005 10:59, Demke Torsten-atd012
    David> wrote:

    Demke> I dont know exactly the state of the DENX kernel, but in the
    Demke> standard kernel the 8xx UART driver and the 16550 driver are
    Demke> using the same device numbers (TTY_MAJOR) and device names
    Demke> (/dev/ttySx).  You have to change one of them.

    David> You are right! What now? I cannot go around and change
    David> TTY_MAJOR!  Is it true then, that you normally cannot have a
    David> mix of non-16550 uarts and 16550 uarts on the same system,
    David> without doing nonstandard things with major numbers?

We've got such a mix but we use completely different MPC8xx support
infrastructure. Our SCC/SMC UART driver takes care of possible external
UARTs (it uses the same major number but configurable minor).

    David> Should maybe arch/ppc/8xx_io/uart.c use another major number?

Then you'll have to change all applications using standard device names
(ttySx).

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
