Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA518DE06E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 04:26:06 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
	<m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
	<1170064058.19887.78.camel@concordia.ozlabs.ibm.com>
	<20070129165217.GA10992@colo.lackof.org> <adabqkh22jy.fsf@cisco.com>
	<ada7iv522cl.fsf@cisco.com>
Date: Mon, 29 Jan 2007 10:25:29 -0700
In-Reply-To: <ada7iv522cl.fsf@cisco.com> (Roland Dreier's message of "Mon, 29
	Jan 2007 09:02:18 -0800")
Message-ID: <m1ireplp86.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier <rdreier@cisco.com> writes:

>  > Really?  Which gigE chips are using MSI-X (as opposed to MSI)?
>
> OK, I should look before I post.  But anyway a quick grep shows that
> the forcedeth driver does enable MSI-X for at least some devices.  And
> a quick look at the nv_suspend() function makes me think that suspend
> probably won't work if MSI-X is used, since it doesn't save the MSI-X
> state anywhere that I can see (unless the device is magic enough to
> keep the MSI-X table in some sort of persistent storage, which I
> highly doubt).

Hmm.

There is this function.  It does save the table, I haven't
looked closely enough yet to know if it saves all of the
other details yet.

It certainly looks to me like we are at least missing
details like saving the mask bit.

I have always been under the impression that this code was
at least close enough that it could be fixed to do
what we needed.

int pci_save_msix_state(struct pci_dev *dev)
{
	int pos;
	int irq, head, tail = 0;
	u16 control;
	struct pci_cap_saved_state *save_state;

	if (!dev->msix_enabled)
		return 0;

	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
	if (pos <= 0 || dev->no_msi)
		return 0;

	/* save the capability */
	pci_read_config_word(dev, msi_control_reg(pos), &control);
	if (!(control & PCI_MSIX_FLAGS_ENABLE))
		return 0;
	save_state = kzalloc(sizeof(struct pci_cap_saved_state) + sizeof(u16),
		GFP_KERNEL);
	if (!save_state) {
		printk(KERN_ERR "Out of memory in pci_save_msix_state\n");
		return -ENOMEM;
	}
	*((u16 *)&save_state->data[0]) = control;

	/* save the table */
	irq = head = dev->first_msi_irq;
	while (head != tail) {
		struct msi_desc *entry;

		entry = msi_desc[irq];
		read_msi_msg(irq, &entry->msg_save);

		tail = msi_desc[irq]->link.tail;
		irq = tail;
	}

	save_state->cap_nr = PCI_CAP_ID_MSIX;
	pci_add_saved_cap(dev, save_state);
	return 0;
}
