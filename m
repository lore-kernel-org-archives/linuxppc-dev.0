Return-Path: <B07421@freescale.com>
Message-ID: <4B478747.8070009@freescale.com>
Date: Fri, 08 Jan 2010 13:28:07 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollis_blanchard@mentor.com>
Subject: Re: "status" property checks
References: <1262905673.11702.16.camel@localhost.localdomain>	<1262918143.2716.8.camel@ccs-laptop>
	<1262975655.31871.67.camel@localhost.localdomain>
In-Reply-To: <1262975655.31871.67.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Hunter Cobbs <hunter.cobbs@gmail.com>, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:
> On Thu, 2010-01-07 at 20:35 -0600, Hunter Cobbs wrote:
>> I think that is definitely a solution.  It does centralize the testing
>> for this particular issue.  The only thing question I have is if its
>> really better to have the upper level do the check.  Shouldn't the
>> driver itself handle the hardware and device node status?
> 
> Practically speaking, all drivers doing the checks today just return
> -ENODEV. They don't try to do anything to "handle" the situation.
> 
> The definition of the status property implies it's outside of software's
> control, for example:
>         "disabled"
>         "Indicates that the device is not presently operational, but it
>         might become operational in the future (for example, something
>         is not plugged in, or switched off)."
> 
> If a device is "not operational" in this sense, I don't think there's
> anything for a device driver to do.

I could see situations where there is some software action that could 
enable the device (e.g. multiple devices sharing pins, where only one 
can be active at a time) -- but it's likely to not be the driver itself 
that knows how to do that.

If the need arises, there could be a mechanism where the enabling entity 
can tell the platform bus that it has enabled a previously-disabled 
device, overriding the status in the device tree (and likewise if it 
wants take down a device that was previously enabled).

-Scott
