Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17865.2853.132102.769702@cargo.ozlabs.ibm.com>
Date: Wed, 7 Feb 2007 10:11:33 +1100
From: Paul Mackerras <paulus@samba.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
In-Reply-To: <45C90A6E.3040302@freescale.com>
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net> <45C90A6E.3040302@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi writes:

> The reason I can't use the same exact printk() is because of this code in 
> function ppc_init():
> 
> 	/* clear the progress line */
> 	if ( ppc_md.progress ) ppc_md.progress("             ", 0xffff);
> 
> If I could get rid of this line, then I wouldn't need to check for "hex == 
> 0xFFFF", but I don't know why ppc_init() thinks it needs to "clear the progress 
> line".  Maybe this is for some kind of LED display.

It would have been for the 2-line display on IBM RS/6000 machines.  If
that's still needed, we can put it in arch/powerpc/platforms/chrp
somewhere, so feel free to remove it from ppc_init().

Paul.
