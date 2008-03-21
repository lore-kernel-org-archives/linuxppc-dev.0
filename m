Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1805FDDFA2
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 22:19:10 +1100 (EST)
Subject: Re: crash in init_ipic_sysfs on efika
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <47E24B69.2080607@genesi-usa.com>
References: <20080317195305.GA13298@aepfle.de>
	<20080319152722.GA9208@aepfle.de>  <47E24B69.2080607@genesi-usa.com>
Content-Type: text/plain
Date: Fri, 21 Mar 2008 22:18:35 +1100
Message-Id: <1206098315.8420.69.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-03-20 at 11:32 +0000, Matt Sealey wrote:
> subsys_initcall(init_ipic_sysfs); <-- this, in my eyes, is the culprit. If
> init_ipic() runs, init_ipic_sysfs should be called from that, not left for
> some further subsystem to blindly try and register sysfs nodes for devices
> which may not even be present..
> 
> I'd love someone to explain to me how this works and why, and why it isn't
> braindead? :D

init_ipic() is called way too early to be able to manpipulate sysfs.

Ben.
