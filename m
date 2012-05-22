Return-Path: <glikely@secretlab.ca>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D0B2B6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 06:10:12 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so11114939pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 13:10:11 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4FBBECC2.10503@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
 <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
 <20120520055436.13AF03E03B8@localhost>
 <20120520060802.03CE73E03B8@localhost> <4FBBECC2.10503@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 22 May 2012 14:09:50 -0600
Message-ID: <CACxGe6tYQVfPRtXxmYF2OPYcEFu+x4-_uzFta9f3mwu=xUrt=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
To: David Daney <ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>, Jaroslav Kysela <perex@perex.cz>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 22, 2012 at 1:45 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 05/19/2012 11:08 PM, Grant Likely wrote:
>>
>> On Sat, 19 May 2012 23:54:36 -0600, Grant
>> Likely<grant.likely@secretlab.ca> =A0wrote:
>>>
>>> On Fri, 11 May 2012 15:05:21 -0700, David Daney<ddaney.cavm@gmail.com>
>>> =A0wrote:
>>>>
>>>> From: David Daney<david.daney@cavium.com>
>>>>
>>>> When generating MODALIASes, it is convenient to add things like "spi:"
>>>> or "i2c:" to the front of the strings. =A0This allows the standard
>>>> modprobe to find the right driver when automatically populating bus
>>>> children from the device tree structure.
>>>>
>>>> Add a prefix parameter, and adjust callers. =A0For
>>>> of_register_spi_devices() use the "spi:" prefix.
>>>>
>>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>>
>>>
>>> Applied, thanks. =A0Some notes below...
>>
>>
>> Wait... why is this necessary?
>
>
> Because in of_register_spi_devices() in of_spi.c, you do:
>
> =A0 =A0 =A0 =A0request_module(spi->modalias);
>
> The string passed to request_module() must have the "spi:" prefix.

How about modifying the call to request_module() to include the prefix
also?  I think that would be a simpler change overall.  Would that
work?

g.
