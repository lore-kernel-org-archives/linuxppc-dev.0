Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6C39BDDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:44:02 +1000 (EST)
Date: Thu, 18 Oct 2007 23:43:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: qe: add ability to upload QE firmware
Message-ID: <20071018194337.GA17044@localhost.localdomain>
References: <11927201051427-git-send-email-timur@freescale.com>
	<20071018185738.GA16782@localhost.localdomain>
	<4717ADCE.9070807@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4717ADCE.9070807@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 02:02:38PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
>>> +	if (firmware->length == (length + sizeof(u32))) {
>>> +		/* Length is valid, and there's a CRC */
>>> +		crc = be32_to_cpu(*((__be32 *) ((void *) firmware + length)));
>> Spaces are not needed after "(__be32 *)" and "(void *)". The whole
>> construction isn't easy to parse, thus spaces are only distracting.
>
> I have to disagree.  I added the spaces to make it easier to read.
>
>>> +	/* If there's only one microcode, then we assume it's common for all
>>> +	   RISCs, so we set the CERCR.CIR bit to share the IRAM with all RISCs.
>>> +	   This should be safe even on SOCs with only one RISC.
>>> +
>>> +	   If there are multiple 'microcode' structures, but each one points
>>> +	   to the same microcode binary (ignoring offsets), then we also assume
>>> +	   that we want share RAM.
>>> +	 */
>> Comment style is unorthodox.
>
> Should I prefix each line with a "*"?

Yup.

Heh... well, ideal multiline comment is:

/*
 * Multiline comment here.
 */

But this doesn't matter much, the salt is in "*"s. ;-)

>>> +		code = (void *) firmware + be32_to_cpu(ucode->code_offset);
>> space after (void *).
>
> Really?  This:
>
> 	code = (void *)firmware + be32_to_cpu(ucode->code_offset);
>
> is harder to read.  Without the space, it looks like *)firmware is one 
> word.

:-) I'm not about to argue, this is each own preference.

But to complete my point: I don't care what style exactly is used, what
I care about is consistency across the code I'm looking in. 100%
consistency is not affordable, of course. But we're all trying, aren't we?
(type *)variable is orthodox style, and when I see unusual style, my eyes
are itching, and this code is hard to read (to me). So, if everybody will
switch to "(type *) variable" style -- I'll just follow.


And again: this is all of minor importance, just my $0.02 for the code
consistency.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
