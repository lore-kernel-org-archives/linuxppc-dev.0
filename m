To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 12 Oct 2001 17:32:34 +1000."
             <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
Date: Fri, 12 Oct 2001 11:16:54 +0200
Message-Id: <20011012091659.B6D6910887@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <15302.40082.869098.88039@cargo.ozlabs.ibm.com> you wrote:
>
> I would like to make a complete list of the methods people use to boot
> the PPC/Linux kernel on different platforms.  As a start, here is what
> I can think of off the top of my head:
...
> Can others contribute entries to this list please?

The following systems are supported by PPCBoot:

## MPC8xx Systems
#########################################################################

	ADS860		AMX860		CCM		cogent_mpc8xx
	ESTEEM192E	ETX094		FADS823		FADS850SAR
	FADS860T	FLAGADM		FPS850L		GENIETV
	GTH		hermes		ICU862		IP860
	IVML24		IVMS8		LANTEC		lwmon
	MBX		MBX860T		NX823		pcu_e
	RPXlite		SM850		SPD823TS	SXNI855T
	TQM823L		TQM850L		TQM855L		TQM860L

## PPC4xx Systems
#########################################################################

	ADCIOP		AR405		CANBT		CPCI405
	CPCIISER4	CRAYL1		DASA_SIM	ERIC
	OCRTC		PIP405		WALNUT405

## MPC8240 Systems
#########################################################################

	CU824		MOUSSE		Sandpoint8240

## MPC8260 Systems
#########################################################################

	cogent_mpc8260	hymod		MPC8260ADS	PM826
	RPXsuper	rsdproto	sbc8260		TQM8260

## MPC74xx Systems
#########################################################################

	EVB64260

> I am particularly interested in the cases where the kernel vmlinux
> binary is loaded directly from some external software, because those

That's what PPCBoot does.

> are the cases that constrain our freedom to choose how information
> gets passed in to the kernel.  From a long-term maintainability
> viewpoint, it would be better if we could say that we always have a
> zImage-style wrapper, because then we could change the interface
> between the wrapper and the kernel at will without breaking anything.

But that would just shift  the  problem  from  the  kernel  into  the
wrapper:  you'd still need a standard way to pass information between
the firmware and  the  wrapper.  I  don't  see  where  there  is  any
improvement, then.

> Along those lines, I have been thinking that it would be good if the
> wrapper built a data structure describing the hardware in the system,
> particularly things like:
>
> - the amount of RAM and any holes
> - type and register addresses for PCI host bus adaptors
> - ditto for interrupt controllers
> - interrupt mapping

The bi_record discussion comes to mind. Is this what you are thinking
of? As soon as such an interface is well defined we  will  make  sure
that it is directly supported by PPCBoot, too.

> Thoughts?

There have already been several rounds of  similar  discussions,  but
AFAIK  they  all  ended  with  just  a  declaration  of  intend to do
"something,  sometime".  Is  your  proposal  a  follow-up  to   these
discussions, or a new approach?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I've finally learned what `upward compatible' means. It means we get
to keep all our old mistakes." - Dennie van Tassel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
