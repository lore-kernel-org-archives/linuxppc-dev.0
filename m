Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93F6468665
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 04:11:52 +1100 (EST)
In-Reply-To: <20051107112424.GE15522@logos.cnet>
References: <20051107112424.GE15522@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a4ca39fa7ebdefb0aed21af16f5d20c4@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 7 Nov 2005 12:17:46 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Edson Seabra <edson.seabra@cyclades.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: BDI and 85xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 7, 2005, at 6:24 AM, Marcelo Tosatti wrote:

> Edson had to patch this in to get BDI to work on 85xx with 2.6.14.

How about we just change MSR_KERNEL and MSR_USER
in the include file #define instead of all of this run-time code?
Or, change the code so it preserves DE in general, so we don't
need a special kernel configuration just for the BDI?

The original reason I did the BDI_SWITCH was due to the
overhead of tracking user PTE switches in the context switch
code.  I don't like the way this has been overloaded to mean
"BDI general operation."  We should be able to attach a BDI2000
to any kernel configuration and always get kernel debugging
capability.  The BDI_SWITCH was to enable the extra feature
(with some overhead) of debugging into user applications,
it never should have affected any kernel debug operation.

It's unfortunate that Book-E is such a PITA for debuggers,
but let's please find a better way of using these features.
Separate kernel configurations to enable hardware
debugging isn't acceptable.

Thanks.

	-- Dan
