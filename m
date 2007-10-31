Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9FBACDDE1A
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 06:47:38 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l9VJlS90211380
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 19:47:28 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9VJlS3a2203770
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 20:47:28 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9VJlREs013463
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 20:47:27 +0100
In-Reply-To: <1193784636.32504.4.camel@concordia>
References: <200710261437.29117.ossthema@de.ibm.com>	
	<1193610737.9637.1.camel@concordia>
	<OF79E7ACE7.5D0488CE-ONC1257384.002E58C0-C1257384.002F8561@de.ibm.com>
	<1193784636.32504.4.camel@concordia>
Subject: Re: [PATCH] ehea: add kexec support
To: michael@ellerman.id.au
Message-ID: <OF59B5FFD2.0294206F-ONC1257385.006A802D-C1257385.006CB6BB@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Wed, 31 Oct 2007 20:48:28 +0100
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


Michael Ellerman <michael@ellerman.id.au> wrote on 30.10.2007 23:50:36:
>
> On Tue, 2007-10-30 at 09:39 +0100, Christoph Raisch wrote:
> >
> > Michael Ellerman <michael@ellerman.id.au> wrote on 28.10.2007 23:32:17:
> > Hope I didn't miss anything here...
>
> Perhaps. When we kdump the kernel does not call the reboot notifiers, so
> the code Jan-Bernd just added won't get called. So the eHEA resources
> won't be freed. When the kdump kernel tries to load the eHEA driver what
> will happen?
>
Good point.

If the device driver tries to allocate resources again (in the kdump
kernel),
which have been allocated before (in the crashed kernel) the hcalls will
fail because from the hypervisor view the resources are still in use.
Currently there's no method to find out the resource handles for these
HEA resources allocated by the crashed kernel within the hypervisor...

So we have to trigger a explicit deregister in the hypervisor before the
driver
is started again.
How do you recommend we should trigger this in the kdump process?
Is placing a hook into a ppc_md.machine_kexec be an option?

Gruss / Regards
Christoph R.
