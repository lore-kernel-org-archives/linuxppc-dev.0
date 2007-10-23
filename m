Return-Path: <timur@freescale.com>
Message-ID: <471E12C7.8020509@freescale.com>
Date: Tue, 23 Oct 2007 10:27:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
In-Reply-To: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> Is this what the device tree entries should look like?
> 
> First example is ac97 audio:
> 
> ac97@2000 {           // PSC1
>       device_type = "sound";
>       compatible = "mpc5200b-psc-ac97\0mpc5200-psc-ac97";
>       cell-index = <0>;
>       reg = <2000 100>;
>       interrupts = <2 1 0>;
>       interrupt-parent = <&mpc5200_pic>;
>       codec-handle = <&codec0>
> };

I think the codec node should be a child of this node, not a separate node. 
Then there should be another codec node as a child of the i2c node.  The first 
codec node should reference the other one via a phandle (so this part you 
already have correct).
