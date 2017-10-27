Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNxrG6lvYzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Oct 2017 08:30:54 +1100 (AEDT)
Date: Fri, 27 Oct 2017 16:30:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Cc: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steven Royer <seroyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, bhelgaas@google.com,
 benh@kernel.crashing.org, paulus@samba.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Juan J . Alvarez" <jjalvare@us.ibm.com>,
 Bodong Wang <bodong@mellanox.com>, Eli Cohen <eli@mellanox.com>,
 Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
Message-ID: <20171027213039.GB9235@bhelgaas-glaptop.roam.corp.google.com>
References: <88eab212351a662dda330071d9afe9dc@linux.vnet.ibm.com>
 <11c15c773aefcc0490e197051c2eaf41@linux.vnet.ibm.com>
 <20171013120558.1a129183@t450s.home>
 <24fdec01-8df4-f027-0b3c-0472a2d73946@linux.vnet.ibm.com>
 <20171017135123.GA5641@bhelgaas-glaptop.roam.corp.google.com>
 <7e23c703-750b-b4f8-f252-0c872a40ae8a@linux.vnet.ibm.com>
 <20171017162621.GB5641@bhelgaas-glaptop.roam.corp.google.com>
 <f8fbbd56-f165-0a17-a24a-2b021f7fa238@linux.vnet.ibm.com>
 <20171017185242.GG5641@bhelgaas-glaptop.roam.corp.google.com>
 <eb1ac136-a054-ea2b-2368-af740e0c23d4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eb1ac136-a054-ea2b-2368-af740e0c23d4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 17, 2017 at 06:13:35PM -0500, Juan Alvarez wrote:
> On 10/17/17 1:52 PM, Bjorn Helgaas wrote:
> > I'm suggesting that maybe there should be a generic way to prevent
> > binding to VF devices that works for everybody and doesn't require any
> > arch-specific code at all.
> 
> The patch that you have suggested in kernel 4.12 is also a generic way.
> 
> https://marc.info/?l=linux-kernel&m=149002335105804&w=2

The patch mentioned above is now upstream:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0e7df22401a3

> Perhaps we can use the same constructs that this patch uses at our level.
> Nonetheless, that will take a rework to this patch and possibly an export
> of a function to set drivers_autoprobe globally. I know that was frowned
> upon on first email thread. Let me know if this is an acceptable
> solution.

I would definitely like to see you use a solution that is somehow
connected with the sriov->drivers_autoprobe mechanism added by
0e7df22401a3.

0e7df22401a3 is a per-PF solution, and you're looking for a
system-wide switch.  I could imagine a system-wide flag exposed in
sysfs and used by pci_device_can_probe().  Or maybe some arch hook in
the pci_device_add() path that clears sriov->drivers_autoprobe for
every PF.

I think the important thing is that it is coordinated as much as
possible with other driver binding controls and not unnecessarily
arch-dependent.

Bjorn
