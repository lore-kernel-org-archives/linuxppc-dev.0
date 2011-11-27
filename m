Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 37A18B6F99
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2011 10:07:23 +1100 (EST)
Message-ID: <1322435233.23348.19.camel@pasglop>
Subject: Re: [RFC PATCH v2 4/4] cpuidle: (POWER) Handle power_save=off
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Mon, 28 Nov 2011 10:07:13 +1100
In-Reply-To: <20111117112906.9191.54050.stgit@localhost6.localdomain6>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
 <20111117112906.9191.54050.stgit@localhost6.localdomain6>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-17 at 16:59 +0530, Deepthi Dharwar wrote:
> This patch makes pseries_idle_driver not to be registered when
> power_save=off kernel boot option is specified. The
> boot_option_idle_override variable used here is similar to
> its usage on x86.

Quick Q. With your changes, the CPU will never get into idle at all
until cpuidle initializes and the driver loads.

That means not only much later in the boot process, but potentially
never if the distro has the driver as a module and fails to load it, or
similar.

Can't that be an issue ? Shouldn't we keep at least one of the basic
idle functions as a fallback ?

Cheers,
Ben.
