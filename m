Return-Path: <scottwood@freescale.com>
Message-ID: <45D0CEC6.3010209@freescale.com>
Date: Mon, 12 Feb 2007 14:32:06 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
References: <200702121129.05004.sr@denx.de>	<1171281988.20192.1.camel@localhost.localdomain>	<ada7iun8bz3.fsf@cisco.com>	<1171310108.20192.7.camel@localhost.localdomain>
	<E1HGhb3-0001fb-9M@jdl.com>
In-Reply-To: <E1HGhb3-0001fb-9M@jdl.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Roland Dreier <rdreier@cisco.com>, Stefan Roese <sr@denx.de>,
	linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> So, like, the other day Benjamin Herrenschmidt mumbled:
> 
>>Note that there are still things that we might want to change. For
>>example, I think we really should look into adding a macro mecanism
>>and/or an include mecanism to dtc so that we can do things like #include
>><ibm440gp.dtc> to get the base processor/SoC definition and then
>>"overlay" some properties on top of it (like emac phy mode etc...)
> 
> 
> What do people prefer here?  Straight CPP pre-run?
> Direct support built into dtc to do file-inclusion, macros?

Simple textual macros would make it difficult to define 123A and 123B 
SoCs whose device tree nodes are mostly a generic 123, but require a few 
changes in various parts.  I'd rather see dtc support overlaying trees, 
with the "newer" tree able to add, modify, and remove nodes and 
properties from the "older", more generic tree.

Parametric macros (or "template" nodes) might be nice for a few things 
on top of that, though (preferably with better syntax than CPP).

-Scott
