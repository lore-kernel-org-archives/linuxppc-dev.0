Return-Path: <pantelis.antoniou@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.186])
	by ozlabs.org (Postfix) with ESMTP id CD8F9DDF04
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:36:11 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w9so378416mue
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Apr 2007 10:36:09 -0700 (PDT)
In-Reply-To: <F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <5CC026D2-9206-495E-B075-491BEFD97795@gmail.com>
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
Date: Wed, 4 Apr 2007 20:36:02 +0300
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 04 =CE=91=CF=80=CF=81 2007, at 7:42 =CE=9C=CE=9C, Kumar Gala wrote:

>
> On Apr 3, 2007, at 11:02 AM, Timur Tabi wrote:
>
>> (This patch is currently for review only.  It is based on Paul's =20
>> for-2.6.22
>> branch.  Please note that the code in this branch is missing many =20
>> fixes for
>> 2.6.21, and so some code will not compile.  Specifially, ARCH=3Dppc =20=

>> is very
>> broken.)
>>
>> The rheap allocation functions are coded to return a pointer, but =20
>> the actual
>> value returned is an offset into a buffer.  Callers of rheap_alloc=20
>> () typically
>> cast the return value to an integer.  Similarly, rheap_free() took =20=

>> a pointer
>> as a parameter, when it should be an unsigned long.
>>
>> This patch changes all of the relevant rheap functions to use an =20
>> unsigned long
>> instead of a pointer.  The allocation functions return a signed =20
>> long, where a
>> negative number indicates error.
>>
>> All code which calls the rheap functions is updated accordingly.  =20
>> Macros
>> IS_MURAM_ERR() and IS_DPERR() have been deleted.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>
> I'm concerned the error handling isn't correctly.  What happens if =20
> the rheap I'm managing has addresses at 0xf0000000.  When I compare =20=

> offset to 0, its going to report as an error, even if the offset =20
> returned is valid.
>
> - k
>
>

Exactly,

Using a IMMR of 0xfff0000 is quite common.

Please verify that these cases are handled correctly.

-- Pantelis
