Return-Path: <cbf123@mail.usask.ca>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F5BF2C0174
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 09:09:04 +1000 (EST)
Message-ID: <51E32F76.5070502@mail.usask.ca>
Date: Sun, 14 Jul 2013 17:08:38 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
References: <51DF1BBB.5060904@mail.usask.ca>	 <51DF2229.5010604@mail.usask.ca>
 <20130712012142.GA24112@concordia>	 <51E07056.8040007@mail.usask.ca>
 <51E08A40.80900@mail.usask.ca>	 <51E0F41A.20904@mail.usask.ca>
 <20130714043600.GA30717@concordia> <1373779584.19894.270.camel@pasglop>
In-Reply-To: <1373779584.19894.270.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2013 11:26 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2013-07-14 at 14:36 +1000, Michael Ellerman wrote:
>>>> Is this expected behaviour? It seems to be the same in current git
>>>> versions of kexec-tools.
>>>>
>>>> On my system I see "/proc/device-tree/memory".
>>>>
>>>> If I modify add_usable_mem_property() to also accept "/memory" then
>> my
>
> This is a bug in your device-tree. The memory node should have a unit
> address which corresponds to it's reg property. I know people tend to
> skip it for "0" but it's bad practice.
>
> So for memory starting at 0 it should be memory@0

There are a fair number of dts files in the kernel tree that don't 
specify an address for the memory node.

If the kernel accepts it without an address, it seems logical that kexec 
should as well.

Or maybe the kernel should just implicitly assume an address of zero and 
export it as such in /proc/device-tree?

Chris
