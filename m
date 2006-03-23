Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D2AFF67B36
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 07:13:32 +1100 (EST)
Date: Thu, 23 Mar 2006 14:12:58 -0600
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] kdump: Fix for machine checkstop on DMA fault
Message-ID: <20060323201258.GA5538@pb15.lixom.net>
References: <44222462.2030103@us.ibm.com>
	<20060323053854.GA17693@pb15.lixom.net>
	<200603231706.35508.michael@ellerman.id.au>
	<20060323061904.GA22439@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060323061904.GA22439@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olaf Hering <olh@suse.de>, ellerman@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 23, 2006 at 12:19:04AM -0600, Olof Johansson wrote:

> The crash kernel needs to be even more careful, and instead read out
> the entries that are mapped and reserve them. This would require a bit
> more plumbing since there's no way to read an entry right now, but it'd
> remove that hole.

Actually, what's probably easier is to allocate some entries when the
purgatory is set up, and make the crash kernel only use those by modifying
the device tree accordingly. Sort of how regular memory is handled right
now. That'd be a cleaner solution with less changes needed.

The trick will be to get a decent size contiguous allocation, but the
same applies for the memory reserve.


-Olof
