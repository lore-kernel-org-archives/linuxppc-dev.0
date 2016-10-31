Return-Path: <larry.finger@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6zYB0FnqzDvMT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 02:58:21 +1100 (AEDT)
Received: by mail-oi0-x243.google.com with SMTP id v84so6128955oie.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 08:58:21 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v2] console: use first console if stdout-path device
 doesn't appear
To: Paul Burton <paul.burton@imgtec.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <87zill13z8.fsf@concordia.ellerman.id.au>
 <20161031121455.23280-1-paul.burton@imgtec.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo
 <tj@kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <61cdc997-61e8-7f30-ba19-35f692a39458@lwfinger.net>
Date: Mon, 31 Oct 2016 10:58:17 -0500
MIME-Version: 1.0
In-Reply-To: <20161031121455.23280-1-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2016 07:14 AM, Paul Burton wrote:
> If a device tree specified a preferred device for kernel console output
> via the stdout-path or linux,stdout-path chosen node properties there's
> no guarantee that it will have specified a device for which we have a
> driver. It may also be the case that we do have a driver but it doesn't
> call of_console_check() to register as a preferred console (eg. offb
> driver as used on powermac systems). In these cases try to ensure that
> we provide some console output by enabling the first usable registered
> console, which we keep track of with the of_fallback_console variable.
>
> Tested in QEMU with a PowerPC pseries_defconfig kernel.

The patch fails to fix my real PowerPC. I still get a kernel panic for an 
attempt to kill init. This first test was done with 4.9-rc2. I am in the process 
of updating to -rc3 to see if that changes anything. Later today when that build 
finishes, I will report those results.

Larry
