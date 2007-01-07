Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29A64DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 10:05:51 +1100 (EST)
In-Reply-To: <45A175B3.4010506@246tNt.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>		<1166528379.19254.69.camel@localhost.localdomain>		<4587D338.7060906@246tNt.com>		<1166538553.25827.99.camel@pmac.infradead.org>		<1166558300.19254.71.camel@localhost.localdomain>		<1167773388.22068.443.camel@pmac.infradead.org>		<1167773863.6165.82.camel@localhost.localdomain>		<1167775493.3660.23.camel@shinybook.infradead.org>		<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>		<45A01416.6080401@genesi-usa.com>	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>	<45A1535C.1080007@genesi-usa.com>	<f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>
	<45A16FF1.5000401@genesi-usa.com> <45A175B3.4010506@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7f6fe6af734258ea560295a5d2d31884@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
Date: Mon, 8 Jan 2007 00:04:58 +0100
To: Sylvain Munaut <tnt@246tNt.com>
Cc: bbrv@genesi-usa.com, Linux PPC DEV <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The very fact of matching device to driver by their
> "name/type/compatible" list
> is just the way it's done/specified in OF. Unless I'm deeply mistaken

No, you're perfectly right.

> So back to ethernet since you seem to like it ;) If fsl produce a new
> chip (let's call
> it mpc5321) , either it has _exactly_ the same interface (not a single
> difference),
> they you could call it mpc52xx in your device tree.

No, it should be "compatible" = "mpc5321\0mpc52xx", since even
if it *supposedly* works identically, there always could be bugs.
The actual device version is a huge thing to leave out of the
device tree no matter what.

Linux would find it via "mpc52xx", if it has no reason to treat
mpc5321 specially, sure.  The device tree should still express
that information though; it shows information about the hardware
to whoever wants to use it (e.g., Linux), it does not *directly*
tell Linux how to handle the hardware.  This is a good thing.

> If it's different, (even slighty, like it handles frame >2048 for
> example), then
> just give it a new name and add it as supported by the same driver. If
> that's the
> 5321 entry that matched, then allow frames >2048.

Yeah.


Segher
