Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix PowerMac sound i2c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <87y80rkmk7.fsf@briny.internal.ondioline.org>
References: <1136695956.30123.44.camel@localhost.localdomain>
	<87y80rkmk7.fsf@briny.internal.ondioline.org>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 09:56:02 +1100
Message-Id: <1139093763.5634.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-02-04 at 18:26 +0000, Paul Collins wrote:
> Hi Ben,
> 
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > My patch reworking the PowerMac i2c code break the sound drivers as they
> > used to rely on some broken behaviour of i2c-keywest that is gone now.
> > This patch should fix them (tested on a g5 with alsa only). It might
> > also fix an oops if the alsa driver hits an unsupported chip.
> 
> Applied Linus's current git tree, this patch makes ALSA sound on my
> PowerBook5,4 work again.  The second patch does not work because the
> i2c wrapper (I assume that's what i2c_smbus_write_i2c_block_data is)
> has apparently not yet returned.
> 
> It would be nice to have this fix in 2.6.16 if possible.

The second patch is the one that should go in, but it relies on an i2c
fix (undoing some Bunk damage) that is still staging in Greg tree... I
don't know what's up with that, I'll ask around.

Ben.
