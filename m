Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id D2AB4B6F97
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Oct 2011 00:39:39 +1100 (EST)
Date: Wed, 5 Oct 2011 15:29:50 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 0/4] powerpc: Mark various interrupts IRQF_NO_THREAD
Message-ID: <20111005132949.GA25028@iram.es>
References: <20111005122122.553832402@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111005122122.553832402@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 05, 2011 at 12:30:49PM -0000, Thomas Gleixner wrote:
> The following series marks the obvious interrupts IRQF_NO_THREAD to
> prevent forced interrupt threading - no guarantee of completeness :)
> 
> The last patch enables the forced threading mechanism in the core
> code, which in turn enables the "irqthreaded" commandline option.

Is there any description of what "interrupt threading" means?

I'm only looking for a pointer to a web page, a mailing list thread
(I am no more subscribed to lkml, too many things to do, so maybe
it has been discussed but it comes out of the blue on linuxppc-dev), 
or a well commented git commit?

>From followups, I see that cascaded interrupt controller should
not be threaded. I suspect that the private VME bridge driver
(Universe chip) I maintain here will need it: clients request
a given VME interrupt (level/vector) and specify an interrupt
handler which is called by the handler for the PCI interrupt.

	Regards,
	Gabriel
