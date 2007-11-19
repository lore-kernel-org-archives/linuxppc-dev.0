Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D260ADDE06
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 03:08:28 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iu8HA-0001Lw-UQ
	for linuxppc-embedded@ozlabs.org; Mon, 19 Nov 2007 15:11:04 +0000
Received: from p5497f08f.dip.t-dialin.net ([84.151.240.143])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Nov 2007 15:11:04 +0000
Received: from dzu by p5497f08f.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Nov 2007 15:11:04 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: how to improve linux tcp/ip(UDP) efficiency on mpc8541 833Mhz.
Date: Mon, 19 Nov 2007 16:10:40 +0100
Message-ID: <m2ejems233.fsf@ohwell.denx.de>
References: <OF406A1338.BB8E4414-ON48257392.000CFC61-48257392.000F90D1@coship.com>
	<47398B44.2070902@anagramm.de> <47407CCB.80503@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

> We use a 8250 and 8270 of which the performance is highly limited by the 
> bandwidth of the memory to the very small internal cache.
> I once modified a driver into a "polling" method polling the device 
> every millisecond. The amount of messages processed trippled this way! 
> On full speed the console could even be used for "normal" operation (in 
> contrairy to the interrupt driver driver).
> The penalties are obvious: When the bandwith used is low the delay for 
> polled messages is higher and the CPU overhead is higher.

Just look at the NAPI[1] (New-NAPI in the latest incarnation) linux
layer for network drivers.  The upshot of this is that where "old"
drivers pull data from the network card onto the kernel network
backlog on interrupt time, NAPI drivers only set an internal flag so
they want to get polled by the kernel when it is ready and basically
disable further interrupts.  They are enabled again by the time the
driver was able to post all packets up to the network stack.

This effectively gives low latencies on low network load because it
more or less stays being interrupt driven but it turns into polling
mode on high network loads and thus prevents interrupt live lock
situations.  

Adapting the network driver in question to NNAPI should improve the
performance of the whole system quite a bit.

Best wishes
  Detlev

[1] http://www.linux-foundation.org/en/Net:NAPI

-- 
Indeed, the author firmly believes that the best serious work is also
good fun.   We needn't apologize if we enjoy doing research.
                                        -- Donald Knuth
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
