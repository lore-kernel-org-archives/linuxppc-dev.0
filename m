Return-Path: <martyn.welch@ge.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D2E1B7D1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Jun 2010 19:12:26 +1000 (EST)
Message-ID: <4C0771F3.2000106@ge.com>
Date: Thu, 03 Jun 2010 10:12:19 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] PowerPC: Remove hardcoded BAT configuration of IMMR in
	CPM	early debug console
References: <20100528151836.5889.10393.stgit@ES-J7S4D2J.amer.consind.ge.com>	<4BFFECF1.9060809@freescale.com>
	<4C050295.408@ge.com> <4C050E84.2010602@ge.com>
	<4C053008.50306@freescale.com> <4C0610F8.6020801@ge.com>
	<4C068691.6040501@freescale.com>
In-Reply-To: <4C068691.6040501@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On 06/02/2010 03:06 AM, Martyn Welch wrote:
>>>>> I think that's a more fundamental change to CPM early debug than I
>>>>> can
>>>>> handle right now.
>>>
>>> Is IMMRBASE on your board at some address that has a low likelihood of
>>> conflicting when treated as a kernel effective address?
>>
>> It's at 0x0f000000, is seems ok, but then I'm not sure I fully
>> understand kernel effective addresses.
>
> That overlaps userspace -- is the BAT cleared before userspace starts?
>

To be honest, once I'd got the device booting past the early debug
stage, I rebuilt the kernel without udbg in it...

> If you don't want to do the fixmap stuff, might want to at least just
> leave it at the current arbitrary effective address, which hasn't
> seemed to cause much trouble so far.
>

Given that I've now switched udbg off in the kernel config, I really
can't substantiate spending much more time on this. This patch was
mainly to help others that maybe struggling to bring up Linux on a
device with CPM serial.

I'll try and get a revised patch out soon which keeps the current
arbitrary effective address.

Martyn

> But fixmap is the right way to do it.
>
> -Scott


-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
