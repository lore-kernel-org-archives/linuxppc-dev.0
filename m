Return-Path: <wg@grandegger.com>
Message-ID: <4B60584A.5050605@grandegger.com>
Date: Wed, 27 Jan 2010 16:14:18 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH v2 1/3] i2c-mpc: use __devinit[data] for initialization
	functions and data
References: <1264452906-32536-1-git-send-email-wg@grandegger.com>
	<1264452906-32536-2-git-send-email-wg@grandegger.com>
	<20100126143507.GA12774@fluff.org.uk>
	<4B5F37FA.8060809@grandegger.com>
	<20100127150801.GC6090@fluff.org.uk>
In-Reply-To: <20100127150801.GC6090@fluff.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Linux-i2c@vger.kernel.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben Dooks wrote:
> On Tue, Jan 26, 2010 at 07:44:10PM +0100, Wolfgang Grandegger wrote:
>> Ben Dooks wrote:
>>> On Mon, Jan 25, 2010 at 09:55:04PM +0100, Wolfgang Grandegger wrote:
[snip]
>>> Any particular reason you decided to move this all about?
>> This was necessary to allow using __devinit[data] for the clock setup
>> functions and clock diviver arrays above which results in some notable
>> saving of memory space if the driver is statically linked into the
>> kernel. If the data is defined within "mpc_i2c_of_match", section
>> mismatches are reported.
>>
>>> Are you sure that __devinitdata is the right thing here, I've no idea
>>> if there is currently any hotplug type support for openfirmware or
>>> not.
>> I agree that __init[data] is more appropriate for this driver even if
>> many other non-hotplugable drivers use __devinit[data]. I will change that.
> 
> sorry, may have gotten confused by which type of __init is which, I
> think __devinit is the correct one here.

Why? It's not obvious to me how a i2c device might be hotpugged? Will
require v4 to fix it.

Thanks,

Wolfgang.
