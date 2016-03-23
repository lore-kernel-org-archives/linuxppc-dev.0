Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVR0M4chzzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 21:40:03 +1100 (AEDT)
Message-ID: <1458729597.13990.4.camel@ellerman.id.au>
Subject: Re: pseries/eeh: Handle RTAS delay requests in configure_bridge
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 23 Mar 2016 21:39:57 +1100
In-Reply-To: <1458701571.5945.8.camel@russell.cc>
References: <3qV9fR1t3Bz9sDb@ozlabs.org> <1458701571.5945.8.camel@russell.cc>
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

On Wed, 2016-03-23 at 13:52 +1100, Russell Currey wrote:
> On Wed, 2016-03-23 at 11:38 +1100, Michael Ellerman wrote:
> > On Tue, 2016-22-03 at 00:34:55 UTC, Russell Currey wrote:
> > >
> > > +		case RTAS_EXTENDED_DELAY_MIN+2:
> > > +			mwait = 100;
> > > +			break;
> > > +		default:
> > > +			goto err;
> > > +		}
> > > +
> > > +		max_wait -= mwait;
> > > +		msleep(mwait);

> > Can you use rtas_busy_delay() ?
>
> Wasn't aware of that, makes life a lot easier.  Do you know if the 0.2s
> maximum delay also applies across the board?  I definitely want to enforce
> it here, but if it is ubiquitous then it should be in rtas_busy_delay.

Not sure sorry, you'll have to read PAPR :)

cheers
