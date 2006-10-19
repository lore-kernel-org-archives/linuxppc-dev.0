Return-Path: <msm@freescale.com>
Subject: Re: [PATCH/RFC] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile
From: Matthew McClintock <msm@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20061019002635.GA2356@mag.az.mvista.com>
References: <20061019002635.GA2356@mag.az.mvista.com>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 00:50:01 -0500
Message-Id: <1161237001.4992.5.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-18 at 17:26 -0700, Mark A. Greer wrote:
> 
>         $(obj)/zImage.sandpoint: vmlinux $(wrapperbits)
>                 $(call cmd,wrap_dts,sandpoint)
> 
>         $(obj)/zImage.initrd.sandpoint: vmlinux $(wrapperbits)
>                 $(call cmd,wrap_dts_initrd,sandpoint) 


Can you do something like this to make it even more automatic:

        $(obj)/$(CONFIG_SANDPOINT): vmlinux $(wrapperbits)
                $(call cmd,wrap_dts,`echo $CONFIG_SANDPOINT | awk '{print substr($1, 8)}'`)

I'm not sure if this will work exactly as is. But, I do think adding an
entry in the Makefile for every possible bootwrapper target is needed. I
say this because I intend to add targets for all variants of Freescale
boards at some point in the future.

Let me clarify my needs here some more, I want to be able to type 'make
cuImage' and have the scripts build the wrapper target and attached the
correct dtb for all variants of Freescale boards. Of course, the dtb
will hopefully be specified in the defconfig. Does this make sense?

-Matthew
