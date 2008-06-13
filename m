Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D67EDDF0D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 02:04:02 +1000 (EST)
Message-Id: <E67AB741-49D3-456D-9559-C040C5CD5ACC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Christian Krafft <krafft@de.ibm.com>
In-Reply-To: <20080613173649.5451976e@de.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC] poweroff via pm_power_off if set
Date: Fri, 13 Jun 2008 11:00:33 -0500
References: <20080613173649.5451976e@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 13, 2008, at 10:36 AM, Christian Krafft wrote:

> This patch is needed to make ipmi_poweroff working on powerpc.
> It straightens the poweroff procedure to match with other  
> architectures.
> At the moment powerpc plattforms can define their poweroff method  
> using
> ppc_md.power_off. The only way for plattform independent driver  
> (ipmi_poweroff)
> to register it's poweroff function is to use pm_power_off. So  
> machine_power_off
> should check whether pm_power_off has been set and if so it should  
> be used.
> If not, plattform dependent ppc_md.power_off should be called.

It seems like this should be the other way around.  Meaning  
ppc_md.power_off should be called first than pm_power_off.  If a  
platform provides a power off mechanism that should presuming take  
precedence over the ipmi_poweroff.

- k
