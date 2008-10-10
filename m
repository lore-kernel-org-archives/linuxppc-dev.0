Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F2560DE2B2
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 23:03:50 +1100 (EST)
Date: Fri, 10 Oct 2008 16:03:49 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wang Jian <lark@linux.net.cn>
Subject: Re: Compact Flash on 8349mITX
Message-ID: <20081010120349.GA13431@oksana.dev.rtsoft.ru>
References: <19900326.post@talk.nabble.com>
	<20081009172338.GA4292@oksana.dev.rtsoft.ru>
	<48EEBA79.9000902@linux.net.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48EEBA79.9000902@linux.net.cn>
Cc: linuxppc-dev@ozlabs.org, Jeff Borlin <jborlin@aclaratech.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 10:14:17AM +0800, Wang Jian wrote:
> How 8349mITX's compact flash is wired?

FYI, the schematics are openly available.

http://www.freescale.com/files/32bit/hardware_tools/schematics/MPC8349EMITXESCH.pdf?WT_TYPE=Schematics&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Downloads

> If it is wired using 8 bit data bus line,
> without another patch, data transfer can't be done.

It is wired that way:

LBD[7:0]    D[0:7]
LBD[15:8]   D[8:15]
LBA[30..28] A[0..2]

I.e. 16 bits for data.

> Looking at logs Sam Sparks provided (without irq):
>
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>
> it seems data transfer failed.

Well, w/o IRQs everything is OK. I think it's just a bogus message
after the interrupt issues.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
