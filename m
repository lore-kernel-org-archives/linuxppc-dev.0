Return-Path: <scottwood@freescale.com>
Message-ID: <46CB0E56.2020601@freescale.com>
Date: Tue, 21 Aug 2007 11:09:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
	<20070821023044.GF15469@localhost.localdomain>
In-Reply-To: <20070821023044.GF15469@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Mon, Aug 20, 2007 at 12:39:49PM -0500, Scott Wood wrote:
> 
>>1. ft_create_node was returning the internal pointer rather than a phandle.
>>2. ft_find_device_rel was treating a "top" phandle of NULL as an error,
>>rather than as the root of the tree.
>>3. Return the node's name when getprop() is called with the "name"
>>property.
> 
> 
> Hrm.  I'm not convinced.  (1) certainly needs fixing.  (2) is kind of
> unclear - there is an ft_find_device() after all for doing root-based
> searches.

The point of #2 was as part of the fix to #1 -- otherwise, the same 
check for NULL would have to be moved into ft_create_node to 
conditionally call ft_find_device or ft_find_device_rel.

The non-relative function should probably be removed, though.

>  (3) I really dislike;  I just don't see the point.

It's needed by dt_get_path().

-Scott
