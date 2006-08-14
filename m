Return-Path: <ossthema@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C5D967BBA
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 23:17:53 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7EDHmRj076190
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 13:17:48 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7EDLakf079964
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 15:21:36 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7EDHmMX005758
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 15:17:48 +0200
Message-ID: <44E06EDA.6040404@de.ibm.com>
Date: Mon, 14 Aug 2006 14:38:50 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: ehea debug output discussion
References: <44D99F38.8010306@de.ibm.com> <20060811215225.GH479@krispykreme>
	<44DE03B0.1060607@de.ibm.com> <20060813144400.GJ479@krispykreme>
In-Reply-To: <20060813144400.GJ479@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	roland@topspin.com, netdev <netdev@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

Anton Blanchard wrote:
> What is going to be done about the debug infrastructure in the ehea
> driver? The entry and exit traces really need to go, and any other debug
> you think is important to users needs to go into debugfs or something
> similar.
> 
> I see a similar issue in the ehca driver that I am in the middle of
> reviewing.
> 
> Anton

This is a statement for the eHEA driver:

Most of the debug outputs are redundant and we'll remove them
(EDEB_EN / EDEB_EX). We can use the standard mechanism for ethernet devices
(netif_msg_x) in most functions of ehea_main.c as we have the device struct
as a parameter available. However, some debug output mechanism is needed
where the standard mechanism does not work (functions that have no relation
to the dev struct do not have a dev parameter, for example
ehea_hcall_9arg_9ret in ehea_phyp.h)

The outcome of some internal discussions was that it is not acceptable for
our enterprise users of this type of driver on this target system to need a
recompile / reload of the driver for error analysis, so we need a mechanism
that allows us to switch on / off debug output at runtime. Therefore, we'd
introduce a stripped down version of EDEB.

Regards,
Jan-Bernd
