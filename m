Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3DA12DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 02:37:44 +1100 (EST)
Date: Fri, 6 Feb 2009 18:37:41 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FSL eSDHC bindings update
Message-ID: <20090206153741.GA17699@oksana.dev.rtsoft.ru>
References: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
	<A7909298-D656-4BDE-BB02-0D6A8036045D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <A7909298-D656-4BDE-BB02-0D6A8036045D@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 05, 2009 at 08:52:56PM -0600, Kumar Gala wrote:
> On Feb 5, 2009, at 1:04 PM, Anton Vorontsov wrote:
>> On Thu, Jan 22, 2009 at 01:15:01PM -0600, Kumar Gala wrote:
>>> On Jan 21, 2009, at 8:00 PM, Anton Vorontsov wrote:
>>>> This patch adds a new driver: sdhci-of. The driver is similar to
>>>> the sdhci-pci, it contains common probe code, and controller- 
>>>> specific
>>>> ops and quirks.
>>>>
>>>> So far there are only Freescale eSDHC ops and quirks.
>>>>
>>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>>> ---
>>>> drivers/mmc/host/Kconfig    |   10 ++
>>>> drivers/mmc/host/Makefile   |    1 +
>>>> drivers/mmc/host/sdhci-of.c |  274 ++++++++++++++++++++++++++++++++ 
>>>> ++
>>>> +++++++++
>>>> 3 files changed, 285 insertions(+), 0 deletions(-)
>>>> create mode 100644 drivers/mmc/host/sdhci-of.c
>>>
>>> Still griping about lack of OF binding docs for this.
>>
>> Here they're.
>>
>> I'm assuming that MPC8536 is the first chip in 85xx family with eSDHC.
>
> thanks.  MPC8536 is the first.  Do we need a u-boot patch for clock- 
> frequency on 85xx?

Yes, I'll prepare U-Boot patches soon (on top of Andy Fleming's
eSDHC work):
http://www.mail-archive.com/u-boot@lists.denx.de/msg04183.html

W/o the U-Boot patches SDHCI driver will just fail to probe
(gracefully, saying that the controller doesn't specify sdclk).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
