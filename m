Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DA86679A6
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 11:35:14 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2V0Z7lI022672
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 19:35:07 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2V0VtSJ263206
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 17:31:55 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2V0Z7UA002497
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 17:35:07 -0700
Date: Thu, 30 Mar 2006 18:35:06 -0600
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during
	reset.
Message-ID: <20060331003506.GU2172@austin.ibm.com>
References: <20060330213928.GQ2172@austin.ibm.com>
	<20060331000208.GS2172@austin.ibm.com>
	<442C8069.507@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <442C8069.507@wolfmountaingroup.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jesse.brandeburg@intel.com, linuxppc-dev@ozlabs.org,
	john.ronciak@intel.com, jeffrey.t.kirsher@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 30, 2006 at 06:05:45PM -0700, Jeff V. Merkey wrote:
> 
> Linas Vepstas wrote:

Well, these comments have nothing to do with my patch, but ... 
anyway ... 

> The driver also needs to be fixed to allow clearing of the stats (like 
> all the other adapter drivers). At present, when I run performance
> and packet drop counts on the cards, I cannot reset the stats with this 
> code because the driver stores them in the e100_adapter
> structure. This is busted.
> 
> This function:
> 
> int clear_network_device_stats(BYTE *name)

I couldn't find such a function in the kernel.
 
> does not work on e1000 due to this section of code:
> 
> void
> e1000_update_stats(struct e1000_adapter *adapter)
> {
> 
> adapter->stats.xofftxc += E1000_READ_REG(hw, XOFFTXC);
> adapter->stats.fcruc += E1000_READ_REG(hw, FCRUC);

These are hardware stats ... presumably useless without
a detailed understanding of the guts of the e1000.

> //NOTE These stats need to be stored in the stats structure so they can 
> be cleared by
> statistics monitoring programs.

I can't imagine what generic interface would allow these 
to be viewed.

> /* Fill out the OS statistics structure */
> 
> adapter->net_stats.rx_packets = adapter->stats.gprc;
> adapter->net_stats.tx_packets = adapter->stats.gptc;
> adapter->net_stats.rx_bytes = adapter->stats.gorcl;
> adapter->net_stats.tx_bytes = adapter->stats.gotcl;

Now *these* are generic ... and fixing this so that the 
stats increment instead of over-riding would take 
maybe half-an-hour or so; this is not hard to do ... !? 

Do you want me to write a patch to do this?

--linas
