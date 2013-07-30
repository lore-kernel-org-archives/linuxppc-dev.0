Return-Path: <rjw@sisk.pl>
Received: from hydra.sisk.pl (hydra.sisk.pl [212.160.235.94])
 by ozlabs.org (Postfix) with ESMTP id BAA382C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 23:23:39 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: fix unremovable issue for module driver
Date: Tue, 30 Jul 2013 15:33:44 +0200
Message-ID: <2534583.WCBIj5YC29@vostro.rjw.lan>
In-Reply-To: <51F7A152.3030602@linaro.org>
References: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259FEF32C@039-SN2MPN1-021.039d.mgd.msft.net>
 <51F7A152.3030602@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Wang Dongsheng-B40534 <B40534@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, July 30, 2013 01:19:46 PM Daniel Lezcano wrote:
> On 07/30/2013 12:48 PM, Wang Dongsheng-B40534 wrote:
> > 
> > 
> >> -----Original Message-----
> >> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
> >> Sent: Tuesday, July 30, 2013 5:28 PM
> >> To: Wang Dongsheng-B40534
> >> Cc: rjw@sisk.pl; linux-pm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> >> Subject: Re: [PATCH] cpuidle: fix unremovable issue for module driver
> >>
> >> On 07/30/2013 08:55 AM, Dongsheng Wang wrote:
> >>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >>>
> >>> After __cpuidle_register_device, the cpu incs are added up, but decs
> >>> are not, thus the module refcount is not match. So the module "exit"
> >>> function can not be executed when we do remove operation. Move
> >>> module_put into __cpuidle_register_device to fix it.
> >>
> >> Sorry, I still don't get it :/
> >>
> >> register->module_get
> >> unregister->module_put
> >>
> >> you change it by:
> >>
> >> register->module_get
> >> register->module_put
> >> unregister->none
> >>
> >> which is wrong.
> >>
> > module_get->set per cpu incs=1
> > module_put->set per cpu decs=1
> > 
> > module_refcount-> incs - decs;
> > 
> > "unregister" usually call in module->exit function. 
> > But if module_refcount is not zero, the module->exit() cannot be executed.
> 
> Ok, IIUC, the refcount is decremented in the unregister function but
> this one is never called because the refcount is not zero.
> 
> Funny, that means the module format was *never* used at all as it does
> not work.
> 
> I am wondering if we shouldn't just remove the module support for
> cpuidle. Rafael ?

That would be the simplest thing to do and possibly the most correct one too,
but I need to double check how inte_idle/ACPI idle interactions depend on that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
