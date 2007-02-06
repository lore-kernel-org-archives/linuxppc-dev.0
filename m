Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 27579DDE47
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 10:08:33 +1100 (EST)
Message-ID: <45C90A6E.3040302@freescale.com>
Date: Tue, 06 Feb 2007 17:08:30 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net>
In-Reply-To: <20070206013051.GA15525@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Mon, Feb 05, 2007 at 01:51:55PM -0600, Timur Tabi wrote:
>> Although udbg_progress() takes a string and a short as parameters, only
>> the string is displayed.  This patch also displays the integer, if it's not
>> equal to 0xFFFF.  This gives callers the option to display only the string.
> 
> Some platforms do this already, but they output the numbers first. It's
> a good idea to stay consistent with that.
> 
> See maple_progress, ps3_progress and friends for templates. They're
> quite verbose though.

Actually, they're just one line each:

static void __init maple_progress(char *s, unsigned short hex)
{
	printk("*** %04x : %s\n", hex, s ? s : "");
}

static void __init ps3_progress(char *s, unsigned short hex)
{
	printk("*** %04x : %s\n", hex, s ? s : "");
}

The reason I can't use the same exact printk() is because of this code in 
function ppc_init():

	/* clear the progress line */
	if ( ppc_md.progress ) ppc_md.progress("             ", 0xffff);

If I could get rid of this line, then I wouldn't need to check for "hex == 
0xFFFF", but I don't know why ppc_init() thinks it needs to "clear the progress 
line".  Maybe this is for some kind of LED display.

I'll submit a new patch in a minute.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
