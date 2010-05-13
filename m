Return-Path: <paulus@ozlabs.org>
Date: Thu, 13 May 2010 10:09:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [PATCH] powerpc: fix register_power_pmu() section mismatch warning
Message-ID: <20100513000923.GD11450@brick.ozlabs.ibm.com>
References: <1273687486-13381-1-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1273687486-13381-1-git-send-email-albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 12, 2010 at 08:04:46PM +0200, Albert Herranz wrote:

> Add missing __cpuinit annotations to fix a bunch of warnings like the one
> shown below when building a kernel for the PowerPC architecture with
> CONFIG_DEBUG_SECTION_MISMATCH=y.
> 
> WARNING: arch/powerpc/kernel/built-in.o(.text+0x11c72): Section mismatch in reference from the function register_power_pmu() to the variable .cpuinit.data:power_pmu_notifier_nb.23552
> The function register_power_pmu() references
> the variable __cpuinitdata power_pmu_notifier_nb.23552.
> This is often because register_power_pmu lacks a __cpuinitdata
> annotation or the annotation of power_pmu_notifier_nb.23552 is wrong.

Hmmm, I would think these things could be just plain __init, not
__cpuinit.  They're not called on cpu hotplug events.

Paul.
