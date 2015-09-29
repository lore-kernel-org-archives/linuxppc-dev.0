Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE6181A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 16:30:46 +1000 (AEST)
Received: by laer8 with SMTP id r8so55760621lae.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 23:30:42 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v3 1/3] powerpc/512x: add LocalPlus Bus FIFO device driver
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
 <1443115737-3948-2-git-send-email-alex.popov@linux.com>
 <56049CD0.7080104@tabi.org> <56093CE5.5070301@linux.com>
 <56093E1D.4080008@tabi.org>
To: Timur Tabi <timur@tabi.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Rob Herring <robh@kernel.org>,
 Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Popov <alex.popov@linux.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <560A30DF.9050900@linux.com>
Date: Tue, 29 Sep 2015 09:34:07 +0300
MIME-Version: 1.0
In-Reply-To: <56093E1D.4080008@tabi.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28.09.2015 16:18, Timur Tabi wrote:
> Alexander Popov wrote:
>> The only question I have: why calling dma_unmap_single() from within
>> a spinlock is a bad practice?
> 
> I don't know, but usually functions that allocate or free memory cannot be
> called from within a spinlock.  You need to check that.  Since the MPC5121
> is a single-core CPU, you might not notice if you're doing something wrong.

I've double-checked the code and LDD and don't see any reason to avoid
calling dma_unmap_single() from interrupt context and within spinlock.

Please correct me if I'm wrong.
Thanks.

Best regards,
Alexander
