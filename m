Return-Path: <mikpe@it.uu.se>
Received: from fanny.its.uu.se (fanny.its.uu.se [130.238.4.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D29E2B7BA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 02:10:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19223.54514.333777.229238@pilspetsen.it.uu.se>
Date: Thu, 3 Dec 2009 16:10:42 +0100
From: Mikael Pettersson <mikpe@it.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
In-Reply-To: <20091202003630.29919100851@ozlabs.org>
References: <20091202003630.29919100851@ozlabs.org>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
 > This is a libata driver for the "macio" IDE controller used on most Apple
 > PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
 > 
 > It supports all the features of its predecessor, including mediabay hotplug
 > and suspend/resume. It should also support module load/unload.
 > 
 > The timing calculations have been simplified to use pre-calculated tables
 > compared to drivers/ide/pmac.c and it uses the new mediabay interface
 > provided by a previous patch.
 > 
 > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
 > ---
 > 
 > v2. Better tested now, seems to be reasonably solid.
 > 
 > Addressed Tejun comments and made remove more robust vs. media-bay,
 > should also fix Andreas problem.

Tested in 2.6.32-rc8 and 2.6.32 final on a G4 eMac.
Works fine, except for the yaboot problem:

> /sbin/installkernel 2.6.32 vmlinux System.map 
ofpath: Driver:  is not supported
ybin: Unable to find OpenFirmware path for boot=/dev/sda2
ybin: Please add ofboot=<path> where <path> is the OpenFirmware path to /dev/sda2 to /etc/yaboot.conf
ofpath: Driver:  is not supported
ybin: Unable to determine OpenFirmware path for macosx=/dev/sda4
ybin: Try specifying the real OpenFirmware path for macosx=/dev/sda4 in /etc/yaboot.conf

(userspace is YDL 6.2)

/Mikael
