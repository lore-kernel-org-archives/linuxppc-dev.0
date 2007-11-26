Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74800DDE43
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 21:45:10 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id lAQAj5G8058094
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 10:45:05 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lAQAj46E2572488
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 11:45:04 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lAQAj38p019307
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 11:45:04 +0100
In-Reply-To: <1196064988.19855.15.camel@concordia>
References: <200711091433.51259.osstklei@de.ibm.com>
	<1196064988.19855.15.camel@concordia>
Subject: Re: [PATCH] ehea: Add kdump support
To: michael@ellerman.id.au
Message-ID: <OF94123F44.9DB75CE9-ONC125739F.00398E63-C125739F.003B2AFE@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Mon, 26 Nov 2007 11:45:02 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <THEMANN@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Marcus Eder <MEDER@de.ibm.com>, tklein@linux.ibm.com,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote on 26.11.2007 09:16:28:
> Solutions that might be better:
>
>  a) if there are a finite number of handles and we can predict their
>     values, just delete them all in the kdump kernel before the driver
>     loads.

Guessing the values does not work, because of the handle structure
defined by the hypervisor.

>  b) if there are a small & finite number of handles, save their values
>     in a device tree property and have the kdump kernel read them and
>     delete them before the driver loads.

5*16*nr_ports+1+1=   >82. a ML16 has 4 adapters with up to 16 ports, so the
number
is not small anymore....
The device tree functions are currently not exported.

If you crashdump to a new kernel, will it get the device tree
representation
of the crashed kernel or of the initial one of open firmware?

>  c) if neither of those work, provide a minimal routine that _only_
>     deletes the handles in the crashed kernel.

I would hope this has the highest chance to actually work.
For this we would have to add a proper notifier chain.
Do you agree?

>  d) <something else>

Firmware change? But that's not something you will get very soon.

Christoph R.
