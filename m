Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE003.bigfish.com (ch1ehsobe006.messaging.microsoft.com
	[216.32.181.186]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E93EEB6FF9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 05:47:27 +1000 (EST)
Message-ID: <4DF12345.1040409@freescale.com>
Date: Thu, 9 Jun 2011 14:47:17 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<20110609124010.6335559e.randy.dunlap@oracle.com>
In-Reply-To: <20110609124010.6335559e.randy.dunlap@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: arnd@arndb.de, konrad.wilk@oracle.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, dsaxena@linaro.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	virtualization@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Randy Dunlap wrote:
>> > +enum fsl_hv_ioctl_cmd {
>> > +	FSL_HV_IOCTL_PARTITION_RESTART = _IOWR(0, 1, struct fsl_hv_ioctl_restart),
>> > +	FSL_HV_IOCTL_PARTITION_GET_STATUS = _IOWR(0, 2, struct fsl_hv_ioctl_status),
>> > +	FSL_HV_IOCTL_PARTITION_START = _IOWR(0, 3, struct fsl_hv_ioctl_start),
>> > +	FSL_HV_IOCTL_PARTITION_STOP = _IOWR(0, 4, struct fsl_hv_ioctl_stop),
>> > +	FSL_HV_IOCTL_MEMCPY = _IOWR(0, 5, struct fsl_hv_ioctl_memcpy),
>> > +	FSL_HV_IOCTL_DOORBELL = _IOWR(0, 6, struct fsl_hv_ioctl_doorbell),
>> > +	FSL_HV_IOCTL_GETPROP = _IOWR(0, 7, struct fsl_hv_ioctl_prop),
>> > +	FSL_HV_IOCTL_SETPROP = _IOWR(0, 8, struct fsl_hv_ioctl_prop),
>> > +};

> Missing an entry in Documentation/ioctl/ioctl-number.txt for 0 (with conflict!).

If I change it from 0, I'm going to break binary compatibility with our apps.  I
agree that maybe I shouldn't have picked 0, but considering how many conflicts
there already are, I wonder what the point is.  Even if I pick a number that is
currently not listed in the chart, that doesn't mean that it's actually not
being used, or that it won't conflict in the future.

So is it okay to stick with 0, or do I need to pick a new number?

-- 
Timur Tabi
Linux kernel developer at Freescale
