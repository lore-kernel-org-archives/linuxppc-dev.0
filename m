Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id BD5D32C0364
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 22:33:18 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 02455-04 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 23 Jul 2012 13:33:05 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [1/3][PATCH][upstream]Adding documentation for TDM
Date: Mon, 23 Jul 2012 13:32:20 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6FA4@saturn3.aculab.com>
In-Reply-To: <1343040588-16002-2-git-send-email-b37400@freescale.com>
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <1343040588-16002-2-git-send-email-b37400@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <b37400@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: Sandeep Singh <Sandeep@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +3. TDM has programmable slot length (8 bits or 16 bits). This can be
> +   configured by:
> +
> +	#define NUM_BYTES_PER_SLOT	8

I presume you meant NUM_BITS_PER_SLOT ?
These constants need name-space protection

> +or
> +	#define NUM_BYTES_PER_SLOT	16
> +
> +depending on the type of sample. For example the sample could be 16
> +bit linear +or 8bit u-law encoded etc.
> +Presently only word length of 16 is supported
> +which is the default configuration.

For flexibility you need to allow for 8bit samples
being converted as:
1) 8bit raw ulaw or alaw data (unchanged from line).
2) 8bit raw data, bit reversed, any hdlc protocol
   is bit reversed from audio [1].
3) 8bit audio, converted from alaw to ulaw
4) 8bit audio, converted from ulaw to alaw
5) 16bit linear converted to/from alaw or ulaw
and on a per-timeslot basis.

[1] most hdlc stuff probably can't stand the 10ms
epochs though, so this is limited use for serious work.

	David
