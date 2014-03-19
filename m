Return-Path: <chenhui.zhao@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CEA462C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 11:08:36 +1100 (EST)
Date: Wed, 19 Mar 2014 08:08:22 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 7/9] fsl: add EPU FSM configuration for deep sleep
Message-ID: <20140319000822.GA9735@localhost.localdomain>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-7-git-send-email-chenhui.zhao@freescale.com>
 <1394582923.13761.81.camel@snotra.buserror.net>
 <20140312083410.GF4706@localhost.localdomain>
 <1394837469.12479.134.camel@snotra.buserror.net>
 <20140317102727.GB6204@localhost.localdomain>
 <1395184882.12479.253.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1395184882.12479.253.camel@snotra.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2014 at 06:21:22PM -0500, Scott Wood wrote:
> On Mon, 2014-03-17 at 18:27 +0800, Chenhui Zhao wrote:
> > On Fri, Mar 14, 2014 at 05:51:09PM -0500, Scott Wood wrote:
> > > On Wed, 2014-03-12 at 16:34 +0800, Chenhui Zhao wrote:
> > > > On Tue, Mar 11, 2014 at 07:08:43PM -0500, Scott Wood wrote:
> > > > > On Fri, 2014-03-07 at 12:58 +0800, Chenhui Zhao wrote:
> > > > > > +	/* Configure the EPU Counters */
> > > > > > +	epu_write(EPCCR15, 0x92840000);
> > > > > > +	epu_write(EPCCR14, 0x92840000);
> > > > > > +	epu_write(EPCCR12, 0x92840000);
> > > > > > +	epu_write(EPCCR11, 0x92840000);
> > > > > > +	epu_write(EPCCR10, 0x92840000);
> > > > > > +	epu_write(EPCCR9, 0x92840000);
> > > > > > +	epu_write(EPCCR8, 0x92840000);
> > > > > > +	epu_write(EPCCR5, 0x92840000);
> > > > > > +	epu_write(EPCCR4, 0x92840000);
> > > > > > +	epu_write(EPCCR2, 0x92840000);
> > > > > > +
> > > > > > +	/* Configure the SCUs Inputs */
> > > > > > +	epu_write(EPSMCR15, 0x76000000);
> > > > > > +	epu_write(EPSMCR14, 0x00000031);
> > > > > > +	epu_write(EPSMCR13, 0x00003100);
> > > > > > +	epu_write(EPSMCR12, 0x7F000000);
> > > > > > +	epu_write(EPSMCR11, 0x31740000);
> > > > > > +	epu_write(EPSMCR10, 0x65000030);
> > > > > > +	epu_write(EPSMCR9, 0x00003000);
> > > > > > +	epu_write(EPSMCR8, 0x64300000);
> > > > > > +	epu_write(EPSMCR7, 0x30000000);
> > > > > > +	epu_write(EPSMCR6, 0x7C000000);
> > > > > > +	epu_write(EPSMCR5, 0x00002E00);
> > > > > > +	epu_write(EPSMCR4, 0x002F0000);
> > > > > > +	epu_write(EPSMCR3, 0x2F000000);
> > > > > > +	epu_write(EPSMCR2, 0x6C700000);
> > > > > 
> > > > > Where do these magic numbers come from?  Which chips are they valid for?
> > > > 
> > > > They are for T1040. Can be found in the RCPM chapter of T1040RM.
> > > 
> > > Then put in a comment to that effect, including what part of the RCPM
> > > chapter.
> > > 
> > > How do you plan to handle the addition of another SoC with different
> > > values?
> > > 
> > > -Scott
> > 
> > Had thought that using an array to put these values (pairs of offset and value)
> > and passing the array to the function.
> 
> Arrays are better than a long sequence of function calls in any case.
> 
> > However, luckily T104x and LS1 have same values for these registers
> > according to the current Reference Manuals.
> 
> If it's likely that the values will remain the same on all chips for the
> near future, then a fancy mechanism to select the array to use can wait
> -- but you should still use an array, and have a comment acknowledging
> the possibility of needing to accommodate different values in the
> future.
> 
> -Scott

OK. Will use an array to pass the values.

-Chenhui
