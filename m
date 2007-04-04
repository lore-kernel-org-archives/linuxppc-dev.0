Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 47907DDEBD
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:36:41 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so750344ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Apr 2007 12:36:36 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] sl82c105: rework PIO support (take 2)
Date: Wed, 4 Apr 2007 21:24:38 +0200
References: <200702140101.26639.sshtylyov@ru.mvista.com>
	<200703282147.41696.sshtylyov@ru.mvista.com>
In-Reply-To: <200703282147.41696.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704042124.39046.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wednesday 28 March 2007, Sergei Shtylyov wrote:
> Get rid of the 'pio_speed' member of 'ide_drive_t' that was only used by this
> driver by storing the PIO mode timings in the 'drive_data' instead -- this
> allows us to greatly  simplify the process of "reloading" of the chip's timing
> register and do it right in sl82c150_dma_off_quietly() and to get rid of two
> extra arguments to config_for_pio() -- which got renamed to sl82c105_tune_pio()
> and now returns a PIO mode selected, with ide_config_drive_speed() call moved
> into the tuneproc() method, now called sl82c105_tune_drive() with the code to
> set drive's 'io_32bit' and 'unmask' flags in its turn moved to its proper place
> in the init_hwif() method.
> Also, while at it, rename get_timing_sl82c105() into get_pio_timings() and get
> rid of the code in it clamping cycle counts to 32 which was both incorrect and
> never executed anyway...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

applied
