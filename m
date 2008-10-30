Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18698.10295.463071.212141@cargo.ozlabs.ibm.com>
Date: Fri, 31 Oct 2008 08:33:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: relocatable kernel vs. yaboot
In-Reply-To: <1225322811.5280.5.camel@johannes.berg>
References: <1225322811.5280.5.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> Sorry if this has been discussed before, but I just found that yaboot
> rejects relocatable kernels claiming they are an invalid ELF file.

Yes, yaboot needs to be fixed.

> In the patch adding relocatable kernel support, I found
> 
> +# The iseries hypervisor won't take an ET_DYN executable, so this
> +# changes the type (byte 17) in the file to ET_EXEC (2).
>  $(obj)/zImage.iseries: vmlinux
>         $(STRIP) -s -R .comment $< -o $@
> +       printf "\x02" | dd of=$@ conv=notrunc bs=1 seek=17
> 
> 
> Modifying the vmlinux in the same way as above makes yaboot take it, and
> I can easily make this part of my installation procedure, but I wonder
> if it should be done automatically? Or maybe only documented in the
> Kconfig help text? I probably wouldn't have enabled it and then wondered
> why it doesn't work if it had warned me about breaking yaboot ;)

Yes, we could add something to the help text.  Until yaboot gets
fixed, you could either boot the zImage with yaboot or use that
iseries hack.

Why did you enable it?  Just to try it out?  The main reason for
having it turned on is if you want to have a single kernel image that
can be used both as a normal kernel and a kdump kernel.

Paul.
