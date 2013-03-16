Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B3E272C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 16:35:23 +1100 (EST)
Message-ID: <1363411807.1244.13.camel@pasglop>
Subject: Re: [PATCH 3/3] VFIO: Direct access config reg without capability
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Sat, 16 Mar 2013 06:30:07 +0100
In-Reply-To: <1363376468.16793.18.camel@ul30vt.home>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1363376468.16793.18.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-03-15 at 13:41 -0600, Alex Williamson wrote:
> 
> This basically gives userspace free access to any regions that aren't
> covered by known capabilities. 

And ?

I mean seriously :-) We already had that discussion ... trying to
"protect" config space is just plain doomed. There is no point.

It makes sense to do things like emulate BARs etc... for things to
function properly under some circumstances/setups where you can't just
expose the original BAR values to the guest and have the HW take care of
it but you *must* be prepared to deal with anything in config space
being changed without you knowing about it.

Devices *will* have backdoors via MMIO. Period. You cannot rely on those
not existing, whether they are documented or not.

If you can't cope with the config space accesses then you aren't
properly isolated. It can be deemed acceptable (depends what you use
your VMs for) but that I mean is that any config space
filtering/emulation for the sake of "security" is ... pointless.

Doing it for functionality to work at all (ie BAR emulation) is fine,
but that's about it. IE. As a mean of security it's pointless.


>  We have no idea what this might expose on some devices.

No more than we have any idea what MMIO mapping of the device register
space exposes :-)

>   I'd like to support be2net, but what's the minimal
> access that it needs?  Can we provide 2 or 4 bytes of read-only access
> at offset 0x7c for just that device?  Is it always 0x7c?  Let's split
> this patch from the series since it's clearly dealing with something
> independent.  Thanks,

Ben.
