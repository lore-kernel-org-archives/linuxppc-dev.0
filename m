Message-ID: <395A1DC8.B5B13377@ocegr.fr>
Date: Wed, 28 Jun 2000 17:46:16 +0200
From: Zirong Wang <zirong.wang@ocegr.fr>
MIME-Version: 1.0
To: guinan@bluebutton.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX IDE
References: <Pine.LNX.4.21.0006280808460.16924-100000@gemini.home.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jamie Guinan wrote:
>
> There was a thread back in November about getting IDE going on
> an MBX,
>
> http://lists.linuxppc.org/listarcs/linuxppc-embedded/199911/msg00054.html
>
> Did anyone make any progress on this?  Meaning, is there a recent
> kernel with working IDE-on-MBX.  I know its an oddball combination,
> but I just wanted to check.
>
> With a few tweaks to MontaVista 2.2.13, I get as far as seeing,
>
> W82C105: IDE controller on PCI bus 00 dev 19
> W82C105: not 100% native mode: will probe irqs later
> SL82C105 command word: 5
> IDE timing: 00000909, resetting to PIO0 timing
> SL82C105 command word: 5
> IDE timing: 000003e4, resetting to PIO0 timing
>

I had a similar problem with a MTX board (not MBX), and the final
thing that deblocked the situation was by changing the file
/usr/src/linux/driver/block/sl82c105.c

I simply enabled the winbond by changing the line

  pci_write_pci_config_dword(dev,0x40,0x10ff08a1) to

  pci_write_pci_config_dword(dev,0x40,0x10ff0011)

I am not sure for your case since this line is enclosed between
"#ifndef CONFIG_MBX", maybe you can try put the line outside the
"ifdef" construct?

I had changed the 0x44 register's value to 0x0260:
  pci_write_pci_config_dword(dev,0x44,0x0260)

hope this helps

---------------------------------------------------------------------
Zirong Wang    Oce Industries  1, Rue J. Lemoine 94015 Creteil France

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
