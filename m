Return-Path: <khali@linux-fr.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by ozlabs.org (Postfix) with ESMTP id DB40EB7B88
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 20:49:51 +1100 (EST)
Date: Tue, 13 Oct 2009 11:49:48 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: i2c-powermac fails
Message-ID: <20091013114948.03608b7f@hyperion.delvare>
In-Reply-To: <1255426348.2192.187.camel@pasglop>
References: <20091013112304.74083fd1@hyperion.delvare>
	<1255426348.2192.187.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Tim Shepard <shep@alum.mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Oct 2009 20:32:28 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2009-10-13 at 11:23 +0200, Jean Delvare wrote:
> > Hi Ben, Paul,
> > 
> > I had a report by Tim Shepard (Cc'd) that the therm_adt746x driver
> > sometimes fails to initialize on his PowerBook G4 running kernel
> > 2.6.31. The following error message can be seen in the logs when the
> > failure happens:
> > 
> > therm_adt746x 7-002e: Thermostat failed to read config!
> > 
> > After enabling low-level i2c debugging, it turns out that the problem
> > is caused by low-level errors at the I2C bus level:
> 
> Nothing comes to mind immediately, but I'll have another look tomorrow.
> 
> Maybe we are configuring the i2c bus too fast ? Another possibility
> would be that the device needs some retries ...

I guess that retrying would work around the problem, yes. But I do not
think this is the proper solution. If retries were needed, they would
be needed all the time, not just at initialization time. And as I said,
the SMBus specification says that devices have to always ack their
slave address (they can always delay the transaction later if they need
more time) so I am reasonably certain that the ADT7467 does ack his
address always. If it seems otherwise, this suggests that either the
message was not properly sent on the bus (so the ADT7467 did not have
anything to ack), or the ADT7467's ack went on the bus but the I2C
master didn't see it.

I2C bus being setup too fast sounds more likely. It might be worth
adding an arbitrary delay after initialization, just to see if it
helps. Not sure where though, as I'm not familiar with the Powermac
initialization steps. Maybe right before i2c_add_adapter() in
i2c_powermac_probe?

-- 
Jean Delvare
