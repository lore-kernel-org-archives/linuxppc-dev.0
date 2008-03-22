Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C3500DDF5D
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 03:38:41 +1100 (EST)
Message-ID: <47E53661.9010508@ru.mvista.com>
Date: Sat, 22 Mar 2008 19:40:01 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
References: <12060242324116-git-send-email-john.linn@xilinx.com>	
	<20080320144402.3063517C005D@mail148-sin.bigfish.com>	
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>	
	<47E3B189.6060002@ru.mvista.com>
	<fa686aa40803220806w3288ab8ew754404a5aee152cf@mail.gmail.com>
In-Reply-To: <fa686aa40803220806w3288ab8ew754404a5aee152cf@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

>> > Personally, I'm not fond of this approach.  There is already some
>> > traction to using the reg-shift property to specify spacing, and I
>> > think it would be appropriate to also define a reg-offset property to
>> > handle the +3 offset and then let the xilinx 16550 nodes use those.

>>    That's making things only worse than the mere "reg-shift" idea. I think
>> that both are totally wrong. Everything about the programming interface should
>> be said in the "compatible" and possibly "model" properties. of_serial driver
>> should recognize them and pass the necessary details to 8250.c. As for me, I'm
>> strongly against plaguing the device tree with the *Linux driver
>> implementation specifics* (despite I was trying this with MTD -- there it
>> seemed somewhat more grounded :-).

> Not true.  Compatible defines what the node is describing.  It is
> perfectly valid for a compatible value definition to also defines some
> additional properties that can be queried for interface details.
> Xilinx is completely free to define a "xlnx,..." compatible value for
> their ns16550 compatible device.  However, 'sparse' ns16550 devices
> are a common and well known variation so I think it is valid and
> reasonable to define a compatible binding for this case.

    We have been mostly talking about the 16550-compatible devices which 
external circuitry makes "sparse" so far. This is surely not a property of a 
16550 device to be "sparse" or not, although some say that this doesn't 
matter. :-)

> As for using a new binding like "sparse16550" instead of extending

    That "sparse16550" again... what if it's a superset of 16550 (not an 
uncommon case too), will you also define "sparce16650", "sparse16570", and so 
on? :-)

> "ns16550"; it is because reg-shift and reg-offset would be required
> nodes and therefore is not compatible with drivers using the original
> ns16550 binding.  Using a new namespace gives freedom to define the
> required properties.

    You'll have to define several namespaces I'm afraid...

> Cheers,
> g.

WBR, Sergei
