Return-Path: <jgpobox@gmail.com>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 1F539B7C2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 19:12:04 +1100 (EST)
Received: by ywh17 with SMTP id 17so1146859ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 03 Dec 2009 00:12:02 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4B1772D0.5030303@garzik.org>
Date: Thu, 03 Dec 2009 03:12:00 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
References: <20091202003630.29919100851@ozlabs.org>
In-Reply-To: <20091202003630.29919100851@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2009 07:36 PM, Benjamin Herrenschmidt wrote:
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
> Signed-off-by: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> ---
>
> v2. Better tested now, seems to be reasonably solid.
>
> Addressed Tejun comments and made remove more robust vs. media-bay,
> should also fix Andreas problem.
>
>
>   drivers/ata/Kconfig      |   10
>   drivers/ata/Makefile     |    1
>   drivers/ata/pata_macio.c | 1427 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1438 insertions(+)

Looks fine to me.  Two minor comments, which might perhaps be ignored if 
that is your taste:

* prefer enums to #define's, for constants

* prefer direct function call to "ap->ops->foo_bar()", because 
ap->ops->foo_bar() is guaranteed to be a constant value known to the 
driver.  The driver is the entity responsible for the function pointer.

Maybe saves a cycle or two.  Not terribly important, but hey, calling 
ap->ops->sff_exec_command() from pata_macio_bmdma_setup() is a hot path.

	Jeff
