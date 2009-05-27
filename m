Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id DB746DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 14:01:12 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so2003859ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 21:01:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905262048ma2d5e12s907c489974343280@mail.gmail.com>
References: <20090527002530.16740.62502.stgit@terra>
	<ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
	<9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
	<fa686aa40905262048ma2d5e12s907c489974343280@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 26 May 2009 22:00:51 -0600
Message-ID: <fa686aa40905262100v64a01d41q65ff39ad953305a3@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 9:48 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> First, udelay just burns time, and if the delay is too large, then the
> it is wasting time that could be used for something else. =A0That being
> said, it needs to be balanced with the context switch overhead. =A0If
> the udelay() is less than double the context switch time, then the
> overhead is greater than the time spent spinning.

BTW, lmbench lat_ctx test case tells me that context switch latency is
measured somewhere around 30 to 60 us for user space processes
sleeping on a file descriptor.  That will be lower for kernel threads
since there is no syscall overhead to account for.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
