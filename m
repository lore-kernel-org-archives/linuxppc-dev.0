Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.176])
	by ozlabs.org (Postfix) with ESMTP id A649BB70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Oct 2010 08:59:06 +1100 (EST)
Message-ID: <4CC20923.8050400@neli.hopto.org>
Date: Fri, 22 Oct 2010 23:58:59 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Subject: Re: [PATCH -mm 0/2] RapidIO: Changes to handling of RIO switches
References: <1287688250-14226-1-git-send-email-alexandre.bounine@idt.com>
	<4CC0AD74.8070800@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445906@CORPEXCH1.na.ads.idt.com>
	<4CC1D7DE.7060405@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445A6B@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E55201445A6B@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bounine, Alexandre wrote:
> Micha Nelissen <micha@neli.hopto.org> wrote:
>> rswitch->rdev->destid should be the id associated with a given switch,
>> so that every (processor) device can agree what id some switch has.
> 
> If we will need to identify the same physical switch by different
> processors we may use the component tag which now is unique for every
> device.

Yes, identification is the point. I think it might be confusing to have 
a destid *and* a component tag id which are slightly different. The 
destid is unambiguous (if you know whether the device is a switch or 
endpoint) so I think it makes sense to use that if possible.

> This actually gives me another idea: instead of using global
> next_switchid counter make rswitch->switchid = component_tag and
> switches in sysfs will look identical for every processor (or just get
> rid of rswitch->switchid and use component_tag directly for switches).

I still prefer the destid as the single identification id.

Micha
