Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 52FE9DDF17
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 08:42:10 +1100 (EST)
Message-ID: <45CA47AB.1000302@freescale.com>
Date: Wed, 07 Feb 2007 15:42:03 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mac-address vs. local-mac-address
References: <45CA41F7.6020700@freescale.com>
	<1170883956.2620.305.camel@localhost.localdomain>
In-Reply-To: <1170883956.2620.305.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2007-02-07 at 15:17 -0600, Timur Tabi wrote:
>> Hi everyone,
>>
>> What is the current consensus on using mac-address vs. local-mac-address in the 
>> device tree?  The 1275 spec says this:
>>
>> "local-mac-address" Standard property name to specify preassigned network address.
>> "mac-address" Standard property name to specify network address last used.
>>
>> I think we need to agree on some interpretation of these statements, and all the 
>> code should be updated to implement that interpretation.
> 
> It's fairly clear:
> 
> local-mac-address is what is statically set by the firwmare (comes from
> EEPROM, whatever).
> 
> mac-address is really only meaningful if your firmware is
> "dynamic" (real OF, uboot maybe) and was, for some reason, instructed by
> the user to use a different mac address for that boot (if that feature
> exist).
> 
> It's basically the mac-address that was actually used on that interface
> to netboot the kernel I'd say.
> 
>> Linux doesn't support that.  In some cases, the actual device tree is located on 
>> a TFTP server, and it's only copied temporarily into RAM by U-Boot.  There's no 
>> way that a Linux driver can update that.
> 
> I don't understand what you mean here :-) The linux driver can perfectly
> well update the in-memory copy of the device-tree, which would make it
> useful in the case of a kexec to a newer kernel.

That makes sense.  I don't know anything about kexec, so I didn't think there 
was any point in updating the in-memory copy.  But in this case, the driver 
should update it.

>> On a full-blown OF machine, the firmware does provide APIs for updating the 
>> device tree, and so we could support mac-address on these machines.  But U-Boot 
>> disappears once the kernel loads, so there is no firmware to call to update the 
>> device tree.
> 
> I don't understand what the firmware device-tree has to do with that...

Without a firmware device tree, there's no way to update the device tree and 
have that new tree retained over a reboot.

> If uboot is instructed to use a different mac-address than the
> "built-in" one, it can perfectly well create that property before
> getting to the kernel.

And it does, depending on which version of U-Boot.  There is debate (inside 
Freescale, at least) whether U-Boot should update mac-address or 
local-mac-address.  It sounds to me like it should update local-mac-address, and 
the DTS file shouldn't even include an entry for mac-address.

>> Therefore, I propose that on systems where the driver cannot update the device 
>> tree, the mac-address property should be absent from the device tree.  U-Boot 
>> should not add one, and the Linux device drivers should not reference it.
> 
> "cannot update the device tree" is what makes little sense to me.

If I keep my device tree on a TFTP server, which U-Boot fetches every time it 
boots the kernel, there's no way for Linux to update *that* device tree, which 
would be the only one that's important.  You mentioned kexec earlier, and that's 
fine, so the driver should update the in-memory copy.  But in my opinion, the 
in-memory copy of the device tree isn't the *real* device tree, it's just a 
temporary copy of one.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
