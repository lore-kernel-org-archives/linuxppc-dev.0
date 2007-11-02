Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A456DDDE4
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 21:19:28 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id lA2AJOeB495532
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 10:19:24 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id lA2AJNJw2257096
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 11:19:23 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA2AJLFQ026793
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 11:19:23 +0100
In-Reply-To: <1193985008.1782.7.camel@concordia>
References: <200710261437.29117.ossthema@de.ibm.com>	
	<1193610737.9637.1.camel@concordia>
	<OF79E7ACE7.5D0488CE-ONC1257384.002E58C0-C1257384.002F8561@de.ibm.com>	
	<1193784636.32504.4.camel@concordia>
	<OF59B5FFD2.0294206F-ONC1257385.006A802D-C1257385.006CB6BB@de.ibm.com>
	<1193985008.1782.7.camel@concordia>
Subject: Re: [PATCH] ehea: add kexec support
To: michael@ellerman.id.au
Message-ID: <OF3FAFDB41.AF236738-ONC1257387.00376233-C1257387.00389861@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 2 Nov 2007 11:19:12 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, ossthema@linux.vnet.ibm.com,
	Jeff Garzik <jeff@garzik.org>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <MEDER@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Michael Ellerman <michael@ellerman.id.au> wrote on 02.11.2007 07:30:08:

> On Wed, 2007-10-31 at 20:48 +0100, Christoph Raisch wrote:
> > Michael Ellerman <michael@ellerman.id.au> wrote on 30.10.2007 23:50:36:
> If that's really the way it works then eHEA is more or less broken for
> kdump I'm afraid.

We think we have a way to workaround this, but let me first try to
explain the base problem.

DD allocates HEA resources and gets firmware_handles for these resources.
To free the resources DD needs to use exactly these handles.
There's no generic firmware call "clean out all resources".
Allocating the same resources twice does not work.

So a new kernel can't free the resources allocated by an old kernel,
because the numeric values of the handles aren't known anymore.

Potential Solution:
Hea driver cleanup function hooks into ppc_md.machine_crash_shutdown
and frees all firmware resources at shutdown time of the crashed kernel.
crash_kexec continues and loads new kernel.
The new kernel restarts the HEA driver within kdump kernel, which will work
because resources have been freed before.

Michael, would this work?

Gruss / Regards
Christoph R.
