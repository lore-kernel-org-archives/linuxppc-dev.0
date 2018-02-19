Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlHCy5zqnzDr12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:36:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param
 xmon=off
In-Reply-To: <87d116wy6g.fsf@vajain21.in.ibm.com>
References: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com>
 <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com>
 <8737264c91.fsf@vajain21.in.ibm.com>
 <87eflnre7w.fsf@concordia.ellerman.id.au>
 <87d116wy6g.fsf@vajain21.in.ibm.com>
Date: Mon, 19 Feb 2018 19:36:43 +1100
Message-ID: <877er9l6jo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> <snip>
<snip>
>>
>> What would be nice is if we keep that behaviour, but any action you take
>> in xmon that requires xmon to remain resident, ie. setting a breakpoint,
>> calls a function which makes sure xmon_on = true and if it wasn't prints
>> a nice message saying "Turning xmon on due to breakpoint insertion" or
>> something.

> That makes sense to me and sounds workable. However we already have a
> debugfs interface to enable/disable xmon debugger hook. I can also tweak
> this interface to also register the sysrq key when xmon is enabled. This
> should provide the user the ability to still use xmon if they want to
> after the system has booted with xmon=off.

I agree that sounds sensible, but it has one fatal flaw IMO.

Currently you can boot a box with XMON_DEFAULT=n, and it will crash dump
and so on, but if the box gets stuck you can jump on the console and
drop into xmon with sysrq-x.

If we additionally require xmon to be enabled via debugfs every boot
that will break the above use case, and I don't want to do that.

So in short I think I like my idea better :)

cheers
