Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfptK6dsSzDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Mar 2017 01:04:56 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: sysdev: cpm1: Optimise gpio bit calculation
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <20170309094206.A832167992@localhost.localdomain>
 <87a88tle0y.fsf@concordia.ellerman.id.au>
 <534d8795-ce21-9af6-498d-22597213a3a2@c-s.fr>
 <20170310130630.GH31469@gate.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <906c025b-47d0-f906-2613-291f350bd48d@c-s.fr>
Date: Fri, 10 Mar 2017 15:04:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170310130630.GH31469@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/03/2017 à 14:06, Segher Boessenkool a écrit :
> On Fri, Mar 10, 2017 at 11:54:19AM +0100, Christophe LEROY wrote:
>> gpio_get() and gpio_set() are used extensively by some GPIO based
>> drivers like SPI, NAND, so it may be worth it as it doesn't impair
>> readability (if anyone prefers, we could write  (1 << 31) >> i  instead
>> of  0x80000000 >> i )
>
> 1 << 31 is undefined behaviour, of course.
>

Shall it be 1U << 31 ?

Christophe
