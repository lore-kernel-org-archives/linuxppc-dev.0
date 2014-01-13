Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id B93B32C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 08:06:34 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 0/9] cpuidle: rework device state count handling
Date: Mon, 13 Jan 2014 22:20:27 +0100
Message-ID: <1616617.RcagPEYAid@vostro.rjw.lan>
In-Reply-To: <2079155.EyEBRDoJjP@vostro.rjw.lan>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
 <2079155.EyEBRDoJjP@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 kyungmin.park@samsung.com, linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday, January 11, 2014 01:37:29 AM Rafael J. Wysocki wrote:
> On Friday, December 20, 2013 07:47:22 PM Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> > 
> > Some cpuidle drivers assume that cpuidle core will handle cases where
> > device->state_count is smaller than driver->state_count, unfortunately
> > currently this is untrue (device->state_count is used only for handling
> > cpuidle state sysfs entries and driver->state_count is used for all
> > other cases) and will not be fixed in the future as device->state_count
> > is planned to be removed [1].
> > 
> > This patchset fixes such drivers (ARM EXYNOS cpuidle driver and ACPI
> > cpuidle driver), removes superflous device->state_count initialization
> > from drivers for which device->state_count equals driver->state_count
> > (POWERPC pseries cpuidle driver and intel_idle driver) and finally
> > removes state_count field from struct cpuidle_device.
> > 
> > Additionaly (while at it) this patchset fixes C1E promotion disable
> > quirk handling (in intel_idle driver) and converts cpuidle drivers code
> > to use the common cpuidle_[un]register() routines (in POWERPC pseries
> > cpuidle driver and intel_idle driver).
> > 
> > [1] http://permalink.gmane.org/gmane.linux.power-management.general/36908
> > 
> > Reference to v1:
> > 	http://comments.gmane.org/gmane.linux.power-management.general/37390
> > 
> > Changes since v1:
> > - synced patch series with next-20131220
> > - added ACKs from Daniel Lezcano
> 
> This series breaks boot on one of my test machines with intel_idle, so I'm
> not sure how well it has been tested.
> 
> I've dropped it entirely for now.  If I have the time, I will try to identify
> the root cause of the failure, but that may not happen before the merge window.
> Sorry about that.

The breakage was introduced by patch [8/9], so I've re-applied patches [1-7/9]
from this series.  Please refer to Fengguang's report [1] for the breakage
details.

Thanks!

[1] http://marc.info/?l=linux-kernel&m=138964167909907&w=2

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
