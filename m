Return-Path: <robb@synergymicro.com>
Received: from localhost.localdomain (renfield.synergymicro.com [207.158.54.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D03467A70
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 12:05:29 +1100 (EST)
Date: Wed, 26 Jan 2005 17:28:31 -0700
From: Rob Baxter <robb@synergymicro.com>
To: Leigh Brown <leigh@solinno.co.uk>
Message-ID: <20050127002831.GB3683@synergymicro.com>
References: <32862.82.10.231.190.1106765713.squirrel@82.10.231.190>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <32862.82.10.231.190.1106765713.squirrel@82.10.231.190>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: cmd_line and cmd_preset in arch/ppc/boot/simple/misc.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


No, you're not going mad...

This piece code, CONFIG_GEMINI, complements a piece code in the GEMINI
specific boot code.  This piece of code is not part of the standard
distribution.  What this compliment piece of code did was to pass an
optional command line from the firmware to misc.c.

Hopes this help,
Rob, A GEMINI Developer

On Wed, Jan 26, 2005 at 06:55:13PM -0000, Leigh Brown wrote:
> Hi,
> 
> Could someone please confirm that I'm not going mad?  At least wrt
> this ;-)  We have this code in misc.c:
> 
> #ifdef CONFIG_GEMINI
>         /*
>          * If cmd_line is empty and cmd_preset is not, copy cmd_preset
>          * to cmd_line.  This way we can override cmd_preset with the
>          * command line from Smon.
>          */
> 
>         if ( (cmd_line[0] == '\0') && (cmd_preset[0] != '\0'))
>                 memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
> #endif
> 
>         /* Display standard Linux/PPC boot prompt for kernel args */
>         puts("\nLinux/PPC load: ");
>         cp = cmd_line;
>         memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
> 
> 
> Surely the bit in the #ifdef is ineffective?  Also, as cmd_line is
> initialised to zeros, I think this is better:
> 
>         /*
>          * If cmd_line is empty and cmd_preset is not, copy cmd_preset
>          * to cmd_line.  This way we can override cmd_preset with the
>          * command line from Smon.
>          */
> 
>         if ( (cmd_line[0] == '\0') && (cmd_preset[0] != '\0'))
>                 memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
> 
>         /* Display standard Linux/PPC boot prompt for kernel args */
>         puts("\nLinux/PPC load: ");
>         cp = cmd_line;
> 
> As, in the general case, cmd_line[0] will always be zero and
> cmd_preset[0] will always be filled, so no need for an #ifdef.
> 
> If someone can confirm I'm not mistaken, I can send a patch...
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
