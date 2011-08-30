Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0F21B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 16:22:09 +1000 (EST)
Subject: Re: [PATCH] PSeries: Cancel RTAS event scan before firmware flash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Suzuki Poulose <suzuki@in.ibm.com>
In-Reply-To: <1314685198.2488.83.camel@pasglop>
References: <20110727120801.10429.7276.stgit@localhost6.localdomain6>
	<1314684237.2488.77.camel@pasglop>  <4E5C806C.1070809@in.ibm.com>
	<1314685198.2488.83.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Aug 2011 16:21:41 +1000
Message-ID: <1314685301.2488.84.camel@pasglop>
Mime-Version: 1.0
Cc: mikey@neuling.org, "Ravi K. Nittala" <ravi.nittala@in.ibm.com>,
	sbest@us.ibm.com, antonb@au1.ibm.com, subrata.modak@in.ibm.com,
	ranittal@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	divya.vikas@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-30 at 16:19 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2011-08-30 at 11:47 +0530, Suzuki Poulose wrote:
> > >
> > 
> > The flash operation is performed in the reboot path at the very end.
> > So, even if we restart the event scan, the thread may not be able to
> > process
> > the events. Hence we thought we would leave it stopped.
> > 
> > Again, we do not have much expertise in deciding which is the best
> > thing to do.
> > We could resume the event scan, if you think that is needed.
> > 
> > Thanks for the review. 
> 
> No that's ok, I'll merge the patch as-is then.

Actually, please dbl check you get the dependencies right. The event
scan stuff is only compiled if CONFIG_PPC_RTAS_DAEMON is set, but the
rtas flash code depends on a different config option that can be set
independently.

So at the very least you need an ifdef to guard the cross-call

Cheers,
Ben.
