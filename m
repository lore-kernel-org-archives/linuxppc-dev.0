Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8byz4yFBzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 09:23:07 +1100 (AEDT)
Date: Thu, 26 Jan 2017 15:05:36 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Michal Such??nek <msuchanek@suse.de>, Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: Ashley Lai <ashleydlai@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Peter Huewe <peterhuewe@gmx.de>, Marcel Selhorst <tpmdd@selhorst.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 tpmdd-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: ibmvtpm byteswapping inconsistency
Message-ID: <20170126220536.GB31937@obsidianresearch.com>
References: <20170126212248.3f3e9103@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170126212248.3f3e9103@kitsune.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 26, 2017 at 09:22:48PM +0100, Michal Such??nek wrote:

> This is repeated a few times in the driver so I added memset to quiet
> gcc and make behavior deterministic in case the unused fields get some
> meaning in the future.

Yep, reserved certainly needs to be zeroed.. Can you send a patch?
memset is overkill...

> However, in tpm_ibmvtpm_send the structure is initialized as
> 
> 	struct ibmvtpm_crq crq;
>         __be64 *word = (__be64 *)&crq;
> ...
>         crq.valid = (u8)IBMVTPM_VALID_CMD;
>         crq.msg = (u8)VTPM_TPM_COMMAND;
>         crq.len = cpu_to_be16(count);
>         crq.data = cpu_to_be32(ibmvtpm->rtce_dma_handle);
> 
> and submitted with
> 
> 	rc = ibmvtpm_send_crq(ibmvtpm->vdev, be64_to_cpu(word[0]),
>                               be64_to_cpu(word[1]));
> meaning it is swapped twice.

No idea, Nayna may know.

My guess is that '__be64 *word' should be 'u64 *word'...

Jason
