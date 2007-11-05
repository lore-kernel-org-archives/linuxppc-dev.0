Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F40DDDDF2
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 01:24:06 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id lA5EO0Y2135698
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 14:24:00 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id lA5EO0NP2244746
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 15:24:00 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA5ENxnP029096
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 15:24:00 +0100
In-Reply-To: <24042.1194069991@neuling.org>
References: <200710261437.29117.ossthema@de.ibm.com>
	<1193610737.9637.1.camel@concordia>
	<OF79E7ACE7.5D0488CE-ONC1257384.002E58C0-C1257384.002F8561@de.ibm.com>
	<1193784636.32504.4.camel@concordia>
	<OF59B5FFD2.0294206F-ONC1257385.006A802D-C1257385.006CB6BB@de.ibm.com>
	<1193985008.1782.7.camel@concordia>
	<OF3FAFDB41.AF236738-ONC1257387.00376233-C1257387.00389861@de.ibm.com>
	<24042.1194069991@neuling.org>
Subject: Re: [PATCH] ehea: add kexec support
To: Michael Neuling <mikey@neuling.org>
Message-ID: <OF46AA6850.8C031396-ONC125738A.004D7626-C125738A.004F05C8@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Mon, 5 Nov 2007 15:24:13 +0100
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


Michael Neuling <mikey@neuling.org> wrote on 03.11.2007 07:06:31:

> > DD allocates HEA resources and gets firmware_handles for these
resources.
> > To free the resources DD needs to use exactly these handles.
> > There's no generic firmware call "clean out all resources".
> > Allocating the same resources twice does not work.
>
> Can we get a new firmware call to do this?

Well, there's no simple answer to this. I'm not working on firmware.
I'm trying to get an answer... but don't expect anything "real soon".

>
> > So a new kernel can't free the resources allocated by an old kernel,
> > because the numeric values of the handles aren't known anymore.
>
> How many possible handles are there?

Depends on system configuration, between
4 and 64 per port.

>
> If the handles are lost, is the only way to clear out the HEA resources
> is to reset the partition?

Yes, that's exactly the problem.

>
> > Potential Solution:
> > Hea driver cleanup function hooks into ppc_md.machine_crash_shutdown
> > and frees all firmware resources at shutdown time of the crashed
kernel.
>
> This means the crashed kernel now has to be trusted to shut down and
> free up the resources.  Isn't trusting the crashing kernel in this way
> against the whole kdump idea?

I would hope that if the cleanup routine only does hcalls
and does not change any kernel memory areas, then the risk to damage
anything
else  in kernel should be pretty small. This should allow to catch most
cases,
but as always you can imagine situations where the kernel memory is broken
beyond hope to even restart the kdump kernel.


>
> > crash_kexec continues and loads new kernel.
> > The new kernel restarts the HEA driver within kdump kernel, which will
work
> > because resources have been freed before.
> >
> > Michael, would this work?

Is ppc_md.machine_crash_shutdown the right hook?

Gruss/Regards
Christoph R
