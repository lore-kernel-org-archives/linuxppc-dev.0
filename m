Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z75P005pTzDqZh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 10:23:00 +1100 (AEDT)
Date: Thu, 28 Dec 2017 17:22:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, seroyer@linux.vnet.ibm.com,
 alex.williamson@redhat.com, aik@ozlabs.ru, ruscur@russell.cc,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com,
 Keith Busch <keith.busch@intel.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v2 2/7] powerpc/kernel: Add uevents in EEH error/resume
Message-ID: <20171228232253.GC19819@bhelgaas-glaptop.roam.corp.google.com>
References: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
 <20171218223808.83928-3-bryantly@linux.vnet.ibm.com>
 <20171219045009.GC14941@bhelgaas-glaptop.roam.corp.google.com>
 <1513664878.2743.8.camel@kernel.crashing.org>
 <952dac4e-cf22-ed68-1a29-58ac7ed3515a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <952dac4e-cf22-ed68-1a29-58ac7ed3515a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 20, 2017 at 09:04:27PM -0600, Juan Alvarez wrote:
> On 12/19/17 12:27 AM, Benjamin Herrenschmidt wrote:
> 
> > On Mon, 2017-12-18 at 22:50 -0600, Bjorn Helgaas wrote:
> >> [+cc Keith, Gabriele, Dongdong]
> >>
> >> On Mon, Dec 18, 2017 at 04:38:03PM -0600, Bryant G. Ly wrote:
> >>> Devices can go offline when EEH is reported. This patch adds
> >>> a change to the kernel object and lets udev know of error.
> >>> When device resumes a change is also set reporting device as
> >>> online. Therefore, EEH events are better propagated to user
> >>> space for devices in powerpc arch.
> >> I'm on vacation and can't review this in detail, but I wonder if you
> >> can compare this with the uevents we emit for DPC, AER, and hotplug
> >> events (if any).  I hope we don't end up with userspace having to be
> >> aware of the differences between EEH, DPC, AER, etc.
> >>
> >>> From a very quick look, I only see a few uevents even mentioned in
> >> drivers/pci: KOBJ_ADD in __pci_hp_register() and KOBJ_CHANGE in the
> >> SR-IOV code.  I'm worried that we're missing some important uevents in
> >> the PCI core.  That's not an argument against what you're doing here;
> >> it just would be nice to fill in any missing pieces in the core also,
> >> and hopefully make them consistent with these EEH events.
> > We also need to be careful about what specific EEH activity we are
> > talking about, and if we bring into the picture things like DPDK, it
> > gets even more murky...
> >
> > The basic way EEH is supposed to work for recovery (minus all sort of
> > implementation nasties which hopefully Russell and Sam are trying to
> > cleanup and fix) is that either:
> >
> > 	- The driver of the device has recovery callbacks, in which
> > case the driver participates in the recovery process, the device
> > doesn't "go away" (though it shouldn't be accessed during that process
> > by other entities, userspace originated config space could be a problem
> > and needs to be blocked...). The recovery typically involves a reset of
> > the device but in sync with the driver.
> >
> > 	- The driver doesn't have the callbacks. In this case, we
> > simulate an unplug, reset the device, and replug.
> >
> > So it makes sense for the second case to emit the same uevents as a
> > normal PCI(e) hotplug.
> >
> > For the former case I'm less sure.... Do we really need userspace to be
> > notified ? If yes, what for precisely ?
> 
> In pSeries SR-IOV environment the management console might need to apply
> certain configuration changes to the PF driver after it has been recovered
> and before the VF drivers are allowed to resume their recovery path.
> I could not think of another way to notify user space of these events.
> I made this assumption because I saw there were no uevents added when 
> the device goes offline and come back online in EEH code. It was my 
> intention to make the event as generic as possible in EEH component,
> therefore, making this change independent of pSeries SR-IOV.

I don't know what your plan for this is, but we do have two different
paths that use the struct pci_error_handlers hooks that drivers may
supply.  There's this AER path that may be used on all arches:

  aer_isr
    get_e_source              # remove from rpc->e_sources[] queue
    aer_isr_one_error
      aer_process_err_devices
        handle_error_source   # or aer_recover_work_func
          do_recovery         # for uncorrectable (fatal/nonfatal) only
            broadcast_error_message(dev, ..., report_error_detected)
              pci_walk_bus(..., report_error_detected)
                report_error_detected
                  dev->driver->err_handler->error_detected

And there's this powerpc path where you're adding a uevent:

  eeh_event_handler
    eeh_handle_event
      eeh_handle_normal_event
        eeh_pe_dev_traverse(pe, eeh_report_error, &result)
          eeh_report_error
            driver->err_handler->error_detected(dev, pci_channel_io_frozen)
 +          kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);

Both paths end up calling the pci_error_handlers.error_detected()
hook.

Drivers are not supposed to care what arch they're running on.  If the
driver supplies an .error_detected() entry point, it's up to the PCI
core and powerpc code to use it consistently across arches.  That
means the same uevents (if any) should be emitted from both paths.

The best way would be to unify the call of .error_detected() so the
AER path and the powerpc path do it via the same function.  The AER
report_error_detected() and the powerpc eeh_report_error() do look
fairly similar, so this seems possible in principle, but I'm not
holding my breath.

Bjorn
