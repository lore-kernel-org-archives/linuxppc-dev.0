Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 473A9DDE28
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 01:44:46 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2856877wfd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 06:44:44 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <76C7F485-EF75-4B83-B673-564E6243C7C6@kernel.crashing.org>
References: <D728AD1FA2543948B89DE29C5BF4CD0716AC2DDE@bjmail1.bj.datangmobile.com>
	<76C7F485-EF75-4B83-B673-564E6243C7C6@kernel.crashing.org>
Date: Tue, 17 Feb 2009 22:38:18 +0800
Message-ID: <2a27d3730902170638h43724c03k6b50843158842e1e@mail.gmail.com>
Subject: Re: [PATCH] fix the interrupt loss problem on powerpc IPIC (2.6.23)
From: Li Yang <leoli@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, "<dayu@datangmobile.cn>" <dayu@datangmobile.cn>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 17, 2009 at 10:12 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Feb 17, 2009, at 6:44 AM, <dayu@datangmobile.cn> <dayu@datangmobile.cn>
> wrote:
>
>> From: Da Yu <dayu@datangmobile.cn>
>> Date: Tue, 17 Feb 2009 19:58:20 +0800
>> Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC (2.6.23)
>>
>> Signed-off-by: Da Yu <dayu@datangmobile.cn>
>> ---
>
> Please provide a bit more description as to why this fixes the issue.

The pending register is write 1 clear.  If there are more than one
external interrupts pending at the same time, acking the first
interrupt will also clear other interrupt pending bits.  That will
cause loss of interrupt.

- Leo
