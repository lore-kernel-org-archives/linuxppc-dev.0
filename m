Return-Path: <meador_inge@mentor.com>
Message-ID: <4DC4896A.6010705@mentor.com>
Date: Fri, 06 May 2011 18:51:06 -0500
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc: add support for MPIC message register API
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>	<1303232375-25014-3-git-send-email-meador_inge@mentor.com>	<071A08F2C6A57E4E94D980ECA553F8741959CA@039-SN1MPN1-004.039d.mgd.msft.net>	<4DBAED5D.4060906@mentor.com>	<071A08F2C6A57E4E94D980ECA553F8741967EC@039-SN1MPN1-004.039d.mgd.msft.net>	<20110429123051.4ed1ca01@schlenkerla.am.freescale.net>	<071A08F2C6A57E4E94D980ECA553F8741984EE@039-SN1MPN1-004.039d.mgd.msft.net>	<4DBED5E9.2070201@mentor.com>	<20110503101921.45f31d34@schlenkerla.am.freescale.net>	<4DC31989.8080703@mentor.com>
	<20110506142937.77e7a10f@schlenkerla.am.freescale.net>
In-Reply-To: <20110506142937.77e7a10f@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	Kushwaha Prabhakar-B32579 <B32579@freescale.com>,
	"openmcapi-dev@googlegroups.com" <openmcapi-dev@googlegroups.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2011 02:29 PM, Scott Wood wrote:
> On Thu, 5 May 2011 16:41:29 -0500
> 
> How can both OSes independently own registers 1 and 3 for alloction?

They can't.  I just choose a horrible example.  It does point to a serious
flaw (which you allude to later) in inferring free registers from send/receive:
in some cases one will have to arbitrarily add registers to send/receive masks
just to keep registers out of the free allocation pool.  Your free-mask
proposal is better.

>> So any register mentioned in one of 'mpic-msgr-receive-mask' or
>> 'mpic-msgr-send-mask' is out of the running for general allocation.
> 
> mpic-msgr-receive-mask has to match interrupts -- it's not intended to be
> an indication of usage, just that this partition is granted those
> interrupts.
> 
> Plus, a dynamically allocated message register must be owned for both
> sending and receiving, so it doesn't make sense to separate it.  I'd have
> an "mpic-msgr-free-mask" property, which must be a subset of
> "mpic-msgr-receive-mask".  If the register is not in free-mask, it is
> reserved for a fixed purpose.  If free-mask is absent, all registers in the
> receive-mask can be allocated.
> 
> So the above example would be:
> 
> 	/* OS 1 */
> 	mpic_msgr_block0: mpic-msgr-block@41400 {
> 		compatible = "fsl,mpic-v3.1-msgr";
> 		reg = <0x41400 0x200>;
> 		interrupts = <0xb0 2 0xb2 2>;
> 		mpic-msgr-receive-mask = <0x5>;
> 		mpic-msgr-free-mask = <0>;
> 	};
> 
> 	mpic_msgr_block1: mpic-msgr-block@42400 {
> 		compatible = "fsl,mpic-v3.1-msgr";
> 		reg = <0x42400 0x200>;
> 		interrupts = <0xb4 2 0xb5 2>;
> 		mpic-msgr-receive-mask = <0x3>;
> 		mpic-msgr-free-mask = <0x2>;
> 	};
> 
> 	/* OS 2 */
> 	mpic_msgr_block0: mpic-msgr-block@41400 {
> 		compatible = "fsl,mpic-v3.1-msgr";
> 		reg = <0x41400 0x200>;
> 		interrupts = <0xb1 2 0xb3 2>;
> 		mpic-msgr-receive-mask = <0xa>;
> 		mpic-msgr-free-mask = <0>;
> 	};
> 
> 	mpic_msgr_block1: mpic-msgr-block@42400 {
> 		compatible = "fsl,mpic-v3.1-msgr";
> 		reg = <0x42400 0x200>;
> 		interrupts = <0xb6 2 0xb7 2>;
> 		mpic-msgr-receive-mask = <0xc>;
> 		mpic-msgr-free-mask = <0x8>;
> 	};
> 
> mpic-msgr-send-mask could be added as well, as a permissions mechanism to
> serve as extra protection against an improperly specified non-free message
> register -- especially if the interface is exposed to a less-trusted realm
> such as userspace, or if a hypervisor is reading the device tree to
> determine what to allow guests to do.  In this case, just like
> mpic-msgr-receive-mask, it would list both free and non-free message
> registers that the partition can send to, and mpic-msgr-free-mask would be
> a subset of both the send and receive masks.

free-mask seems reasonable.  Although, all of these masks are starting to get
rather complicated :-)

Anyway, I am going to cut a v2 patch without the dynamic allocation.  All
of this is getting complicated without a public use case.  I agree with your
previous suggestion that the dynamic allocation can be added as a part of the
patch set that actually uses it.

Thanks Scott.

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
