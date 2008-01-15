Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A31D2DDF2B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 04:32:05 +1100 (EST)
Date: Tue, 15 Jan 2008 09:32:02 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] net: EMAC: Fix problem with mtu > 4080 on non TAH
	equipped 4xx PPC's
Message-ID: <20080115173202.GA1268@gate.ebshome.net>
References: <1200400809-19720-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1200400809-19720-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2008 at 01:40:09PM +0100, Stefan Roese wrote:
> Currently, all non TAH equipped 4xx PPC's call emac_start_xmit() upon
> xmit. This routine doesn't check if the frame length exceeds the max.
> MAL buffer size.
> 
> This patch now changes the driver to call emac_start_xmit_sg() on all
> platforms and not only the TAH equipped ones (440GX). This enables an
> MTU of 9000 instead 4080.
> 
> Tested on Kilauea (405EX) with gbit link -> jumbo frames enabled.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
> Eugene & Ben, do you see any problems with this patch? If not, then I'll
> send another version for the newemac driver too.

Hmm, so why not make GigE support a condition to hook SG version of 
xmit then? I don't like when you change behaviour for chips where it 
perefectly legal not to do this check because you cannot change MTU 
anyways.

-- 
Eugene
