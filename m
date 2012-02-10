Return-Path: <jgpobox@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
 [209.85.216.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A054B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Feb 2012 05:26:07 +1100 (EST)
Received: by qan41 with SMTP id 41so2076476qan.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 10:26:04 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4F356139.9000609@pobox.com>
Date: Fri, 10 Feb 2012 13:26:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: qiang.liu@freescale.com
Subject: Re: [PATCH V2] fsl-sata: I/O load balancing
References: <1327025958-10605-1-git-send-email-qiang.liu@freescale.com>
In-Reply-To: <1327025958-10605-1-git-send-email-qiang.liu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/19/2012 09:19 PM, qiang.liu@freescale.com wrote:
> From: Qiang Liu<qiang.liu@freescale.com>
>
> Reduce interrupt signals through reset Interrupt Coalescing Control Reg.
> Provide dynamic method to adjust interrupt signals and timer ticks by sysfs.
> It is a tradeoff for different applications.
>
> Signed-off-by: Qiang Liu<qiang.liu@freescale.com>
> ---
>
> change for V2
> 	support dynamic config interrupt coalescing register by /sysfs
> 	test random small file with iometer
> Description:
>    1. fsl-sata interrupt will be raised 130 thousand times when write 8G file
>      (dd if=/dev/zero of=/dev/sda2 bs=128K count=65536);
>    2. most of interrupts raised because of only 1-4 commands completed;
>    3. only 30 thousand times will be raised after set max interrupt threshold,
>      more interrupts are coalesced as the description of ICC;
>
> Test methods and results:
>    1. test sequential large file performance,
>    [root@p2020ds root]# echo 31 524287>  \
>    	/sys/devices/soc.0/ffe18000.sata/intr_coalescing
>    [root@p2020ds root]# dd if=/dev/zero of=/dev/sda2 bs=128K count=65536&
>    [root@p2020ds root]# top
>
>    CPU %  |  dd   |  flush-8:0 | softirq
>    ---------------------------------------
>    before | 20-22 |    17-19   |    7
>    ---------------------------------------
>    after  | 18-21 |    15-16   |    5
>    ---------------------------------------
>    2. test random small file with iometer,
>   iometer paramters:
>     4 I/Os burst length, 1MB transfer request size, 100% write, 2MB file size
>     as default configuration of interrupt coalescing register, 1 interrupts and
>   no timeout config, total write performance is 119MB per second,
>     after config with the maximum value, write performance is 110MB per second.
>
>    After compare the test results, a configuable interrupt coalescing should be
>    better when cope with flexible context.
>
>   drivers/ata/sata_fsl.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 files changed, 107 insertions(+), 4 deletions(-)

Doesn't seem to apply to upstream, or another less recent -rc...

	Jeff
