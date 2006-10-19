Return-Path: <mgreer@mvista.com>
Date: Thu, 19 Oct 2006 12:26:41 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [PATCH/RFC] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile
Message-ID: <20061019192641.GA6586@mag.az.mvista.com>
References: <20061019002635.GA2356@mag.az.mvista.com>
	<1161237001.4992.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1161237001.4992.5.camel@localhost>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2006 at 12:50:01AM -0500, Matthew McClintock wrote:
> On Wed, 2006-10-18 at 17:26 -0700, Mark A. Greer wrote:
> > 
> >         $(obj)/zImage.sandpoint: vmlinux $(wrapperbits)
> >                 $(call cmd,wrap_dts,sandpoint)
> > 
> >         $(obj)/zImage.initrd.sandpoint: vmlinux $(wrapperbits)
> >                 $(call cmd,wrap_dts_initrd,sandpoint) 
> 
> 
> Can you do something like this to make it even more automatic:
> 
>         $(obj)/$(CONFIG_SANDPOINT): vmlinux $(wrapperbits)
>                 $(call cmd,wrap_dts,`echo $CONFIG_SANDPOINT | awk '{print substr($1, 8)}'`)
> 
> I'm not sure if this will work exactly as is. But, I do think adding an
> entry in the Makefile for every possible bootwrapper target is needed. I
> say this because I intend to add targets for all variants of Freescale
> boards at some point in the future.
> 
> Let me clarify my needs here some more, I want to be able to type 'make
> cuImage' and have the scripts build the wrapper target and attached the
> correct dtb for all variants of Freescale boards. Of course, the dtb
> will hopefully be specified in the defconfig. Does this make sense?

Yes, something like that would reduce the number of rules that would
have to be added.  I'll think about it.  It'll be low on my priority
list though so feel free to submit your own patch.

Mark
