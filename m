Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28ECB67B25
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 00:46:43 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0504120101210.10781@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0504120101210.10781@blarg.somerset.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <83a359bdf2c4d4902f58e6788c37811a@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 12 Apr 2005 10:46:29 -0400
To: Kumar Gala <galak@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: Fix alignment exception checking on load/store
	multiple instructions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 12, 2005, at 2:03 AM, Kumar Gala wrote:

> The handling of misaligned load/store multiplies did not check to see 
> if
> the address were ok to access before __{get,put}_user().

I think we should also take the opportunity to fix up the lawrx
case and look for other reserved/conditional instructions
that may slip through.  Since these are atomic operations, we
can't emulate them.  According to the PEM, an alignment fault
on these is a fatal programming error.

Thanks.

	-- Dan
