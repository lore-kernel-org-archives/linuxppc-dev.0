Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id C2739DDEDC
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 15:21:55 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4136009wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 22:21:55 -0700 (PDT)
Date: Fri, 11 Jul 2008 23:21:49 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH v2 4/5] spi: Add OF binding support for SPI busses
Message-ID: <20080712052149.GA23213@secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010313.26187.99119.stgit@trillian.secretlab.ca>
	<9e4733910807022002n3c739c7cs8ed642e4a6027bb6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807022002n3c739c7cs8ed642e4a6027bb6@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 11:02:23PM -0400, Jon Smirl wrote:
> On 7/2/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> >  This patch adds support for populating an SPI bus based on data in the
> >  OF device tree.  This is useful for powerpc platforms which use the
> >  device tree instead of discrete code for describing platform layout.
> >
> >  Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >  ---
> >  +               /* Select device driver */
> >  +               sprop = of_get_property(nc, "linux,modalias", &len);
> >  +               if (sprop && len > 0)
> >  +                       strncpy(spi->modalias, sprop, KOBJ_NAME_LEN);
> >  +               else
> >  +                       strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN);
> 
> You're missing a request_module("%s", info.type) to make sure the
> module is loaded.
> 
> It might make sense to share code with of_find_i2c_driver() so we have
> a common way of guessing module names.

You're right.  I've refactored the i2c code to make it usable by SPI
also.  I'll post the new patch series this evening.

g.
