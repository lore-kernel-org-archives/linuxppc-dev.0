Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.224])
	by ozlabs.org (Postfix) with ESMTP id 75465DE15F
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 03:43:17 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so3285071qbc.37
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 10:43:16 -0700 (PDT)
Date: Thu, 3 Jul 2008 11:42:29 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [V2] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Message-ID: <20080703174229.GL2284@secretlab.ca>
References: <20080703164235.37739A006B@mail196-wa4.bigfish.com>
	<20080703132305.ZZRA012@mailhub.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080703132305.ZZRA012@mailhub.coreip.homeip.net>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Sadanand <sadanan@xilinx.com>, linuxppc-dev@ozlabs.org,
	linux-input@vger.kernel.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2008 at 01:27:00PM -0400, Dmitry Torokhov wrote:
> Hi John,
> 
> On Thu, Jul 03, 2008 at 09:42:31AM -0700, John Linn wrote:
> > +
> > +	/* Initialize the PS/2 interface */
> > +	mutex_lock(&drvdata->cfg_mutex);
> > +	if (xps2_initialize(drvdata)) {
> > +		mutex_unlock(&drvdata->cfg_mutex);
> > +		dev_err(dev, "Could not initialize device\n");
> > +		retval = -ENODEV;
> > +		goto failed3;
> > +	}
> > +	mutex_unlock(&drvdata->cfg_mutex);
> 
> The drvdata is allocated per-port and so both (there are 2 PS/2 ports,
> right?) ports get their own copy of cfg_mutex. Since you are trying to
> serialze access to resource shared by both ports it will not work.
> The original driver-global mutex was appropriate (the only thing I
> objected there was use of a counting semaphore instead of a mutex).

John, correct me if I'm wrong, but I don't think there are any shared
resources being accessed here and I believe the mutex is entirely
unnecessary.

Cheers,
g.
