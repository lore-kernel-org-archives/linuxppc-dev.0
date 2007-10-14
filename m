Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D04FBDDE1B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 06:08:42 +1000 (EST)
Date: Sun, 14 Oct 2007 15:14:31 -0500
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Quieten cache information at boot
Message-ID: <20071014201431.GA23002@lixom.net>
References: <20071014193317.GC26693@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071014193317.GC26693@kryten>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 14, 2007 at 02:33:17PM -0500, Anton Blanchard wrote:
> 
> After 6 years the ppc64 kernel still thinks its important to tell me my
> cache line size is 0x80 bytes. I think most people who care know that by
> now. The rest probably cant even understand the hex output.
> 
> Since we might have misconfigured firmware or cpus that have a linesize
> that isnt 128 bytes, I still print it out for those cases. If people
> would prefer to remove it completely, lets do it.

Let's just remove it completely. I have yet to see a bug because of it,
and we have 0x40 byte cache lines.

If anything, compare firmware setting to cputable one and print a warning.

Should maybe give them loglevels too, since you're touching them? I
suggest KERN_DEBUG -- if needed it's there in dmesg, and if you need it
on the console you can just add "debug" to the kernel command line.


-Olof
