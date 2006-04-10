Return-Path: <vatsa@in.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 069B167AC7
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 23:44:29 +1000 (EST)
Received: from e6.ny.us.ibm.com ([192.168.1.106])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ACPwIS012442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 08:25:58 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ACPibS001441
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 08:25:44 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3ACPYun230660
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 08:25:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3ACPYjk013544
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 08:25:34 -0400
Date: Mon, 10 Apr 2006 17:53:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] tickless idle cpu: Skip ticks when CPU is idle
Message-ID: <20060410122339.GD5564@in.ibm.com>
References: <20060407063131.GB22416@in.ibm.com>
	<981C3B4E-7336-403D-AF58-3B36AA071866@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <981C3B4E-7336-403D-AF58-3B36AA071866@kernel.crashing.org>
Cc: sri_vatsa_v@yahoo.com, paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: vatsa@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 07, 2006 at 09:16:58AM -0500, Kumar Gala wrote:
> >+config NO_IDLE_HZ
> >+	depends on EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC || PPC_MAPLE)
> >+	bool "Switch off timer ticks on idle CPUs"
> >+	help
> >+	  Switches the HZ timer interrupts off when a CPU is idle.
> >+
> 
> any reason not to provide this for all 6xx class processors?

I think the same patch would work mostly for 6xx cpus as well. I however
dont think have any hardware to test it. If I am not mistaken, to
support 6xx CPUs, only ppc6xx_idle needs to be modified to call stop_hz_timer 
before going into power-save mode?


-- 
Regards,
vatsa
