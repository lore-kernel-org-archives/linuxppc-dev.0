Return-Path: <larry.finger@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t743g5TcrzDvJd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 06:21:35 +1100 (AEDT)
Received: by mail-oi0-x243.google.com with SMTP id i127so13314010oia.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 12:21:35 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v2] console: use first console if stdout-path device
 doesn't appear
To: Paul Burton <paul.burton@imgtec.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <87zill13z8.fsf@concordia.ellerman.id.au>
 <20161031121455.23280-1-paul.burton@imgtec.com>
 <1593250.MZpe3pfUW6@np-p-burton>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo
 <tj@kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <8c0538ec-6922-3c43-d944-8ac9cd57a708@lwfinger.net>
Date: Mon, 31 Oct 2016 14:21:30 -0500
MIME-Version: 1.0
In-Reply-To: <1593250.MZpe3pfUW6@np-p-burton>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2016 10:50 AM, Paul Burton wrote:
> On Monday, 31 October 2016 12:14:55 GMT Paul Burton wrote:
>> If a device tree specified a preferred device for kernel console output
>> via the stdout-path or linux,stdout-path chosen node properties there's
>> no guarantee that it will have specified a device for which we have a
>> driver. It may also be the case that we do have a driver but it doesn't
>> call of_console_check() to register as a preferred console (eg. offb
>> driver as used on powermac systems). In these cases try to ensure that
>> we provide some console output by enabling the first usable registered
>> console, which we keep track of with the of_fallback_console variable.
>>
>> Tested in QEMU with a PowerPC pseries_defconfig kernel.
>
> Actually whilst this fixes the output in QEMU it has other problems. I'm still
> digging...

As expected, it does n ot work with 4.9-rc3 on the real PowerPC.

Larry
