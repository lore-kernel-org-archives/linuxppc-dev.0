Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 386AF2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 00:03:11 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 18/18] cpufreq: powerpc/platforms/cell: move cpufreq
 driver to drivers/cpufreq
Date: Thu, 4 Apr 2013 13:02:09 +0000
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <0f989533f2e47d4d632710029bf0273082bafee3.1365079581.git.viresh.kumar@linaro.org>
In-Reply-To: <0f989533f2e47d4d632710029bf0273082bafee3.1365079581.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201304041302.09995.arnd@arndb.de>
Cc: robin.randhawa@arm.com, linux-pm@vger.kernel.org, patches@linaro.org,
 Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org,
 rjw@sisk.pl, Steve.Bannister@arm.com, arvind.chauhan@arm.com,
 linuxppc-dev@lists.ozlabs.org, linaro-kernel@lists.linaro.org,
 charles.garcia-tobin@arm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 04 April 2013, Viresh Kumar wrote:
> This patch moves cpufreq driver of powerpc platforms/cell to drivers/cpufreq.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Compile Tested only.
> 
>  arch/powerpc/platforms/cell/Kconfig                | 26 +---------------------
>  arch/powerpc/platforms/cell/Makefile               |  3 ---
>  drivers/cpufreq/Kconfig.powerpc                    | 18 +++++++++++++++
>  drivers/cpufreq/Makefile                           |  3 +++
>  .../cpufreq/ppc_cbe_cpufreq.c                      |  2 +-
>  .../cpufreq/ppc_cbe_cpufreq_pervasive.c            |  3 +--
>  .../cpufreq/ppc_cbe_cpufreq_pmi.c                  |  3 +--
>  .../linux/ppc_cbe_cpufreq.h                        |  4 ++--

Moving the files is good, but I don't see a reason to make the cbe_cpufreq.h
header globally visible in include/linux/. Isn't it just used by as the
interface between ppc_cbe_cpufreq_pmi.c  and ppc_cbe_cpufreq.c?

	Arnd
