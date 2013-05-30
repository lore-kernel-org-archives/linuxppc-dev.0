Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 36BA62C0085
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 19:29:48 +1000 (EST)
Message-ID: <51A71C19.7000604@windriver.com>
Date: Thu, 30 May 2013 17:30:01 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: wolfking <wolfking2000@msn.com>
Subject: Re: can't access PCIe card under sbc8548
References: <1369885321567-71775.post@n7.nabble.com>
 <51A6EA1D.7080100@windriver.com> <1369898369690-71782.post@n7.nabble.com>
 <51A71225.2040102@windriver.com> <1369905341079-71815.post@n7.nabble.com>
In-Reply-To: <1369905341079-71815.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2013 05:15 PM, wolfking wrote:
> hi, tiejun.chen:
>    When I use ioremap, the card seems to work fine. That is, I can access

Yes, ioremap() should work for MMIO.

> part of all register. My PCIe card is a rs232 expand card, it has some
> standard UART register, for example the SCR(scratch register). My driver
> can access the SCR(write and read) normally, but the other registers
> behave odd. For example, the DLM should be 0, but it reads 5. The card
> has a software reset bit, when it is set to 1, the card reset itself. When
> it finished reset, this reset bit should be back to 0. But In sbc8548, when
> I set this
> bit, it remains high. So I guess, the area I accessed is not the PCIe card,

I suspect you're missing some load/storage sync code, so what is your R/W 
function exactly?

Tiejun
