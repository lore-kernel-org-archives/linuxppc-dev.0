Return-Path: <schwab@suse.de>
From: Andreas Schwab <schwab@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1136695956.30123.44.camel@localhost.localdomain>
Date: Sun, 08 Jan 2006 11:37:12 +0100
In-Reply-To: <1136695956.30123.44.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Sun, 08 Jan 2006 15:52:36 +1100")
Message-ID: <jefynz0zvr.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> My patch reworking the PowerMac i2c code break the sound drivers as they
> used to rely on some broken behaviour of i2c-keywest that is gone now.

I'm not sure, but from looking at the other i2c drivers I'd rather think
that the old behaviour of i2c-keywest was correct.  There are only a few
that implement both I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_I2C_BLOCK_DATA, but
none of them write the length byte together with the data.  The commands
are ony different in behaviour when reading: with I2C_SMBUS_I2C_BLOCK_DATA
a fixed sized block is read from the bus, whereas with
I2C_SMBUS_BLOCK_DATA the size of the block is variable.  At least that's
how i2c-nforce2, i2c-viapro and i2c-amd8111 implement the commands.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
