Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85CFF1A00ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 16:26:55 +1000 (EST)
Received: by mail-ob0-f169.google.com with SMTP id uz6so5182352obc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:26:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53F57E51.4060200@gmail.com>
References: <1408015178-21745-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAKohponDNHYrD9b==cp+pVmAi2ygA9-HcLZWqr4w3DDivB=-Ng@mail.gmail.com>
 <53F57E51.4060200@gmail.com>
Date: Thu, 21 Aug 2014 11:56:52 +0530
Message-ID: <CAKohpon8ANWoy52B=_nSuNyHALrsQOLX4cA+690E=CifnVRFtg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: Register the driver with reboot notifier
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpabhatppc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 August 2014 10:36, Shilpasri G Bhat <shilpabhatppc@gmail.com> wrote:
> The intention here is stop the cpufreq governor and then to set the cpus to
> nominal frequency so as to ensure that the frequency won't be changed later.
>
> The .suspend callback of the driver is not called during reboot/kexec.
> So we need an explicit reboot notifier to call cpufreq-suspend() to
> suffice the requirement.

Hi Shilpa,

No, we can't allow any platform driver to misuse cpufreq_suspend().
Platform drivers aren't *allowed* to call this routine.

Now the deal is how do we move to nominal frequency on reboot..
@Rafael: Any suggestions? How do we ensure that governors
are stopped on these notifiers, or if there is some other solution here?
