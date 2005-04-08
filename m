Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7167567B24
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 12:10:08 +1000 (EST)
In-Reply-To: <20050407193846.GE19449@logos.cnet>
References: <20050407120013.GF14822@logos.cnet>
	<BCEFJBPJCGFCNMMMIDBHGEGHCLAA.Joakim.Tjernlund@lumentis.se>
	<20050407193846.GE19449@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <19116173cb07648317c2a73a9c822c70@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 7 Apr 2005 22:09:58 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 7, 2005, at 3:38 PM, Marcelo Tosatti wrote:

> Would be nice to have someone from 8xx team look into this?

I'll look into it and find some solution.  I suspect it is an
interaction with the previous TLB miss and the behavior
of the dcbst TLB look up.  Perhaps, if we ensure the
TLB entry is not valid at the time of the dcbst, it will work.
This is why the tlbie() I added as a hack a long time
ago made the "problem" disappear.  The other dcbxx
instructions in the code work on already existing pages,
while this one is a special case of a miss on a page
that doesn't exist.

Thanks.

	-- Dan
