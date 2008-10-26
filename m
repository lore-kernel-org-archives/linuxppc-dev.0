Return-Path: <dgibson@ozlabs.org>
Date: Mon, 27 Oct 2008 10:53:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081026235303.GE22339@yookeroo.seuss>
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<49024646.3050300@genesi-usa.com> <49025DE0.6070403@firmworks.com>
	<4904DD76.7070706@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4904DD76.7070706@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 26, 2008 at 04:13:26PM -0500, Matt Sealey wrote:
>
>
> Mitch Bradley wrote:
>>
>> I don't use device_type much, if at all, anymore.  Generic name +  
>> compatible just works better than device_type + specific name.  When
> > I write code that has to find a node that is suitable for a given purpose,
> > I look for the existence of suitable methods and perhaps other properties.
> > I was just too hard to keep the list of device_type values properly
> > synchronized with all the possible things that you might want to infer
> > from that set of names.
>
> The simple problem comes when you define a device_type for everything,
> I do agree it's best not to add any *MORE* that aren't in the IEEE1275
> or CHRP etc. bindings, but for those that still exist and are well
> defined (serial port probably the best, but network devices too) I
> think we should keep using them where possible and where relevant.

device_type in 1275 defines the runtime method interface.  It's *not*
for declaring the general class of the device, although it often
matches that in practice.  Drivers which attempt to use it this way
are buggy.

So, in the  case of a real OF implementation,  yes, you should include
device_type values as specified by 1275.  Assuming of course that your
implementation  really  does  implement  the OF  method  binding  that
matches the stated device_type.  However, flattened trees clearly
can't provide the method interface, and so shouldn't declare the
device_type.

In practice, we do suggest including device_type in certain, limited,
circumstances precisely because there are a whole bunch of buggy
drivers out there which match (at least partly) on device_type.  We
don't want to break these gratuitously, but neither do we want to
encourage any further spread of using device_type incorrectly for
driver matching.  Hence the current policy.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
