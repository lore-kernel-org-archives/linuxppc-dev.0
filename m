Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jefynz0zvr.fsf@sykes.suse.de>
References: <1136695956.30123.44.camel@localhost.localdomain>
	<jefynz0zvr.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 08:03:33 +1100
Message-Id: <1136754214.30123.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Fix PowerMac sound i2c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-01-08 at 11:37 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > My patch reworking the PowerMac i2c code break the sound drivers as they
> > used to rely on some broken behaviour of i2c-keywest that is gone now.
> 
> I'm not sure, but from looking at the other i2c drivers I'd rather think
> that the old behaviour of i2c-keywest was correct.  There are only a few
> that implement both I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_I2C_BLOCK_DATA, but
> none of them write the length byte together with the data.  The commands
> are ony different in behaviour when reading: with I2C_SMBUS_I2C_BLOCK_DATA
> a fixed sized block is read from the bus, whereas with
> I2C_SMBUS_BLOCK_DATA the size of the block is variable.  At least that's
> how i2c-nforce2, i2c-viapro and i2c-amd8111 implement the commands.

They are probably all wrong :) Look at the fallback implementation of
smbus using base i2c in i2c-core.c .. I also checked the smbus spec and
indeed, an smbus block transfer has the lenght on the wire.

Ben
