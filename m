Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8hPF0140zDq8x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 12:42:40 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0R1cbb0050109
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 20:42:38 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 287vabrtxe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 20:42:37 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 26 Jan 2017 20:42:37 -0500
Subject: Re: ibmvtpm byteswapping inconsistency
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Ashley Lai <ashleydlai@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Peter Huewe <peterhuewe@gmx.de>,
 Marcel Selhorst <tpmdd@selhorst.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 tpmdd-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20170126212248.3f3e9103@kitsune.suse.cz>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2017 17:42:29 -0800
MIME-Version: 1.0
In-Reply-To: <20170126212248.3f3e9103@kitsune.suse.cz>
Content-Type: text/plain; charset=windows-1252
Message-Id: <d55b06cc-cb7a-1ef1-05b7-d7d4114d0c48@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/26/2017 12:22 PM, Michal Suchánek wrote:
> Hello,
> 
> building ibmvtpm I noticed gcc warning complaining that second word of
> struct ibmvtpm_crq in tpm_ibmvtpm_suspend is uninitialized.
> 
> The structure is defined as 
> 
> struct ibmvtpm_crq {
>         u8 valid;
>         u8 msg;
>         __be16 len;
>         __be32 data;
>         __be64 reserved;
> } __attribute__((packed, aligned(8)));
> 
> initialized as
> 
>         struct ibmvtpm_crq crq;
>         u64 *buf = (u64 *) &crq;
> ...
>         crq.valid = (u8)IBMVTPM_VALID_CMD;
>         crq.msg = (u8)VTPM_PREPARE_TO_SUSPEND;
> 
> and submitted with
> 
>         rc = ibmvtpm_send_crq(ibmvtpm->vdev, cpu_to_be64(buf[0]),
>                               cpu_to_be64(buf[1]));

These should be be64_to_cpu() here. The underlying hcall made by
ibmvtpm_send_crq() requires parameters to be in cpu endian unlike the
RTAS interface which requires data in BE.

> 
> which means that the second word indeed contains purely garbage.
> 
> This is repeated a few times in the driver so I added memset to quiet
> gcc and make behavior deterministic in case the unused fields get some
> meaning in the future.
> 
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
> 
> 
> Where is the interface defined? Are the command arguments passed as BE
> subfields (the second case was correct before adding the extra whole
> word swap) or BE words (the first case doing whole word swap is
> correct)?

The interface is defined in PAPR. The crq format is defined in BE terms.
However, when we break the crq apart into high and low words they need
to be in cpu endian as mentioned above.

-Tyrel

> 
> Thanks
> 
> Michal
> 
