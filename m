Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C50EDDE3F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 01:34:25 +1000 (EST)
In-Reply-To: <20070416102533.0f87396f.kim.phillips@freescale.com>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Mon, 16 Apr 2007 10:34:07 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 16, 2007, at 10:25 AM, Kim Phillips wrote:

> On Fri, 13 Apr 2007 21:02:25 +0200
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
>
>>> Since ucc_geth is being migrated to use the phylib, the existing
>>> (undocumented) 'interface' property is being deprecated in favour
>>> of unconjoined variations 'max-speed' and 'interface-type'.
>>
>> Again, please explain why this information shouldn't
>> be in the PHY node instead?
>>
>
> Strictly speaking, it should be neither in the UCC node nor the PHY
> node, as it describes the connection between the two, but..
>
> the UCC driver utilizes the data itself; the UCC, unlike other network
> controllers, does not provide interface data in its programming model.
>
> the phy drivers are not of_ drivers.  Porting phylib drivers to be of_
> drivers would break phylib for non-OF arches, e.g. x86.

Nothing stops the code in the UCC driver from grabbing the phy device  
node and pulling the information out if it.

I believe the question is about where the information should truly  
live.  It would seem to be more of a property of the phy than of the  
enet controller.

- k
