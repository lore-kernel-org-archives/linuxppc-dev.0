Return-Path: <FENKES@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DA719DDD09
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 00:01:08 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7UE0wjC153976
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 14:00:58 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7UE0vEu1826882
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 16:00:57 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7UE0v9u026868
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 16:00:57 +0200
In-Reply-To: <46D5BBFA.5060200@austin.ibm.com>
To: jschopp <jschopp@austin.ibm.com>, Nathan Lynch <ntl@pobox.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF9D1ED44F.896DCCC5-ONC1257347.0044D256-C1257347.004CFB07@de.ibm.com>
Date: Thu, 30 Aug 2007 16:00:56 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Q Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch <ntl@pobox.com> wrote on 29.08.2007 20:12:32:

> > Previously, ibmebus derived a device's bus_id from its location code. 
The
> > location code is not guaranteed to be unique, so we might get bus_id
> > collisions if two devices share the same location code. The OFDT 
full_name,
> > however, is unique, so we use that instead.
> 
> This is a userspace-visible change, but I guess it's unavoidable.
> Will anything break?

Nope. Userspace programs should not depend on ibmebus' way of naming the 
devices; especially since some overly long loc_codes tended to be 
truncated and thus rendered useless. I have tested IBM's DLPAR tools 
against the changed kernel, and they didn't break.
 
> Also, I dislike this approach of duplicating the firmware device tree
> path in sysfs.

Why? Any specific reasons for your dislike?

> Are GX/ibmebus devices guaranteed to be children of
> the same node in the OF device tree?  If so, their unit addresses will
> be unique, and therefore suitable values for bus_id.  I believe this
> is what the powerpc vio bus code does.

While there's no such guarantee (as in "officially signed document"), yes, 
I expect future GX devices to also appear beneath the OFDT root node. For 
the existing devices, the unit addresses are already part of the device 
name, so I save the need to use sprintf() again. Plus, I rather like using 
the full_name since it also contains a descriptive name as opposed to 
being just nondescript numbers, helping the layman (ie user) to make sense 
out of a dev_id.

jschopp <jschopp@austin.ibm.com> wrote on 29.08.2007 20:33:30:

> > +   len = strlen(dn->full_name + 1);
> > +   bus_len = min(len, BUS_ID_SIZE - 1);
> > +   memcpy(dev->ofdev.dev.bus_id, dn->full_name + 1
> > +          + (len - bus_len), bus_len);
> > +   for (i = 0; i < bus_len; i++)
> > +      if (dev->ofdev.dev.bus_id[i] == '/')
> > +         dev->ofdev.dev.bus_id[i] = '_';
> > 
> >     /* Register with generic device framework. */
> >     if (ibmebus_register_device_common(dev, dn->name) != 0) {
> 
> What happens when the full name is > 31 characters?  It looks to me that 
it 
> will be truncated, which takes away the uniqueness guarantee.

There are currently two GX devices, eHCA and eHEA, which both reside 
beneath the root node - this is required by architecture for those 
devices. Unless they invent a device called 
"supercalifragilisticexpialidocious", devices in the root note will have a 
full_name of less than 31 chars. Even in that case, the truncation occurs 
at the beginning, so the @xxx part that makes the nodes unique will stay 
in place.

If any more GX devices appear on the scene, I expect them to appear in the 
root node as well. The substitution of "/" by "_" is a safeguard so 
possible weird OFDT setups don't break the kernel.
 
> There must be an individual property that is guaranteed to be unique and 

> less than 32 characters.  How about "ibm,my-drc-index"?  That looks like 
a 
> good candidate.

On first glance, it does, however the attribute might not be present in 
all cases. Architecture states it only needs to be present on systems with 
dynamic reconfiguration enabled.

All things considered, I still like the idea of using the full_name most. 
No offense.

Regards,
  Joachim
