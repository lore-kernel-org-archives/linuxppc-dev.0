Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D95D1A0200
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 15:32:38 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 845DF1400F1
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 15:32:35 +1100 (AEDT)
Message-ID: <1416889937.4998.54.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 25 Nov 2014 15:32:17 +1100
In-Reply-To: <20141124121803.GH3733@katana>
References: <20141116171605.4750.17472.stgit@localhost.localdomain>
 <546DF910.4060802@linux.vnet.ibm.com> <20141124121803.GH3733@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-24 at 13:18 +0100, Wolfram Sang wrote:
> 
> I think there are now 3 drivers in my queue which are not fully I2C
> compatible but more supporting the very minimum to, say, read an
> eeprom.
> I am not feeling well to allow them to use I2C_FUNC_I2C. So, I want to
> think about ways how to communicate deficiencies like "only 255 byte"
> or
> "only WRRD messages" to users of that I2C controller. This is most
> likely not happening before 3.19. But assistance is very welcome.

There are drivers doing that already, this is afaik common practice.

Please don't gate the merging process to some hypothetical rework that
will imply reworking also a number of user space tools and in-kernel i2c
device drivers. Basically that would mean "your platform won't be
supported upstream for the next year and btw, rewrite all userspace".

By all means let's create new "smbus" APIs for >1 bytes offset but let's
not make it a gate to merging drivers using the existing way of doing
things that has been so far perfectly functional.

Cheers,
Ben.
