From: Ryan Nielsen <ran@krazynet.com>
Date: Thu, 24 Jun 1999 12:41:38 -0700
To: =?iso-8859-1?Q?Albrecht_Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help: Porting PCI driver from Linux/Intel -> PPC
Message-ID: <19990624124138.A1051@gondolin.asf>
References: <3771D987.C59A9374@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: =?iso-8859-1?Q?=3C3771D987=2EC59A9374=40mpifr-bonn=2Empg=2Ede=3E=3B_from?=
 =?iso-8859-1?Q?_Albrecht_Dre=DF_on_Thu=2C_Jun_24=2C_1999_at_09:08:55AM_+?=
 =?iso-8859-1?Q?0200?=
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Albrecht Dreß wrote:
> Now I try to insmod my driver, which reads the configuration space (using calls
> to pci_read_config_dword) and dumps it, reads irq and board revision, reads the
> base adresses of the five io regions, and reads one io address via inl().  The
> last operation leads to a panic:

you might need to enable memory with somthing like:
	u16 cmd;

	/* on OpenFirmware machines (PowerMac at least), PCI memory cycle */
	/* response on cards with no firmware is not enabled by OF */
	pci_read_config_word(dev, PCI_COMMAND, &cmd);
	cmd |= PCI_COMMAND_MEMORY;
	pci_write_config_word(dev, PCI_COMMAND, cmd);

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
