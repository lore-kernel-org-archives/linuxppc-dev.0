Date: Tue, 27 Aug 2002 08:29:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paul Mackerras <paulus@samba.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linuxppc-dev@lists.linuxppc.org
Subject: Re: pcspkr.c
Message-ID: <20020827082937.A29250@ucw.cz>
References: <15722.56799.290632.720143@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15722.56799.290632.720143@argo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Aug 27, 2002 at 12:03:11PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 27, 2002 at 12:03:11PM +1000, Paul Mackerras wrote:
> Vojtech,
>
> I like the way that the code for doing the beeps via the PC speaker
> has been pulled out into its own little module.
>
> We have a situation on PPC where we would want the PC speaker input
> device to be compiled in to the kernel but only registered and
> initialized on some machines but not on others.  We can run the same
> kernel binary on powermac, CHRP and PReP machines.  The CHRP and PReP
> machines have a PC-style southbridge, including the ISA timer/counter
> that pcspkr.c uses.  On powermacs there is no ISA bus, and to make a
> beep it is necessary to push a suitable waveform out through the
> audio.
>
> So what we want is some way to decide at runtime whether to register
> the pc-speaker input device or not.
>
> Suggestions?

1) Future grand vision: the arch-dependent code supplies a list of
devices present in the system in a generic format, and including or not
the speaker, based on what machine we're running on.  The
hotplug/drivermodel core will then load or not load the pcspkr driver as
a module from initramfs.

2) Quick hack: I have no problem with an

	#ifdef CONFIG_PPC
		if (something)
			return -ENODEV;
	#endif

   inside pcspkr_init()

--
Vojtech Pavlik
SuSE Labs

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
