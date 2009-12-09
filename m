Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78D7AB6F19
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 19:56:48 +1100 (EST)
Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFB03B60EA.0352DA78-ONC1257687.002955A6-C1257687.002A145F@transmode.se>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<1260332399.16132.7.camel@pasglop>
	<OFB03B60EA.0352DA78-ONC1257687.002955A6-C1257687.002A145F@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 19:56:35 +1100
Message-ID: <1260348995.16132.37.camel@pasglop>
Mime-Version: 1.0
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

On Wed, 2009-12-09 at 08:39 +0100, Joakim Tjernlund wrote:
> The later isn't as simple :) I believe the bulk of such code in
> entry_32.S.

Yeah but it would be useful for hash I suppose if one really wants to
boot with nobats. Though at least on hash most of the time we have ways
to recover by mean of MSR:RI being cleared, which your TLB miss code
doesn't check...

> Anyhow, the config option is still valid as if enabled
> it will pin several DTLB's too. Scott had some concerns about removing
> the config option completely so this was the next best thing.

Well, if you want to pin at least one entry, then just remove the #if
completely but don't leave a #if 1 :-)

Cheers,
Ben.
