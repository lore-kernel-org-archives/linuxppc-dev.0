Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69342DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 06:50:24 +1100 (EST)
Date: Fri, 6 Feb 2009 11:49:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH 1/1] edac: new ppc4xx driver module
Message-Id: <20090206114947.ea86ee58.akpm@linux-foundation.org>
In-Reply-To: <C5B1D239.14743%gerickson@nuovations.com>
References: <20090130140520.ca1b2b8e.akpm@linux-foundation.org>
	<C5B1D239.14743%gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 06 Feb 2009 11:40:41 -0800
Grant Erickson <gerickson@nuovations.com> wrote:

> On 1/30/09 2:05 PM, Andrew Morton wrote:
> > On Fri, 30 Jan 2009 09:54:42 -0700 dougthompson@xmission.com wrote:
> >> From: Grant Erickson <gerickson@nuovations.com>
> > 
> > Perhaps a powerpc mailing list should have been cc'ed?
> 
> The first round patch went to Doug, the BlueSmoke (EDAC) mailing list and
> the Linux/PowerPC mailing list. However, because the original patch was
> split in two, subsequent revisions of just the EDAC piece went to Doug and
> BlueSmoke. Doug then forwarded it to linux-kernel.
> 
> What's the preferred sign-off, ACK chain for this subsystem? Through
> PowerPC/4xx or PowerPC GIT upstream or through you and -mm upstream?

I don't trust those guys ;)

I'd merge it via -mm, while cc'ing various random powerpc personalities.

> >> +static void
> >> +ppc4xx_edac_handle_ce(struct mem_ctl_info *mci,
> >> +        const struct ppc4xx_ecc_status *status)
> >> +{
> >> + int row;
> >> + char message[PPC4XX_EDAC_MESSAGE_SIZE];
> > 
> > 256 bytes on the stack is getting a bit large.
> 
> Would you characterize this as a "getting a bit large, but still OK" or
> "getting a bit large, this MUST be changed"?

The former.
