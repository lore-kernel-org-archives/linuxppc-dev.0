Message-ID: <3D1B81C3.6060907@mvista.com>
Date: Thu, 27 Jun 2002 14:21:07 -0700
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Trivial cleanup in ocp_uart.c
References: <20020620073440.GC20689@zax> <20020620155026.GE16052@opus.bloom.county> <20020621005216.GH20689@zax> <20020621143903.GO16052@opus.bloom.county> <20020624074019.GA9087@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> On Fri, Jun 21, 2002 at 07:39:03AM -0700, Tom Rini wrote:
>
>>On Fri, Jun 21, 2002 at 10:52:16AM +1000, David Gibson wrote:
>>
>>>On Thu, Jun 20, 2002 at 08:50:26AM -0700, Tom Rini wrote:
>>>
>>>>And I think it can be used, once it gets registered to the ocp_list (and
>>>>something later accesses it).
>>>>
>>>
> I can't see why it would need to: ocp_register() will just be calling
> pm_register() which will directly provide a usable device identifier
> to its callbacks.  For that matter I don't see much point in running
> the PM stuff through the OCP layer at all rather than just having the
> relevant drivers call pm_register() directly.  But the last point
> might change if useful default power management handlers could be
> implemented through the CPM constants added to core_ocp in Armin's
> recent patch.
>
> Incidentally I think a "register" interface could make sense if the
> "registration" occured at the point the device was discovered - which
> for these embedded devices means unconditionally during board and/or
> chip initialization.  This is the obvious way to map embedded devices
> onto the 2.5 unified device model.  Registration at driver
> initialization like ocp_register() makes no sense to me.

Thats obvious			^^^^^^^^^^^^^^^^^^

>
> Basically there are two quite distinct approaches either of which
> would make sense (for any given peripheral/bus type):
> 	a) Register each device as it is discovered.  Register each
> driver as the appropriate module loads.  Whenever either event happens
> the common code calls init or probe callbacks in a driver to connect
> it to any devices of appropriate type.
> 	b) No registration.  When a driver loads, it searches for all
> devices of appropriate type, and initializes each of them in turn.

I'll need to fix that won't I :)

>
> Examples of (a) include the new PCI interface, PCMCIA, and the 2.5
> unified device model.  Examples of (b) include the old PCI interface
> (pci_find_device()) and (some?/all?) non-PCI devices on OF machines
> (e.g. Airport).
>
> Approach (a) is clearly needed to handle hotplug.  But that's not an
> issue for OCPs (indeed device (not driver) registration will always be
> degenerate) so either approach would do.  Frankly (a) seems overkill
> for OCPs, but it does have the advantage of being easily integrated
> into the unified device model.

It's not over kill.  if I used the entire PCI model, it would be.

>
> What we have at the moment is mishmash of both models, which *doesn't*
> make sense).
>
This is in devel, I guess what I should have done was fork and do all
the work there and then provide a complete solution to devel. :)

>


armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
