Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BD6F67B21
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 22:10:05 +1000 (EST)
Received: from zambia.cambridgebroadband.com (cbluk-gw0.cambridgebroadband.com
	[217.204.121.82])
	by cambridgebroadband.com (8.12.8/8.12.8) with SMTP id j49CA0gl007868
	for <linuxppc-embedded@ozlabs.org>; Mon, 9 May 2005 13:10:00 +0100
Date: Mon, 9 May 2005 13:10:00 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20050509131000.38afa58a.ajz@cambridgebroadband.com>
In-Reply-To: <427BBA71.8040307@chello.nl>
References: <427BBA71.8040307@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: 2.4.18: CPM1 stops when initializing ATM/UTOPIA.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It may be that you're getting a conflict in SCC usage.  Make sure you
have CONFIG_SERIAL_ATM undefined.  But if you really need it make sure
CONFIG_SERIAL_ATM_SCC is not used by anything else.  You may also want
to disable CONFIG_PTP_SWITCHING if you don't need it.  Finally you
probably want CONFIG_PHY_OTHER instead of CONFIG_PHY_SUNI_155 or
CONFIG_PHY_ATM_25.  These latter options make assumptions about the
memory mapping of your phy.

Note: a long while ago we had problems with PTP switching causing hangs
but this was fixed by a ucode patch from motorola.  If you really need
PTP switching you should get this.

Alex


On Fri, 06 May 2005 20:41:53 +0200
Theo Gjaltema <gjalt007@chello.nl> wrote:

> Hi,
> 
> Last week I was trying to integrate the atm/utopia driver
> (sourceforce) into a 2.4.18 kernel build for a 862, but mij attemtps
> failed. It appeared that wen on the first location of the SCC4 (now
> used for utopia) a buffer address is written, most CPM activities are
> halted, including the SCM1 which I used as console port. The console
> driver did write in the allocated buffer descriptors, but the
> tranmission of the data was never acknowledged, thus hanging the
> kernel.
> 
> Anyone an idea what happened?
> 
> Theo.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
