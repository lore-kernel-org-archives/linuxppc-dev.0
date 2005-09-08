Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17B1468162
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 11:03:34 +1000 (EST)
Date: Wed, 7 Sep 2005 21:58:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050908005821.GB8882@dmt.cnet>
References: <20050907230324.GC7513@dmt.cnet> <1126139332.29803.0.camel@gaston>
	<00a1f47bb2edbbc001c2267191aa36f0@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00a1f47bb2edbbc001c2267191aa36f0@embeddededge.com>
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

On Wed, Sep 07, 2005 at 08:42:42PM -0400, Dan Malek wrote:
> 
> On Sep 7, 2005, at 8:28 PM, Benjamin Herrenschmidt wrote:
> 
> >I'm not fan of the approach. You should use in_/out_ macros for IOs. If
> >you don't need eieio on 8xx , then just #ifdef it out of the
> >implementation of these.
> 
> Yeah, #ifdef :-)  That patch wouldn't go anywhere (well,
> to /dev/null perhaps).

Well, its easy to s/st/out/ - s/ld/in/, so its still a useful patch. ;)

> We can just use the in_/out_ macros that are there.  The eieio
> doesn't hurt anything on the 8xx.

eieio/isync are not required. There's no need to execute redudant
instructions and occupy kernel space.
