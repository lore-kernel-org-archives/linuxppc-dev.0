Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfqhW3WffzDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Mar 2017 01:41:31 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: sysdev: cpm1: Optimise gpio bit calculation
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <20170309094206.A832167992@localhost.localdomain>
 <87a88tle0y.fsf@concordia.ellerman.id.au>
 <534d8795-ce21-9af6-498d-22597213a3a2@c-s.fr>
 <20170310130630.GH31469@gate.crashing.org>
 <906c025b-47d0-f906-2613-291f350bd48d@c-s.fr>
 <20170310143241.GJ31469@gate.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <777e903f-b816-5efa-2ece-e4e16fab27c6@c-s.fr>
Date: Fri, 10 Mar 2017 15:41:23 +0100
MIME-Version: 1.0
In-Reply-To: <20170310143241.GJ31469@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/03/2017 à 15:32, Segher Boessenkool a écrit :
> On Fri, Mar 10, 2017 at 03:04:48PM +0100, Christophe LEROY wrote:
>> Le 10/03/2017 à 14:06, Segher Boessenkool a écrit :
>>> On Fri, Mar 10, 2017 at 11:54:19AM +0100, Christophe LEROY wrote:
>>>> gpio_get() and gpio_set() are used extensively by some GPIO based
>>>> drivers like SPI, NAND, so it may be worth it as it doesn't impair
>>>> readability (if anyone prefers, we could write  (1 << 31) >> i  instead
>>>> of  0x80000000 >> i )
>>>
>>> 1 << 31 is undefined behaviour, of course.
>>>
>>
>> Shall it be 1U << 31 ?
>
> Sure, that works.  "1 << (31 - i)" is most readable (but it doesn't yet
> generate the code you want).
>
>

Euh .... I'm a bit lost. Do you mean the form we have today is the 
driver is wrong ?


@@ -684,9 +682,7 @@ static int cpm1_gpio32_get(struct gpio_chip *gc, 
unsigned int gpio)
  {
  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
  	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
-	u32 pin_mask;
-
-	pin_mask = 1 << (31 - gpio);
+	u32 pin_mask = 0x80000000 >> gpio;

  	return !!(in_be32(&iop->dat) & pin_mask);
  }


Which I thought could also become


@@ -684,9 +682,7 @@ static int cpm1_gpio32_get(struct gpio_chip *gc, 
unsigned int gpio)
  {
  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
  	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
-	u32 pin_mask;
-
-	pin_mask = 1 << (31 - gpio);
+	u32 pin_mask = (1 << 31) >> gpio;

  	return !!(in_be32(&iop->dat) & pin_mask);
  }


Christophe
