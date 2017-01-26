Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8YJK2YP5zDq6j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 07:22:56 +1100 (AEDT)
Date: Thu, 26 Jan 2017 21:22:48 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Ashley Lai <ashleydlai@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Peter Huewe <peterhuewe@gmx.de>, Marcel
 Selhorst <tpmdd@selhorst.net>, Jarkko Sakkinen
 <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: ibmvtpm byteswapping inconsistency
Message-ID: <20170126212248.3f3e9103@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

building ibmvtpm I noticed gcc warning complaining that second word of
struct ibmvtpm_crq in tpm_ibmvtpm_suspend is uninitialized.

The structure is defined as 

struct ibmvtpm_crq {
        u8 valid;
        u8 msg;
        __be16 len;
        __be32 data;
        __be64 reserved;
} __attribute__((packed, aligned(8)));

initialized as

        struct ibmvtpm_crq crq;
        u64 *buf = (u64 *) &crq;
...
        crq.valid = (u8)IBMVTPM_VALID_CMD;
        crq.msg = (u8)VTPM_PREPARE_TO_SUSPEND;

and submitted with

        rc = ibmvtpm_send_crq(ibmvtpm->vdev, cpu_to_be64(buf[0]),
                              cpu_to_be64(buf[1]));

which means that the second word indeed contains purely garbage.

This is repeated a few times in the driver so I added memset to quiet
gcc and make behavior deterministic in case the unused fields get some
meaning in the future.

However, in tpm_ibmvtpm_send the structure is initialized as

	struct ibmvtpm_crq crq;
        __be64 *word = (__be64 *)&crq;
...
        crq.valid = (u8)IBMVTPM_VALID_CMD;
        crq.msg = (u8)VTPM_TPM_COMMAND;
        crq.len = cpu_to_be16(count);
        crq.data = cpu_to_be32(ibmvtpm->rtce_dma_handle);

and submitted with

	rc = ibmvtpm_send_crq(ibmvtpm->vdev, be64_to_cpu(word[0]),
                              be64_to_cpu(word[1]));
meaning it is swapped twice.


Where is the interface defined? Are the command arguments passed as BE
subfields (the second case was correct before adding the extra whole
word swap) or BE words (the first case doing whole word swap is
correct)?

Thanks

Michal
