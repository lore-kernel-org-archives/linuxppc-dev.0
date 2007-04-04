Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5F10DDE23
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 14:44:23 +1000 (EST)
Subject: Re: [PATCH] Allow drivers to map individual 4k pages to userspace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adamz1odbpr.fsf@cisco.com>
References: <17938.14674.621036.256587@cargo.ozlabs.ibm.com>
	<adar6r0dg0q.fsf@cisco.com>
	<1175657025.30879.45.camel@localhost.localdomain>
	<adamz1odbpr.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 14:43:50 +1000
Message-Id: <1175661830.30879.71.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Joachim Fenkes <fenkes@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 21:07 -0700, Roland Dreier wrote:
> > It's somewhat architected. I doubt there will ever be a processor that
>  > can have an eHCA and doesn't support that trick. The thing is, eHCA is
>  > platform specific, so the remap_4k_pfn would have to be called by driver
>  > specific code, but that's not a problem since that driver will only ever
>  > be used on those platforms that support that call.
> 
> If I'm going off on something irrelevant, just tell me.  But is there
> a chance that you would want to build a kernel that can boot on both a
> platform that has eHCA, and also on some other platform that cannot
> support remap_4k_pfn?  If so does this approach cause problems?

As long as remap_4k_pfn() is only called on the platform that supports
it, it's fine... and if we ever end up having such platforms (we don't
at the moment, remap_4k_pfn() is basically a forced 4K fallback which is
always possible in a machine running a 64K base page kernel), we'll make
it fail at runtime. Again, as long as it's called only by the eHCA
driver, we are pretty certain it will only ever be called on plaforms
where it makes sense.

Ben.
