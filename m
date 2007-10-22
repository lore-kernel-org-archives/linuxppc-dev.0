Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710211729k2f2a065cm56670d1b0f90a1af@mail.gmail.com>
Date: Sun, 21 Oct 2007 20:29:38 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: Device trees and audio codecs
In-Reply-To: <5cac8057884ac400b0596988414c7ed7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
	<a76a128145ec8a8f779727a7e11925ac@kernel.crashing.org>
	<9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>
	<5cac8057884ac400b0596988414c7ed7@kernel.crashing.org>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/21/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > How do we want to be consistent with the Efika which uses an AC97
> > codec that only connects to i2s?
>
> Huh?  AC'97 isn't I2S.  Yeah you probably could hook it up to some I2S
> device if you do all the interleaving and whatever stuff by hand -- but
> then you probably shouldn't call the I2S "host" an I2S anymore, but name
> it "ac97" in the device tree, or "this-or-that-i2s-controller-hooked-up-
> in-this-particular-crazy-way".  You will want to know which driver to
> use for the device, and if it's hooked up in "strange and unforeseen"
> ways you want to know about it.

I meant an ac97 bus. ac97 is conceptually the same as i2s with the
control signals also routed over it. ac97 and i2s are handled in the
same PSC on the 5200.

I have received conflicting opinions as to whether a codec hooked to
an ac97 bus should get a chip specific codec entry in the device tree.
Without the codec specific entry only generic ac97 features can be
used. The Efika has a STA9766. Looking at the data sheet for the chip
I see that it implements some proprietary functions in addition to the
standard ones.

asoc has a generic ac97 driver. Should the ac97 bus be required to
have a entry for the generic ac97 device? It would make loading the
driver much easier.


> _Please_ don't name busses that are not plain I2S "i2s" in the device
> tree.  At best this means you'll need a quirk in the kernel code to deal
> with this later.

the i2s and ac97 drivers for the mpc5200 already exist. I'm using
these preexisting drivers.


-- 
Jon Smirl
jonsmirl@gmail.com
