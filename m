Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp3.wanadoo.fr (unknown [193.252.22.28])
	by ozlabs.org (Postfix) with ESMTP id 5558E2BF12
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Dec 2004 22:59:33 +1100 (EST)
Date: Sun, 26 Dec 2004 13:05:06 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041226120506.GA29020@pegasos>
References: <1103739194.5316.1.camel@gaston> <1103740513.29974.0.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1103740513.29974.0.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 22, 2004 at 07:35:13PM +0100, Benjamin Herrenschmidt wrote:
> On Wed, 2004-12-22 at 19:13 +0100, Benjamin Herrenschmidt wrote:
> > This patch (which will be send upstream separately by the Alsa folks) fixes
> > an signed vs. unsigned char problem in Alsa which was the cause of the Oops
> > people were experiencing on ppc with OSS emulation and possibly other issues.
> 
> Ok, actually, the one that will be commited upstream is a bit different,
> here it is:
> 
> 
> Summary: [ALSA] Fix the wrong sign of format data entries
> 
> Fix suggested by Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> On architectures like PPC, char is handled as "unsigned char", thus the
> pcm_format_data table entries with -1 give a positive 255.  This causes
> Oops with OSS-emulation on such architectures.
> 
> The patch simply adds the right signed/unsigned prefix to fix this problem.
> 
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> 
> --- linux/sound/core/pcm_misc.c 8 Jun 2004 16:57:28 -0000       1.12
> +++ linux/sound/core/pcm_misc.c 22 Dec 2004 18:07:29 -0000      1.14
> @@ -25,11 +25,14 @@
>  #include <sound/pcm.h>
>  #define SND_PCM_FORMAT_UNKNOWN (-1)
>  
> +/* NOTE: "signed" prefix must be given below since the default char is
> + *       unsigned on some architectures!
> + */
>  struct pcm_format_data {
> -       char width;     /* bit width */
> -       char phys;      /* physical bit width */
> -       char le;        /* 0 = big-endian, 1 = little-endian, -1 = others */
> -       char signd;     /* 0 = unsigned, 1 = signed, -1 = others */
> +       unsigned char width;    /* bit width */
> +       unsigned char phys;     /* physical bit width */
> +       signed char le; /* 0 = big-endian, 1 = little-endian, -1 = others */
> +       signed char signd;      /* 0 = unsigned, 1 = signed, -1 = others */
>         unsigned char silence[8];       /* silence data to fill */
>  };

Mmm, this does not apply to the 2.6.8 debian kernel-source package, which
doesn't seem to have a pcm_format_data structure. Do we need a backport of it
to 2.6.8, or was the problem not present then ? 

Friendly,

Sven Luther
