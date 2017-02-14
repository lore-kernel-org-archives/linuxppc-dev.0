Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMmkR3NjhzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 13:35:59 +1100 (AEDT)
Received: by mail-it0-x244.google.com with SMTP id e137so2239067itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 18:35:59 -0800 (PST)
Date: Tue, 14 Feb 2017 12:35:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, xinhui.pan@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/xmon: add debugfs entry for xmon
Message-ID: <20170214123540.38b995cb@roar.ozlabs.ibm.com>
In-Reply-To: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 13 Feb 2017 19:00:42 -0200
"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> wrote:

> Currently the xmon debugger is set only via kernel boot command-line.
> It's disabled by default, and can be enabled with "xmon=on" on the
> command-line. Also, xmon may be accessed via sysrq mechanism, but once
> we enter xmon via sysrq,  it's  kept enabled until system is rebooted,
> even if we exit the debugger. A kernel crash will then lead to xmon
> instance, instead of triggering a kdump procedure (if configured), for
> example.
> 
> This patch introduces a debugfs entry for xmon, allowing user to query
> its current state and change it if desired. Basically, the "xmon" file
> to read from/write to is under the debugfs mount point, on powerpc
> directory. Reading this file will provide the current state of the
> debugger, one of the following: "on", "off", "early" or "nobt". Writing
> one of these states to the file will take immediate effect on the debugger.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
> * I had this patch partially done for some time, and after a discussion
> at the kernel slack channel latest week, I decided to rebase and fix
> some remaining bugs. I'd change 'x' option to always disable the debugger,
> since with this patch we can always re-enable xmon, but today I noticed
> Pan's patch on the mailing list, so perhaps his approach of adding a flag
> to 'x' option is preferable. I can change this in a V2, if requested.
> Thanks in advance!

xmon state changing after the first sysrq+x violates principle of least
astonishment, so I think that should be fixed.

Then the question is, is it worth making it runtime configurable with xmon
command or debugfs tunables?

Thanks,
Nick
