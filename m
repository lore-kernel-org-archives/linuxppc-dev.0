Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 2EE09DDFCE
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 10:10:34 +1100 (EST)
Date: Wed, 26 Mar 2008 18:09:59 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] scanlog_init cleanup, minor fixes
Message-ID: <20080326230959.GI7137@localdomain>
References: <20080323225144.GA7137@localdomain>
	<1206571210.7482.0.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1206571210.7482.0.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> > +	/* Ideally we could allocate a buffer < 4G */
> > +	data = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
> > +	if (!data)
> > +		goto err;
> 
> Not your bug, but what happens if data is > 4G? Kaboom?

An old RPA doc (scan-log-dump isn't specified in PAPR) says the buffer
should be "contiguous real storage", so... yeah, probably.  That's why
I preserved the comment.  Will fix if I get access to a machine to
test this code more thoroughly (plenty of other issues in this file,
too).
