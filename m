Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2A33D67B19
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 02:14:22 +1000 (EST)
Date: Mon, 18 Apr 2005 09:14:20 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
Message-ID: <20050418161420.GA25352@gate.ebshome.net>
References: <0007F077BB3476449151699150E8FEA20592C8@exchange.tsi-telsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0007F077BB3476449151699150E8FEA20592C8@exchange.tsi-telsys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Unable to capture device interrupts on ppc440gx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 18, 2005 at 12:02:52PM -0400, Sanjay Bajaj wrote:
> In the device driver open function, I call request_irq() to register 
> my interrupt handler function to a specified IRQ number. It 
> succeeds. 
> But when I enable the interrupt (and we can detect the hardware line 
> is active) on the hardware, the interrupt handler in NOT invoked. Is 
> there something I am missing? Any help or pointers are appreciated.

Did you configure polarity and triggering settings for this IRQ 
source? If not, look for example at ebony.c (ppc4xx_uic_ext_irq_cfg) 
keeping in mind, that Ebony has 440GP CPU. 440GX has 5 additional 
IRQ lines.

-- 
Eugene
