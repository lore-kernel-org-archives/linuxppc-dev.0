Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 22CFA1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 19:00:55 +1100 (AEDT)
Message-ID: <54F6BBA7.8040008@c-s.fr>
Date: Wed, 04 Mar 2015 09:00:39 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: fsl-spi: use of_iomap() to map parameter ram on CPM1
References: <20150226161142.D08681A2360@localhost.localdomain>
 <20150303184403.GE21293@sirena.org.uk>
In-Reply-To: <20150303184403.GE21293@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 03/03/2015 19:44, Mark Brown a écrit :
> On Thu, Feb 26, 2015 at 05:11:42PM +0100, Christophe Leroy wrote:
>> On CPM2, the SPI parameter RAM is dynamically allocated in the dualport RAM
>> whereas in CPM1, it is statically allocated to a default address with
>> capability to relocate it somewhere else via the use of CPM micropatch.
>> The address of the parameter RAM is given by the boot loader and expected
>> to be mapped via of_iomap()
> Why are we using of_iomap() rather than a generic I/O mapping function
> here?
Euh ...

because all drivers for powerpc seems to be using of_iomap(), as on 
powerpc the HW is described by the bootloader in a OF device tree.
Today, of_iomap() is at least used in FSL SPI, FSL UART, SPI mpc52xx, 
UART mpc52xx, i2c-mpc, i2c-cpm, freescale ethernet drivers, etc ....

Is it not correct ?
