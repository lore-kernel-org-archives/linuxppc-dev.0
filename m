Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB71AB6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 01:15:47 +1000 (EST)
Subject: Re: [PATCH 3/3] powerpc: icswx: Simple ACOP fault handler for both
	book3e and book3s parts.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <500B0F0F-658A-4B95-8BEC-978D738A926F@kernel.crashing.org>
References: <1312842408-21482-1-git-send-email-jimix@pobox.com>
	<1312842408-21482-4-git-send-email-jimix@pobox.com>
	<500B0F0F-658A-4B95-8BEC-978D738A926F@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Aug 2011 10:15:29 -0500
Message-ID: <1312902929.29273.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-09 at 00:26 -0500, Kumar Gala wrote:

> > +	/* Some implementations leave us a hint for the CT */
> > +	ct = ICSWX_GET_CT_HINT(error_code);
> > +	if (ct < 0) {
> > +		/* we have to peek at the instruction work to figure out CT */
> > +		union cop_ccw ccw;
> 
> don't use a union, we don't do this for any other place we decode instructions (just use shift/mask).  Utilize ppc-opcode.h

Except that the union here is -not- the instruction, but the content of
the RS register :-)

Cheers,
Ben.
