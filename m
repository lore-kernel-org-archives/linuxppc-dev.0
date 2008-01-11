Return-Path: <jonsmirl@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by ozlabs.org (Postfix) with ESMTP id 08CE9DE016
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 02:52:58 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so671306nzh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 07:52:57 -0800 (PST)
Message-ID: <9e4733910801110752k57f1fd7crd5f143900fc64f0b@mail.gmail.com>
Date: Fri, 11 Jan 2008 10:52:56 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 0/5] Version 17,
	series to add device tree naming to i2c
In-Reply-To: <20080111095638.775670ed@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071220044136.20091.70984.stgit@terra.home>
	<20080111095638.775670ed@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/11/08, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Jon,
>
> On Wed, 19 Dec 2007 23:41:36 -0500, Jon Smirl wrote:
> > Since copying i2c-mpc.c to maintain support for the ppc architecture seems to be an issue; instead rework i2c-mpc.c to use CONFIG_PPC_MERGE #ifdefs to support both the ppc and powerpc architecture. When ppc is deleted in six months these #ifdefs will need to be removed.
> >
> > Another rework of the i2c for powerpc device tree patch. This version implements standard alias naming only on the powerpc platform and only for the device tree names. The old naming mechanism of i2c_client.name,driver_name is left in place and not changed for non-powerpc platforms. This patch is fully capable of dynamically loading the i2c modules. You can modprobe in the i2c-mpc driver and the i2c modules described in the device tree will be automatically loaded. Modules also work if compiled in.
> >
> > The follow on patch to module-init-tools is also needed since the i2c subsystem has never implemented dynamic loading.
> >
> > The following series implements standard linux module aliasing for i2c modules on arch=powerpc. It then converts the mpc i2c driver from being a platform driver to an open firmware one. I2C device names are picked up from the device tree. Module aliasing is used to translate from device tree names into to linux kernel names. Several i2c drivers are updated to use the new aliasing.
>
> Now that I have read all the previous versions of this patch series
> and, more importantly, all objections that were raised on the way, I
> can start reviewing the latest iteration of your patches. I'll also do
> some testing, although I have no powerpc stuff here, but at least I
> want to make sure that there are no regressions introduced by your
> patches on x86.


Various people were worried about x86. Around version 15 I altered the
patches so that they only impacted PowerPC. If they impact x86 in
current form that is a bug.

When x86 is ready for it I do think dynamic module loading should be
implemented there also.
>
> --
> Jean Delvare
>


-- 
Jon Smirl
jonsmirl@gmail.com
