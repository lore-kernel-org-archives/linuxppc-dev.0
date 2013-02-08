Return-Path: <fweisbec@gmail.com>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C5E62C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2013 01:32:00 +1100 (EST)
Received: by mail-bk0-f46.google.com with SMTP id j5so1715269bkw.33
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2013 06:31:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130208141447.03914013db9a5f7308fc1675@canb.auug.org.au>
References: <1359399845-10568-1-git-send-email-fweisbec@gmail.com>
 <1359399845-10568-5-git-send-email-fweisbec@gmail.com>
 <20130208140749.5a094f271e529dacfb962b51@canb.auug.org.au>
 <20130208141447.03914013db9a5f7308fc1675@canb.auug.org.au>
Date: Fri, 8 Feb 2013 15:31:55 +0100
Message-ID: <CAFTL4hyx+hSg5n4D+PMTG6OBVgX66tkHcM7S2EvNYqv95qoC7w@mail.gmail.com>
Subject: Re: [PATCH 4/8] cputime: Generic on-demand virtual cputime accounting
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Namhyung Kim <namhyung.kim@lge.com>, Li Zhong <zhong@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/2/8 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Frederic,
>
> On Fri, 8 Feb 2013 14:07:49 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> This patch has the side effect of changing the default configurations:
>> (This is PowerPC pseries_defconfig before/after this patch)
>>
>> @@ -119,8 +120,8 @@
>>  #
>>  # CPU/Task time and stats accounting
>>  #
>> -# CONFIG_TICK_CPU_ACCOUNTING is not set
>> -CONFIG_VIRT_CPU_ACCOUNTING=y
>> +CONFIG_TICK_CPU_ACCOUNTING=y
>> +# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
>>  # CONFIG_BSD_PROCESS_ACCT is not set
>>  CONFIG_TASKSTATS=y
>>  CONFIG_TASK_DELAY_ACCT=y
>>
>> I don't know if that was deliberate, but it was suprising.  I noticed
>> when this patch entered next-20130207.
>
> I suspect that this is caused by the changes to init/Kconfig:
>
> diff --git a/init/Kconfig b/init/Kconfig
> index be8b7f5..a05f843 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -326,6 +326,9 @@ source "kernel/time/Kconfig"
>
>  menu "CPU/Task time and stats accounting"
>
> +config VIRT_CPU_ACCOUNTING
> +       bool
> +
>  choice
>         prompt "Cputime accounting"
>         default TICK_CPU_ACCOUNTING if !PPC64
>
> The next line of context is:
>
>         default VIRT_CPU_ACCOUNTING if PPC64
>
> Which may have needed changing as well?  Indeed, changing that to
> VIRT_CPU_ACCOUNTING_NATIVE restores the old defaults.

Indeed, thanks for your fix!
