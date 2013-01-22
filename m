Return-Path: <olof@lixom.net>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43C802C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:01:08 +1100 (EST)
Received: by mail-ie0-f173.google.com with SMTP id e13so11200977iej.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2013 23:01:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1358825006.21576.47.camel@gandalf.local.home>
References: <1358825006.21576.47.camel@gandalf.local.home>
Date: Mon, 21 Jan 2013 23:01:06 -0800
Message-ID: <CAOesGMibLJWXmjRtd4u-RBZoQq1swhFYfRD=KYT0cVg2A93Adg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pasemi: Fix crash on reboot
From: Olof Johansson <olof@lixom.net>
To: Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Jan 21, 2013 at 7:23 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> commit f96972f2dc "kernel/sys.c: call disable_nonboot_cpus() in
> kernel_restart()"
>
> added a call to disable_nonboot_cpus() on kernel_restart(), which tries
> to shutdown all the CPUs except the first one. The issue with the PA
> Semi, is that it does not support CPU hotplug.
>
> When the call is made to __cpu_down(), it calls the notifiers
> CPU_DOWN_PREPARE, and then tries to take the CPU down.
>
> One of the notifiers to the CPU hotplug code, is the cpufreq. The
> DOWN_PREPARE will call __cpufreq_remove_dev() which calls
> cpufreq_driver->exit. The PA Semi exit handler unmaps regions of I/O
> that is used by an interrupt that goes off constantly
> (system_reset_common, but it goes off during normal system operations
> too). I'm not sure exactly what this interrupt does.

On this version of the power architecture, the system comes back
through the reset vector when returning from some of the lower-power
idle states, which should be why you see those exceptions go off.

Thanks for catching this. I have a system that I try booting a few
times every release cycle, but I must have missed checking if reboots
still work. Glad to see you're keeping yours alive, it's becoming a
collectible. :-)

[...]

> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Olof Johansson <olof@lixom.net>

Ben, please apply for 3.8.


-Olof
