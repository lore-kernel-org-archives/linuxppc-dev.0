Date: Tue, 14 Oct 2003 00:27:07 -0700
From: Xiaoshan Zuo <xzuo@vinesystech.com>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Jacky Lam <jackylam@astri.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut PCI bridge can't be detected
Message-ID: <20031014072707.GA17019@vinesystech.com>
References: <001d01c39133$20f088a0$2803050a@JackyLam> <001d01c39133$20f088a0$2803050a@JackyLam> <5.1.0.14.2.20031013223052.00b112d8@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20031013223052.00b112d8@mail.ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> >I was puzzled by this for a while. Then I saw this code while debugging
> >PCI on my custom board:
> >In ppc405_pci.c, there is ppc4xx_exclude_device function:
> >
> >static int
> >ppc4xx_exclude_device(unsigned char bus, unsigned char devfn)
> >{
> >/* We prevent us from seeing ourselves to avoid having
> >* the kernel try to remap our BAR #1 and fuck up bus
> >* master from external PCI devices
> >*/
> >return (bus == 0 && devfn == 0);
> >}
>
> I think comment is quite clear, don't you think ?
>
Yes, it is just plain English. Unless someone points out, I have to search in
the jungle.

>
> >With this function there, there is no way you are going to see the
> >bridge, even your driver does the scan itself. I had to write my own
> >pci_read_config_<size> function to just to be able to read the bridge
> >configration.
>
> Well, all you had to do was to clear ppc_md.pci_exclude_device.
>
> Frankly, I don't understand why do you want to mess with the bridge setup
> from _device driver_ ?
>
Right. I don't want to mess with bridge setup from my production driver. But for
dubugging( and also for fun) I need to dispay/set the configurations. lspci
doesn't work because the bridge is hidden by the OS. Once everything
works as expected, those code can be commented out. It would be nice to
have utility to mess around pci in the user space without depending on
/proc/pci.

Xiaoshan

>
> The right place for bridge specific setup is bios_fixup. walnut.c has a
> good example.
>
> Eugene
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
