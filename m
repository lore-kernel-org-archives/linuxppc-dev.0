Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3D73467B74
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 14:01:15 +1000 (EST)
Date: Thu, 14 Apr 2005 21:01:12 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Message-ID: <20050415040112.GB11362@gate.ebshome.net>
References: <425EB470.9040203@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <425EB470.9040203@am.sony.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: {PATCH] Fix IBM EMAC driver ioctl bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 14, 2005 at 11:20:32AM -0700, Geoff Levand wrote:
> Fix IBM EMAC driver ioctl bug.
> 
> I found IBM EMAC driver bug.
> So mii-tool command print wrong status.
> 
>   # mii-tool
>   eth0: 10 Mbit, half duplex, no link
>   eth1: 10 Mbit, half duplex, no link
> 
> I can get correct status on fixed kernel.
> 
>   # mii-tool
>   eth0: negotiated 100baseTx-FD, link okZZ
>   eth1: negotiated 100baseTx-FD, link ok
> 

There is a problem with this patch. I'm aware of this problem for 
quite some time, but chose to keep the current code.

This IOCTL implementation has been here for many years in all 
revisions of the driver, so I think we should keep it as is, because 
some software could rely on it, and your change will break it. 

And all new code should use ethtool anyway :).

-- 
Eugene
