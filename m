Return-Path: <benh@kernel.crashing.org>
Subject: Re: Deprecating of_platform, the path from here...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <1260409535.16132.109.camel@pasglop>
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
	<20091209.161550.168794100.davem@davemloft.net>
	<1260409535.16132.109.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Dec 2009 08:30:18 +1100
Message-ID: <1260480618.16132.299.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	paulus@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-10 at 12:45 +1100, Benjamin Herrenschmidt wrote:

> I don't agree with grant idea however that just converting the content
> of the device node into properties is the way to go.

And here of course I meant " converting the content of the device node
into into pdata" ...

> I do prefer your proposed approach (from our IRC discussion) which is
> instead to allocate a struct device-node, convert pdata into properties,
> and modify the drier to use these properties.
> 
> The main difference thus between the two type of conversions (convert to
> of_platform vs convert to platform) is that in the first case, you have
> to convert the driver to use properties -and- convert all platforms in
> all archs including gory ARM cell phone stuff you really don't want to
> go anywhere near. In the second case, you still convert the driver to
> use properties natively, but you keep a "wart" to turn pdata into a
> device-node -inside the driver-, protected by a CONFIG option maybe, so
> that those archs can be left alone until it becomes so obvious to
> everybody what approach is better that they'll end up being converted
> too and the wart can go.
> 
> I believe the second approach, while less "clean" in the absolute is a
> more realistic path to take.
> 
> Now, orthogonally to that, I do believe it's still nice to provide a way
> to statically lay out a device node in platform code, to allow archs
> that don't otherwise have the device-tree to replace pdata with
> something nicer and get rid of the wart quicker.
> 
> We could either find a way with macros to layout an actual struct
> device_node statically along with all the properties etc... but that
> sounds a tad hard.
> 
> We could have something that convert an entirely ASCII representation
> into a struct device_node, but that would be akin of having dtc in the
> kernel, might be a bit bloated no ? Though it could be made simpler and
> more restrictive.
> 
> Or we could find an in-between .. .A different struct type that is more
> suitable for being laid out statically (a name, a type, and an enum of
> structs for various property "types", ie, strings, words, bytes, ...)
> with a little helper function that conver that into a device node at
> runtime ?
> 
> What do you think ?
> 
> Cheers,
> Ben.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
