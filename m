Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPLQM2k66zDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:56:27 +1100 (AEDT)
Message-ID: <1458014186.8059.5.camel@ellerman.id.au>
Subject: Re: [PATCH next] cxl: Allow PSL timebase to not sync
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, Frederic Barrat
 <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 15 Mar 2016 14:56:26 +1100
In-Reply-To: <1458001649.12098.59.camel@neuling.org>
References: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1458001649.12098.59.camel@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-15 at 11:27 +1100, Michael Neuling wrote:

> On Mon, 2016-03-14 at 20:29 +0100, Frederic Barrat wrote:

> > CXL driver synchronizes the PSL timebase with the CAPP during
> > initialization. If it can't synchronize, then the driver currently
> > fails and the cxl adapter is not usable. That behavior is a bit
> > extreme for the time being, as some adapters are known to have
> > troubles syncing their PSL timebase and there are no known use of it.
> > 
> > Introduce a psl_timebase module parameter to control whether PSL
> > timebase is required or not. Default is to allow initializaton even
> > if
> > syncing failed.
> > Default behavior will be changed when current issues with some cxl
> > adapters are resolved.
> 
> I'm not happy with doing this unless we add something which advertises
> that it's synced or not to userspace.
> 
> If we do that, I'm happy to just fail without the need of the parameter
> but advertise it to userspace.
> 
> The parameter is a bit of a PITA too, as it's a driver level config not
> card level.  You really want to turn it on/off based on the card, not
> the whole system.

And it just sounds like a big hack around broken hardware, which we'll have to
carry for the foreseeable future.

cheers
