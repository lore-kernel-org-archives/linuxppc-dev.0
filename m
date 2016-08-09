Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7jJX244RzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 15:19:39 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id cf3so310809pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 22:19:39 -0700 (PDT)
Subject: Re: [PATCH 0/7] ima: carry the measurement list across kexec
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <91fa2f95-4d70-a056-d599-01cb3bbe6771@gmail.com>
Date: Tue, 9 Aug 2016 15:19:31 +1000
MIME-Version: 1.0
In-Reply-To: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/08/16 22:24, Mimi Zohar wrote:
> The TPM PCRs are only reset on a hard reboot.  In order to validate a
> TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> of the running kernel must be saved and then restored on the subsequent
> boot.
> 
> The existing securityfs binary_runtime_measurements file conveniently
> provides a serialized format of the IMA measurement list. This patch
> set serializes the measurement list in this format and restores it.
> 
> This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> hand-over for the next kernel" patch set* for actually carrying the
> serialized measurement list across the kexec.
> 
> Mimi
> 

Hi, Mimi

I am trying to convince myself of the security of the solution. I asked
Thiago as well, but may be I am be lagging behind in understanding.

We trust the kernel to hand over PCR values of the old kernel (which
cannot be validated) to the IMA subsystem in the new kernel for storage.
I guess the idea is for ima_add_boot_aggregate to do the right thing?
How do we validate what the old kernel is giving us? Why do we care for
the old measurement list? Is it still of significance in the new kernel?


Balbir Singh.
