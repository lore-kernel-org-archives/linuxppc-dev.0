Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVmg737xnzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 10:56:19 +1100 (AEDT)
Message-ID: <1458777374.5888.3.camel@russell.cc>
Subject: Re: pseries/eeh: Handle RTAS delay requests in configure_bridge
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 24 Mar 2016 10:56:14 +1100
In-Reply-To: <1458729597.13990.4.camel@ellerman.id.au>
References: <3qV9fR1t3Bz9sDb@ozlabs.org> <1458701571.5945.8.camel@russell.cc>
 <1458729597.13990.4.camel@ellerman.id.au>
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

On Wed, 2016-03-23 at 21:39 +1100, Michael Ellerman wrote:
> On Wed, 2016-03-23 at 13:52 +1100, Russell Currey wrote:
> > 
> > On Wed, 2016-03-23 at 11:38 +1100, Michael Ellerman wrote:
> > > 
> > > On Tue, 2016-22-03 at 00:34:55 UTC, Russell Currey wrote:
> > > > 
> > > > 
> > > > +		case RTAS_EXTENDED_DELAY_MIN+2:
> > > > +			mwait = 100;
> > > > +			break;
> > > > +		default:
> > > > +			goto err;
> > > > +		}
> > > > +
> > > > +		max_wait -= mwait;
> > > > +		msleep(mwait);
> > 
> > > 
> > > Can you use rtas_busy_delay() ?
> > Wasn't aware of that, makes life a lot easier.  Do you know if the 0.2s
> > maximum delay also applies across the board?  I definitely want to
> > enforce
> > it here, but if it is ubiquitous then it should be in rtas_busy_delay.
> Not sure sorry, you'll have to read PAPR :)
It doesn't mention anything, but I was more concerned about whether it's
ever sensible to have that much of a sleep in any case.  Probably safe to
ignore given it hasn't been a problem up to this point.
> 
> cheers
> 
