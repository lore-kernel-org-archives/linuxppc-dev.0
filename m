Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 00C90DE0FF
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Jan 2009 19:47:35 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5414eaef99b7392a95f6e3488b81dbf7@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] 2.6.28-git4 - powerpc - drivers build fails with
	!CONFIG_VIOPATH
Date: Sun, 4 Jan 2009 02:54:15 -0600
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In-Reply-To: <20090103191359.GA9304@linux.vnet.ibm.com>

Kamalesh Babulal wrote:
>  config SCSI_IBMVSCSI
>         tristate "IBM Virtual SCSI support"
> -       depends on PPC_PSERIES || PPC_ISERIES
> +       depends on (PPC_PSERIES || PPC_ISERIES) && VIOPATH
>         select SCSI_SRP_ATTRS
>         help
>           This is the IBM POWER Virtual SCSI Client

As VIOPATH is iSeries code and is only used by the iSeries code, the 
requirment should be

depends on PPC_PSERIES || (PPC_ISERIES && VIOPATH)

except VIOPATH isn't selectable:

arch/powerpc/platforms/iseries/Kconfig:

  config VIOPATH
         bool
         depends on VIODASD || VIOCD || VIOTAPE || ISERIES_VETH
         default y

so instead we should be adding

select VIOPATH if PPC_ISERIES

to SCSI_IBMVSCSI and just

select VIOPATH

to HVC_ISERIES as it depends on PPC_ISERIES

otherwise you have to enable one driver to get these other drivers.

milton
