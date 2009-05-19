Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28289DE127
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 07:10:32 +1000 (EST)
Message-ID: <4A131FEF.3080405@freescale.com>
Date: Tue, 19 May 2009 16:09:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] qe: add polling timeout to qe_issue_cmd()
References: <1242761199-17875-1-git-send-email-timur@freescale.com>
	<1242761199-17875-2-git-send-email-timur@freescale.com>
	<1242761199-17875-3-git-send-email-timur@freescale.com>
	<fa686aa40905191310h3ed0efdfn4bd4b4f4b9ca0b7d@mail.gmail.com>
In-Reply-To: <fa686aa40905191310h3ed0efdfn4bd4b4f4b9ca0b7d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Hmmm, the ret value is backwards from what most coders would expect
> (zero on success, non-zero on failure).  I'd personally recommend
> reversing the polarity in the macro.

The ret value is documented as being the value of the expression when the loop terminates.  The reason it appears backwards is because the expression is

	(in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0

That is, the loop should spin until the QE_CR_FLG is zero.  So when the loop terminates normally, the expression (x) == 0 is true, which is equal to one.

I would expect that in most cases, the loop spins until some bit is *set*.  Let's pretend that QE_CR_FLG operates this way.  In that case, the call would look like this:

spin_event_timeout(in_be32(&qe_immr->cp.cecr) & QE_CR_FLG, 100, 0, ret);

At loop termination, the result of the expression will be either QE_CR_FLG or zero.

> Otherwise, feel free to add my acked-by line to both patches.

Thanks.

Ben, would you please apply this to your 'next' branch?

-- 
Timur Tabi
Linux kernel developer at Freescale
