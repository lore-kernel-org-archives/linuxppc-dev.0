Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F411567AC6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 03:23:27 +1000 (EST)
In-Reply-To: <20050506170809.GC19401@gate.ebshome.net>
References: <427B22A0.8010704@ru.mvista.com>
	<20050506081805.GA19401@gate.ebshome.net>
	<427B3465.1070502@ru.mvista.com>
	<20050506170809.GC19401@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7ad6626ea88c1e1ec98d310f4db438f7@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 6 May 2005 13:23:21 -0400
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2] Updated platform additions for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 6, 2005, at 1:08 PM, Eugene Surovegin wrote:

> Yeah, it's better, I'm only wondering what if some board has separate
> PHY interrupt lines for each FCC? Define name - "PHY_INTERRUPT" was
> chosen quite badly IMHO :).

One of my feature_calls is:
	embed_feature_call(CPM_FTR_FCC1, REQ_FTR_PHY_INT, &irq)

and so on for every Ethernet port.  This presents my current coding
challenge, do I want this to be a varargs function or we just always 
have
three parameters, where the last one is ignored if not necessary, a
pointer for an out value, or a pointer to a data structure for more
complex information.  Right now I have it coded as always three
parameters.

In addition, this feature call will set up whatever interrupt routing
is necessary.  The driver only needs to check if a value is returned,
if not, no interrupt.  It also may want to test if the returned irq is 
the
same for all PHYS, since it may be needed in the interrupt handler.

Thanks.

	-- Dan
