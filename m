Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4563A67A89
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 08:19:28 +1100 (EST)
In-Reply-To: <00c001c503e6$64369fb0$0301a8c0@chuck2>
References: <20050126185350.20232.qmail@web53804.mail.yahoo.com>
	<BD936D78-6FCC-11D9-A0FB-003065F9B7DC@embeddededge.com>
	<00c001c503e6$64369fb0$0301a8c0@chuck2>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ECCFD7F0-6FDF-11D9-A0FB-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 26 Jan 2005 13:19:12 -0800
To: "Mark Chambers" <markc@mail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Is there a DER for the MPC82xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 26, 2005, at 12:33 PM, Mark Chambers wrote:

> P.S. I've read the BDI manual - I don't see it.  My manual
> says the BDI can only set one hardware breakpoint, and
> stuff like VECTOR CATCH assumes valid memory.

The BDI2000 lets you set as many hardware breakpoints
as the processor supports.  The VECTOR CATCH is equivalent
to setting of the bits in the DER.  I don't know where you
determined it requires valid memory, as it catches the vector
before it starts to execute the instructions in the trap handler.
I don't know the COP details, there may be versions that don't
have sufficient hardware support, and in that case it would
have to be implemented by stuffing breakpoints into all of
the vector tables, but that is just speculation on my part and
have never seen that done.  I've used VECTOR CATCH on
603 cores and had it trap properly before memory was initialized.
Using VECTOR CATCH seems to have no effect on setting
other breakpoints.

Yes, you can manually set bits in the DER and get a different
control over the debugging environment, but you have to
be conscious of what the BDI2000 is also trying to do with
that and other debug registers, too :-)


	-- Dan
