Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E24EDDF32
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:02:50 +1000 (EST)
Message-ID: <4717ADCE.9070807@freescale.com>
Date: Thu, 18 Oct 2007 14:02:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: qe: add ability to upload QE firmware
References: <11927201051427-git-send-email-timur@freescale.com>
	<20071018185738.GA16782@localhost.localdomain>
In-Reply-To: <20071018185738.GA16782@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
>> +	if (firmware->length == (length + sizeof(u32))) {
>> +		/* Length is valid, and there's a CRC */
>> +		crc = be32_to_cpu(*((__be32 *) ((void *) firmware + length)));
> 
> Spaces are not needed after "(__be32 *)" and "(void *)". The whole
> construction isn't easy to parse, thus spaces are only distracting.

I have to disagree.  I added the spaces to make it easier to read.

>> +	/* If there's only one microcode, then we assume it's common for all
>> +	   RISCs, so we set the CERCR.CIR bit to share the IRAM with all RISCs.
>> +	   This should be safe even on SOCs with only one RISC.
>> +
>> +	   If there are multiple 'microcode' structures, but each one points
>> +	   to the same microcode binary (ignoring offsets), then we also assume
>> +	   that we want share RAM.
>> +	 */
> 
> Comment style is unorthodox.

Should I prefix each line with a "*"?

>> +		code = (void *) firmware + be32_to_cpu(ucode->code_offset);
> 
> space after (void *).

Really?  This:

	code = (void *)firmware + be32_to_cpu(ucode->code_offset);

is harder to read.  Without the space, it looks like *)firmware is one word.

I shall apply the other changes.  Thanks.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
