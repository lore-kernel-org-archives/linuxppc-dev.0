Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (unknown [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 116DADDDEE
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 05:21:35 +1100 (EST)
Message-ID: <49A9809D.9000307@mlbassoc.com>
Date: Sat, 28 Feb 2009 11:21:17 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: OF device mappings
References: <49A97878.6060308@mlbassoc.com>
	<fa686aa40902281004r5fcb67f4md328d79dd1d5d82c@mail.gmail.com>
In-Reply-To: <fa686aa40902281004r5fcb67f4md328d79dd1d5d82c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sat, Feb 28, 2009 at 10:46 AM, Gary Thomas <gary@mlbassoc.com> wrote:
>> Still looking for some help...  I need to be able to locate
>> the kernel platform_device which corresponds to an instance
>> from my OF tree.  Basically, I have a [somewhat] unrelated
>> driver which needs to know these things, so the drivers in
>> question should not have to be affected.
>>
>> In particular, I'm working with the net/dsa drivers (Distributed
>> Switch Architecture) which need access to the network driver as
>> well as the MII/MDIO bus driver.  It doesn't make sense to tie
>> those drivers back to DSA, but rather let the DSA driver find
>> its way to them.
>>
>> I've defined this in by DTS tree:
>>        lan1 {
>>                cell-index = <0x01>;
> 
> Side note, why do you have cell-index here?  I suspect that you're
> using it incorrectly.

Probably - I don't think I need it anyway.

>>                compatible = "marvell,m88e609x";
>>                net_dev = "fsl-gianfar.0";
>>                mii_bus = "fsl-gianfar_mdio.14";
> 
> These two lines don't make much sense.  They are encoding Linux
> internal details with could very well change in the future.
> 
>>                net_devX = <&eth0>;
>>                mii_busX = <&mii_bus>;
> 
> This is the right thing to do.  This give you the phandle to the relevant node.

As I suspected.

> Once you have a handle to the node, you can iterate through the
> of_platform bus devices and look for a node which has a matching node
> pointer stored in archdata.  That will give you a struct device which
> is contained by a struct of_device (note well: this will give you an
> of_device, not a platform_device.)

I have code which does this already, but I could not figure out
how to get from the of_device node to the actual platform_device.
    for_each_compatible_node(np, NULL, "marvell,m88e609x") {
        const phandle *ph;
        struct device *dev;
        struct of_device *of_dev;

        ph = of_get_property(np, "net_devX", NULL);
        if (ph == NULL) {
            printk("%s: missing 'net_dev'\n", np->name);
            break;
        }
        of_dev = of_find_device_by_phandle(*ph);
    }

How do I find the platform_device which was created when this
particular of_device was instantiated?  I made sure that this code
is run late - after all the of_devices have been handled.

> I'm working on a set of patches which should make this much easier.
> I'll try to remember to CC you when I post them to the list.

Looking forward to your code/ideas

>>        };
>> ... two ways to find the same node.
>>
>> Using 'net_dev' (which I admit is pretty hokey), I can look
>> up the corresponding platform device, which does work for
>> the DSA layer.  What I want is to be able to get to this
>> from the 'net_devX' pointer, but I don't seem to be able
>> to get out of the OF tree and into the actual platform
>> device tree to find the appropriate instance.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
