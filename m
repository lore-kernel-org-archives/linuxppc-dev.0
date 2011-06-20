Return-Path: <mlcreech@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5EE56B6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jun 2011 01:20:49 +1000 (EST)
Received: by vws20 with SMTP id 20so2728226vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jun 2011 08:20:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110617163442.204348a0@schlenkerla.am.freescale.net>
References: <BANLkTikyKObukzVw+c10HyDz+Q=PH4jozA@mail.gmail.com>
	<20110617163442.204348a0@schlenkerla.am.freescale.net>
Date: Mon, 20 Jun 2011 11:20:45 -0400
Message-ID: <BANLkTik7W-9mLOAUCU20O9+KXCimL6Y1+g@mail.gmail.com>
Subject: Re: NAND BBT corruption on MPC83xx
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	mhench@elutions.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2011 at 5:34 PM, Scott Wood <scottwood@freescale.com> wrote:
>
> As for the corruption, could it be degradation from repeated reads of that
> one page?
>

Could be.  I think Mike's theory was that the -1 page_addr sort of
"wrapped around", and caused us to read in the last block on flash
each time NAND_CMD_PAGEPROG was performed.  So with a lot of writes
happening, we could end up with a BBT that looks like this.

That makes sense I guess, since set_addr() in fsl_elbc_nand.c uses
page_addr to set FBAR.  I don't see anything about it in the manual,
but if FBAR wraps beyond the end of the chip, maybe the bits that
don't make sense are simply ignored.  (In which case we should
probably add a check in set_addr() to prevent anything like this in
the future)

In theory I should be able to prove it out by running 2 devices in
parallel - one with that block of code still there, and one with it
removed.  If the former device sees bit-flips in the BBT and the
latter one doesn't, we'll be sure of the culprit.  I'll try this and
come back with the results.

Thanks!

-- 
Matthew L. Creech
