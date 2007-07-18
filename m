Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0DD0BDDF07
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 01:43:28 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <336b7f0b48526c8feeb9914de32cc9d1@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 09/61] bootwrapper: Add dt_is_compatible().
Date: Wed, 18 Jul 2007 10:42:56 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>

On Wed Jul 18 11:33:06 EST 2007, Scott Wood wrote:
> +int dt_is_compatible(void *node, const char *compat)
> +{
> +       char *buf = (char *)prop_buf;
> +       int compat_len = strlen(compat);
> +       int len, pos;
> +
> +       len = getprop(node, "compatible", buf, MAX_PROP_LEN);
> +       if (len < 0)
> +               return 0;
> +
> +       for (pos = 0; pos + compat_len < len; pos++) {
> +               if (!strcmp(buf + pos, compat))
> +                       return 1;
> +
> +               while (buf[pos] && pos + compat_len < len)
> +                       pos++;

This is buggy: if you are searching for "ns16550" and the compatable is 
"fsl,1234\0commons16550" this code will incorrectly says its 
compatable.

Comparing pos < len instead will do the right thing, at the cost of a 
few iterations of the loop.

> +       }
> +
> +       return 0;

milton
