Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 7C28E2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 08:15:36 +1100 (EST)
Message-ID: <1363641330.24132.437.camel@bling.home>
Subject: Re: [PATCH 3/3] VFIO: Direct access config reg without capability
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 Mar 2013 15:15:30 -0600
In-Reply-To: <1363411807.1244.13.camel@pasglop>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1363376468.16793.18.camel@ul30vt.home> <1363411807.1244.13.camel@pasglop>
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

On Sat, 2013-03-16 at 06:30 +0100, Benjamin Herrenschmidt wrote:
> On Fri, 2013-03-15 at 13:41 -0600, Alex Williamson wrote:
> > 
> > This basically gives userspace free access to any regions that aren't
> > covered by known capabilities. 
> 
> And ?
> 
> I mean seriously :-) We already had that discussion ... trying to
> "protect" config space is just plain doomed. There is no point.
> 
> It makes sense to do things like emulate BARs etc... for things to
> function properly under some circumstances/setups where you can't just
> expose the original BAR values to the guest and have the HW take care of
> it but you *must* be prepared to deal with anything in config space
> being changed without you knowing about it.
> 
> Devices *will* have backdoors via MMIO. Period. You cannot rely on those
> not existing, whether they are documented or not.
> 
> If you can't cope with the config space accesses then you aren't
> properly isolated. It can be deemed acceptable (depends what you use
> your VMs for) but that I mean is that any config space
> filtering/emulation for the sake of "security" is ... pointless.
> 
> Doing it for functionality to work at all (ie BAR emulation) is fine,
> but that's about it. IE. As a mean of security it's pointless.
> 
> 
> >  We have no idea what this might expose on some devices.
> 
> No more than we have any idea what MMIO mapping of the device register
> space exposes :-)

Yeah, yeah.  Ok, I can't come up with a reasonable argument otherwise,
it'll give us better device support, and I believe pci-assign has always
done this.  I'll take another look at the patch.  Thanks,

Alex
