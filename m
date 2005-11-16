Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 157F468728
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2005 15:26:59 +1100 (EST)
In-Reply-To: <1132108490.5646.67.camel@gaston>
References: <1132032910.23979.6.camel@gaston>
	<00eecfdbd5bccc7b293d847033121eee@freescale.com>
	<1132108490.5646.67.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <02de724e66fe23fd23a3635c8b6f049f@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 15 Nov 2005 23:26:45 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 15, 2005, at 9:34 PM, Benjamin Herrenschmidt wrote:

> What about lwz/stw cropssing page boundaries ? Is this handled in HW ?

Yep.  All of these hardware alignment support features on
the Freescale processors are the reasons they are used
so extensively in data communication processing (where
unaligned data can sometimes occur).  All of the load/store
alignment issues are handled in the cache subsystem, so
to the external world all you really see are cache line
operations.  In the event of uncached data operations, you
get the performance penalty of two bus accesses, where
some of the data is discarded.

	-- Dan
