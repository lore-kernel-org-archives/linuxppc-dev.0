Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 2FC89DDDF6
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 05:44:39 +1100 (EST)
Received: by gxk1 with SMTP id 1so5760220gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 10:44:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49A9809D.9000307@mlbassoc.com>
References: <49A97878.6060308@mlbassoc.com>
	<fa686aa40902281004r5fcb67f4md328d79dd1d5d82c@mail.gmail.com>
	<49A9809D.9000307@mlbassoc.com>
Date: Sat, 28 Feb 2009 11:44:37 -0700
Message-ID: <fa686aa40902281044l3b910866g7467131db80c87e7@mail.gmail.com>
Subject: Re: OF device mappings
From: Grant Likely <grant.likely@secretlab.ca>
To: Gary Thomas <gary@mlbassoc.com>
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

On Sat, Feb 28, 2009 at 11:21 AM, Gary Thomas <gary@mlbassoc.com> wrote:
> Grant Likely wrote:
>> Once you have a handle to the node, you can iterate through the
>> of_platform bus devices and look for a node which has a matching node
>> pointer stored in archdata. =A0That will give you a struct device which
>> is contained by a struct of_device (note well: this will give you an
>> of_device, not a platform_device.)
>
> I have code which does this already, but I could not figure out
> how to get from the of_device node to the actual platform_device.

You can't.  There is no platform_device.  There is only the of_device.

The bit that you're missing is that the 'platform bus' isn't being
used at all for these devices.  The 'of_platform bus' is used instead.
 platform bus and of_platform bus perform essentially the same job,
but the of_platform bus differs in the way it probes drivers.
Specifically, an of_platform_driver can be handed a list of values
that it will match against, and it has a 1:1 relationship with a node
in the device tree.

> How do I find the platform_device which was created when this
> particular of_device was instantiated? =A0I made sure that this code
> is run late - after all the of_devices have been handled.

Again, there is no platform_device.  of_device *is* the device that was cre=
ated.

g.
