Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 3D17FDDEFC
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 23:08:47 +1100 (EST)
Date: Thu, 5 Feb 2009 11:51:00 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Mike Ditto <mditto@consentry.com>
Subject: Re: Calling wait_event_interruptible_timeout() in I2C wait functions
Message-ID: <20090205115100.GD422@sirena.org.uk>
References: <49889CFA.7070308@freescale.com> <4989F3F4.7070207@consentry.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4989F3F4.7070207@consentry.com>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 04, 2009 at 12:00:52PM -0800, Mike Ditto wrote:
> Timur Tabi wrote:
> > However, it appears that this is not common behavior for I2C driver.  In
> > fact, only these six drivers ever call wait_event_interruptible_timeout():

> > i2c-cpm.c

> I don't know about the others, but in i2c-cpm.c the use of interruptible
> wait seems incorrect.  Maybe it could be made correct, but as is, it
> does not correctly clean up the hardware state or return a useful
> value when interrupted by a signal.  It's not clear what to do, anyway -

This is exactly the problem for users that caused Timur to run into this
- further up the stack we're trying to do cleanup that involves writing
via I2C but the I2C writes error out due to the signal.

> handling (one second delay in the unlikely worst case for i2c-cpm).

Ditto for the Freescale PowerPC I2C driver.
