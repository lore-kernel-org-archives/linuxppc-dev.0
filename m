Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84F3367C15
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 06:53:27 +1000 (EST)
In-Reply-To: <1154550970.19994.57.camel@cashmere.sps.mot.com>
References: <1154544503.19994.42.camel@cashmere.sps.mot.com>
	<9C1B15CC-6984-433D-8A1E-F856567B1AD2@kernel.crashing.org>
	<1154549483.19994.46.camel@cashmere.sps.mot.com>
	<BFD18279-7617-4F50-BB22-21A46C65FD50@kernel.crashing.org>
	<1154550970.19994.57.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F4FA8DDC-0490-4792-8B9B-89D3F0AECF26@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add MPC8641 HPCN Device Tree Source file.
Date: Wed, 2 Aug 2006 15:53:28 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 2, 2006, at 3:36 PM, Jon Loeliger wrote:

> On Wed, 2006-08-02 at 15:30, Kumar Gala wrote:
>
>>> Yeah, we have lined up Matt to make a comprehensive
>>> update for this.  Can we take my patch as-is?  Matt will
>>> follow up with a clean sweep, including fsl_socl.c, to
>>> fix it all in one swell foop.
>>
>> I think this is one that is clearly something that should be fixed
>> before acceptance.  Since we are talking about a dozen lines of
>> modifications.  Especially since at this point having the .dts in the
>> tree doesn't really effect anything inside the kernel tree.
>>
>> - kumar
>
> On the other hand, this matches what the kernel implements
> today, and is already in use by several people around the
> world.  It _does_ have an affect and is based on things
> inside the kernel tree today as it is.

True, but the people that are running this dont really care if the  
dts is in the kernel or not. I think having an error in the kernel  
tree that we know about is more of an issue.  Its something we all  
agree needs to be fixed.

Here is the code modification to fsl_soc.c, I'm sure we can get this  
fixed push into 2.6.18 if desired.

if(mac_addr = get_property(np, "address", NULL))
   memcpy(gfar_data.mac_addr, mac_addr, 6);

if(mac_addr = get_property(np, "local-mac-address", NULL);
   memcpy(gfar_data.mac_addr, mac_addr, 6);

- kumar
