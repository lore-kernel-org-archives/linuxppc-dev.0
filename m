Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (unknown [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id E390DDDDA5
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 06:18:40 +1100 (EST)
Message-ID: <49A98DFF.9050503@mlbassoc.com>
Date: Sat, 28 Feb 2009 12:18:23 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: OF device mappings
References: <49A97878.6060308@mlbassoc.com>	<fa686aa40902281004r5fcb67f4md328d79dd1d5d82c@mail.gmail.com>	<49A9809D.9000307@mlbassoc.com>
	<fa686aa40902281044l3b910866g7467131db80c87e7@mail.gmail.com>
In-Reply-To: <fa686aa40902281044l3b910866g7467131db80c87e7@mail.gmail.com>
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
> On Sat, Feb 28, 2009 at 11:21 AM, Gary Thomas <gary@mlbassoc.com> wrote:
>> Grant Likely wrote:
>>> Once you have a handle to the node, you can iterate through the
>>> of_platform bus devices and look for a node which has a matching node
>>> pointer stored in archdata.  That will give you a struct device which
>>> is contained by a struct of_device (note well: this will give you an
>>> of_device, not a platform_device.)
>> I have code which does this already, but I could not figure out
>> how to get from the of_device node to the actual platform_device.
> 
> You can't.  There is no platform_device.  There is only the of_device.
> 
> The bit that you're missing is that the 'platform bus' isn't being
> used at all for these devices.  The 'of_platform bus' is used instead.
>  platform bus and of_platform bus perform essentially the same job,
> but the of_platform bus differs in the way it probes drivers.
> Specifically, an of_platform_driver can be handed a list of values
> that it will match against, and it has a 1:1 relationship with a node
> in the device tree.
> 
>> How do I find the platform_device which was created when this
>> particular of_device was instantiated?  I made sure that this code
>> is run late - after all the of_devices have been handled.
> 
> Again, there is no platform_device.  of_device *is* the device that was created.

But this doesn't work :-(  I also don't understand how you
can say "there is no platform_device" - they are everywhere,
corresponding to actual device instances, as the system
creates them, typically in a driver 'probe' function.

I've tried both ways.  If I look up the of_platform node and
then pass the 'dev' structure to the DSA driver, it doesn't work.
If I look up the actual device instance from the platform_bus
and pass that to the driver, it does.

How do I get to the proper 'dev' structure which will make the
DSA driver work?

More details - the DSA driver is expecting to get the 'dev'
structure pointer which was created in the gianfar driver,
  static int gfar_probe(struct platform_device *pdev)
namely '&pdev->dev' -- this works.

If I look up the of_platform device like this:
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
and pass '&of_dev->dev', the DSA driver fails.

What am I missing and how do I solve this?

I'm not trying to be obstinate; I just need this to work
and I'm trying to make it work in an extensible, "play nice
in the OF sandbox" way.

Thanks for your help

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
