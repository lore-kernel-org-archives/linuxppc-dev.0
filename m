Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id 89220B7B80
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 01:05:16 +1100 (EST)
Date: Thu, 15 Oct 2009 16:05:13 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: i2c-powermac fails
Message-ID: <20091015160513.5c356b7e@hyperion.delvare>
In-Reply-To: <1255605559.2347.102.camel@pasglop>
References: <20091013112304.74083fd1@hyperion.delvare>
	<1255426348.2192.187.camel@pasglop>
	<20091013114948.03608b7f@hyperion.delvare>
	<20091014230252.0d0cba8d@hyperion.delvare>
	<1255555575.2347.56.camel@pasglop>
	<20091015124923.23863a94@hyperion.delvare>
	<1255605559.2347.102.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Tim Shepard <shep@alum.mit.edu>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Oct 2009 22:19:19 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2009-10-15 at 12:49 +0200, Jean Delvare wrote:
> > Oh. Well, if that was the case, we would see errors all the time, not
> > just during initialization, right? Or does the I2C clock frequency
> > change over time somehow?
> 
> No but maybe we are a bit on the "limit" of the device and some
> registers take long to respond than others ?

Unlikely. The ADT7460 can run at I2C clock rates up to 400 kHz while
the Keywest I2C runs at 25, 50 or 100 kHz if I read the code properly.
I don't know what exact speed is used on Tim's system, apparently it is
read from the hardware in the device tree directly?

We could have low_i2c.c log the I2C clock frequency and/or try to force
the lowest speed (25 kHz) and see if it helps, but I very much doubt
it. And I'd rather wait for Tim to report the result with my last patch
first.

-- 
Jean Delvare
