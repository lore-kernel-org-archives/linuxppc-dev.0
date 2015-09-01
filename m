Return-Path: <ananth@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 676381A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 16:42:12 +1000 (AEST)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A251E14076A
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2015 16:42:11 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 1 Sep 2015 00:42:08 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1C4013E4003F
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2015 00:42:07 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t816evSe35979512
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2015 23:41:05 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t816fXq3007579
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2015 00:41:34 -0600
Date: Tue, 1 Sep 2015 12:11:13 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, ego@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc: Add user-return-notifier support
Message-ID: <20150901064113.GA1196@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20150825054110.GD3815@in.ibm.com>
 <20150831103517.96D1A1401E7@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150831103517.96D1A1401E7@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 31, 2015 at 08:35:17PM +1000, Michael Ellerman wrote:
> On Tue, 2015-25-08 at 05:41:10 UTC, Ananth N Mavinakayanahalli wrote:
> > Add user return notifier support for powerpc. Similar to x86, this feature
> > keys off of the KVM Kconfig.
> 
> Please flesh this out.
> 
> What is it, why do we want it, why is your implementation correct.

The only current in-kernel user of the infrastructure is KVM on x86. It
is useful for optimizations when MSR values can continue to be used
between the host and guest. Commit log for 18863bdd60f8 upstream has a
more complete explanation.

I do not know the inner details of the KVM implementation on Power,
perhaps Paul/Gautham can comment on if a similar optimization will
benefit Power systems too?

We could certainly make this a generic config option.. but I am yet to
see a real usecase outside of the KVM thingy. We do use TIF_UPROBE for
something very similar, though that needs to fire much before the
outstanding signals get handled. The user-return notifier is the last
thing executed before return to userspace -- the two cannot be merged.

Ananth

PS: I am not sure having an 'ok' against the Documentation/features/ for
powerpc is a valid enough argument for this :-)
