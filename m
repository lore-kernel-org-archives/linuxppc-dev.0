Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 3CAE0DE37B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 09:02:59 +1100 (EST)
Message-ID: <45B7D78E.5020704@freescale.com>
Date: Wed, 24 Jan 2007 16:02:54 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/18] Make ft_node_add() accept and return NULL.
References: <20070124210709.GF10527@ld0162-tx32.am.freescale.net>
	<4EF444AA-B7C0-460D-BA0A-EEDC9E2E4812@kernel.crashing.org>
In-Reply-To: <4EF444AA-B7C0-460D-BA0A-EEDC9E2E4812@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> Currently, if ft_node_add() is passed NULL it will allocate an  entry for
>> it and return a non-NULL phandle.  This patch makes it simply pass the
>> NULL through.
> 
> 
> Hrm, is this a good thing?  Shouldn't you just BUG_ON()
> instead?

There are times where NULL is normal -- such as at the end of an 
iteration to find every instance of a certain type of node, or to follow 
parentage to the root node.  Having ft_node_add() pass the NULL through 
keeps it from being a special case in all of the wrapper code that turns 
the internal node into a phandle before returning.

-Scott
