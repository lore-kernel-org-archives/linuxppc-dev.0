Return-Path: <scottwood@freescale.com>
Message-ID: <469E5ACD.3040708@freescale.com>
Date: Wed, 18 Jul 2007 13:24:13 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 09/61] bootwrapper: Add dt_is_compatible().
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>,
	<20070718013306.GH15238@ld0162-tx32.am.freescale.net>
	<c5856df6a88b8124fbb6a3cc6974314c@bga.com>
In-Reply-To: <c5856df6a88b8124fbb6a3cc6974314c@bga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Milton Miller wrote:
>> +       for (pos = 0; pos + compat_len < len; pos++) {
>> +               if (!strcmp(buf + pos, compat))
>> +                       return 1;
>> +
>> +               while (buf[pos] && pos + compat_len < len)
>> +                       pos++;
> 
> 
> This is buggy: if you are searching for "ns16550" and the compatable is 
> "fsl,1234\0commons16550" this code will incorrectly says its compatable.

How so?

The first iteration will compare "ns16550" to "fsl,1234", find that they 
don't match, and advance to the '\0'.

The second iteration will compare "ns16550" to "commons16550", find that 
they don't match, and advance to the 'n'.

The third iteration will not happen, since the loop condition fails, and 
not-compatible is returned.

> Comparing pos < len instead will do the right thing, at the cost of a 
> few iterations of the loop.

I'll grant that the extra iterations aren't worth doing the strlen() -- 
I'm not sure why I did it that way.

-Scott
