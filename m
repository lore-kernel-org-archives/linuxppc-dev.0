Return-Path: <richardcochran@gmail.com>
Date: Thu, 24 Feb 2011 17:50:04 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V11 2/4] ptp: Added a clock that uses the eTSEC found
	on the MPC85xx.
Message-ID: <20110224165004.GB15234@riccoc20.at.omicron.at>
References: <cover.1298447722.git.richard.cochran@omicron.at>
	<be1f5e801e8cd0145dd23aadae7c2055bb3c1d47.1298447722.git.richard.cochran@omicron.at>
	<20110223165058.GE14597@angua.secretlab.ca>
	<20110223112612.30071995@schlenkerla>
	<20110223175459.GH14597@angua.secretlab.ca>
	<20110223132444.65dfdda4@schlenkerla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110223132444.65dfdda4@schlenkerla>
Cc: Mike Frysinger <vapier@gentoo.org>, Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rodolfo Giometti <giometti@linux.it>, Christoph Lameter <cl@linux.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 23, 2011 at 01:24:44PM -0600, Scott Wood wrote:
> Whatever string is used should be written into a binding document.
> 
> fsl,etsec-v1.6-ptp seems like it would be just as good for that purpose.
> 
> Even just fsl,etsec-ptp will identify the binding, though it's lacking in
> identifying the hardware (in the absence of access to the eTSEC ID
> registers).

I read the conversation, and I don't mind admitting that I do not
understand what you both are arguing/discussing about.

How should I set the strings?  Like this?

arch/powerpc/boot/dts/mpc8313erdb.dts:
	ptp_clock@24E00 {
		compatible = "fsl,mpc8313-etsec-ptp";
	}
arch/powerpc/boot/dts/mpc8572ds.dts:
	ptp_clock@24E00 {
		compatible = "fsl,mpc8572-etsec-ptp";
	} 
arch/powerpc/boot/dts/p2020ds.dts:
	ptp_clock@24E00 {
		compatible = "fsl,p2020ds-etsec-ptp";
	} 
arch/powerpc/boot/dts/p2020rdb.dts:
	ptp_clock@24E00 {
		compatible = "fsl,p2020rdb-etsec-ptp";
	} 

drivers/net/gianfar_ptp.c:

static struct of_device_id match_table[] = {
	{ .compatible = "fsl,mpc8313-etsec-ptp" },
	{ .compatible = "fsl,mpc8572-etsec-ptp" },
	{ .compatible = "fsl,p2020ds-etsec-ptp" },
	{ .compatible = "fsl,p2020rdb-etsec-ptp" },
	{},
};

Please let me know if this is what you meant.

Thanks,
Richard
