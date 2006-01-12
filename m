Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-19.bluehost.com (outbound-mail-19.bluehost.com
	[70.98.111.234]) by ozlabs.org (Postfix) with SMTP id 2A276689DF
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 13:20:11 +1100 (EST)
Message-ID: <43C5BB41.1000907@secretlab.ca>
Date: Wed, 11 Jan 2006 19:13:21 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: andrew.l.bomber@maxtek.com
References: <7E11C792A1D81242B9BFFC8355D4979387F6F7@us-bv-m23.global.tektronix.net>
In-Reply-To: <7E11C792A1D81242B9BFFC8355D4979387F6F7@us-bv-m23.global.tektronix.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: kernel hang on 'now booting the kernel'
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

andrew.l.bomber@maxtek.com wrote:
> Ali,
> 
> What is likely happening is that Linux's logical address space is not
> configured appropriately. The MMU configuration is the first or Second
> thing to happen after zImage boots into the Kernel.
> 
> I had the same problem for a custom board with a Xilinx Virtex 2 Pro.
> The problem was that I edited the .config file without running
> menuconfig and that I changed KERNELBASE. Don't change KERNELBASE
> because if you do it will screw up Linux's logical address space. Second
> always run make menuconfig before make dep and make zImage because
or you can run 'make oldconfig' after editing .config.  oldconfig will 
sanitize your changes.

> menuconfig alters a number of lower level files according to your
> configuration. Also make sure that you copy the BSP into the kernel
> source tree otherwise Linux will be writing to the wrong address when
> trying to output to stdout.
> 
> Regards,
> 
> Andrew

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
