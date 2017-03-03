Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZGZ70Q5jzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 15:35:11 +1100 (AEDT)
Message-ID: <1488515705.6003.1.camel@russell.cc>
Subject: Re: [RESEND-RFC v2 2/3] powerpc/eeh: Introduce function
 eeh_pe_reset_freeze_counter()
From: Russell Currey <ruscur@russell.cc>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>, Philippe Bergheaud
 <philippe.bergheaud@fr.ibm.com>,  Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Fri, 03 Mar 2017 15:35:05 +1100
In-Reply-To: <87r32f6ldy.fsf@vajain21.in.ibm.com>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-3-vaibhav@linux.vnet.ibm.com>
 <87r32f6ldy.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-03 at 09:51 +0530, Vaibhav Jain wrote:
> Hi Russell,
> 
> Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:
> 
> > This patch introduces function eeh_pe_reset_freeze_counter() which can
> > be used to reset the PE's freeze count variable outside eeh code. This
> > is useful for devices that can acquire a different personality after
> > a PERST event (e.g FPGA Adapters). Presently an existing freeze
> > count for an adapter with personality N will be taken into account
> > when the adapter acquired personality N+1.
> > 
> > By calling eeh_pe_reset_freeze_counter() drivers can reset the freeze
> > counter for an adapter once it has acquired a new personality and
> > ideally wont be plagued by the failures similar to the one before.
> > 
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> > ---
> 
> Had a short chat discussion with Gavin Shan on this patchset and he
> preffers restoring the freeze_count on the eeh_pe once FRESET is done.
> He expects a the flow to be similar to one below
> 
> 1. module caches the value of freeze_count and resets it
> 2. Issue warm reset
> 3. During eeh error-detected callback module restores the freeze_count
> from the cached value.
> 
> Russell, what do you think? 
> 
I thought about this but figured it didn't really make sense from a CAPI
perspective.  If you're flashing the device, it is going to have different
behaviour to before it was flashed, and that it should be treated differently as
a result (and thus restoring the freeze_count doesn't make much sense).

Consider a case where there's a buggy FPGA image on an adapter that's failed 4
times in the past hour, and generally has frequent errors.  You decide to update
it to something that's less buggy, so you flash the adapter.  The freeze_count
gets cached and thus is restored to 4 after the flash.  Now even if the new
image is less buggy and may only fail once an hour instead of multiple times, if
it happens to fail within an hour of the earlier failures the device is now
fenced and you need to reboot.

I don't mind either way - I just don't get the logic of restoring the count.
