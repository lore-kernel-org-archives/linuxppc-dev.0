Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D9EAFDDDDB
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 15:54:31 +1100 (EST)
Message-ID: <476DE9FF.7070409@am.sony.com>
Date: Sat, 22 Dec 2007 20:54:23 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch v2] PS3: Fix printing of os-area magic numbers
References: <473F6A28.5000309@am.sony.com>	<4745FDDB.7090208@am.sony.com>
	<18283.17563.790043.79740@cargo.ozlabs.ibm.com>
In-Reply-To: <18283.17563.790043.79740@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/20/2007 08:44 PM, Paul Mackerras wrote:
> Geoff Levand writes:
> 
>> Fix a bug in the printing of the os-area magic numbers which assumed that
>> magic numbers were zero terminated strings.  The magic numbers are represented
>> in memory as integers.  If the os-area sections are not initialized correctly
>> they could contained random data that would be printed to the display.
> 
>> +	u8 str[sizeof(h->magic_num) + 1];
>> +	u8 *s, *d;
>> +
>> +	for(s = h->magic_num, d = str; s < h->magic_num + sizeof(h->magic_num);
>> +		s++, d++) {
>> +		*d = isprint(*s) ? *s : '.';
>> +	}
>> +	d[sizeof(h->magic_num)] = 0;
> 
> This last statement is wrong, because d has been incremented to point
> to the last byte of str already by this stage.
> 
> It would be nicer if you pulled out the two instances of the for loop
> into a little helper function.

OK.

>> +	for(s = (u8*)&db->magic_num, d = str;
> 
> Why do you need the (u8*) cast in this case but not the other?

The types are different.  The header magic is an array of u8, the db magic
is a u32.

-Geoff 
