Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 8F31ADDDDB
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 00:20:05 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [PATCH RFC v2] net: add PCINet driver
Date: Wed, 5 Nov 2008 14:19:52 +0100
References: <20081029202027.GH12879@ovro.caltech.edu>
	<200811042123.03819.arnd@arndb.de>
	<20081104222927.GE4641@ovro.caltech.edu>
In-Reply-To: <20081104222927.GE4641@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811051419.53194.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Stephen Hemminger <shemminger@vyatta.com>,
	Jan-Bernd Themann <THEMANN@de.ibm.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 November 2008, Ira Snyder wrote:

> So, since interrupts are disabled while my interrupt handler is running,
> I think I should be able to use spin_lock() and spin_unlock(), correct?

yes.

> But sparse gives me the following warning:
> wqt.c:185:9: warning: context imbalance in 'wqt_interrupt': wrong count at exit
> wqt.c:185:9:    context 'lock': wanted 0, got 1
> 
> If I'm using spin_lock_irqsave() and spin_lock_irqrestore() I do not get
> the same warnings. Therefore I must have some misunderstanding :)


I've seen something like that before, I think it was a bug either in
sparse or in the powerpc platform code. Try updating both the kernel
and sparse and see if it still happens.

	Arnd <><
