Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D4E267BA8
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 10:28:10 +1000 (EST)
Subject: Re: [PATCH] fix gettimeofday vs. update_gtod race
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20060817001807.GB354@localdomain>
References: <20060811204105.GK3233@localdomain>
	<1155772134.11312.119.camel@localhost.localdomain>
	<20060817001807.GB354@localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 02:27:57 +0200
Message-Id: <1155774477.11312.137.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-16 at 19:18 -0500, Nathan Lynch wrote:

> No?  I didn't find anything about mftb having synchronizing
> behavior.  How should we ensure that temp_varp is assigned before
> reading the timebase?

I sync an isync would be enough.

> Surely at least a compiler barrier is needed?

Yeah.

> > and the race not completely closed imho... 
> 
> How so?  I could've missed something, but I've hammered the patch
> pretty hard, fwiw.

Nah you are right, but you may be using a too big hammer

> > I need to think about it a bit more closely but what about instead
> > just check if tb_ticks goes negative, and if yes, just do get_tb()
> > again ?  That might be faster than having a sync in there and should
> > still be correct.
> 
> I did try something like that but found that a loop (i.e. multiple
> get_tb's to "catch up") was necessary.

Hrm... even with an isync ?

Ben.
