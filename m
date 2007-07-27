Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 15CF3DDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 23:36:57 +1000 (EST)
Date: Fri, 27 Jul 2007 17:36:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH 1/4] [POWERPC][SPI] spi_mpc83xx.c:
	should turn off SPI unit while switching any mode.
Message-ID: <20070727133628.GA19151@localhost.localdomain>
References: <20070726131134.GA3309@localhost.localdomain>
	<20070726131346.GA3417@localhost.localdomain>
	<250FD11F-9ADC-46CC-B652-1148FC549316@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <250FD11F-9ADC-46CC-B652-1148FC549316@kernel.crashing.org>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2007 at 01:32:27AM -0500, Kumar Gala wrote:
>
> On Jul 26, 2007, at 8:13 AM, Anton Vorontsov wrote:
>
>> Documentation clearly states, that mode should not be changed
>> till SPMODE_ENABLE bit set. I've seen hangs w/o this patch.
>
> Out of interest what board/part do you see the hang on?

It's MPC8323E-RDB.

Using spidev_test utility:

root@10.0.0.99:~# ./a.out -D /dev/spidev1.0
spi mode: 0
bits per word: 8
max speed: Hz (kHz): 500000 (500)
...
root@10.0.0.99:~#


Then trying change bits per word to 32:

root@10.0.0.99:~# ./a.out -D /dev/spidev1.0 -b 32
spi mode: 0
bits per word: 32
max speed: Hz (kHz): 500000 (500)
<---- hang

Board is still alive, but SPI isn't.

Though, there are various steps to reproduce the same.
So SPI unit should be really turned off to change mode.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
