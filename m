Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 77B9A474CE
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 07:00:54 +1100 (EST)
Message-ID: <4989F3F4.7070207@consentry.com>
Date: Wed, 04 Feb 2009 12:00:52 -0800
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Timur Tabi <timur@freescale.com>
Subject: Re: Calling wait_event_interruptible_timeout() in I2C wait functions
References: <49889CFA.7070308@freescale.com>
In-Reply-To: <49889CFA.7070308@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> However, it appears that this is not common behavior for I2C driver.  In
> fact, only these six drivers ever call wait_event_interruptible_timeout():
> 
> i2c-cpm.c

I don't know about the others, but in i2c-cpm.c the use of interruptible
wait seems incorrect.  Maybe it could be made correct, but as is, it
does not correctly clean up the hardware state or return a useful
value when interrupted by a signal.  It's not clear what to do, anyway -
it's hard to know which messages of the interrupted transaction have
actually taken effect in the hardware.  I think it's better to use
uninterruptible wait here and just live with the delayed signal
handling (one second delay in the unlikely worst case for i2c-cpm).

In general, I think it's best to consider I2C I/O to be uninterruptible,
like disk I/O.  The only reason to make it interruptible is to make
sure you don't end up with an unkillable process due to an I/O error,
and that is adequately handled by a timeout (and re-initialization of
the I2C interface in that case).

					-=] Mike [=-
