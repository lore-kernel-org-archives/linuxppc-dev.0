Return-Path: <nforrester@whoi.edu>
Received: from mx1.whoi.edu (zeratul.whoi.edu [128.128.76.62])
	by ozlabs.org (Postfix) with ESMTP id 95F95DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 14:03:40 +1000 (EST)
Message-ID: <46A967D5.30606@whoi.edu>
Date: Thu, 26 Jul 2007 23:34:45 -0400
From: Ned Forrester <nforrester@whoi.edu>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH 2/3] [SPI] Add new mode: SPI_LOOP
References: <20070726134754.GA3539@localhost.localdomain>	<20070726135051.GB5550@localhost.localdomain>
	<200707262007.07537.david-b@pacbell.net>
In-Reply-To: <200707262007.07537.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: spi-devel-general@lists.sourceforge.net,
	Stephen Street <stephen@streetfiresound.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Brownell wrote:
> On Thursday 26 July 2007, Anton Vorontsov wrote:
>> Loopback mode is supported by various controllers, this mode
>> is useful for testing, especially in conjunction with spidev
>> driver.
> 
> ISTR that Stephen Street provided a loopback mode for debug
> in his pxa2xx_spi code.  And I know you're fight that this
> mode shows up in a lot of hardware.
> 
> Comments, anyone?  This seems like a fair way to expose this
> mechanism.  And I tend to agree that it'd mostly be useful in
> conjunction with "spidev".

Yes, it is in pxa2xx_spi.  It is passed in a structure that is attached 
to spi_board_info.controller_data.  I have used it to great effect to 
test data modes in the driver for which I have no external hardware 
support: various bits/word, clock frequencies, fifo thresholds, dma 
burst sizes, etc.

It works for me if this is moved to struct spi_device.

I don't think I have any code that could be readily turned into a 
generic test program.

-- 
Ned Forrester                                       nforrester@whoi.edu
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079
