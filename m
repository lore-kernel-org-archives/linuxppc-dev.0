Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id 58F7EB6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 21:40:45 +1000 (EST)
Date: Tue, 9 Aug 2011 06:40:43 -0500
From: Robin Holt <holt@sgi.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC 4/4] [powerpc] Add flexcan device support for p1010rdb.
Message-ID: <20110809114043.GN4926@sgi.com>
References: <1312869313-22434-1-git-send-email-holt@sgi.com>
	<1312869313-22434-5-git-send-email-holt@sgi.com>
	<20110809063319.GK4926@sgi.com> <4E40DDA5.1050004@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E40DDA5.1050004@grandegger.com>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2011 at 09:11:33AM +0200, Wolfgang Grandegger wrote:
> > +	return &p1010_rdb_system_clock;
> 
> Just returning fsl_get_sys_freq() here would already be fine. I'm also
> missing the factor of two here:
> 
>         return fsl_get_sys_freq() / 2; ????

I am working on the other comments right now as well, but this one
brought up a good question.  The old algorithm in the original freescale
patches I started with actually did, essentially:

	...clock.freq = DIV_ROUND_CLOSEST(fsl_get_sys_freq() / 2, 1000) * 1000

The end result was before:
	...clock.freq=0x0bebc200
After:
	...clock.freq=0x0bebc1fe

Is that rounding relavent?

Thanks,
Robin
