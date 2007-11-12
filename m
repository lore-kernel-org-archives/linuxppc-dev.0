Return-Path: <benh@kernel.crashing.org>
Subject: Re: Gianfar ethernet device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910711111530g1f50d6e6hfaa76b4f051b5887@mail.gmail.com>
References: <9e4733910711111511v36aa3504s3b55438698a4b4a8@mail.gmail.com>
	<9e4733910711111530g1f50d6e6hfaa76b4f051b5887@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Nov 2007 11:04:36 +1100
Message-Id: <1194825876.18185.3.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-11-11 at 18:30 -0500, Jon Smirl wrote:
> Does this patch add the right ifdefs in fsl_soc.c to make these
> drivers build on their proper platforms? As an experiment I have
> disabled platform bus on the mpc5200 and I'm only using of_platform
> bus. Turning off platform bus is exposing a lot of code that is
> getting built into my mpc5200 kernel that is supporting devices not
> available on the platform.
> 
> A few more fixups in some other drivers and I should have mpc5200
> working without platform bus.

That sort of per-platform ifdefs is just WRONG.

On the other hand, if you feel that such common code deserves not being
built on all platforms, then what you can do is define a Kconfig option,
such as CONFIG_PPC_CAN_HAVE_GIANFAR, that gets select'ed by the
platforms that can have a Gianfar and use -that- for the ifdef.

Ben.
