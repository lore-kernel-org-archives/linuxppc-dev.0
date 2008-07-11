Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DB4D8DDF05
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 05:15:03 +1000 (EST)
Date: Fri, 11 Jul 2008 23:15:02 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping, otherwise
	kernel will oops
Message-ID: <20080711191502.GA21847@polina.dev.rtsoft.ru>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<20080711182323.GB15321@secretlab.ca> <4877ADF6.8070702@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4877ADF6.8070702@scram.de>
Cc: khali@linux-fr.org, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 11, 2008 at 09:01:10PM +0200, Jochen Friedrich wrote:
> Hi Grant,
> 
> > What is the reason that info.irq is set to -1 in the first place?  This
> > looks like another bug to me.  Does something in the i2c layer depend on
> > the -1 value?
> 
> Nope, it was a bug in the i2c documentation fixed recently:

Nope? I'm looking into i2c-core.c:

.. i2c_new_device(...)
{
	client->irq = info->irq;

Core will blindly pass irq, so clients should ensure that irq contains
correct value. And as far as there is no common scheme of checking that
"there is no irq specified", the most safe option is -1.

> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8e29da9ee8958cc17e27f4053420f1c982614793

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
