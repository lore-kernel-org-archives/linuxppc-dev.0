Return-Path: <timur@freescale.com>
Message-ID: <471CC461.1080207@freescale.com>
Date: Mon, 22 Oct 2007 10:40:17 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Device trees and audio codecs
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>	<a76a128145ec8a8f779727a7e11925ac@kernel.crashing.org>	<9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>	<5cac8057884ac400b0596988414c7ed7@kernel.crashing.org>
	<9e4733910710211729k2f2a065cm56670d1b0f90a1af@mail.gmail.com>
In-Reply-To: <9e4733910710211729k2f2a065cm56670d1b0f90a1af@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> I meant an ac97 bus. ac97 is conceptually the same as i2s with the
> control signals also routed over it. ac97 and i2s are handled in the
> same PSC on the 5200.
> 
> I have received conflicting opinions as to whether a codec hooked to
> an ac97 bus should get a chip specific codec entry in the device tree.

I think it should.  For one thing, ASoC requires a pointer to a structure in the 
codec device driver so that it knows which functions to call to change volume. 
What if you have multiple i2s/ac97 devices and multiple codecs?  You'll need to 
know which i2s device is connected to which codec.  The only way to distinguish 
that is by having a node for the codec under the i2s node.
