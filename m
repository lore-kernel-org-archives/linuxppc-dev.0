Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPcwn6psVzDrn7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 06:50:49 +1000 (AEST)
Date: Wed, 31 Aug 2016 13:50:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
Message-Id: <20160831135047.4b05a7f912f158ed5f888241@linux-foundation.org>
In-Reply-To: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 30 Aug 2016 18:40:02 -0400 Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> The TPM PCRs are only reset on a hard reboot.  In order to validate a
> TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> of the running kernel must be saved and then restored on the subsequent
> boot, possibly of a different architecture.
> 
> The existing securityfs binary_runtime_measurements file conveniently
> provides a serialized format of the IMA measurement list. This patch
> set serializes the measurement list in this format and restores it.
> 
> Up to now, the binary_runtime_measurements was defined as architecture
> native format.  The assumption being that userspace could and would
> handle any architecture conversions.  With the ability of carrying the
> measurement list across kexec, possibly from one architecture to a
> different one, the per boot architecture information is lost and with it
> the ability of recalculating the template digest hash.  To resolve this
> problem, without breaking the existing ABI, this patch set introduces
> the boot command line option "ima_canonical_fmt", which is arbitrarily
> defined as little endian.
> 
> The need for this boot command line option will be limited to the
> existing version 1 format of the binary_runtime_measurements.
> Subsequent formats will be defined as canonical format (eg. TPM 2.0
> support for larger digests).
> 
> This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> hand-over for the next kernel" patch set. 
> 
> These patches can also be found in the next-kexec-restore branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

I'll merge these into -mm to get some linux-next exposure.  I don't
know what your upstream merge planes will be?
