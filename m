Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id B953DB6EE8
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 22:44:21 +1000 (EST)
Received: by bwz19 with SMTP id 19so1057371bwz.15
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 05:44:19 -0700 (PDT)
Date: Tue, 29 Jun 2010 16:44:15 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH]460EX on-chip SATA driver<kernel 2.6.33><resubmission>
Message-ID: <20100629124415.GA32738@oksana.dev.rtsoft.ru>
References: <201006041226.o54CQH2V017366@amcc.com>
	<201006290333.50673.marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <201006290333.50673.marek.vasut@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	sr@denx.de, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 29, 2010 at 03:33:50AM +0200, Marek Vasut wrote:
> Dne Pá 4. června 2010 14:26:17 Rupjyoti Sarmah napsal(a):
> > This patch enables the on-chip DWC SATA controller of the AppliedMicro
> > processor 460EX.
> > 
> > Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com>
> > Signed-off-by: Mark Miesfeld <mmiesfeld@appliedmicro.com>
> > Signed-off-by: Prodyut Hazarika <phazarika@appliedmicro.com>
> > 
> 
> --SNIP--
> 
> > +		dev_err(ap->dev, "%s: Command not pending cmd_issued=%d "
> > +			"(tag=%d) DMA NOT started\n", __func__,
> > +			hsdevp->cmd_issued[tag], tag);
> 
> Just a nitpick, but don't break strings if possible.

Note that in this particular case breaking strings was OK, and
was actually done in a clever manner.

That is, I doubt that anyone grep for error messages with
regexps, so grep "Command not pending" or grep "DMA NOT started"
would work.

This makes the code more readable (literally, because you don't
have to scroll to see dev_err's arguments) without sacrificing
grep'ability.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
