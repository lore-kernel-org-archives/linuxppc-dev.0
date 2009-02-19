Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CBB8EDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 04:29:07 +1100 (EST)
Date: Thu, 19 Feb 2009 20:29:02 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/83xx: Do not configure or probe disabled FSL
	DR USB controllers
Message-ID: <20090219172902.GA11227@oksana.dev.rtsoft.ru>
References: <20090219160223.GA2095@oksana.dev.rtsoft.ru>
	<8EC0BAAB-7261-406F-BA42-BE6D9EC55AAB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <8EC0BAAB-7261-406F-BA42-BE6D9EC55AAB@kernel.crashing.org>
Cc: Liu Dave <DaveLiu@freescale.com>, Andy Fleming <afleming@freescale.com>,
	linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 19, 2009 at 10:19:05AM -0600, Kumar Gala wrote:
>
> On Feb 19, 2009, at 10:02 AM, Anton Vorontsov wrote:
>
>> On MPC837X CPUs Dual-Role USB isn't always available (for example DR
>> USB pins can be muxed away to eSDHC).
>>
>> U-Boot adds status = "disabled" property into the DR USB nodes to
>> indicate that we must not try to configure or probe Dual-Role USB,
>> otherwise we'll break eSDHC support on targets with MPC837X CPUs.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> arch/powerpc/platforms/83xx/usb.c |    3 ++-
>> arch/powerpc/sysdev/fsl_soc.c     |    4 ++++
>> 2 files changed, 6 insertions(+), 1 deletions(-)
>
> Mind looking at possibly killing the fsl_soc.c  usb code and making the 
> usb a real of-platform driver?

Sure, but it's a bit complicated because of OTG support (which
doesn't currently work, btw).

Just need to think about whether we want to leave UDC and HOST
drivers as pure platform drivers, and implement an of platform
driver as a proxy for Host/UDC/OTG...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
