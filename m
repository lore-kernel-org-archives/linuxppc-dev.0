Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 8DD78DDF15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 00:46:53 +1100 (EST)
In-Reply-To: <20070320033039.GA21124@localhost.localdomain>
References: <boot-00.miltonm@bga.com> <boot-01.miltonm@bga.com>
	<20070320033039.GA21124@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f7b20d0a2660652ca1ddbb69eb41feb5@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/7] boot: use a common zImage rule
Date: Tue, 20 Mar 2007 08:47:20 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 19, 2007, at 10:30 PM, David Gibson wrote:

> On Mon, Mar 19, 2007 at 02:58:07PM -0600, Milton Miller wrote:
>> Before the plethora of platforms gets any worse, establish a common
>> rule to invoke the wrapper for any platform.  Add arguments to
>> the rule for initrd, dts, dtb, etc.   Show example usage with initrd.
>
> The problem with this patch is that while the wrap command can take a
> dts or dtb, there's no way to specify which should be used with each
> target.

I thought a bit about that before I posted, but didn't write anything.
We could add standard varable names dts-$(platform) dtb-$(platform),
since make would default such names as unset.

But this does raise the point, instead of listing the image names, 
should
we be seelcting the platforms and generating the image names with the
expansion.   That would save us stripping of zImage to get the platform
name in the rule.

I'll try to test this later.

Should I respin patch 3, add FORCE, without this so we can merge that
first?   I put this one first so there would be less adding rules that
would be removed later, but the other is really a bugfix and this is
a cleanup.

milton
