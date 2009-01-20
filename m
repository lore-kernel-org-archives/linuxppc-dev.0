Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f20.google.com (mail-gx0-f20.google.com
	[209.85.217.20]) by ozlabs.org (Postfix) with ESMTP id 672A6474C7
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 03:00:29 +1100 (EST)
Message-ID: <fa686aa40901200800j51ee6799i888951889d6901d2@mail.gmail.com>
Date: Tue, 20 Jan 2009 09:00:26 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Roman Fietze" <roman.fietze@telemotive.de>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"devicetree-discuss list" <devicetree-discuss@ozlabs.org>
Subject: Re: Kernel Documentation MPC52xx Device Tree Bindings
In-Reply-To: <200901200844.40924.roman.fietze@telemotive.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200901200844.40924.roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2009 at 12:44 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> Hello Grant,
>
> Sorry for mailing to you directly, but joining the appropriate mailing
> lists just for posting this one thing doesn't make too much sense.

You don't need to subscribe to post to the list.  Just email the list
and CC: me.  When I reply it will go to both you *and* the list.

>
> In
>
>  Documentation/powerpc/mpc52xx-device-tree-bindings.txt
>
> you wrote or at least submitted:
>
>  For example, PSC5 might be physically connected to the port labeled
>  'COM1' and PSC1 wired to 'COM1'.  In this case, PSC5 would have a
>  "port-number = <0>" property, and PSC1 would have "port-number =
>  <1>".
>
>
> Shouldn't this read 'COM0' instead of 'COM1' for PSC5?

Yes, you are right, but this description is wrong on another level
too.  I need to rewrite it.  Don't depend on the port-number property
sticking around forever.  It was an ignorant hack and a better way of
choosing human friendly labels to devices is to add properties to the
'aliases' node.  Something like this:

aliases {
        serial0 = &PSC5;
        serial1 = &PSC0;
};

where PSC5 and PSC0 are labels (used by the dtc compiler) on the psc5
and psc0 nodes.  You can see lots of examples of this in
arch/powerpc/boot/dts/

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
