Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5A2BDE0E6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 09:31:07 +1100 (EST)
In-Reply-To: <45B7D78E.5020704@freescale.com>
References: <20070124210709.GF10527@ld0162-tx32.am.freescale.net>
	<4EF444AA-B7C0-460D-BA0A-EEDC9E2E4812@kernel.crashing.org>
	<45B7D78E.5020704@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C498DBDF-5413-46CA-9A11-B625B009B53A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/18] Make ft_node_add() accept and return NULL.
Date: Wed, 24 Jan 2007 23:30:53 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Currently, if ft_node_add() is passed NULL it will allocate an   
>>> entry for
>>> it and return a non-NULL phandle.  This patch makes it simply  
>>> pass the
>>> NULL through.
>> Hrm, is this a good thing?  Shouldn't you just BUG_ON()
>> instead?
>
> There are times where NULL is normal -- such as at the end of an  
> iteration to find every instance of a certain type of node, or to  
> follow parentage to the root node.  Having ft_node_add() pass the  
> NULL through keeps it from being a special case in all of the  
> wrapper code that turns the internal node into a phandle before  
> returning.

But doesn't ft_add_node() add a node to the tree?  If so,
a NULL is most likely a program error. If not, some name
change is in order /me thinks ;-)


Segher
