Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 0015BDDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 14:08:41 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1448197yxb.39
	for <linuxppc-dev@ozlabs.org>; Sun, 10 May 2009 21:08:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1242007203.7767.28.camel@concordia>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 10 May 2009 22:08:19 -0600
Message-ID: <fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
Subject: Re: device trees.
To: michael@ellerman.id.au
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, dhlii@dlasys.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 10, 2009 at 8:00 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Sat, 2009-05-09 at 14:51 -0600, Grant Likely wrote:
>> On Fri, May 8, 2009 at 10:03 AM, David H. Lynch Jr. <dhlii@dlasys.net> w=
rote:
>> > =A0 =A0Is there an example somewhere that shows building a device tree=
 on
>> > the fly ?
>> >
>> > =A0 =A0As our products move forward it becomes increasingly clear that
>> > static configurations are not going to work.
>
>> To use device tree with partial reconfiguration would require rework
>> to the device tree infrastructure to prune and graft portions of the
>> device tree. =A0I think it is possible, but it is non-trivial to get
>> working.
>
> arch/powerpc/platforms/pseries/reconfig.c
>
> Not pretty, but it does more or less what you're talking about. Would
> need some work to get it going on !pseries obviously.

Heh, I didn't even know this existed.  :-)

Thinking about this more, it seems to me that the tricky bit would be
figuring out how to drop all references to a node before it is pruned
from the tree.  of_platform_devices would probably be the easiest
because the bus could walked before pruning the node, but there are
also references on the i2c, spi and mdio busses that must be dealt
with appropriately.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
