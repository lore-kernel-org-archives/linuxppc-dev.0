Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED9EFB7B68
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 03:12:56 +1100 (EST)
In-Reply-To: <OF76EB2F89.E66EDF7B-ONC125766E.00687237-C125766E.006921DF@transmode.se>
References: <1258195348-2861-1-git-send-email-Joakim.Tjernlund@transmode.se>	<1258195348-2861-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-3-git-send-email-Joakim.Tjernlund@transmode.se>	<1258195348-2861-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-5-git-send-email-Joakim.Tjernlund@transmode.se>	<8F89F37D-4EC1-4B1B-AA89-5BFF5707E5F8@embeddedalley.com>
	<OF76EB2F89.E66EDF7B-ONC125766E.00687237-C125766E.006921DF@transmode.se>
Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
Message-ID: <OFE90CBB76.746C0038-ONC125766F.00586C10-C125766F.0058A227@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 15 Nov 2009 17:08:06 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Dan Malek <dan@embeddedalley.com> wrote on 14/11/2009 19:08:43:
> > On Nov 14, 2009, at 2:42 AM, Joakim Tjernlund wrote:
> >
> > > ..... Avoid this by always pinning
> > > kernel instruction TLB space.
> >
> > You may as well map the data space, too, since you have
> > reserved the entries.  Take advantage of that performance.

Just to be clear, I don't reserve and DTLB entries(I think).
That remains under the config flag.

> > Also, some processor variants have very few TLB entries,
> > and may only reserve two entries (although the flag says
> > reserve 4).  Ensure there are sufficient resources to do
> > what you want.  This is the reason the option is configurable.
>
> Scott had some concerns about pinning the data space too. That is
> is why I left the data TLB pinning behind the the config option.
>
> How to make better use of the remaining ITLB slots is tricky.
> Somehow one would want to map at lest one to modules but I cannot see how.
>
