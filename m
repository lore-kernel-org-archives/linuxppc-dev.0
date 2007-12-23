Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 82DC5DDEBB
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 04:34:41 +1100 (EST)
Message-ID: <476E98CF.7010204@am.sony.com>
Date: Sun, 23 Dec 2007 09:20:15 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch v3] PS3: Fix printing of os-area magic numbers
References: <473F6A28.5000309@am.sony.com> <476DED97.8070709@am.sony.com>
	<Pine.LNX.4.62.0712231049240.17187@chinchilla.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0712231049240.17187@chinchilla.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/23/2007 01:51 AM, Geert Uytterhoeven wrote:
> On Sat, 22 Dec 2007, Geoff Levand wrote:
>> +static void dump_field(char *s, const u8 *f, unsigned int size)
>> +{
>> +#if defined(DEBUG)
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < size; i++)
>> +		s[i] = isprint(f[i]) ? f[i] : '.';
>> +	s[i] = 0;
>> +#endif
>> +}
> 
> Sorry for nitpicking again.
> 
> Usually the _length_ of a C-string is the number of characters, while the
> _size_ of a C-string includes the zero-terminator.
> 
> In dump_field() it writes size+1 bytes to s.

The arg size is the size of the field in bytes:

  dump_field(str, h->magic_num, sizeof(h->magic_num));

To me, the name length doesn't seem to convey that.

-Geoff
