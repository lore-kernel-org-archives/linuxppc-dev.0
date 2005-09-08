Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15B2168164
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 10:29:12 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050907230324.GC7513@dmt.cnet>
References: <20050907230324.GC7513@dmt.cnet>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 10:28:52 +1000
Message-Id: <1126139332.29803.0.camel@gaston>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] add big endian version of ld_/st_ IO access macros and
	convert main 8xx code to use it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-09-07 at 20:03 -0300, Marcelo Tosatti wrote:
> Hi,
> 
> The following patch adds big endian version of ld_/st_ macros 
> and converts core 8xx code to use them.
> 
> Other than making IO accesses explicit (which is a plus for
> readability), a common set of macros provides a unified place for the
> volatile flag to constraint compiler code reordering.
> 
> There are several unlucky places at the moment which lack the 
> volatile flag.

I'm not fan of the approach. You should use in_/out_ macros for IOs. If
you don't need eieio on 8xx , then just #ifdef it out of the
implementation of these.

Ben.
