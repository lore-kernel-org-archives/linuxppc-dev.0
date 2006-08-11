Return-Path: <jdl@freescale.com>
Subject: Re: [RFC] consolidated libdt proposal
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <1155064370.5572.11.camel@localhost>
References: <20060719230544.GD3887@mag.az.mvista.com>
	<1154911082.27074.104.camel@diesel>
	<1154987921.24455.32.camel@basalt.austin.ibm.com>
	<1155062792.5572.5.camel@localhost>
	<1155064370.5572.11.camel@localhost>
Content-Type: text/plain
Message-Id: <1155324825.10054.23.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 11 Aug 2006 14:33:46 -0500
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	"xen-ppc-devel@lists.xensource.com" <xen-ppc-devel@lists.xensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-08 at 14:12, Matthew McClintock wrote:
> This is a patch to u-boot with the changes.
> 
> * Patch to modify ft_build.c to update flat device trees in place
>   Patch by Matthew McClintock 26-June-2006
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>

Also FYI, I have assembled all Matt's 85xx related U-Boot patches,
along with the corresponding 86xx updates, into the u-boot-86xx.git
tree on:

    http://jdl.com/git_repos/

This U-Boot separates out the DTS files, but allows the DTB
to be downloaded.  It can then update it and hand it off to
either an 85xx or 86xx linux kernel.

I use these commands, roughly:

    # build U-boot and Linux as usual

    $ dtc -f -V 0x10 -I dts -O dtb \
        linux-2.6-86xx/arch/powerpc/boot/dts/mpc8641_hpcn.dts \
        mpc8641_hpcn.dtb

    In U-boot now:

    > tftp 1000000 loeliger/uImage.8641
    > tftp 900000 loeliger/mpc8641_hpcn.dtb

    > bootm 1000000 - 900000

Enjoy,
jdl
