Return-Path: <meador_inge@mentor.com>
Message-ID: <4DC31989.8080703@mentor.com>
Date: Thu, 05 May 2011 16:41:29 -0500
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc: add support for MPIC message register API
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>	<1303232375-25014-3-git-send-email-meador_inge@mentor.com>	<071A08F2C6A57E4E94D980ECA553F8741959CA@039-SN1MPN1-004.039d.mgd.msft.net>	<4DBAED5D.4060906@mentor.com>	<071A08F2C6A57E4E94D980ECA553F8741967EC@039-SN1MPN1-004.039d.mgd.msft.net>	<20110429123051.4ed1ca01@schlenkerla.am.freescale.net>	<071A08F2C6A57E4E94D980ECA553F8741984EE@039-SN1MPN1-004.039d.mgd.msft.net>	<4DBED5E9.2070201@mentor.com>
	<20110503101921.45f31d34@schlenkerla.am.freescale.net>
In-Reply-To: <20110503101921.45f31d34@schlenkerla.am.freescale.net>
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

On 05/03/2011 10:19 AM, Scott Wood wrote:
> In the absence of partitioning, no driver should need a specific one.  With
> partitioning, let the system designer mark those resources as reserved so
> they don't get allocated. :-)

That seem reasonable.  Back to the device tree then.  One option is to bring
back the sister-send property 'mpic-msgr-send-mask', which was discussed some
months back.  For example, consider:

	/* OS 1 */
	mpic_msgr_block0: mpic-msgr-block@41400 {
		compatible = "fsl,mpic-v3.1-msgr";
		reg = <0x41400 0x200>;
		interrupts = <0xb0 2 0xb2 2>;
		mpic-msgr-receive-mask = <0x5>;
		mpic-msgr-send-mask = <0xa>;
	};

	mpic_msgr_block1: mpic-msgr-block@42400 {
		compatible = "fsl,mpic-v3.1-msgr";
		reg = <0x42400 0x200>;
		interrupts = <0xb4 2 0xb6 2>;
		mpic-msgr-receive-mask = <0x5>;
	};

	/* OS 2 */
	mpic_msgr_block0: mpic-msgr-block@41400 {
		compatible = "fsl,mpic-v3.1-msgr";
		reg = <0x41400 0x200>;
		interrupts = <0xb0 2 0xb2 2>;
		mpic-msgr-receive-mask = <0xa>;
		mpic-msgr-send-mask = <0x5>;
	};

	mpic_msgr_block1: mpic-msgr-block@42400 {
		compatible = "fsl,mpic-v3.1-msgr";
		reg = <0x42400 0x200>;
		interrupts = <0xb4 2 0xb6 2>;
		mpic-msgr-send-mask = <0x5>;
	};

In block0 for both OSes, all registers are partitioned and are thus not
available for allocation.  In block1 for both OSes, registers 0 and 2 are
reserved and registers 1 and 3 are available for general allocation.

So any register mentioned in one of 'mpic-msgr-receive-mask' or
'mpic-msgr-send-mask' is out of the running for general allocation.
If neither of the properties appear, then all registers are available
for general allocation.

You could get into trouble with this method with cases like:

	/* OS 1 */
	mpic_msgr_block0: mpic-msgr-block@41400 {
		compatible = "fsl,mpic-v3.1-msgr";
		reg = <0x41400 0x200>;
		interrupts = <0xb0 2 0xb2 2>;
		mpic-msgr-send-mask = <0xa>;
	};

	/* OS 2 */
	mpic_msgr_block0: mpic-msgr-block@41400 {
		compatible = "fsl,mpic-v3.1-msgr";
		reg = <0x41400 0x200>;
		interrupts = <0xb0 2 0xb2 2>;
		mpic-msgr-receive-mask = <0x5>;
	};

Now OS 1 has registers 0 and 2 available for general allocation, which
OS 2 is receiving on.  However, we already have that problem if someone
botches the masks.  So I am not very worried about that.

Clearly this is just one method, but I think tagging what is available from the
device tree is a must.


Thoughts?


-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
