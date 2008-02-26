Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 99751DDF16
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 02:03:53 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1QF5eMj019325
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 10:05:40 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1QF3ULB1208462
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 10:03:37 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1QF3LmM019410
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 08:03:21 -0700
Date: Tue, 26 Feb 2008 09:02:10 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [RFC][PATCH] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock
	workaround
Message-ID: <20080226090210.6816c130@zod.rchland.ibm.com>
In-Reply-To: <47C41DBE.7090505@harris.com>
References: <1203634340.10422.203.camel@pasglop>
	<20080222192817.GA26211@ru.mvista.com>
	<20080222144919.3ded7c54@weaponx> <47C40548.4080608@ru.mvista.com>
	<47C41DBE.7090505@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Feb 2008 09:10:06 -0500
"Steven A. Falco" <sfalco@harris.com> wrote:

> When I saw Josh's question, I thought the irq save/restore was there to
> make the read-modify-write atomic; i.e. read SDR0_MFR, "AND" out some
> bits, then write it back without the possibility of anything else
> touching SDR0_MFR.  I'm just starting to get familiar with the kernel,

That was probably the intention, yes.

> so if you have a chance, please help educate me.  Does the irq lock in
> mtdcri protect the read-modify-write? Or maybe this R-M-W doesn't need
> protecting?

Nope, it doesn't.  It is possible for something to come in between the
first call to mtdcri and the second call to mtdcri and modify the
value.  The window would be quite small, but I suppose it's
theoretically possible.

Seems the code will do the right thing since everything is using
flags.  I suppose my question can be withdrawn.  It is slightly
confusing to do it that way though.  Perhaps a function to do
read-modify-writes on DCRs would be welcome.  dcr_modify anyone?

josh
