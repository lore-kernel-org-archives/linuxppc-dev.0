Message-ID: <3C02D1CD.9050307@humboldt.co.uk>
Date: Mon, 26 Nov 2001 23:35:41 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: VT82C686B IDE and Linux/PPC woes
References: <0111262205.AA22280@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:


 > Has anyone here other than us with the Adirondack ever designed a
 > PPC board with a VT82C686B south bridge and put Linux/PPC on it? If
 >  anyone has done this, what magic did you do for the IDE?

Almost (VT82C686A) for a custom control system (item 1 on
http://www.varisys.co.uk/custom.html).

As your firmware works you've already done most of the difficult bits.
Could there be something wrong with your ppc_ide_md.ide_init_hwif
function?  This is mine, as mangled by Mozilla:

static void __init
hppb_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
			      ide_ioreg_t ctrl_port, int *irq)
{
	ide_ioreg_t reg = data_port;
	uint	alt_status_base;
	int	i;

	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
		hw->io_ports[i] = reg++;
	}

	if (data_port == hppb_ide_regbase[0]) {
		alt_status_base = hppb_ide_ctl_regbase[0] + 2;
		hw->irq = 14;
	}
	else if (data_port == hppb_ide_regbase[1]) {
		alt_status_base = hppb_ide_ctl_regbase[1] + 2;
		hw->irq = 15;
	}
	else {
		alt_status_base = 0;
		hw->irq = 0;
	}

	if (ctrl_port) {
		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
	} else {
		hw->io_ports[IDE_CONTROL_OFFSET] = alt_status_base;
	}

	if (irq != NULL) {
		*irq = hw->irq;
	}

	return;
}


--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
