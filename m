Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9F50FDDF31
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:58:02 +1000 (EST)
Date: Thu, 18 Oct 2007 22:57:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: qe: add ability to upload QE firmware
Message-ID: <20071018185738.GA16782@localhost.localdomain>
References: <11927201051427-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <11927201051427-git-send-email-timur@freescale.com>
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

On Thu, Oct 18, 2007 at 10:08:25AM -0500, Timur Tabi wrote:
> Define the layout of a binary blob that contains a QE firmware and instructions
> on how to upload it.  Add function qe_upload_microcode() to parse the blob
> and perform the actual upload.  Fully define 'struct rsp' in immap_qe.h to
> include the actual RISC Special Registers.
[...]
> I need to add a few fields to the structure, but I would still appreciate
> comments on the structure and the corresponding code.

It seems I'm too lazy to go deep inside the code, but it's okay... because
I believe it is works fine. ;-)

Thus sorry, only fluffy cosmetic notes.

> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
[...]
> +	if (firmware->length == (length + sizeof(u32))) {
> +		/* Length is valid, and there's a CRC */
> +		crc = be32_to_cpu(*((__be32 *) ((void *) firmware + length)));

Spaces are not needed after "(__be32 *)" and "(void *)". The whole
construction isn't easy to parse, thus spaces are only distracting.

> +		if (crc != crc32(0, firmware, length)) {
> +			printk(KERN_ERR "QE: firmware CRC is invalid\n");
> +			return -EIO;
> +		}
> +	} else if (firmware->length != length) {
> +		printk(KERN_ERR "QE: invalid length(s) in firware structure\n");
> +		return -EPERM;
> +	}
> +
> +	/* If there's only one microcode, then we assume it's common for all
> +	   RISCs, so we set the CERCR.CIR bit to share the IRAM with all RISCs.
> +	   This should be safe even on SOCs with only one RISC.
> +
> +	   If there are multiple 'microcode' structures, but each one points
> +	   to the same microcode binary (ignoring offsets), then we also assume
> +	   that we want share RAM.
> +	 */

Comment style is unorthodox.

> +	if (firmware->count == 1)
> +	      setbits16(&qe_immr->cp.cercr, cpu_to_be16(0x800));
> +	else {

I'd place braces for the first 'if'. No lines added, more good looking.
The CodingStyle also suggest this.

> +		for (i = 1; i < firmware->count; i++)

I'd place braces here too. No rationale though, just better looking.

> +			if (firmware->microcode[i].code_offset !=
> +			    firmware->microcode[0].code_offset)
> +				break;
> +
> +		if (i == firmware->count)
> +			setbits16(&qe_immr->cp.cercr, cpu_to_be16(0x800));

0x800? Desires proper #define.

> +	}
> +
> +	if (firmware->soc.model)
> +		printk(KERN_INFO "QE: uploading microcode '%s' for %u V%u.%u\n",
> +			firmware->id, be16_to_cpu(firmware->soc.model),
> +			firmware->soc.rev_h, firmware->soc.rev_l);
> +	else
> +		printk(KERN_INFO "QE: uploading microcode '%s'\n",
> +			firmware->id);
> +
> +	for (i = 0; i < firmware->count; i++) {
> +		const struct qe_microcode *ucode = &firmware->microcode[i];
> +
> +		code = (void *) firmware + be32_to_cpu(ucode->code_offset);

space after (void *).

> +		/* Use auto-increment */
> +		out_be32(&qe_immr->iram.iadd, cpu_to_be32(0x80080000 |

magic number.

> +			be32_to_cpu(ucode->iram_offset)));
> +
> +		for (j = 0; j < ucode->count; j++)
> +			out_be32(&qe_immr->iram.idata, be32_to_cpu(code[j]));
> +
> +		/* Program the traps.  We program both RISCs, even on platforms
> +		   that only have one.  This *should* be safe. */
> +		for (j = 0; j < 16; j++)
> +			if (ucode->traps[j]) {
> +				u32 trap = be32_to_cpu(ucode->traps[j]);
> +				out_be32(&qe_immr->rsp[0].tibcr[j], trap);

Empty line needed after variable declaration.

> +				out_be32(&qe_immr->rsp[1].tibcr[j], trap);
> +			}
> +	}
> +
> +	/* Enable the traps for both RISCs.  Again, on a single-RISC system,
> +	   this should be safe. */

Comment.

> +	out_be32(&qe_immr->rsp[0].eccr, cpu_to_be32(0x20800000));
> +	out_be32(&qe_immr->rsp[1].eccr, cpu_to_be32(0x20800000));

magic numbers.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
