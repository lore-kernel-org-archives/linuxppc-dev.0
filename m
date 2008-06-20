Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B04FADDE2A
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 09:18:29 +1000 (EST)
Message-ID: <485C3ABF.7030008@ru.mvista.com>
Date: Sat, 21 Jun 2008 03:18:23 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 1/5] Allow drc indexes to be specified in formats other
	than	decimal
References: <485C2033.20101@austin.ibm.com> <485C2134.4030109@austin.ibm.com>
In-Reply-To: <485C2134.4030109@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Nathan Fontenot wrote:
> Allow the drc index passed to the /proc/ppc64/ofdt file to be specified
> in formats other than decimal.  This allows us to easily specify drc 
> indexes
> in hex that would otherwise appears as negative integers.
>
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> ---
>
> Index: linux-2.6.git/arch/powerpc/platforms/pseries/reconfig.c
> ===================================================================
> --- linux-2.6.git.orig/arch/powerpc/platforms/pseries/reconfig.c    
> 2008-06-03 16:29:04.000000000 -0500
> +++ linux-2.6.git/arch/powerpc/platforms/pseries/reconfig.c    
> 2008-06-19 22:03:12.000000000 -0500
> @@ -365,7 +365,7 @@
>      *buf = '\0';
>      buf++;
>
> -    handle = simple_strtoul(handle_str, NULL, 10);
> +    handle = simple_strtoul(handle_str, NULL, 0);

   I guess checkpatch.pl told you to consider switching to 
strict_strtol()? :-)

WBR, Sergei
