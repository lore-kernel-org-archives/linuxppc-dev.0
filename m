Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 020EEDE12D
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 02:30:23 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so838493pyi.27
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 09:30:21 -0700 (PDT)
Message-ID: <fa686aa40808150930icad997dl567391bd46766f29@mail.gmail.com>
Date: Fri, 15 Aug 2008 10:30:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sinisa Denic" <sinisa.denic@abs-cs.com>
Subject: Re: mpc52xx localplus bus and dm9000
In-Reply-To: <WorldClient-F200808141152.AA52170076@abs-cs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <WorldClient-F200808141152.AA52170076@abs-cs.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 3:52 AM, Sinisa Denic <sinisa.denic@abs-cs.com> wrote:
> Hi,I have mpc52xx based board very similar to lite5200b.
> There is Davicom DM9000 connected to Local Plus Bus CS0.
> Does anybody have idea how should DTS part look like in order to add this
> resource in system.
> I've written something like this:
>
> lpb {
>                        device_type = "network";

device_type doesn't make any sense here.  Drop this line.

>                        compatible = "fsl,lpb";
>                        ranges = <0 0 ff000000 1000000>;

You need to add #address-cells = <2> and #size-cells = <1> properties
to this node.  Otherwise the address translation doesn't work.  The
local plus bus uses 2 cells to describe address.  First cell is the
chip select and second cell is the address offset on the chip select.

The ranges property translates between the global address space to the
local chip select address space.  In this case, "0 0" means 0 offset
from chip select 0, and ff000000 is the address it is mapped to on the
parent bus.

>
>                        dm9000@0,0 {
>                                compatible = "dm9000";
>                                reg = <0 0 100000>;
>                                #size-cells = <1>;
>                                #address-cells = <1>;

You should not need #address-cells or #size-cells on the child node
because it is not a bus.

>                        };
>                };
>
> but it's not working.
> Is it enough to have right dts record for default dm9000 driver working
> or I have to change something more?
> Thank you in andvance.
>
> Sinisa Denic
> System and software  engineer
> tel: +381(0)112016142
> ABS Control Systems
> bul.Zorana Djindjica 8a
> Belgrade,Serbia
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
