Message-ID: <000701c1d8ef$20c131c0$b949893e@m5axc>
Reply-To: "Neil Wilson" <nwilson@airspan.com>
From: "Neil Wilson" <nwilson@airspan.com>
To: <mporter@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: forcing pci device start address ?  
Date: Sun, 31 Mar 2002 21:02:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>On Sat, Mar 30, 2002 at 05:14:24PM -0000, Neil Wilson wrote:
>
> Hi,
>
> We have a new 7450/107 board that I have got to boot and run 2.4.17.  The
> hardware designer has got some non-standard pci devices ie, a large fpga
>  that lives in pci space but does not have a configuration register and
also
>  some standard pci devices like the AMD79C973 ethernet controller.

>I don't understand.  It doesn't have "a configuration register".  Do
>you mean that it does have any configuration space registers or that
>it does not have BAR registers?  If it has BAR registers in config
>space, do they respond to config cycles in the convential manner or
>are they in a fixed position?  Please clarify so we can help you.

Sorry for any lack of clarity, mainly it's due to me not understanding
enough about pci to know what to ask for help on.

Reading/decoding the hardware design spec section for the fpga says that it
does not support pci plug & play and the pci interface in the fpga code does
not have a configuration register set, it just details what IDSEL line is
allocated and the fact that it is interfaced to the MPC107 pci bus both as a
slave & master. There are no mention of BAR registers.

Is it possible to set up a linuxppc pci interface to the fpga pci interface
and other peripherals that do have configuration register sets (a tdm
controller & an ethernet controller), to be at specific addresses in pci
space, i.e. fpga at 0xc0000000, tdm at 0xd0000000 and ethernet at 0xe0000000
rather than have the interfaces probed during initialisation and the ioaddr
etc handed out to the relevant drivers ?  I know that we need to write a
couple of drivers anyway but the ethernet is a pcnet32 controller.

There, I have again probably unclarified what I am trying to find out !

>  Is it possible to force the start address for the devices to be at
specific
>  addresses as determined by the hardware map using the existing pci
>  controller code ?  An example is the ethernet controller which is at
>  0xe0000000 in the hardware map yet when it it is detected during the pci
>  probing the pcnet32 driver has its ioaddr set to somewhere like
0xfbeffxxx.
>
>
> I am looking through the other setups in the platforms directory and
trying
>  to search the archives but this pci is all a bit of a mystery to me a the
>  momment.

>We can help as well as the info you give us. :)

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
