Return-Path: <leon.woestenberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 054B3B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 03:00:07 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 5A460DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 03:00:06 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1983963ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 10:00:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A37C88F.8040701@ovro.caltech.edu>
References: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>
	<4A37C88F.8040701@ovro.caltech.edu>
Date: Tue, 16 Jun 2009 18:59:59 +0200
Message-ID: <c384c5ea0906160959v1fde484av8cff4916cacb84cc@mail.gmail.com>
Subject: Re: MPC83xx watchdog reset board dead lock
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: David Hawkins <dwh@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Tue, Jun 16, 2009 at 6:30 PM, David Hawkins<dwh@ovro.caltech.edu> wrote:
>> Most MPC8xxx board designs I have seen suffer from this possible dead
>> lock:
>> - NOR Flash is put in erase mode or write mode
>> - Hardware watchdog triggers
>> - HRESET# is asserted by the processor, during which the configuration
>> words are read from NOR Flash.
>>
>> Either
>> HRESET# is not attached to NOR, NOR stays in erase/write mode and
>> invalid words will be read -> dead lock
>>
>> or either:
>> HRESET# is attached to NOR reset, NOR is reset, but stays in reset as
>> HRESET# stays asserted.
>>
>> We have been looking at several solutions hardware wise that reset the
>> NOR flash on HRESET# going low, but the processors are stubborn,
>> read the config words only once, than dead lock.
>>
>> I wonder if there are known-working designs for this.
>
> What do you do in the case of blank flash on a board?
>
The problem is not with blank flash or firmware upgrades, we know how
to handle that.

Your solution is (a solution) to a different problem.

The problem lies in the fact that board dead lock can occur if the
watchdog triggers, for all reference designs I have seen.

Thanks for thinking along.  I would like to solve the original problem though.
BTW, we use CPLD/FPGAs on most of our boards, this one we do not for
cost reasons.


Regards,
-- 
Leon
