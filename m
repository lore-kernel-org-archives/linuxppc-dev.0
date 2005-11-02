Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17256.4190.184855.821331@cargo.ozlabs.ibm.com>
Date: Wed, 2 Nov 2005 12:03:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1130860444.21212.52.camel@hades.cambridge.redhat.com>
References: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
	<1130860444.21212.52.camel@hades.cambridge.redhat.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: please pull the powerpc-merge.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> Hm. Not entirely in line with my experience. Can you share the configs
> you used?

Sure, attached (as a .tar.gz).  For 32-bit pmac, you currently have to
disable CONFIG_PREP and (I believe) the TAU options.  For the 64-bit
configs I basically just used the defconfigs in arch/ppc64/configs.

> Using http://david/woodhou.se/powerpc-merge-32.config it doesn't
> actually boot on my powerbook. I'll try it on the Pegasos later or
> tomorrow, where I have a serial console; it dies very early.

That's probably either the pci quirk that got added to do USB host
controller handoff unconditionally on all platforms, and which touches
the device without doing pci_enable_device or checking whether MMIO is
enabled.  A fix has gone into Linus' tree for that.

There was also a bug added to the adbhid.c driver which would cause an
oops when you pressed a key if you had an ADB keyboard (which
powerbooks do).  That's also fixed in Linus' tree.

> Aside from disabling CONFIG_NVRAM because call_rtas() isn't implemented
> anywhere, I also needed to do this to make that config build:
> 
> --- linux-2.6.14/arch/powerpc/kernel/setup-common.c.orig	2005-11-01 10:14:32.000000000 +0000
> +++ linux-2.6.14/arch/powerpc/kernel/setup-common.c	2005-11-01 10:15:03.000000000 +0000
> @@ -203,11 +203,11 @@ static int show_cpuinfo(struct seq_file 
>  #ifdef CONFIG_TAU_AVERAGE
>  		/* more straightforward, but potentially misleading */
>  		seq_printf(m,  "temperature \t: %u C (uncalibrated)\n",
> -			   cpu_temp(i));
> +			   cpu_temp(cpu_id));
>  #else
>  		/* show the actual temp sensor range */
>  		u32 temp;
> -		temp = cpu_temp_both(i);
> +		temp = cpu_temp_both(cpu_id);
>  		seq_printf(m, "temperature \t: %u-%u C (uncalibrated)\n",
>  			   temp & 0xff, temp >> 16);
>  #endif

Thanks, I'll put that in.

Paul.
