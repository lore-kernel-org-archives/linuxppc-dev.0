Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4ED6B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 10:42:50 +1100 (EST)
Message-ID: <4B15AA4F.5040309@kernel.org>
Date: Wed, 02 Dec 2009 08:44:15 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
References: <20091201070834.6A840B7B63@ozlabs.org>	
	<4B14CD22.4020806@kernel.org> <1259709552.2076.1053.camel@pasglop>	
	<4B15A67C.2030102@kernel.org> <1259710543.2076.1054.camel@pasglop>
In-Reply-To: <1259710543.2076.1054.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, Holger Macht <hmacht@suse.de>,
	linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/2009 08:35 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2009-12-02 at 08:27 +0900, Tejun Heo wrote:
>> Conceptually freeze would be more approriate but the side effect is
>> that the port is frozen and EH will try to thaw it by resetting it.
>> So, abort would work better.
> 
> BTW. For a plug event, what should I do ? freeze is fine ? Or just
> schedule eh ? Right now, when plugging I see an exception Emask 0x10
> etc... message in the log when plugging which isn't totally nice :-)

freeze() and please don't fight the EH messages from low level driver.
If it's too much, we need to update core layer but given the variety
of phy related bugs, I think we need those messages.

Thanks.

-- 
tejun
